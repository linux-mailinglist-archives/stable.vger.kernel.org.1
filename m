Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157847353F1
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjFSKu3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjFSKtf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F148C199A
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7661960B86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C3DC433C0;
        Mon, 19 Jun 2023 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171767;
        bh=RvhLnMwvMVtq6iBrmjN0Z+XxIqZxJitgSVyn6zb+lrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=04DNx/evOjip+Evfm2KZ+pw/1tLsNVhnjb9EWZddEeKw9FD6mEJEHwEpBcgGdPpEH
         7zLOMs5jtQNHIFiTvBxcHYAKchDvfw5ByWEX0HlKN7Or0RNcaQOSRtmQ/IZEb2S/Jm
         jpS1cnT0efhdN+Wg7DBugN4Uqh0Bom23lWr7Y0K0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Lingfeng <lilingfeng3@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 150/166] dm: dont lock fs when the map is NULL during suspend or resume
Date:   Mon, 19 Jun 2023 12:30:27 +0200
Message-ID: <20230619102201.981049430@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Lingfeng <lilingfeng3@huawei.com>

[ Upstream commit 2760904d895279f87196f0fa9ec570c79fe6a2e4 ]

As described in commit 38d11da522aa ("dm: don't lock fs when the map is
NULL in process of resume"), a deadlock may be triggered between
do_resume() and do_mount().

This commit preserves the fix from commit 38d11da522aa but moves it to
where it also serves to fix a similar deadlock between do_suspend()
and do_mount().  It does so, if the active map is NULL, by clearing
DM_SUSPEND_LOCKFS_FLAG in dm_suspend() which is called by both
do_suspend() and do_resume().

Fixes: 38d11da522aa ("dm: don't lock fs when the map is NULL in process of resume")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c | 5 +----
 drivers/md/dm.c       | 4 ++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 83aecd9250ba6..6ae1c19b82433 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1151,13 +1151,10 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
-		int srcu_idx;
 
 		/* Suspend if it isn't already suspended */
-		old_map = dm_get_live_table(md, &srcu_idx);
-		if ((param->flags & DM_SKIP_LOCKFS_FLAG) || !old_map)
+		if (param->flags & DM_SKIP_LOCKFS_FLAG)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
-		dm_put_live_table(md, srcu_idx);
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 		if (!dm_suspended_md(md))
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 24284d22f15bc..acf7e7551c941 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2801,6 +2801,10 @@ int dm_suspend(struct mapped_device *md, unsigned int suspend_flags)
 	}
 
 	map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
+	if (!map) {
+		/* avoid deadlock with fs/namespace.c:do_mount() */
+		suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+	}
 
 	r = __dm_suspend(md, map, suspend_flags, TASK_INTERRUPTIBLE, DMF_SUSPENDED);
 	if (r)
-- 
2.39.2



