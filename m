Return-Path: <stable+bounces-158884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC05AED85A
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB8B3AAD97
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740D023C4FA;
	Mon, 30 Jun 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYvYO4lt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1C23ABA9
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274996; cv=none; b=TGZxTDL6g2ysWITcSyanwLNvjqgBs+RHcTtneIQ101up8EDfrU7s6qjU3supNG6RP+sLqJ/LX47bsGa+nrtjxWsd4qBa/B5RHnyDcpURyxsjqIiDE7onhn4kY0+YdV1J4fTFXE0S6sHVjQPVdSel34yoyTqC4FmOtVKuoH8IXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274996; c=relaxed/simple;
	bh=w0ei8K/hFoB4BYDccv1+O/OkKFA8KtS0Of0UUJPkCoE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r4jyxl20ju/49lOqoOIVcSsycpxuoujyf5KwFQN8wRd8ySC2W5eq33qNuJTDvSYSGO/y1BulALqPdIebLDObrV4YsiQSXBhASpzNiv2DLEl5uKRWb7L8o22TtD4oH7m/NAhZ6WvEtXeAY1OaSjWYl7Gt8AyTWY6zon9NzOTuZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYvYO4lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF41C4CEEF;
	Mon, 30 Jun 2025 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751274995;
	bh=w0ei8K/hFoB4BYDccv1+O/OkKFA8KtS0Of0UUJPkCoE=;
	h=Subject:To:Cc:From:Date:From;
	b=eYvYO4ltAaafpuLYScfvHIHO1Fv+tBvo5pmKMk1Cse0uCTql8NJPXuoj667IBt1mE
	 AiAhoZObGxIoEktxRM9aSF7jPen6g7mQKowXcRHy5xsTqqqlrufDdCG423mxTYP2D1
	 nYL/+6wEx5qdEp6NV7fqWamyrvusbB4ZOv3OU3Qc=
Subject: FAILED: patch "[PATCH] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs" failed to apply to 5.15-stable tree
To: avadhut.naik@amd.com,bp@alien8.de,yazen.ghannam@amd.com,zilvinas@natrix.lt
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:16:27 +0200
Message-ID: <2025063027-delighted-selection-2dde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a3f3040657417aeadb9622c629d4a0c2693a0f93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063027-delighted-selection-2dde@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3f3040657417aeadb9622c629d4a0c2693a0f93 Mon Sep 17 00:00:00 2001
From: Avadhut Naik <avadhut.naik@amd.com>
Date: Thu, 29 May 2025 20:50:04 +0000
Subject: [PATCH] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD Zen-based
SOCs has an Address Mask and a Secondary Address Mask register associated with
it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS granularity
during init using these two registers.

Currently, the module primarily considers only the Address Mask register for
computing DIMM sizes. The Secondary Address Mask register is only considered
for odd CS. Additionally, if it has been considered, the Address Mask register
is ignored altogether for that CS. For power-of-two DIMMs i.e. DIMMs whose
total capacity is a power of two (32GB, 64GB, etc), this is not an issue
since only the Address Mask register is used.

For non-power-of-two DIMMs i.e., DIMMs whose total capacity is not a power of
two (48GB, 96GB, etc), however, the Secondary Address Mask register is used
in conjunction with the Address Mask register. However, since the module only
considers either of the two registers for a CS, the size computed by the
module is incorrect. The Secondary Address Mask register is not considered for
even CS, and the Address Mask register is not considered for odd CS.

Introduce a new helper function so that both Address Mask and Secondary
Address Mask registers are considered, when valid, for computing DIMM sizes.
Furthermore, also rename some variables for greater clarity.

Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250529205013.403450-1-avadhut.naik@amd.com

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b681c0663203..07f1e9dc1ca7 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1209,7 +1209,9 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_PRIMARY;
 
-	/* Asymmetric dual-rank DIMM support. */
+	if (csrow_sec_enabled(2 * dimm, ctrl, pvt))
+		cs_mode |= CS_EVEN_SECONDARY;
+
 	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_SECONDARY;
 
@@ -1230,12 +1232,13 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	return cs_mode;
 }
 
-static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
-				  int csrow_nr, int dimm)
+static int calculate_cs_size(u32 mask, unsigned int cs_mode)
 {
-	u32 msb, weight, num_zero_bits;
-	u32 addr_mask_deinterleaved;
-	int size = 0;
+	int msb, weight, num_zero_bits;
+	u32 deinterleaved_mask;
+
+	if (!mask)
+		return 0;
 
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
@@ -1248,19 +1251,30 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
 	 * without swapping with the most significant bit. This can be handled
 	 * by keeping the MSB where it is and ignoring the single zero bit.
 	 */
-	msb = fls(addr_mask_orig) - 1;
-	weight = hweight_long(addr_mask_orig);
+	msb = fls(mask) - 1;
+	weight = hweight_long(mask);
 	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
 
 	/* Take the number of zero bits off from the top of the mask. */
-	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
+	deinterleaved_mask = GENMASK(msb - num_zero_bits, 1);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", deinterleaved_mask);
+
+	return (deinterleaved_mask >> 2) + 1;
+}
+
+static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
+				  unsigned int cs_mode, int csrow_nr, int dimm)
+{
+	int size;
 
 	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
 
 	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
+	size = calculate_cs_size(addr_mask, cs_mode);
+
+	edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask_sec);
+	size += calculate_cs_size(addr_mask_sec, cs_mode);
 
 	/* Return size in MBs. */
 	return size >> 10;
@@ -1269,8 +1283,8 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
 static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
+	u32 addr_mask = 0, addr_mask_sec = 0;
 	int cs_mask_nr = csrow_nr;
-	u32 addr_mask_orig;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -1308,13 +1322,13 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	if (!pvt->flags.zn_regs_v2)
 		cs_mask_nr >>= 1;
 
-	/* Asymmetric dual-rank DIMM support. */
-	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
-	else
-		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
+	if (cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY))
+		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
 
-	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
+	if (cs_mode & (CS_EVEN_SECONDARY | CS_ODD_SECONDARY))
+		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
+
+	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, dimm);
 }
 
 static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
@@ -3512,9 +3526,10 @@ static void gpu_get_err_info(struct mce *m, struct err_info *err)
 static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
+	u32 addr_mask		= pvt->csels[umc].csmasks[csrow_nr];
+	u32 addr_mask_sec	= pvt->csels[umc].csmasks_sec[csrow_nr];
 
-	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
+	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, csrow_nr >> 1);
 }
 
 static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)


