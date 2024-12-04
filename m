Return-Path: <stable+bounces-98471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46429E41BB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C1928CBE7
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D374C22CE67;
	Wed,  4 Dec 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIN+Oose"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578A22CE5D;
	Wed,  4 Dec 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331832; cv=none; b=Rfv6SniMtlor64HP852IzXlHUzE0z/cLpLyXMvTZX0K/KtocYfiHL/4W+iaKKLLl1ESa41htshYrbZiMcA0T9DvOIruQoFbBSLwj7Q0Fp5JltXr5jWUt/El5qb1h5V7OXau0Ga5kqxOXy7sITEvtgMpkvxPqdqJzBviqCUuTKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331832; c=relaxed/simple;
	bh=gsV/QsNcFpCtE/D+hR3ES7sxSQqH2WQ/eY32NGrHz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riCUr+Rxyh1D5+FMCwAdo9XneAEJhuKL0G4QcifsN+xnvC1Z8VhGHcNaORxnpu0ozkOz7mfSI2YuEZMaRHV71UxWYLZROgzfCtXopxtA/EO2i15MtLQupEAj0av5qVc6UcpYGR1jlToUWHwZ5sHO77FyqpjKK1yV6i7Lh1tZm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIN+Oose; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE59C4CED1;
	Wed,  4 Dec 2024 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331832;
	bh=gsV/QsNcFpCtE/D+hR3ES7sxSQqH2WQ/eY32NGrHz18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIN+OoseD5hToSG66v9s0tKIK7SxxZT6zPt1cG3aHwR2T67o/fVmn2aJ0xVTe6Ugx
	 zDNpeET0nUy+Ne8qtLoaalW8tjcxT19N3lX5ZQB26MV1eQDOSBhRNmexIgVOdXg0ln
	 wT7tDho60Ayag7Sxfl2FrOv2fq6X55ymj6uupxC/6xpl5MqPELL4vB/ICmUQmEBhmR
	 ri7Iy1+gJma9EqWOTxXAzH4hjoZuBAqknSGehEk7aZBpSUJCwA/CWoarbIKbsS3HIF
	 ylde7gyzwe5Vi83z8wk2dKUh9v6boB+zdKzA1yrPBZeqX0P0AjxPdQtPs+3ltZccRQ
	 Oyk48Hbdn/oTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	John Meneghini <jmeneghi@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/6] scsi: st: Add MTIOCGET and MTLOAD to ioctls allowed after device reset
Date: Wed,  4 Dec 2024 10:52:24 -0500
Message-ID: <20241204155226.2215336-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155226.2215336-1-sashal@kernel.org>
References: <20241204155226.2215336-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index c6b341415a125..abfde71216faf 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3501,6 +3501,7 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 	int i, cmd_nr, cmd_type, bt;
 	int retval = 0;
 	unsigned int blk;
+	bool cmd_mtiocget;
 	struct scsi_tape *STp = file->private_data;
 	struct st_modedef *STm;
 	struct st_partstat *STps;
@@ -3615,6 +3616,7 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 			 */
 			if (mtc.mt_op != MTREW &&
 			    mtc.mt_op != MTOFFL &&
+			    mtc.mt_op != MTLOAD &&
 			    mtc.mt_op != MTRETEN &&
 			    mtc.mt_op != MTERASE &&
 			    mtc.mt_op != MTSEEK &&
@@ -3728,17 +3730,28 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
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


