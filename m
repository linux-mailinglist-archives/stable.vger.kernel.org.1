Return-Path: <stable+bounces-22853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C721A85DECC
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EBCB26994
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9B7EEE2;
	Wed, 21 Feb 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kNVX4feu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3697E792;
	Wed, 21 Feb 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524732; cv=none; b=L+u/RGWtheI/4y56SAu6VhoXDdi5vMhk880FZDGhXB7C3I1YUyVRfxcMAkDYaWeeNTcmPig66R2qECGa/yaZIHT5B6pO6pWq3hB3AzCJKfJEM8T0Z7fNa+ctLzGi041dUAJRhfTvlv+2IXhAVkNPE0YJxoeHtPrPmL3Jq7DPi+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524732; c=relaxed/simple;
	bh=3F4ywAcbh6mLsfLUdJSuVGd8HBskPBrWA+r1BRsiXAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJBeVSKccSFsqQCf6lhE5hvvvkp5TYOeYITrbSMjbpBnI3ahs4QPNV4rnd/TF0PSIVPzxj155MJtcIvaDBW9mzaNFs9ocVpRqZ/L1/MnVPFuW4efKwGSggGDh0DaFp222yIMwWu12cmFF3wrUtEkJ3Lhhrubt8R3xAic3dI0Piw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kNVX4feu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F997C433C7;
	Wed, 21 Feb 2024 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524732;
	bh=3F4ywAcbh6mLsfLUdJSuVGd8HBskPBrWA+r1BRsiXAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNVX4feumJqVWp5m/MK7+MRHx//KgQTNMiWclv/n4VFNmqG2bRYieCnjG0Qj4WLPz
	 JEpqPSEo1EwWH3qr7LuWoh23DJnoULZ4tWdahDAoS3fnETV826voL++A5JMACaiV4U
	 TykkC83BVuHjyDidyZdKnZXFxh2Xeb3v0Q3AakOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve Wahl <steve.wahl@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.10 332/379] x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
Date: Wed, 21 Feb 2024 14:08:31 +0100
Message-ID: <20240221130004.798415456@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Wahl <steve.wahl@hpe.com>

commit d794734c9bbfe22f86686dc2909c25f5ffe1a572 upstream.

When ident_pud_init() uses only gbpages to create identity maps, large
ranges of addresses not actually requested can be included in the
resulting table; a 4K request will map a full GB.  On UV systems, this
ends up including regions that will cause hardware to halt the system
if accessed (these are marked "reserved" by BIOS).  Even processor
speculation into these regions is enough to trigger the system halt.

Only use gbpages when map creation requests include the full GB page
of space.  Fall back to using smaller 2M pages when only portions of a
GB page are included in the request.

No attempt is made to coalesce mapping requests. If a request requires
a map entry at the 2M (pmd) level, subsequent mapping requests within
the same 1G region will also be at the pmd level, even if adjacent or
overlapping such requests could have been combined to map a full
gbpage.  Existing usage starts with larger regions and then adds
smaller regions, so this should not have any great consequence.

[ dhansen: fix up comment formatting, simplifty changelog ]

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240126164841.170866-1-steve.wahl%40hpe.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/ident_map.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_map
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_large(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;



