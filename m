Return-Path: <stable+bounces-172208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D0CB30186
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 19:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD97165977
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF9C31DD90;
	Thu, 21 Aug 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qcb78u9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4E2D63E1
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798964; cv=none; b=IaC/MbnrKEkNOwUwPPh4eV5EoV80E+HC+JXgBmIU/H2SZRPT8oiu4SRZtfMdiOM1xadZkUTOilKoW14ApfatpVazOZj1Q9Ji9uEdHh9N9DbvB+TJg3Rg0z53pEtN9JBU/1ICKuTABc/c91aitA5x6ROJggZ0Bvmd5NDki+eMfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798964; c=relaxed/simple;
	bh=/qIN0PvKhvHpXYa8gxO9lPlnJH6sBSbLBaygpiL8RKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldVgS0WyG+mKZ+xa/o5+JFBqMuHcdpiyI/31VSC4QzE6+cdI4VmC1r2IhZRzs+ef60ottMqlGHRrjFItYeqMClbkHTxmHxYq9+s+wYdxfWuOXVktzr4wWQAy+S+tYxYxgXh/+G5RICp+5t6aBBorlCG132wUD8MztgVIJD2fVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qcb78u9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5452EC4CEEB;
	Thu, 21 Aug 2025 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755798963;
	bh=/qIN0PvKhvHpXYa8gxO9lPlnJH6sBSbLBaygpiL8RKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qcb78u9E529i9Gut27iPOTt60Dq0cxFD96irxDUfbzrFtstEw6nrC8eKpYsqs96LK
	 70zHH4f5O6k6r8FssH4p7vFP6k7ddQcZFRkBZ4upAgS2GP0ctbp72BzcSBO96/qyy4
	 Ay+35fnZBKyM2DzDQ2voYUi1iMU3C0BxQfhiopol9sy0OiWbxpsZ0YV1rZW7bFZBpy
	 dj0gMxjSqnthyKpEN1ktdFd99n2aDoHe0o+4Lq0EX6TiWaUfIQG2RNItmKT3kaMs4o
	 u6gpVcG+cyLIXv6wWLV3zLEr+9EyWjbCfCX25Ay5MHjFvmDM4pzHJD9kNn0f/HxSBI
	 m1VaXcvltLCHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Youssef Samir <quic_yabdulra@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] bus: mhi: host: Detect events pointing to unexpected TREs
Date: Thu, 21 Aug 2025 13:56:00 -0400
Message-ID: <20250821175600.873291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082132-hurricane-stank-2ae5@gregkh>
References: <2025082132-hurricane-stank-2ae5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Youssef Samir <quic_yabdulra@quicinc.com>

[ Upstream commit 5bd398e20f0833ae8a1267d4f343591a2dd20185 ]

When a remote device sends a completion event to the host, it contains a
pointer to the consumed TRE. The host uses this pointer to process all of
the TREs between it and the host's local copy of the ring's read pointer.
This works when processing completion for chained transactions, but can
lead to nasty results if the device sends an event for a single-element
transaction with a read pointer that is multiple elements ahead of the
host's read pointer.

For instance, if the host accesses an event ring while the device is
updating it, the pointer inside of the event might still point to an old
TRE. If the host uses the channel's xfer_cb() to directly free the buffer
pointed to by the TRE, the buffer will be double-freed.

This behavior was observed on an ep that used upstream EP stack without
'commit 6f18d174b73d ("bus: mhi: ep: Update read pointer only after buffer
is written")'. Where the device updated the events ring pointer before
updating the event contents, so it left a window where the host was able to
access the stale data the event pointed to, before the device had the
chance to update them. The usual pattern was that the host received an
event pointing to a TRE that is not immediately after the last processed
one, so it got treated as if it was a chained transaction, processing all
of the TREs in between the two read pointers.

This commit aims to harden the host by ensuring transactions where the
event points to a TRE that isn't local_rp + 1 are chained.

Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
[mani: added stable tag and reworded commit message]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250714163039.3438985-1-quic_yabdulra@quicinc.com
[ Replaced missing MHI_TRE_DATA_GET_CHAIN macro with direct bit 0 check on dword[1]. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/host/main.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index c83a3875fbc5..f96a3620e67d 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -594,7 +594,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 	{
 		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
 		struct mhi_ring_element *local_rp, *ev_tre;
-		void *dev_rp;
+		void *dev_rp, *next_rp;
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
 
@@ -613,6 +613,19 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 		result.dir = mhi_chan->dir;
 
 		local_rp = tre_ring->rp;
+
+		next_rp = local_rp + 1;
+		if (next_rp >= tre_ring->base + tre_ring->len)
+			next_rp = tre_ring->base;
+		/* Check if the event points to an unexpected TRE.
+		 * Chain flag is bit 0 of dword[1] in the TRE.
+		 */
+		if (dev_rp != next_rp && !(le32_to_cpu(local_rp->dword[1]) & 0x1)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event element points to an unexpected TRE\n");
+			break;
+		}
+
 		while (local_rp != dev_rp) {
 			buf_info = buf_ring->rp;
 			/* If it's the last TRE, get length from the event */
-- 
2.50.1


