Return-Path: <stable+bounces-193663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCB3C4A5C6
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16FC9340286
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D1346FBA;
	Tue, 11 Nov 2025 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hBeOf1hj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D6346FB0;
	Tue, 11 Nov 2025 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823715; cv=none; b=XO5HxSbU+R2SfCZvxqxfd0/qv20d3dCUNTquH/Kka46isEG8AyVdpQmTfYdxfC9pzEXN92i6BqCa8Iehd/uRD/w84rHt0p1eQu6XsrqDx1+ebNIzTCdm3gewgVTLLKVbdxBkp0EHBMHkykygLxP3s3QOPlE1bt4h1KYrRI3FUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823715; c=relaxed/simple;
	bh=VP5HehuQcPev/QNRPSoxKIxJ1Ptf/iRWw3CXvo5TzlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiUpNMByBwauChdiTpiCVTcAvfmyaZh2ESIosWaCkl/veOXD3DTDEf2f0yAHlotbDWCSIQGQ46Ra+Wx7yCtPbqbMhsQUfTjIhHFiLoFIMpp+zyQKFk1oZu6suCQtstepyZO73YjsCRH9T0nC9vlZYZMdoJTISHKXE7fccRn0x44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hBeOf1hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F056C116B1;
	Tue, 11 Nov 2025 01:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823714;
	bh=VP5HehuQcPev/QNRPSoxKIxJ1Ptf/iRWw3CXvo5TzlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBeOf1hjJUkBuEqDWOBMdgb0SEjCxDE9dvZnEp4VndYFIZh2CPD4MSkM/eUpLnK/O
	 FU1STsb5UBPdldrKTjv4IlKJ2EtCvusAFQnL706TSnqIsASLs7jlma0T7eK0sCIm9r
	 HRu3SgzoRak2Rb+YVNSLVGKhgdPRAuDhjnf+nl8Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 355/849] scsi: mpi3mr: Fix I/O failures during controller reset
Date: Tue, 11 Nov 2025 09:38:45 +0900
Message-ID: <20251111004545.003034553@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chandrakanth Patil <chandrakanth.patil@broadcom.com>

[ Upstream commit b7b2176e30fc8e57664e5a8a23387af66eb7f72b ]

I/Os can race with controller reset and fail.

Block requests at the mid layer when reset starts using
scsi_host_block(), and resume with scsi_host_unblock() after reset
completes.

Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Link: https://lore.kernel.org/r/20250820084138.228471-4-chandrakanth.patil@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 3 +++
 drivers/scsi/mpi3mr/mpi3mr_os.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 0152d31d430ab..9e18cc2747104 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -5420,6 +5420,7 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 	    mpi3mr_reset_rc_name(reset_reason));
 
 	mrioc->device_refresh_on = 0;
+	scsi_block_requests(mrioc->shost);
 	mrioc->reset_in_progress = 1;
 	mrioc->stop_bsgs = 1;
 	mrioc->prev_reset_result = -1;
@@ -5528,6 +5529,7 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 	if (!retval) {
 		mrioc->diagsave_timeout = 0;
 		mrioc->reset_in_progress = 0;
+		scsi_unblock_requests(mrioc->shost);
 		mrioc->pel_abort_requested = 0;
 		if (mrioc->pel_enabled) {
 			mrioc->pel_cmds.retry_count = 0;
@@ -5552,6 +5554,7 @@ int mpi3mr_soft_reset_handler(struct mpi3mr_ioc *mrioc,
 		mrioc->device_refresh_on = 0;
 		mrioc->unrecoverable = 1;
 		mrioc->reset_in_progress = 0;
+		scsi_unblock_requests(mrioc->shost);
 		mrioc->stop_bsgs = 0;
 		retval = -1;
 		mpi3mr_flush_cmds_for_unrecovered_controller(mrioc);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 1582cdbc66302..5516ac62a5065 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -2866,12 +2866,14 @@ static void mpi3mr_preparereset_evt_th(struct mpi3mr_ioc *mrioc,
 		    "prepare for reset event top half with rc=start\n");
 		if (mrioc->prepare_for_reset)
 			return;
+		scsi_block_requests(mrioc->shost);
 		mrioc->prepare_for_reset = 1;
 		mrioc->prepare_for_reset_timeout_counter = 0;
 	} else if (evtdata->reason_code == MPI3_EVENT_PREPARE_RESET_RC_ABORT) {
 		dprint_event_th(mrioc,
 		    "prepare for reset top half with rc=abort\n");
 		mrioc->prepare_for_reset = 0;
+		scsi_unblock_requests(mrioc->shost);
 		mrioc->prepare_for_reset_timeout_counter = 0;
 	}
 	if ((event_reply->msg_flags & MPI3_EVENT_NOTIFY_MSGFLAGS_ACK_MASK)
-- 
2.51.0




