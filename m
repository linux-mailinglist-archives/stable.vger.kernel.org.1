Return-Path: <stable+bounces-52719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D07590CC61
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C44028295A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D216630B;
	Tue, 18 Jun 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCz8Enjl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01F14EC4C;
	Tue, 18 Jun 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714318; cv=none; b=HzknAP0/wizcDvduQEDkTv+IsV+ob3euQtdgw95CSfEf/ylJXn3GL6JjEX9GK3PXIl/OAI+gxQBDiV3hzGw4QfJhWS8l1C9FniPhfP04tolXqCm4CxXammVZGBy7rcoJnPq6NGqwFajdwVPByHDPuYPEBvLuR1Ct3fFYt9qpC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714318; c=relaxed/simple;
	bh=CNfLHAR7cvnRetSECMAsuXP2xiqrS/PUdaTJ/tSsJqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4Iwgq3LaAkydQaTos111/MpGfMxg+qbcmtfOv/6KR1w8npIFBGGCAnF0EwpA4kbV4J0Y53zGzZUUhykUOfoTXh6QdMoJPi3u5nxUKNPpsRas2SUvoU2V4dvjAgc/vWDrORzMnQo0Q3TPpqltD+/eg9t5RzKMMMrc8epnhhclfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCz8Enjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188BCC3277B;
	Tue, 18 Jun 2024 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714318;
	bh=CNfLHAR7cvnRetSECMAsuXP2xiqrS/PUdaTJ/tSsJqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCz8EnjlyI8CM7jy+WzqWrEF/dayWbw5oCKHlrCG+j3kHGTMT94i++48blVbLkxsh
	 wHQaz25LudnYi0uXp0x9+By5iug6CqEEKgQHsn8CKBE4VXtbWQcP48bDKdYAXEXg32
	 sU3dczW+ilBjaUOy/1BEtMXqTzCUoWLxrOlqIt7NeVsEoGuFJstbXPqGppmVEKyQOD
	 ZvWx6xdr9QaBjOBQKuhHj61N19HiG9tLidc86KHgcsb/pCmPml9noXuGJf95H/0PZG
	 +QZBFmyC9r07Jpl2EcwA2yHz+j8sMrDltN6S3Q/0TRm3WRH+iYmlIk5oPVJumhEo/u
	 JEKsR/FuHPIzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurav Kashyap <skashyap@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jhasan@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/35] scsi: qedf: Don't process stag work during unload and recovery
Date: Tue, 18 Jun 2024 08:37:23 -0400
Message-ID: <20240618123831.3302346-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: Saurav Kashyap <skashyap@marvell.com>

[ Upstream commit 51071f0831ea975fc045526dd7e17efe669dc6e1 ]

Stag work can cause issues during unload and recovery, hence don't process
it.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240515091101.18754-2-skashyap@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedf/qedf_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 91f3f1d7098eb..c27e27cff0790 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3996,6 +3996,22 @@ void qedf_stag_change_work(struct work_struct *work)
 	struct qedf_ctx *qedf =
 	    container_of(work, struct qedf_ctx, stag_work.work);
 
+	if (!qedf) {
+		QEDF_ERR(&qedf->dbg_ctx, "qedf is NULL");
+		return;
+	}
+
+	if (test_bit(QEDF_IN_RECOVERY, &qedf->flags)) {
+		QEDF_ERR(&qedf->dbg_ctx,
+			 "Already is in recovery, hence not calling software context reset.\n");
+		return;
+	}
+
+	if (test_bit(QEDF_UNLOADING, &qedf->flags)) {
+		QEDF_ERR(&qedf->dbg_ctx, "Driver unloading\n");
+		return;
+	}
+
 	printk_ratelimited("[%s]:[%s:%d]:%d: Performing software context reset.",
 			dev_name(&qedf->pdev->dev), __func__, __LINE__,
 			qedf->dbg_ctx.host_no);
-- 
2.43.0


