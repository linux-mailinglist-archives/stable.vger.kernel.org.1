Return-Path: <stable+bounces-108702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDAAA11E97
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0281883A66
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9121E7C32;
	Wed, 15 Jan 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vVDmYlN2"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF724816D;
	Wed, 15 Jan 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934661; cv=none; b=LVixlPYaIXcIbE4j6Ej/wwMthUi+7bTM7mkcT4fvz5hNWjqUQEGUkaolVS/rmU+cLCD+1Q5nXGvILGtxw+l3FlyohzlBJbRNnFQwY98WyxHLyc/EhKzGL5//ry2KaseEpaspSXoqiGLSexd/yqf4oGVqFb7wpGrt0Polyn+lIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934661; c=relaxed/simple;
	bh=nwfePTRPoRRFuCBUWXql9E3sSf2NsBtmCiTBH1uwAFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyyrPNMgt8Hn8HvLdtkRgjPR8raIWqduRfsHOfoB8/vVIxSVKaOWN9vHDvHYlMLHv5oZ7ez8PN2uzIh32iHUMHqQ5eKLAV4iDypZJBWcaPnA/0X8uyNwCR/ENd1wo/v/GQNy+mKWP0yICmBKlnI2Gda3cgIAKmRfojZ01z0UsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vVDmYlN2; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736934657; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3Rjkjm8Jq5H24ooOjCp1xVDbTvFXijBEgngWFzUKsAM=;
	b=vVDmYlN2tahMlHPeP60CtIwrDs8H9NpZ2v/95+7YXWZ+PAq8z0JL2qqMo1O4nRv5TSQZNQyRfA2BsvJrBZigNGg2EhxgSFL6bAWLtrkVTMlgtC9ksYcHebJQnCNYkeo07dbIEgSjRuthuRmPt1Ug9EQWiBlOXoPAANt8nQKIkqI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNi9tts_1736934655 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 17:50:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y 2/2] erofs: handle NONHEAD !delta[1] lclusters gracefully
Date: Wed, 15 Jan 2025 17:50:48 +0800
Message-ID: <20250115095048.2845612-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250115095048.2845612-1-hsiangkao@linux.alibaba.com>
References: <20250115095048.2845612-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0bc8061ffc733a0a246b8689b2d32a3e9204f43c upstream.

syzbot reported a WARNING in iomap_iter_done:
 iomap_fiemap+0x73b/0x9b0 fs/iomap/fiemap.c:80
 ioctl_fiemap fs/ioctl.c:220 [inline]

Generally, NONHEAD lclusters won't have delta[1]==0, except for crafted
images and filesystems created by pre-1.0 mkfs versions.

Previously, it would immediately bail out if delta[1]==0, which led to
inadequate decompressed lengths (thus FIEMAP is impacted).  Treat it as
delta[1]=1 to work around these legacy mkfs versions.

`lclusterbits > 14` is illegal for compact indexes, error out too.

Reported-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/67373c0c.050a0220.2a2fcc.0079.GAE@google.com
Tested-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Fixes: d95ae5e25326 ("erofs: add support for the full decompressed length")
Fixes: 001b8ccd0650 ("erofs: fix compact 4B support for 16k block size")
CVE: CVE-2024-53234
Link: https://lore.kernel.org/r/20241115173651.3339514-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 046eaaf16dad..2cd70cf4c8b2 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -256,7 +256,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int amortizedshift;
 	erofs_off_t pos;
 
-	if (lcn >= totalidx)
+	if (lcn >= totalidx || vi->z_logical_clusterbits > 14)
 		return -EINVAL;
 
 	m->lcn = lcn;
@@ -441,7 +441,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
 	int err;
 
-	do {
+	while (1) {
 		/* handle the last EOF pcluster (no next HEAD lcluster) */
 		if ((lcn << lclusterbits) >= inode->i_size) {
 			map->m_llen = inode->i_size - map->m_la;
@@ -453,14 +453,16 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return err;
 
 		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-			DBG_BUGON(!m->delta[1] &&
-				  m->clusterofs != 1 << lclusterbits);
+			/* work around invalid d1 generated by pre-1.0 mkfs */
+			if (unlikely(!m->delta[1])) {
+				m->delta[1] = 1;
+				DBG_BUGON(1);
+			}
 		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
 			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
 			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
-			/* go on until the next HEAD lcluster */
 			if (lcn != headlcn)
-				break;
+				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
 		} else {
 			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
@@ -469,8 +471,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return -EOPNOTSUPP;
 		}
 		lcn += m->delta[1];
-	} while (m->delta[1]);
-
+	}
 	map->m_llen = (lcn << lclusterbits) + m->clusterofs - map->m_la;
 	return 0;
 }
-- 
2.43.5


