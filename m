Return-Path: <stable+bounces-62287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24193E807
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59B31F213DB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA46E15573D;
	Sun, 28 Jul 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQneo+cl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561A1553B7;
	Sun, 28 Jul 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182901; cv=none; b=qrHWiFuCI11Fd/4+mBaZW6bdiqFAPkGC37oVb72cIQhLlHjT1Dd6qSXPiwbbDVTnstWTFNz9h3WRvZy0rIesSLJZxSdRxVkmjfRsDVwzkf1Eiswe62VyObvMBVg3r2y429tPIVeoXoQ/dU0wZweUBfr5zujGCqyjiHMl2VsGov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182901; c=relaxed/simple;
	bh=Yz4QNBWLzCTNvfrjUvMjk4xQF3HdDyRR+HU6vgZ21ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vyf+C6mbevmfVCqqwUqeC4k2MHSoeReegNcYUwoyp/Qw7py7gHQP0dbpWUuii8IUkUaQG6b9bZ4Cs7PRNgTuGlZfKdHQgC4/cd4Jvk+z+2x6K/K06Y8hNOqQ1aPxTT5cF/q8e+rw4fMQFNF0+6uBB4wCHmxPB7IXukmK1ANW7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQneo+cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639F9C116B1;
	Sun, 28 Jul 2024 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182901;
	bh=Yz4QNBWLzCTNvfrjUvMjk4xQF3HdDyRR+HU6vgZ21ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQneo+clLVy5usy4NG8Az+B/Rw02HN+bKMeB58IKwLoEFjxK81zGDWAHXvDn7x8rd
	 Puh5ScVHRWgG0oNUCn6Ma3oX+BbOPlmK+rz4qKuS0RdCO+p7nxrOpJvPzbKr3IL+lb
	 LFoBbrFolazHY60mhLgDfMTpnyhsoiwPvOPcr2F1bbFVLBdy40iS7mgLIR4nVGtc8h
	 0iX8ezd2VbrK3prkftZgtB1YXnKLq4QCksFS3FO7zIcR4kmFkEAx5XF5XsDbDrsMkA
	 /NIW1w/7bCvd28X3RCYAdLimcGk3hnm3KbB9m3aG4C011C+QV0GTjpn+zdO0VCBxMc
	 ttnIqlEAVbx1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Hongchi <hongchi.peng@siengine.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	hminas@synopsys.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/15] usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled
Date: Sun, 28 Jul 2024 12:07:48 -0400
Message-ID: <20240728160813.2053107-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Peng Hongchi <hongchi.peng@siengine.com>

[ Upstream commit 1134289b6b93d73721340b66c310fd985385e8fa ]

When using dma_map_sg() to map the scatterlist with iommu enabled,
the entries in the scatterlist can be mergerd into less but longer
entries in the function __finalise_sg(). So that the number of
valid mapped entries is actually smaller than ureq->num_reqs,and
there are still some invalid entries in the scatterlist with
dma_addr=0xffffffff and len=0. Writing these invalid sg entries
into the dma_desc can cause a data transmission error.

The function dma_map_sg() returns the number of valid map entries
and the return value is assigned to usb_request::num_mapped_sgs in
function usb_gadget_map_request_by_dev(). So that just write valid
mapped entries into dma_desc according to the usb_request::num_mapped_sgs,
and set the IOC bit if it's the last valid mapped entry.

This patch poses no risk to no-iommu situation, cause
ureq->num_mapped_sgs equals ureq->num_sgs while using dma_direct_map_sg()
to map the scatterlist whith iommu disabled.

Signed-off-by: Peng Hongchi <hongchi.peng@siengine.com>
Link: https://lore.kernel.org/r/20240523100315.7226-1-hongchi.peng@siengine.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index cb29f9fae2f23..1c8141d80e25d 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -886,10 +886,10 @@ static void dwc2_gadget_config_nonisoc_xfer_ddma(struct dwc2_hsotg_ep *hs_ep,
 	}
 
 	/* DMA sg buffer */
-	for_each_sg(ureq->sg, sg, ureq->num_sgs, i) {
+	for_each_sg(ureq->sg, sg, ureq->num_mapped_sgs, i) {
 		dwc2_gadget_fill_nonisoc_xfer_ddma_one(hs_ep, &desc,
 			sg_dma_address(sg) + sg->offset, sg_dma_len(sg),
-			sg_is_last(sg));
+			(i == (ureq->num_mapped_sgs - 1)));
 		desc_count += hs_ep->desc_count;
 	}
 
-- 
2.43.0


