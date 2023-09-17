Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801547A3CE7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbjIQUgu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjIQUg3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:36:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56410E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:36:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBCCC433C8;
        Sun, 17 Sep 2023 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982983;
        bh=Z8LpXU4rz0Jkr5dZqjS0HvtGVDVAPVmxjp0MVeW6SaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deoUPvbRYVPX6PU9Ail63gu6eb7AUEEf9ooB8nw2nOIfXRjChIsa0XMQ3idXmrBA/
         TopeUTwJsV+/pfEQh0gXuDuu1kjN8LyE9CSlCb9pkm0VNY7m3/L1k+zc6XTayvSN9f
         rp8/o4ZQCXsXOVPEvyRLAd0PaqGOKyj+N0fDs9oQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 409/511] gfs2: low-memory forced flush fixes
Date:   Sun, 17 Sep 2023 21:13:56 +0200
Message-ID: <20230917191123.662397627@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit b74cd55aa9a9d0aca760028a51343ec79812e410 ]

First, function gfs2_ail_flush_reqd checks the SDF_FORCE_AIL_FLUSH flag
to determine if an AIL flush should be forced in low-memory situations.
However, it also immediately clears the flag, and when called repeatedly
as in function gfs2_logd, the flag will be lost.  Fix that by pulling
the SDF_FORCE_AIL_FLUSH flag check out of gfs2_ail_flush_reqd.

Second, function gfs2_writepages sets the SDF_FORCE_AIL_FLUSH flag
whether or not enough pages were written.  If enough pages could be
written, flushing the AIL is unnecessary, though.

Third, gfs2_writepages doesn't wake up logd after setting the
SDF_FORCE_AIL_FLUSH flag, so it can take a long time for logd to react.
It would be preferable to wake up logd, but that hurts the performance
of some workloads and we don't quite understand why so far, so don't
wake up logd so far.

Fixes: b066a4eebd4f ("gfs2: forcibly flush ail to relieve memory pressure")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/aops.c | 4 ++--
 fs/gfs2/log.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index ee212c9310ad0..2b654c3b918a3 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -207,13 +207,13 @@ static int gfs2_writepages(struct address_space *mapping,
 	int ret;
 
 	/*
-	 * Even if we didn't write any pages here, we might still be holding
+	 * Even if we didn't write enough pages here, we might still be holding
 	 * dirty pages in the ail. We forcibly flush the ail because we don't
 	 * want balance_dirty_pages() to loop indefinitely trying to write out
 	 * pages held in the ail that it can't find.
 	 */
 	ret = iomap_writepages(mapping, wbc, &wpc, &gfs2_writeback_ops);
-	if (ret == 0)
+	if (ret == 0 && wbc->nr_to_write > 0)
 		set_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 	return ret;
 }
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 924d7f0de1e83..9a96842aeab3d 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1277,9 +1277,6 @@ static inline int gfs2_ail_flush_reqd(struct gfs2_sbd *sdp)
 {
 	unsigned int used_blocks = sdp->sd_jdesc->jd_blocks - atomic_read(&sdp->sd_log_blks_free);
 
-	if (test_and_clear_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags))
-		return 1;
-
 	return used_blocks + atomic_read(&sdp->sd_log_blks_needed) >=
 		atomic_read(&sdp->sd_log_thresh2);
 }
@@ -1320,7 +1317,9 @@ int gfs2_logd(void *data)
 						  GFS2_LFC_LOGD_JFLUSH_REQD);
 		}
 
-		if (gfs2_ail_flush_reqd(sdp)) {
+		if (test_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags) ||
+		    gfs2_ail_flush_reqd(sdp)) {
+			clear_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 			gfs2_ail1_start(sdp);
 			gfs2_ail1_wait(sdp);
 			gfs2_ail1_empty(sdp, 0);
@@ -1333,6 +1332,7 @@ int gfs2_logd(void *data)
 		try_to_freeze();
 
 		t = wait_event_interruptible_timeout(sdp->sd_logd_waitq,
+				test_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags) ||
 				gfs2_ail_flush_reqd(sdp) ||
 				gfs2_jrnl_flush_reqd(sdp) ||
 				kthread_should_stop(),
-- 
2.40.1



