Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D127A7D45
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjITMIB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjITMIA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:08:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC90AC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:07:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E77C433C8;
        Wed, 20 Sep 2023 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211674;
        bh=df4yxF3BUCsLXEgRBcbOqMM7k+vBT+OE8+nkpn9GEiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFgRft0NZhZ8aoV+X0uU2GqAng9kIeHuY5R4lhWsQrxP9WNDj3HN8vrSo2Awjmtef
         KsTz7/OEf/XGesZFbxl3nRehUPAJX8fHyoxU7TjAnG0DyVY65aBCdEKduwL4OxtGVl
         GCj7ancQJYuClE2E0Xomr3J5C59vKBx+NBIFrCSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhi Li <yieli@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 4.14 180/186] nfsd: fix change_info in NFSv4 RENAME replies
Date:   Wed, 20 Sep 2023 13:31:23 +0200
Message-ID: <20230920112843.393797195@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

commit fdd2630a7398191e84822612e589062063bd4f3d upstream.

nfsd sends the transposed directory change info in the RENAME reply. The
source directory is in save_fh and the target is in current_fh.

Reported-by: Zhi Li <yieli@redhat.com>
Reported-by: Benjamin Coddington <bcodding@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2218844
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -870,8 +870,8 @@ nfsd4_rename(struct svc_rqst *rqstp, str
 			     rename->rn_tname, rename->rn_tnamelen);
 	if (status)
 		return status;
-	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
-	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_sinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_tinfo, &cstate->current_fh);
 	return nfs_ok;
 }
 


