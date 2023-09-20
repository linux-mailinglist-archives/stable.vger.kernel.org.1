Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539757A805D
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjITMgv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbjITMgt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:36:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB902C9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:36:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41DBC433CA;
        Wed, 20 Sep 2023 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213403;
        bh=ACSDM1VqD8PABz992q52gF9AO53NNsQkpcsPe7030rQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJXhL5A0mP3Kwq1zjyIzCOuogZ6M0TJh9eQcESg48lqnesWlpyzCxjldJ12uGmfHR
         dhzVdEMHDS8hHIrGe9BRe+HY2tc+p+e+HGACneBVlcdtpC17GWGtKUJWke9S2SWcjW
         EQ0XoQ/sYU+OKKSqFFLsowTlOXM84eeO/VNIMSP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Barry Marson <bmarson@redhat.com>,
        Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 5.4 225/367] dlm: fix plock lookup when using multiple lockspaces
Date:   Wed, 20 Sep 2023 13:30:02 +0200
Message-ID: <20230920112904.409056321@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

commit 7c53e847ff5e97f033fdd31f71949807633d506b upstream.

All posix lock ops, for all lockspaces (gfs2 file systems) are
sent to userspace (dlm_controld) through a single misc device.
The dlm_controld daemon reads the ops from the misc device
and sends them to other cluster nodes using separate, per-lockspace
cluster api communication channels.  The ops for a single lockspace
are ordered at this level, so that the results are received in
the same sequence that the requests were sent.  When the results
are sent back to the kernel via the misc device, they are again
funneled through the single misc device for all lockspaces.  When
the dlm code in the kernel processes the results from the misc
device, these results will be returned in the same sequence that
the requests were sent, on a per-lockspace basis.  A recent change
in this request/reply matching code missed the "per-lockspace"
check (fsid comparison) when matching request and reply, so replies
could be incorrectly matched to requests from other lockspaces.

Cc: stable@vger.kernel.org
Reported-by: Barry Marson <bmarson@redhat.com>
Fixes: 57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspace")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dlm/plock.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -466,7 +466,8 @@ static ssize_t dev_write(struct file *fi
 		}
 	} else {
 		list_for_each_entry(iter, &recv_list, list) {
-			if (!iter->info.wait) {
+			if (!iter->info.wait &&
+			    iter->info.fsid == info.fsid) {
 				op = iter;
 				break;
 			}
@@ -478,8 +479,7 @@ static ssize_t dev_write(struct file *fi
 		if (info.wait)
 			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
 		else
-			WARN_ON(op->info.fsid != info.fsid ||
-				op->info.number != info.number ||
+			WARN_ON(op->info.number != info.number ||
 				op->info.owner != info.owner ||
 				op->info.optype != info.optype);
 


