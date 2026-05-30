Return-Path: <stable+bounces-259027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OZrIxQvG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-259027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:40:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21461236D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53D9D30041E3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71633E36A;
	Sat, 30 May 2026 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1DkG/3J1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC6241C8C;
	Sat, 30 May 2026 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166345; cv=none; b=h0/9YqeLkmYgT9xRCkbbd480FJnzYH4TfPj4u/kXHv3LpDoTzM1k0MQBfLhERC/Sj4NA89kUjF9MmcSCGVJVlJCFt+PSDji30c/UcrYEVOG84Vz+2L1w1mUor0rrJX1YPF8kMOgcp7RbpjgQjv+qpbgq0DvNed4u9MUCcl5m+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166345; c=relaxed/simple;
	bh=Tf3PIIc+BZ6lvOjme706npMTHYW1ZJlz3T4SBbGspbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szgb/TJaycwQNVv5kbDE7UICKigMO8As527AldO6e0DCnDMnB7sMB/G/B3r1+K6LQZ4XqSUwHzZPLArDv66Nh+nBXwvFcCF+Txoo3ZE8aZLODr8xB0899RXEA9ws1yrMk/OjK8ekBMWU4R1/cw4PdbO0Apn/fE1dXXL5xer69pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1DkG/3J1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6788A1F00893;
	Sat, 30 May 2026 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166344;
	bh=nrRU03hEDua/qHJacIrYvC8OP6KnhxWz+zCjcN8REqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1DkG/3J1z5lZAXem+0UyPf0ZLsecCgLMfsS/9UD3Kqrj3LHJah676x5cRwnYnQwbX
	 0XTzFXvYPyvFEiMkd5XFMxOL+f0PtGVMMxi1Nh54RQkpH+MxzgTWfkspsTm1bIxVoC
	 KOfzSNiR80sA/NUsz/jyrLau1QWrrzS/1ki5Iqes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 345/589] drm/msm/a6xx: Use barriers while updating HFI Q headers
Date: Sat, 30 May 2026 18:03:46 +0200
Message-ID: <20260530160233.950719409@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259027-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: 4D21461236D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil P Oommen <akhilpo@oss.qualcomm.com>

[ Upstream commit dc78b35d5ec09d1b0b8a937e6e640d2c5a030915 ]

To avoid harmful compiler optimizations and IO reordering in the HW, use
barriers and READ/WRITE_ONCE helpers as necessary while accessing the HFI
queue index variables.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/714653/
Message-ID: <20260327-a8xx-gpu-batch2-v2-1-2b53c38d2101@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 8bcf87726ec66..9c3f88959b8c5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -29,7 +29,7 @@ static int a6xx_hfi_queue_read(struct a6xx_gmu *gmu,
 	struct a6xx_hfi_queue_header *header = queue->header;
 	u32 i, hdr, index = header->read_index;
 
-	if (header->read_index == header->write_index) {
+	if (header->read_index == READ_ONCE(header->write_index)) {
 		header->rx_request = 1;
 		return 0;
 	}
@@ -55,7 +55,10 @@ static int a6xx_hfi_queue_read(struct a6xx_gmu *gmu,
 	if (!gmu->legacy)
 		index = ALIGN(index, 4) % header->size;
 
-	header->read_index = index;
+	/* Ensure all memory operations are complete before updating the read index */
+	dma_mb();
+
+	WRITE_ONCE(header->read_index, index);
 	return HFI_HEADER_SIZE(hdr);
 }
 
@@ -67,7 +70,7 @@ static int a6xx_hfi_queue_write(struct a6xx_gmu *gmu,
 
 	spin_lock(&queue->lock);
 
-	space = CIRC_SPACE(header->write_index, header->read_index,
+	space = CIRC_SPACE(header->write_index, READ_ONCE(header->read_index),
 		header->size);
 	if (space < dwords) {
 		header->dropped++;
@@ -86,7 +89,10 @@ static int a6xx_hfi_queue_write(struct a6xx_gmu *gmu,
 			queue->data[index] = 0xfafafafa;
 	}
 
-	header->write_index = index;
+	/* Ensure all memory operations are complete before updating the write index */
+	dma_mb();
+
+	WRITE_ONCE(header->write_index, index);
 	spin_unlock(&queue->lock);
 
 	gmu_write(gmu, REG_A6XX_GMU_HOST2GMU_INTR_SET, 0x01);
-- 
2.53.0




