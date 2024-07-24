Return-Path: <stable+bounces-61291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD2A93B242
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86A1284C7C
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 14:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D30159217;
	Wed, 24 Jul 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmANyIPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6521591FC;
	Wed, 24 Jul 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830095; cv=none; b=j5OI8WMoRSx72hkEn2XAZMVRQzvQvAiFLrO3uxGynlN2yv6ZbMvBHFhSNjUp6eGcXPyfX2tsqPByMWIWGbIDYMuz/vcrvSXXSjw2w7mOlbP/lsiRxj8cKNclWzfu+20omMXq6mS0SdLiv160Iwk6KrOfSxDbFGkiNo9MNz4p9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830095; c=relaxed/simple;
	bh=QmQE3RANXAxwAPFq3hm3fsYTfUNnvB67NIGWJNKqD5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plx6WlYeOOVnVu61TZXNmsmdXiFfiUBK1F6TgeDxfrYvn0AX3hXr/RHODrAyi30v4iLpWqs1OFg/t0qxnrnnQlpRJHILZomLat0OjYw4q0vf6CC8i9y8/b3B/Cl2gEMrexE4rYtQTcPmESFCVpSG7zfC727r/OCQBvMyijThSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmANyIPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6081C32781;
	Wed, 24 Jul 2024 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721830094;
	bh=QmQE3RANXAxwAPFq3hm3fsYTfUNnvB67NIGWJNKqD5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmANyIPgH5FTA0r5hXz5M2QWdfj6T8k3NslfhXbXSs47eAydKpvdCw8sZzy2ctuZ9
	 2slgG5RSND+V9tyYDyeX6xjl2JMxikGPJ9qkc7jGORiNHXbgkccMOf7xWTaBC7S8Bb
	 /eD8UQy+WyYj0SFWyssQz67FEg5cQftghrxy1Tho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.10.1
Date: Wed, 24 Jul 2024 16:08:01 +0200
Message-ID: <2024072401-facecloth-partly-ecc8@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024072401-barmaid-profusely-6d62@gregkh>
References: <2024072401-barmaid-profusely-6d62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 3d10e3aadeda..9ae12a6c0ece 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 10
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 2281d55df545..d3521aadd43e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -746,15 +746,16 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	struct tpm2_auth *auth = chip->auth;
 	off_t offset_s, offset_p;
 	u8 rphash[SHA256_DIGEST_SIZE];
-	u32 attrs;
+	u32 attrs, cc;
 	struct sha256_state sctx;
 	u16 tag = be16_to_cpu(head->tag);
-	u32 cc = be32_to_cpu(auth->ordinal);
 	int parm_len, len, i, handles;
 
 	if (!auth)
 		return rc;
 
+	cc = be32_to_cpu(auth->ordinal);
+
 	if (auth->session >= TPM_HEADER_SIZE) {
 		WARN(1, "tpm session not filled correctly\n");
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 61a4638d1be2..237cb1ef7975 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -622,7 +622,12 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 
 	if (!iwl_mvm_firmware_running(mvm) ||
 	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
-		ret = -ENODATA;
+		/*
+		 * Tell the core that there is no valid temperature value to
+		 * return, but it need not worry about this.
+		 */
+		*temperature = THERMAL_TEMP_INVALID;
+		ret = 0;
 		goto out;
 	}
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ecc748d15eb7..4e7fec406ee5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -300,8 +300,6 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
-	else if (tz->temperature == THERMAL_TEMP_INVALID)
-		thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
 }
 
 static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
@@ -382,7 +380,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 	td->threshold = trip->temperature;
 
 	if (tz->last_temperature >= old_threshold &&
-	    tz->last_temperature != THERMAL_TEMP_INVALID) {
+	    tz->last_temperature != THERMAL_TEMP_INIT) {
 		/*
 		 * Mitigation is under way, so it needs to stop if the zone
 		 * temperature falls below the low temperature of the trip.
@@ -417,27 +415,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 	}
 }
 
-static void update_temperature(struct thermal_zone_device *tz)
-{
-	int temp, ret;
-
-	ret = __thermal_zone_get_temp(tz, &temp);
-	if (ret) {
-		if (ret != -EAGAIN)
-			dev_warn(&tz->device,
-				 "failed to read out thermal zone (%d)\n",
-				 ret);
-		return;
-	}
-
-	tz->last_temperature = tz->temperature;
-	tz->temperature = temp;
-
-	trace_thermal_temperature(tz);
-
-	thermal_genl_sampling_temp(tz->id, temp);
-}
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
@@ -452,7 +429,7 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
-	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->temperature = THERMAL_TEMP_INIT;
 	tz->passive = 0;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
@@ -501,6 +478,7 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	struct thermal_trip_desc *td;
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
+	int temp, ret;
 
 	if (tz->suspended)
 		return;
@@ -508,10 +486,29 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (!thermal_zone_device_is_enabled(tz))
 		return;
 
-	update_temperature(tz);
+	ret = __thermal_zone_get_temp(tz, &temp);
+	if (ret) {
+		if (ret != -EAGAIN)
+			dev_info(&tz->device, "Temperature check failed (%d)\n", ret);
 
-	if (tz->temperature == THERMAL_TEMP_INVALID)
+		thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
+		return;
+	} else if (temp <= THERMAL_TEMP_INVALID) {
+		/*
+		 * Special case: No valid temperature value is available, but
+		 * the zone owner does not want the core to do anything about
+		 * it.  Continue regular zone polling if needed, so that this
+		 * function can be called again, but skip everything else.
+		 */
 		goto monitor;
+	}
+
+	tz->last_temperature = tz->temperature;
+	tz->temperature = temp;
+
+	trace_thermal_temperature(tz);
+
+	thermal_genl_sampling_temp(tz->id, temp);
 
 	__thermal_zone_set_trips(tz);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 94eeb4011a48..5afd541d54b0 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -133,6 +133,9 @@ struct thermal_zone_device {
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
 
+/* Initial thermal zone temperature. */
+#define THERMAL_TEMP_INIT	INT_MIN
+
 /*
  * Default delay after a failing thermal zone temperature check before
  * attempting to check it again.
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index d9f4e26ec125..36f872b840ba 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -140,6 +140,8 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	}
 
 	ret = __thermal_zone_get_temp(tz, temp);
+	if (!ret && *temp <= THERMAL_TEMP_INVALID)
+		ret = -ENODATA;
 
 unlock:
 	mutex_unlock(&tz->lock);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 983dad8c07ec..efed7f09876d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1347,7 +1347,7 @@ struct ext4_super_block {
 /*60*/	__le32	s_feature_incompat;	/* incompatible feature set */
 	__le32	s_feature_ro_compat;	/* readonly-compatible feature set */
 /*68*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
-/*78*/	char	s_volume_name[EXT4_LABEL_MAX];	/* volume name */
+/*78*/	char	s_volume_name[EXT4_LABEL_MAX] __nonstring; /* volume name */
 /*88*/	char	s_last_mounted[64] __nonstring;	/* directory where last mounted */
 /*C8*/	__le32	s_algorithm_usage_bitmap; /* For compression */
 	/*
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index dab7acd49709..e8bf5972dd47 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1151,7 +1151,7 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
 	BUILD_BUG_ON(EXT4_LABEL_MAX >= FSLABEL_MAX);
 
 	lock_buffer(sbi->s_sbh);
-	strscpy_pad(label, sbi->s_es->s_volume_name);
+	memtostr_pad(label, sbi->s_es->s_volume_name);
 	unlock_buffer(sbi->s_sbh);
 
 	if (copy_to_user(user_label, label, sizeof(label)))
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 6397fdefd876..c92937bed133 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1359,7 +1359,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	target_tcon = tlink_tcon(smb_file_target->tlink);
 
 	if (src_tcon->ses != target_tcon->ses) {
-		cifs_dbg(VFS, "source and target of copy not on same server\n");
+		cifs_dbg(FYI, "source and target of copy not on same server\n");
 		goto out;
 	}
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 1374635e89fa..04ec1b9737a8 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -123,6 +123,11 @@ static void cifs_issue_write(struct netfs_io_subrequest *subreq)
 	goto out;
 }
 
+static void cifs_netfs_invalidate_cache(struct netfs_io_request *wreq)
+{
+	cifs_invalidate_cache(wreq->inode, 0);
+}
+
 /*
  * Split the read up according to how many credits we can get for each piece.
  * It's okay to sleep here if we need to wait for more credit to become
@@ -307,6 +312,7 @@ const struct netfs_request_ops cifs_req_ops = {
 	.begin_writeback	= cifs_begin_writeback,
 	.prepare_write		= cifs_prepare_write,
 	.issue_write		= cifs_issue_write,
+	.invalidate_cache	= cifs_netfs_invalidate_cache,
 };
 
 /*
@@ -2358,13 +2364,18 @@ void cifs_write_subrequest_terminated(struct cifs_io_subrequest *wdata, ssize_t
 				      bool was_async)
 {
 	struct netfs_io_request *wreq = wdata->rreq;
-	loff_t new_server_eof;
+	struct netfs_inode *ictx = netfs_inode(wreq->inode);
+	loff_t wrend;
 
 	if (result > 0) {
-		new_server_eof = wdata->subreq.start + wdata->subreq.transferred + result;
+		wrend = wdata->subreq.start + wdata->subreq.transferred + result;
 
-		if (new_server_eof > netfs_inode(wreq->inode)->remote_i_size)
-			netfs_resize_file(netfs_inode(wreq->inode), new_server_eof, true);
+		if (wrend > ictx->zero_point &&
+		    (wdata->rreq->origin == NETFS_UNBUFFERED_WRITE ||
+		     wdata->rreq->origin == NETFS_DIO_WRITE))
+			ictx->zero_point = wrend;
+		if (wrend > ictx->remote_i_size)
+			netfs_resize_file(ictx, wrend, true);
 	}
 
 	netfs_write_subrequest_terminated(&wdata->subreq, result, was_async);
@@ -2877,6 +2888,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 		rc = netfs_start_io_direct(inode);
 		if (rc < 0)
 			goto out;
+		rc = -EACCES;
 		down_read(&cinode->lock_sem);
 		if (!cifs_find_lock_conflict(
 			    cfile, iocb->ki_pos, iov_iter_count(to),
@@ -2889,6 +2901,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 		rc = netfs_start_io_read(inode);
 		if (rc < 0)
 			goto out;
+		rc = -EACCES;
 		down_read(&cinode->lock_sem);
 		if (!cifs_find_lock_conflict(
 			    cfile, iocb->ki_pos, iov_iter_count(to),
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2ae2dbb6202b..bb84a89e5905 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4859,9 +4859,6 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	struct cifs_io_parms *io_parms = NULL;
 	int credit_request;
 
-	if (!wdata->server || test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
-		server = wdata->server = cifs_pick_channel(tcon->ses);
-
 	/*
 	 * in future we may get cifs_io_parms passed in from the caller,
 	 * but for now we construct it here...
diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 1a3c6f66f620..dc627ebf01df 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -209,7 +209,7 @@
 
 /* CS35L56_MAIN_RENDER_USER_VOLUME */
 #define CS35L56_MAIN_RENDER_USER_VOLUME_MIN		-400
-#define CS35L56_MAIN_RENDER_USER_VOLUME_MAX		400
+#define CS35L56_MAIN_RENDER_USER_VOLUME_MAX		48
 #define CS35L56_MAIN_RENDER_USER_VOLUME_MASK		0x0000FFC0
 #define CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT		6
 #define CS35L56_MAIN_RENDER_USER_VOLUME_SIGNBIT		9
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index d2945c9c812b..c95dc1736dd9 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -657,8 +657,10 @@ static int io_alloc_pbuf_ring(struct io_ring_ctx *ctx,
 	ring_size = reg->ring_entries * sizeof(struct io_uring_buf_ring);
 
 	bl->buf_ring = io_pages_map(&bl->buf_pages, &bl->buf_nr_pages, ring_size);
-	if (!bl->buf_ring)
+	if (IS_ERR(bl->buf_ring)) {
+		bl->buf_ring = NULL;
 		return -ENOMEM;
+	}
 
 	bl->is_buf_ring = 1;
 	bl->is_mmap = 1;
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 758dfdf9d3ea..7f2f2f8c13fa 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -196,7 +196,11 @@ static const struct snd_kcontrol_new cs35l56_controls[] = {
 		       cs35l56_dspwait_get_volsw, cs35l56_dspwait_put_volsw),
 	SOC_SINGLE_S_EXT_TLV("Speaker Volume",
 			     CS35L56_MAIN_RENDER_USER_VOLUME,
-			     6, -400, 400, 9, 0,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_MIN,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_MAX,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_SIGNBIT,
+			     0,
 			     cs35l56_dspwait_get_volsw,
 			     cs35l56_dspwait_put_volsw,
 			     vol_tlv),

