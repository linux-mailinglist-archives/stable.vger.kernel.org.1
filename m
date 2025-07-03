Return-Path: <stable+bounces-159844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC3AF7AD6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A778317867A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE02EFDB8;
	Thu,  3 Jul 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vudo9qDj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536532F0022;
	Thu,  3 Jul 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555535; cv=none; b=bcL2o1Ughpasyx/NJqT20GgvoLbD1by5A/lDLOLyEC06v+OWxB5cZ8mWNlJ5yzi1OnVX6eMtgAsg0oyGaytrg8n6rDzg9tLJg6OyT+NcH/egM5Pg+65O7T/K8Xf2bN1Do4qrcvv/qrDVRaeYVG5K1mMrMKx7+4JOXR0anKigqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555535; c=relaxed/simple;
	bh=Gp6mEgD+g/e8vCOvwhR2GzZMWke07rBwJMLyUgwxkZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvpjxBUGrd556SQMFTvt3w7XPXUZ6v7Xo7hC/OKhV0CiaeQ4m2evpTN2JP5AZ32T+w7HV6K8q8ArY89jLtxyNSbG6jDq38wxVyTA+AMAscr+DaqMsH6p1efbRMLjL6kelDKi4ZV+XMTRl3TN4U7f96Z668G+IXFSzYax/veWE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vudo9qDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84672C4CEEE;
	Thu,  3 Jul 2025 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555535;
	bh=Gp6mEgD+g/e8vCOvwhR2GzZMWke07rBwJMLyUgwxkZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vudo9qDjZI8COr0y7JfbuxtQtxvERmNRLnLp+Bd0p4c1yfCYlTqMRGGxD8JjhEEkP
	 eaf3BYQi8kabrPS7Ftq+wDkML9VKo7M41MYCqvY3E3vcVcBcubdxVy1PAYe1r/8Dhh
	 C2j/58HrVXEW3kL+ezJxKiYgv/kNGuPOG/YZftjw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Can Guo <quic_cang@quicinc.com>,
	Ziqi Chen <quic_ziqichen@quicinc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 044/139] scsi: ufs: core: Dont perform UFS clkscaling during host async scan
Date: Thu,  3 Jul 2025 16:41:47 +0200
Message-ID: <20250703143942.896638131@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziqi Chen <quic_ziqichen@quicinc.com>

[ Upstream commit e97633492f5a3eca7b3ff03b4ef6f993017f7955 ]

When preparing for UFS clock scaling, the UFS driver will quiesce all
sdevs queues in the UFS SCSI host tagset list and then unquiesce them in
ufshcd_clock_scaling_unprepare(). If the UFS SCSI host async scan is in
progress at this time, some LUs may be added to the tagset list between
UFS clkscale prepare and unprepare. This can cause two issues:

1. During clock scaling, there may be I/O requests issued through new
added queues that have not been quiesced, leading to task abort issue.

2. These new added queues that have not been quiesced will be unquiesced
as well when UFS clkscale is unprepared, resulting in warning prints.

Therefore, use the mutex lock scan_mutex in
ufshcd_clock_scaling_prepare() and ufshcd_clock_scaling_unprepare() to
protect it.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
Link: https://lore.kernel.org/r/20250522081233.2358565-1-quic_ziqichen@quicinc.com
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9dabc03675b00..412931cf240f6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1284,6 +1284,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba, u64 timeout_us)
 	 * make sure that there are no outstanding requests when
 	 * clock scaling is in progress
 	 */
+	mutex_lock(&hba->host->scan_mutex);
 	blk_mq_quiesce_tagset(&hba->host->tag_set);
 	mutex_lock(&hba->wb_mutex);
 	down_write(&hba->clk_scaling_lock);
@@ -1294,6 +1295,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba, u64 timeout_us)
 		up_write(&hba->clk_scaling_lock);
 		mutex_unlock(&hba->wb_mutex);
 		blk_mq_unquiesce_tagset(&hba->host->tag_set);
+		mutex_unlock(&hba->host->scan_mutex);
 		goto out;
 	}
 
@@ -1315,6 +1317,7 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, int err, bool sc
 	mutex_unlock(&hba->wb_mutex);
 
 	blk_mq_unquiesce_tagset(&hba->host->tag_set);
+	mutex_unlock(&hba->host->scan_mutex);
 	ufshcd_release(hba);
 }
 
-- 
2.39.5




