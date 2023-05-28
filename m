Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0A713F6D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjE1TpT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjE1TpS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A79B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5275561F39
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC5CC433D2;
        Sun, 28 May 2023 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303116;
        bh=svX6p8RpOfbWOOhKfH6X87MPrUCKFo6yKVCFjmgu7FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdXYfIr9nZzvR+eSQwS9VM9Me8cnm1rvLo2X4eT/1pTP1y7pOLFCsGgIZx9ZDL1Y3
         Bv8+CypDZ4g0zVWydNpx4mczx/5uuDrLv+Wvm6hOxCO15Cjn+BGd8kBHl8PeVHgQH1
         TDc/aHJPbRH6ft7Sp6yAg5j/6+5BgloxK1K0fjdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Greg Thelen <gthelen@google.com>
Subject: [PATCH 5.10 161/211] writeback, cgroup: remove extra percpu_ref_exit()
Date:   Sun, 28 May 2023 20:11:22 +0100
Message-Id: <20230528190847.502997819@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Greg Thelen <gthelen@google.com>

5.10 stable commit 2b00b2a0e642 ("writeback, cgroup: fix null-ptr-deref
write in bdi_split_work_to_wbs") is a backport of upstream 6.3 commit
1ba1199ec574.

In the 5.10 stable commit backport percpu_ref_exit() is called twice:
first in cgwb_release_workfn() and then in cgwb_free_rcu(). The 2nd call
is benign as percpu_ref_exit() internally detects there's nothing to do.

This fixes an non-upstream issue that only applies to 5.10.y.

Fixes: 2b00b2a0e642 ("writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs")
Signed-off-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/backing-dev.c |    1 -
 1 file changed, 1 deletion(-)

--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -404,7 +404,6 @@ static void cgwb_release_workfn(struct w
 	blkcg_unpin_online(blkcg);
 
 	fprop_local_destroy_percpu(&wb->memcg_completions);
-	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
 	call_rcu(&wb->rcu, cgwb_free_rcu);
 }


