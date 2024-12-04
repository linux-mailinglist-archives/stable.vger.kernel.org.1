Return-Path: <stable+bounces-98394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AABE9E44CB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B13B3CD03
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A12111CE;
	Wed,  4 Dec 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifRzOhjy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E22111C2;
	Wed,  4 Dec 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331634; cv=none; b=tLaZZ1+IDO/r+OWQaz72BE0pA/6LWF1x5FJAqnO9tfa/iP2tFMebEmNBbAhhsy88zb4LGyh9HskStfg645BSNEMOq7fWyJEofyAqC5SePHNf0G/TC/Qnf6NBdNGZMqg3PtolkcPP+yMLzwm4f6nWOGx2rHvoAh79Op57nSiI6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331634; c=relaxed/simple;
	bh=MGMQGMV36VjZEUVEA0LYRw2jW2vTOpWtBFcIyCZ8hlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOqU40+TbA1EcYZqURt0l6afh72/OUGOMKlK6SYFsbxv1FEZX9zAwyGMxm2qdu48a515BBcWFc6aiqcfxUnzCoPPGxLH/J95yCknwMeiO2aR3WkluuXNjRnsUtFf/DLsH0vn9w9TgdH62mmjx2FSJIKuJpeZmSqNbchnr/3xU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifRzOhjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908B3C4CED6;
	Wed,  4 Dec 2024 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331634;
	bh=MGMQGMV36VjZEUVEA0LYRw2jW2vTOpWtBFcIyCZ8hlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifRzOhjyBRcjPZvsYu98bob5yH+53pROhQpw82frlbw5ol93kqTcpbdujZDI/htod
	 ZFSqr7CMVIyqLDXQawXDT+Y3PewSLreJZsCQyClOkf5Sy4kV14ExlFU2O22fUI7oiC
	 74otN80RoDvFV++NMmIW+BvLRvOvTfx4D2BZhHAsH37/GIAcwVRXIldYKrADS59sC4
	 njFGXOuAjOsEojCGrMHhPp2VELcmCYp6R7kUKx9XPq7J2G/5UEUchyMSBcIjy/+0pP
	 6EKy3yAdygjnlyU6ysSyTC60pv97WCYU9QkuonkzMna1X3OiPKr5o7ecLVuvqz/wnO
	 51Zr/jSSr7WLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	John Meneghini <jmeneghi@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 25/33] scsi: st: Add MTIOCGET and MTLOAD to ioctls allowed after device reset
Date: Wed,  4 Dec 2024 10:47:38 -0500
Message-ID: <20241204154817.2212455-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Kai Mäkisara <Kai.Makisara@kolumbus.fi>

[ Upstream commit 0b120edb37dc9dd8ca82893d386922eb6b16f860 ]

Most drives rewind the tape when the device is reset. Reading and writing
are not allowed until something is done to make the tape position match the
user's expectation (e.g., rewind the tape). Add MTIOCGET and MTLOAD to
operations allowed after reset. MTIOCGET is modified to not touch the tape
if pos_unknown is non-zero. The tape location is known after MTLOAD.

Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219419#c14
Link: https://lore.kernel.org/r/20241106095723.63254-3-Kai.Makisara@kolumbus.fi
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/st.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 9f480a1b4a81a..4863802371a70 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3506,6 +3506,7 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 	int i, cmd_nr, cmd_type, bt;
 	int retval = 0;
 	unsigned int blk;
+	bool cmd_mtiocget;
 	struct scsi_tape *STp = file->private_data;
 	struct st_modedef *STm;
 	struct st_partstat *STps;
@@ -3619,6 +3620,7 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 			 */
 			if (mtc.mt_op != MTREW &&
 			    mtc.mt_op != MTOFFL &&
+			    mtc.mt_op != MTLOAD &&
 			    mtc.mt_op != MTRETEN &&
 			    mtc.mt_op != MTERASE &&
 			    mtc.mt_op != MTSEEK &&
@@ -3732,17 +3734,28 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 		goto out;
 	}
 
+	cmd_mtiocget = cmd_type == _IOC_TYPE(MTIOCGET) && cmd_nr == _IOC_NR(MTIOCGET);
+
 	if ((i = flush_buffer(STp, 0)) < 0) {
-		retval = i;
-		goto out;
-	}
-	if (STp->can_partitions &&
-	    (i = switch_partition(STp)) < 0) {
-		retval = i;
-		goto out;
+		if (cmd_mtiocget && STp->pos_unknown) {
+			/* flush fails -> modify status accordingly */
+			reset_state(STp);
+			STp->pos_unknown = 1;
+		} else { /* return error */
+			retval = i;
+			goto out;
+		}
+	} else { /* flush_buffer succeeds */
+		if (STp->can_partitions) {
+			i = switch_partition(STp);
+			if (i < 0) {
+				retval = i;
+				goto out;
+			}
+		}
 	}
 
-	if (cmd_type == _IOC_TYPE(MTIOCGET) && cmd_nr == _IOC_NR(MTIOCGET)) {
+	if (cmd_mtiocget) {
 		struct mtget mt_status;
 
 		if (_IOC_SIZE(cmd_in) != sizeof(struct mtget)) {
-- 
2.43.0


