Return-Path: <stable+bounces-216850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDAYG0yHlGmWFQIAu9opvQ
	(envelope-from <stable+bounces-216850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:20:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45B914D887
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C89F302AC3D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4D274B4A;
	Tue, 17 Feb 2026 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw4kTHfI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39E22424C
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341635; cv=none; b=A7qGwny+SQyuFVcXf5oxjsRk9QnRLumsTXUHsAlNPqsnJD6dwhyYh0oSIk2Gsw0kM798cn8JVl+jvuV51kf1IbfoDC47OVQ/KJSEMRTAJB4kO+kGWv3nyBxQ+/yAR1heiKO1/l+a9FyeieNlkLyE/c0WLCDNrjcq0ulHNdzMKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341635; c=relaxed/simple;
	bh=b5R3eW/5jT1u7TJo9PZAa2aIc5jmgj0vdghjkJ4JGRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI2V6YqpnAa6qX6Ie52MLBJqV3/y9PH5RvPydCTVb3r2O7xnxP5l5lSsuJCsNdp/V4zUqdl/HhRDx+Q/6uvcqhr8jaKu1ACwA8jNJskIXXkDwa/R1pVlu4NfMo0rSmaSs48ZwbcFHCFFdxT44cw2FbF4Q7ksVWZVzkVBOkN2y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw4kTHfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6E2C4CEF7;
	Tue, 17 Feb 2026 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771341635;
	bh=b5R3eW/5jT1u7TJo9PZAa2aIc5jmgj0vdghjkJ4JGRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yw4kTHfIuWrqfVPpY0pncMIDscH2hhq6UE3qIOpi5zytvJUXBPW7UpLIGOeh/QtCV
	 E46VbmfDKqHyzs04oLq9tpICxFfG9lAJZzwB9CG0VjHR2ZMlcPGDHlurj0Fh81OSeA
	 prNbqZswfIlcYi1sYl3mPvYQPMhjJ92q4yhIuaKGxD7LB63vkVsi3uapvyhEjLp/5b
	 D/HYs2lMLrb1o69DVw24N7XwoGqDrwmQRoGc58M6XTYXBMcgZ4fl53+VfFaL3zbdju
	 0k8QWBwaRZa3hoRyV8RiXKGIVNCbbYmZT0m6O7BPRHTEEJAGsfPjH1DDtsMfCtyzIB
	 JaTnUvITQrPOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: fix zoned block device information initialization
Date: Tue, 17 Feb 2026 10:20:31 -0500
Message-ID: <20260217152032.3680679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021700-wrongness-undermine-54e0@gregkh>
References: <2026021700-wrongness-undermine-54e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216850-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C45B914D887
X-Rspamd-Action: no action

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit 0f9b12142be1af8555cfe53c6fbecb8e60a40dac ]

If the max open zones of zoned devices are less than
the active logs of F2FS, the device may error due to
insufficient zone resources when multiple active logs
are being written at the same time.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 5c145c03188b ("f2fs: fix to avoid mapping wrong physical block for swapfile")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9a4eabd11c734..d7afa8bc0ff8e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1567,6 +1567,7 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dd6cd014fefb0..9bd71d68cd95c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2359,6 +2359,17 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi) &&
+		sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max open zones %u is too small, need at least %u open zones",
+				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+		err = -EINVAL;
+		goto restore_opts;
+	}
+#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -3902,11 +3913,24 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	sector_t nr_sectors = bdev_nr_sectors(bdev);
 	struct f2fs_report_zones_args rep_zone_arg;
 	u64 zone_sectors;
+	unsigned int max_open_zones;
 	int ret;
 
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	if (bdev_is_zoned(FDEV(devi).bdev)) {
+		max_open_zones = bdev_max_open_zones(bdev);
+		if (max_open_zones && (max_open_zones < sbi->max_open_zones))
+			sbi->max_open_zones = max_open_zones;
+		if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+			f2fs_err(sbi,
+				"zoned: max open zones %u is too small, need at least %u open zones",
+				sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+			return -EINVAL;
+		}
+	}
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
 				SECTOR_TO_BLOCK(zone_sectors))
@@ -4188,6 +4212,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
 	sbi->aligned_blksize = true;
+#ifdef CONFIG_BLK_DEV_ZONED
+	sbi->max_open_zones = UINT_MAX;
+#endif
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-- 
2.51.0


