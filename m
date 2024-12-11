Return-Path: <stable+bounces-100715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905869ED52A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D42B1625C4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E2723608D;
	Wed, 11 Dec 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ7ddfoD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619A236085;
	Wed, 11 Dec 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943094; cv=none; b=LQn35EQfdNNrSlQ5ACiroKy/FTpgC82T19Rjldi+Hd24oqqpN8OoyrI5eyeMGBzSWfBCQWbgtoDFQqcsTxBZu3BVUmD9V+2DEH0rzsqCBInqq96iWTHXw6UziV8Ws1kZSdSpCPKF6OkhnDNZZ2S0Z6Ij6DwJX/B5BXD/VQtmv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943094; c=relaxed/simple;
	bh=+0VTUkI4TSyM45Xbuc0gozQdpSPsnzOUU5lwfKaC2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8zuznniMN2XgGNLOYjzpZNrmQ8RA4GbCtqgxenNV7l8hL9JwvM7JG0362aR+ya/zx1uGCz0v8lKQUf5rsDucI8VCck8EAfP4No+aaBZq/DeyGU8ebOY9f1SncuzcHm3e5nPRVPmoH6kqeKhE+CLamP5w5DV/3ryOmVm1EykVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ7ddfoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86584C4CED4;
	Wed, 11 Dec 2024 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943094;
	bh=+0VTUkI4TSyM45Xbuc0gozQdpSPsnzOUU5lwfKaC2iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQ7ddfoDd+DVRwqlaQVlNwr1q6nsWJAYZQZmiuBFKWfg4cSrUdS0CAnYRa9R4aZAC
	 1ernB3s4jaD6UAQQHCkxJWzzUm0WjltsRl4KMp3WpxfoBU79WNWM3w+RI3YSluzcse
	 ty655kYnqGL1+KGL1SXVKYOQhgqOM5VD0RmH9F8HKben5PcBdnER6chG8kYR/8PxmQ
	 4uevnlJQU8B/lUB9NiGJIYe177xaY+NQba+BzvdRlNHzvLGyXk8mf9bgnC4kzjUsg4
	 7z4v0XIM2hvkY0/UNK9EY4DeR4iwax/cBUNQaLBMfoav2fFKkyKpl/E7nd9xQAuQeD
	 rNtICk29BFdhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	sathya.prakash@broadcom.com,
	kashyap.desai@broadcom.com,
	sreekanth.reddy@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 25/36] scsi: mpi3mr: Synchronize access to ioctl data buffer
Date: Wed, 11 Dec 2024 13:49:41 -0500
Message-ID: <20241211185028.3841047-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit 367ac16e5ff2dcd6b7f00a8f94e6ba98875cb397 ]

The driver serializes ioctls through a mutex lock but access to the
ioctl data buffer is not guarded by the mutex. This results in multiple
user threads being able to write to the driver's ioctl buffer
simultaneously.

Protect the ioctl buffer with the ioctl mutex.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20241110194405.10108-2-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_app.c | 36 ++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 01f035f9330e4..10b8e4dc64f8b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -2329,6 +2329,15 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 	if (!mrioc)
 		return -ENODEV;
 
+	if (mutex_lock_interruptible(&mrioc->bsg_cmds.mutex))
+		return -ERESTARTSYS;
+
+	if (mrioc->bsg_cmds.state & MPI3MR_CMD_PENDING) {
+		dprint_bsg_err(mrioc, "%s: command is in use\n", __func__);
+		mutex_unlock(&mrioc->bsg_cmds.mutex);
+		return -EAGAIN;
+	}
+
 	if (!mrioc->ioctl_sges_allocated) {
 		dprint_bsg_err(mrioc, "%s: DMA memory was not allocated\n",
 			       __func__);
@@ -2339,13 +2348,16 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 		karg->timeout = MPI3MR_APP_DEFAULT_TIMEOUT;
 
 	mpi_req = kzalloc(MPI3MR_ADMIN_REQ_FRAME_SZ, GFP_KERNEL);
-	if (!mpi_req)
+	if (!mpi_req) {
+		mutex_unlock(&mrioc->bsg_cmds.mutex);
 		return -ENOMEM;
+	}
 	mpi_header = (struct mpi3_request_header *)mpi_req;
 
 	bufcnt = karg->buf_entry_list.num_of_entries;
 	drv_bufs = kzalloc((sizeof(*drv_bufs) * bufcnt), GFP_KERNEL);
 	if (!drv_bufs) {
+		mutex_unlock(&mrioc->bsg_cmds.mutex);
 		rval = -ENOMEM;
 		goto out;
 	}
@@ -2353,6 +2365,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 	dout_buf = kzalloc(job->request_payload.payload_len,
 				      GFP_KERNEL);
 	if (!dout_buf) {
+		mutex_unlock(&mrioc->bsg_cmds.mutex);
 		rval = -ENOMEM;
 		goto out;
 	}
@@ -2360,6 +2373,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 	din_buf = kzalloc(job->reply_payload.payload_len,
 				     GFP_KERNEL);
 	if (!din_buf) {
+		mutex_unlock(&mrioc->bsg_cmds.mutex);
 		rval = -ENOMEM;
 		goto out;
 	}
@@ -2435,6 +2449,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 					(mpi_msg_size > MPI3MR_ADMIN_REQ_FRAME_SZ)) {
 				dprint_bsg_err(mrioc, "%s: invalid MPI message size\n",
 					__func__);
+				mutex_unlock(&mrioc->bsg_cmds.mutex);
 				rval = -EINVAL;
 				goto out;
 			}
@@ -2447,6 +2462,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 		if (invalid_be) {
 			dprint_bsg_err(mrioc, "%s: invalid buffer entries passed\n",
 				__func__);
+			mutex_unlock(&mrioc->bsg_cmds.mutex);
 			rval = -EINVAL;
 			goto out;
 		}
@@ -2454,12 +2470,14 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 		if (sgl_dout_iter > (dout_buf + job->request_payload.payload_len)) {
 			dprint_bsg_err(mrioc, "%s: data_out buffer length mismatch\n",
 				       __func__);
+			mutex_unlock(&mrioc->bsg_cmds.mutex);
 			rval = -EINVAL;
 			goto out;
 		}
 		if (sgl_din_iter > (din_buf + job->reply_payload.payload_len)) {
 			dprint_bsg_err(mrioc, "%s: data_in buffer length mismatch\n",
 				       __func__);
+			mutex_unlock(&mrioc->bsg_cmds.mutex);
 			rval = -EINVAL;
 			goto out;
 		}
@@ -2472,6 +2490,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 		dprint_bsg_err(mrioc, "%s:%d: invalid data transfer size passed for function 0x%x din_size = %d, dout_size = %d\n",
 			       __func__, __LINE__, mpi_header->function, din_size,
 			       dout_size);
+		mutex_unlock(&mrioc->bsg_cmds.mutex);
 		rval = -EINVAL;
 		goto out;
 	}
@@ -2480,6 +2499,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 		dprint_bsg_err(mrioc,
 		    "%s:%d: invalid data transfer size passed for function 0x%x din_size=%d\n",
 		    __func__, __LINE__, mpi_header->function, din_size);
+		mutex_unlock(&mrioc->bsg_cmds.mutex);
 		rval = -EINVAL;
 		goto out;
 	}
@@ -2487,6 +2507,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 		dprint_bsg_err(mrioc,
 		    "%s:%d: invalid data transfer size passed for function 0x%x dout_size = %d\n",
 		    __func__, __LINE__, mpi_header->function, dout_size);
+		mutex_unlock(&mrioc->bsg_cmds.mutex);
 		rval = -EINVAL;
 		goto out;
 	}
@@ -2497,6 +2518,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 			dprint_bsg_err(mrioc, "%s:%d: invalid message size passed:%d:%d:%d:%d\n",
 				       __func__, __LINE__, din_cnt, dout_cnt, din_size,
 			    dout_size);
+			mutex_unlock(&mrioc->bsg_cmds.mutex);
 			rval = -EINVAL;
 			goto out;
 		}
@@ -2544,6 +2566,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 				continue;
 			if (mpi3mr_map_data_buffer_dma(mrioc, drv_buf_iter, desc_count)) {
 				rval = -ENOMEM;
+				mutex_unlock(&mrioc->bsg_cmds.mutex);
 				dprint_bsg_err(mrioc, "%s:%d: mapping data buffers failed\n",
 					       __func__, __LINE__);
 			goto out;
@@ -2556,20 +2579,11 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 		sense_buff_k = kzalloc(erbsz, GFP_KERNEL);
 		if (!sense_buff_k) {
 			rval = -ENOMEM;
+			mutex_unlock(&mrioc->bsg_cmds.mutex);
 			goto out;
 		}
 	}
 
-	if (mutex_lock_interruptible(&mrioc->bsg_cmds.mutex)) {
-		rval = -ERESTARTSYS;
-		goto out;
-	}
-	if (mrioc->bsg_cmds.state & MPI3MR_CMD_PENDING) {
-		rval = -EAGAIN;
-		dprint_bsg_err(mrioc, "%s: command is in use\n", __func__);
-		mutex_unlock(&mrioc->bsg_cmds.mutex);
-		goto out;
-	}
 	if (mrioc->unrecoverable) {
 		dprint_bsg_err(mrioc, "%s: unrecoverable controller\n",
 		    __func__);
-- 
2.43.0


