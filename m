Return-Path: <stable+bounces-166647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3AEB1BB2C
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 21:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFF018A8039
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 19:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA4289813;
	Tue,  5 Aug 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M1w8NVA1"
X-Original-To: stable@vger.kernel.org
Received: from sonic.asd.mail.yahoo.com (sonic306-20.consmr.mail.sg3.yahoo.com [106.10.241.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE95270551
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423425; cv=none; b=gmwq4XgObPFE9AkMV26z9VBYWr0Lg3sL4EmYbQ90x76/53iNmpb10rOXccY5k1tgFJfn7mgi/44M0TX7He4lb8yxNgAxR4MkF+2Ss7v6veOb/ttMtcW/1zY0jaGcoguzoL3ZIdwZ4u0GHMZxr02K5ieypmerkva+IULr4GyLZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423425; c=relaxed/simple;
	bh=ajefu/XpiABW3hLAC6IZOz6zrZrUpYBpFvddSuDg7o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=gXpklQ2dW1vUis8ytkymlOv2dUKNRxls8CrbUjbj0vxH5DT43cIvIpncocxNBA0KUob/ff8jrQieXpVkCRmb4xn3+aPZm1DgaEGTwlHQnJqUirlyzDnH94JRGzIwrdr9tFDqycd120fTLUIh4FPDSwnZGsvSDrV5UlgoE7JY7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=M1w8NVA1; arc=none smtp.client-ip=106.10.241.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754423421; bh=+MODNQyYtZacIV3M94jpCN5VGFvspUT3n/gFK38eANc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=M1w8NVA1LQ200RTGnp85O1xXo8HKrIB1QETNCmZspxhZDdUj/i7Ayy0A6fE6LxS/xROli+0YloMcAbu9SXZGz6gfdom/kQWieyy7CgL4+JfvR1Q4HuIQgOJmTLTEKBwWeV0Z+fr5S/vNHtrI79HeffrLtoFYpepv597x3AQB+oip4OCiSoVhWZTlJkVq5upUL39Dfz0bJem/V+kcvdN7OK3+yXgMUFO4PaGWe1U7cJtfnr/LYknR7VxY8eedVC4u/0TlAWPv+XFde4MsG0A2Qtru13bmCTLVmPKOZASdgVRUFEc7//Il57w7WwGOzl6KfiRB2n0lpRurOQBluOLr9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754423421; bh=79E1hSZf/bfQyA9WFU0zFZFvLuuvawJ5pc6jAv88aYS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iUtmkCZ0vmmrl8P4cGV3Xw3bNmwdLhwhY+PPwgTwLjkaqwPrmMM13lgK666u+C0HMrFVpvaC7cY2Ob5TytFbNtH0mgq/j5UN97jxsU+0w5mmAgBW7p6UsR1O/CoqL+f19urE7isw2R9hdi/EbLGToN2KYAG8G7gTN80mREriq1RE+olkUtrcZ8bsJpoF/4vedmCfvWnQ2utn+f6UPZqwcFr97r9n3yblzrJE0wJWe0dbnnrG/5pM7Zy7/J5UTAVnN40vNUGiR3xP2aCFXEuUdnZDifiZ0XjX1OpHSdQ0Lfnj4ysz+BGMFq+xI2ueK0ZSfOf3ZTd1OJhOzkAVywP5GA==
X-YMail-OSG: lbh.FcEVM1kwGVRa6plSVmx5SyRcOda_HdGGIl_9QhbT5ZGqT4DmHJJjbbHMCi3
 DqS6hBc8yb.CRixsQNTPXHzdGtzUPgWvVrFnO7ikqj.i32TzSTQ0TX_JIzGKk_TOY1zM3jFI4.ly
 qQBr34HnjJx09rfgRjG.aXs2lMk6KINUd._dYwYMnp_9O5Q.Y6qdD2QO6.PsfpY5peAgxZVAYfHD
 vMDSHbtwEgQ8vSrBSoBK.AaXZmsxOm19l6oMpjtP1GUXEeS_zdqUFiJ0e0rn4Gd5RtZ_utthTUMy
 F98LzuPPfOvPABiXFS_TD8DMXnUOyaX8hDPn04dBftx5uRG.TsFG1Uz8hmd9bjocPgB79WrNvAMh
 YoZj1enFuTEuvAyq3nDI2ogIDH9v9XvCwOMNFfogAl8RKTObqv2ayU_3yqnVYqN.c2v5vkrdXqZl
 XPXMUv2KS9QGUSVy6JT5fd_IM1dWjAzEwD7rXIcmN6hvAP47ZlOgGmgvrSDss.yVEmfFXNmfTT5x
 _Wr9FKs0KgLSr_anJ5DtgcHqyDiEbQ3TiTSyK_k7650lad5l_QjrrkezlXwdw.HzlyPm_5C31Fq_
 Y1.Ro8uQhd5zDuReZrBeS3idofBxkItcUvg76zjoU5ANlFvWHVi3iyGC79pHHI2RZOL36Bm7FPmg
 L_Mi6Clf2V4jyD_RxrON.JQlAbmao0brAWU_M429c.rbM2FjrkgNIauhLva2mKCvKi4Jka5TKQOq
 RcsRQ.kX9lckI_a5u3T3kLZ4g75AKb06uuldPnf4JAMG3t3LBBMaYtUz3U69PB5jnlGTCptqAXdZ
 duTOQ85C197MMZJySYeILqJs.QyvAZ2p5WvIuTp8fpgCMU.AZGK6QmEtoXPOoiw7CTlHl0GC7wDE
 mrqU7v.3LRjdKw6KIt2DuD.CSODcaJJnZ7hw6QcrRmcsyDaB2RYYaPhKiv4.eBUzcOq6HtDmcKas
 NEvDM8ttHpuqEO0RC2Jn_h2k3pOmIS4plFlXiI6JQme62HIKrFQLijsUsltJ5nFpYC1WM_ePvuG0
 mkyDHb5A8HedBAs2biRr.KNfxEkFmzFfYSAXfMaUaSepkKv5ZBlsGxwEDTM85Z.gu_JMn1jNjzNp
 Bo3HjYgSCgmL9p8pNavUkyZOC1jqNX8d3OsvqeVVjNNjYFzmW3uAemAGsSvf5XiNCQCtS8tjV_R6
 KcpwxCD46rvPGgekwJEU1oWaY6ngBZHLgk280.Y_TKGgQnS8HCG00oa87t7DLRQObsIzhE2fM8N9
 7MkxwVc2CgDVlBhR3OdUUDNT6SWjujbeES51SoeDx6JhJSBgkpgjqhRHxaMO5_pEs9NTH8eixP5b
 OcORJvHGVUjKaXZ78u_Ee8FWIm5Nm5bgF1aKr6nJdda8HvZ0kYAr1zLmL500bJyrbqy2fTv2mDpN
 AXF6uGhra97Eg98zzrYpgBStiwZPM.rYE381XOd8srFoBU5T9LNYltLP8uy8cEL8JfdIQiYNZrQk
 0Eu3SEaTM4RtEhY7qbZiXljPk8rdePvnZxoeNNAFYHkybvNPaUcKypYU83_b1gmqY9KLHNNTAD79
 4UQZhByk.rCNz4ylDgh4BjB6PN9RIKRvZ.YUoyf87wq7nrHjDh_y_oUc4FumPvp6d9uGoSzwmxzN
 jj7fO_hlYmdvBRRZAmcsFvg9IiqAdoTzK.hE9.rEMsPm4GhpPJfleMJAdNuD.Ds2Q0_KZGGnrjER
 iHoPqCQ0eiEUfgTWxx11ujkkyzXx1UTjRY0LTV.kYdKeHHm4CIQWIKwrLyWbpo2bfj9EUS0OS.OZ
 CLcZGJ4nI3hgIfvMKcxoHUNkt8NahgiNE5bGix7gnwjeHhPqx_Ij.glcl8.dZRq7r6MVGyKjG.nP
 yDsyZowLuAL20ijrE0GheEvA4vvd5NQ_Dwl4.dS9RLvOx2zvYGTr.XmQIfsxRfVj8SKS5n4TmupY
 _ir6VzRBK2mPZf4eCAvFYWLzLqm2AZFcNwcWCjUa.mZpDyxnz9prxxH33WqTqDkBy6ItcVtLOpYK
 HYqMfGqgXrVWV5LAE.Ht0f6QeNQTz2nw0tKKMyqg9IA_WVgAThJzuUbeaWvGM7HbjU40LB__vI4J
 csNg1THGZ4bIVk_sAxrB8C4zm4Rf0bsYsHEkilhcOW.yXSmzcXK_GdNFcYvydgi2U75Ymp.B.01c
 39cx659epNtUn3AL68cbhneNmt.Yi6_AzQNRMZ2f1djojSwImPxM3Y3BO33BA8aTKc2.Q56lnYiO
 0JCwmwKeP6C6_93qQlbPbF3vSkZV2kh76rdNI7Hocw_eVTky0MXtLXl.Qh12WHQSsdRoEOjZ0XSO
 kPwkPSs8xqHczLw.TdBwbohmBEKX7yI9gQcfHGg--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 138cfcb2-21cd-401b-983d-d750719ac2a1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Tue, 5 Aug 2025 19:50:21 +0000
Received: by hermes--production-ne1-9495dc4d7-27szc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6c357f7640c1af4f723f6a091515b028;
          Tue, 05 Aug 2025 19:40:09 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: rpeterso@redhat.com,
	agruenba@redhat.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.6] gfs2: replace sd_aspace with sd_inode
Date: Tue,  5 Aug 2025 14:40:04 -0500
Message-ID: <20250805194005.327445-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250805194005.327445-1-sumanth.gavini.ref@yahoo.com>

commit ae9f3bd8259a0a8f67be2420e66bb05fbb95af48 upstream.

Currently, sdp->sd_aspace and the per-inode metadata address spaces use
sb->s_bdev->bd_mapping->host as their ->host; folios in those address
spaces will thus appear to be on bdev rather than on gfs2 filesystems.
This is a problem because gfs2 doesn't support cgroup writeback
(SB_I_CGROUPWB), but bdev does.

Fix that by using a "dummy" gfs2 inode as ->host in those address
spaces.  When coming from a folio, folio->mapping->host->i_sb will then
be a gfs2 super block and the SB_I_CGROUPWB flag will not be set in
sb->s_iflags.

Based on a previous version from Bob Peterson from several years ago.
Thanks to Tetsuo Handa, Jan Kara, and Rafael Aquini for helping figure
this out.

Fixes: aaa2cacf8184 ("writeback: add lockdep annotation to inode_to_wb()")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 fs/gfs2/glock.c      |  3 +--
 fs/gfs2/glops.c      |  4 ++--
 fs/gfs2/incore.h     |  9 ++++++++-
 fs/gfs2/meta_io.c    |  2 +-
 fs/gfs2/meta_io.h    |  4 +---
 fs/gfs2/ops_fstype.c | 28 ++++++++++++++++------------
 fs/gfs2/super.c      |  2 +-
 7 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4a280be229a6..7ab1b4dac0bb 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1146,7 +1146,6 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 		   const struct gfs2_glock_operations *glops, int create,
 		   struct gfs2_glock **glp)
 {
-	struct super_block *s = sdp->sd_vfs;
 	struct lm_lockname name = { .ln_number = number,
 				    .ln_type = glops->go_type,
 				    .ln_sbd = sdp };
@@ -1210,7 +1209,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
                 mapping->a_ops = &gfs2_meta_aops;
-		mapping->host = s->s_bdev->bd_inode;
+		mapping->host = sdp->sd_inode;
 		mapping->flags = 0;
 		mapping_set_gfp_mask(mapping, GFP_NOFS);
 		mapping->private_data = NULL;
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index f41ca89d216b..5877afdb11c5 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -165,7 +165,7 @@ void gfs2_ail_flush(struct gfs2_glock *gl, bool fsync)
 static int gfs2_rgrp_metasync(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct address_space *metamapping = &sdp->sd_aspace;
+	struct address_space *metamapping = gfs2_aspace(sdp);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	const unsigned bsize = sdp->sd_sb.sb_bsize;
 	loff_t start = (rgd->rd_addr * bsize) & PAGE_MASK;
@@ -222,7 +222,7 @@ static int rgrp_go_sync(struct gfs2_glock *gl)
 static void rgrp_go_inval(struct gfs2_glock *gl, int flags)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct address_space *mapping = &sdp->sd_aspace;
+	struct address_space *mapping = gfs2_aspace(sdp);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	const unsigned bsize = sdp->sd_sb.sb_bsize;
 	loff_t start, end;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index a8c95c5293c6..52712ec33d91 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -795,7 +795,7 @@ struct gfs2_sbd {
 
 	/* Log stuff */
 
-	struct address_space sd_aspace;
+	struct inode *sd_inode;
 
 	spinlock_t sd_log_lock;
 
@@ -850,6 +850,13 @@ struct gfs2_sbd {
 	unsigned long sd_glock_dqs_held;
 };
 
+#define GFS2_BAD_INO 1
+
+static inline struct address_space *gfs2_aspace(struct gfs2_sbd *sdp)
+{
+	return sdp->sd_inode->i_mapping;
+}
+
 static inline void gfs2_glstats_inc(struct gfs2_glock *gl, int which)
 {
 	gl->gl_stats.stats[which]++;
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 924361fa510b..fca8ea2f4504 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -122,7 +122,7 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 	unsigned int bufnum;
 
 	if (mapping == NULL)
-		mapping = &sdp->sd_aspace;
+		mapping = gfs2_aspace(sdp);
 
 	shift = PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
 	index = blkno >> shift;             /* convert block to page */
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index d0a58cdd433a..a4c3865137d4 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -44,9 +44,7 @@ static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
 		struct gfs2_glock_aspace *gla =
 			container_of(mapping, struct gfs2_glock_aspace, mapping);
 		return gla->glock.gl_name.ln_sbd;
-	} else if (mapping->a_ops == &gfs2_rgrp_aops)
-		return container_of(mapping, struct gfs2_sbd, sd_aspace);
-	else
+    } else
 		return inode->i_sb->s_fs_info;
 }
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 33ca04733e93..9933c7328dcb 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -72,7 +72,6 @@ void free_sbd(struct gfs2_sbd *sdp)
 static struct gfs2_sbd *init_sbd(struct super_block *sb)
 {
 	struct gfs2_sbd *sdp;
-	struct address_space *mapping;
 
 	sdp = kzalloc(sizeof(struct gfs2_sbd), GFP_KERNEL);
 	if (!sdp)
@@ -110,16 +109,6 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 
 	INIT_LIST_HEAD(&sdp->sd_sc_inodes_list);
 
-	mapping = &sdp->sd_aspace;
-
-	address_space_init_once(mapping);
-	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping->host = sb->s_bdev->bd_inode;
-	mapping->flags = 0;
-	mapping_set_gfp_mask(mapping, GFP_NOFS);
-	mapping->private_data = NULL;
-	mapping->writeback_index = 0;
-
 	spin_lock_init(&sdp->sd_log_lock);
 	atomic_set(&sdp->sd_log_pinned, 0);
 	INIT_LIST_HEAD(&sdp->sd_log_revokes);
@@ -1159,6 +1148,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	int silent = fc->sb_flags & SB_SILENT;
 	struct gfs2_sbd *sdp;
 	struct gfs2_holder mount_gh;
+	struct address_space *mapping;
 	int error;
 
 	sdp = init_sbd(sb);
@@ -1206,9 +1196,21 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 		sdp->sd_tune.gt_statfs_quantum = 30;
 	}
 
+	/* Set up an address space for metadata writes */
+	sdp->sd_inode = new_inode(sb);
+	error = -ENOMEM;
+	if (!sdp->sd_inode)
+		goto fail_free;
+	sdp->sd_inode->i_ino = GFS2_BAD_INO;
+	sdp->sd_inode->i_size = OFFSET_MAX;
+
+	mapping = gfs2_aspace(sdp);
+	mapping->a_ops = &gfs2_rgrp_aops;
+	mapping_set_gfp_mask(mapping, GFP_NOFS);
+
 	error = init_names(sdp, silent);
 	if (error)
-		goto fail_free;
+		goto fail_iput;
 
 	snprintf(sdp->sd_fsname, sizeof(sdp->sd_fsname), "%s", sdp->sd_table_name);
 
@@ -1327,6 +1329,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	gfs2_sys_fs_del(sdp);
 fail_delete_wq:
 	destroy_workqueue(sdp->sd_delete_wq);
+fail_iput:
+	iput(sdp->sd_inode);
 fail_free:
 	free_sbd(sdp);
 	sb->s_fs_info = NULL;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b..47e0b5c96d1c 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -642,7 +642,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_jindex_free(sdp);
 	/*  Take apart glock structures and buffer lists  */
 	gfs2_gl_hash_clear(sdp);
-	truncate_inode_pages_final(&sdp->sd_aspace);
+	iput(sdp->sd_inode);
 	gfs2_delete_debugfs_file(sdp);
 	/*  Unmount the locking protocol  */
 	gfs2_lm_unmount(sdp);
-- 
2.43.0


