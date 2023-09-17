Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932BC7A3AA8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbjIQUHA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbjIQUGz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234A97
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:06:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A63C433C7;
        Sun, 17 Sep 2023 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981209;
        bh=CBj0fMDm8TFafK74/N2USeIxosUOiYYnDc9/cniEeNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEmjFVSb2PmExflFcQ88t9nYge4vMKmvuDLXfIts0uNG15JzrGul77SlIF4zLcGTy
         CAg/AuIR46v0OliAIZrW0hphBdsVkJERWHXxSkJcbY9FgpDUowDvnxFHVFyLKQK1iu
         hWWSUpBpVYXig0GpkRVuECnMnHigwanoZ81pltqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/219] gfs2: Switch to wait_event in gfs2_logd
Date:   Sun, 17 Sep 2023 21:13:06 +0200
Message-ID: <20230917191043.147481622@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 6df373b09b1dcf2f7d579f515f653f89a896d417 ]

In gfs2_logd(), switch from an open-coded wait loop to
wait_event_interruptible_timeout().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Stable-dep-of: b74cd55aa9a9 ("gfs2: low-memory forced flush fixes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/log.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 61323deb80bc7..69c3facfcbef4 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1304,7 +1304,6 @@ int gfs2_logd(void *data)
 {
 	struct gfs2_sbd *sdp = data;
 	unsigned long t = 1;
-	DEFINE_WAIT(wait);
 
 	while (!kthread_should_stop()) {
 
@@ -1341,17 +1340,11 @@ int gfs2_logd(void *data)
 
 		try_to_freeze();
 
-		do {
-			prepare_to_wait(&sdp->sd_logd_waitq, &wait,
-					TASK_INTERRUPTIBLE);
-			if (!gfs2_ail_flush_reqd(sdp) &&
-			    !gfs2_jrnl_flush_reqd(sdp) &&
-			    !kthread_should_stop())
-				t = schedule_timeout(t);
-		} while(t && !gfs2_ail_flush_reqd(sdp) &&
-			!gfs2_jrnl_flush_reqd(sdp) &&
-			!kthread_should_stop());
-		finish_wait(&sdp->sd_logd_waitq, &wait);
+		t = wait_event_interruptible_timeout(sdp->sd_logd_waitq,
+				gfs2_ail_flush_reqd(sdp) ||
+				gfs2_jrnl_flush_reqd(sdp) ||
+				kthread_should_stop(),
+				t);
 	}
 
 	return 0;
-- 
2.40.1



