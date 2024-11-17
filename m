Return-Path: <stable+bounces-93750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE79D072D
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 01:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC52281E24
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ED8EC2;
	Mon, 18 Nov 2024 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="F62tTxCH"
X-Original-To: stable@vger.kernel.org
Received: from sonic316-12.consmr.mail.bf2.yahoo.com (sonic316-12.consmr.mail.bf2.yahoo.com [74.6.130.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292A360
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731888389; cv=none; b=iWXIxiP4F5FozhrPyGtLkkvd3s0qJXomSNRFTqCm2UCam/fVOaJZFDO3E7tOdPTl+PW2rg/9Wgnfmti7qzV1TSCdbF8vPta4siiow8T4l553BATKsFxCySjTb3cujrbyI6HlgfjHi3UC4befK9sreBwb2RjrndDvHQFzAu3HBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731888389; c=relaxed/simple;
	bh=IvWoevXXpmOe+XQTPhPlMfQe/45LyI5ZKS9WsLqakXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNZKORSaucw5BodbviKYQsl8D9r3NJQofCH5JbRuxwaQecw60hvQEueZIW28a6oM49piWu24JGERivPtdLxyDu3lEr5TDcSHxd5XpKzklSoutVTZCRDVjFUWk06x+34yEHG35yT2OIkQvpRuB5McwsfHxjZlD8dd9Uw+WPL5WMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=F62tTxCH; arc=none smtp.client-ip=74.6.130.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731888387; bh=r8BNRTgQmSesSBBIr5W5/aasZKD6i/fztbdUkMyjEmU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=F62tTxCHCfIcFZ+/rSPYP2aWNvyBN+fsqoUUC3Ps4+gRJPrVYSYeNBJmGIS9KDRZ7ExRVpmdFNKLmBUehwc+Me/4ioEjcsiiBfhAInyGnRPYnl5AzCnjmCNoatmIAzmidYa4MIoMpF3fUF7B52j9v1knis8JtETxC4SUDbA09vOKsMuLVbP2eTZqvqy1v3t2p3gaNgLlfZjYRLUHIv4y6JeHIvA/b1soMVjYMTxSh319cs+CxCGOKlPM8GP83vr5M3g6Tw3zf6qF7RD+PoCeGKi69oN/ZxcgzGC/IGiuyZShCKOfzJ6ZPWlXgulViTZPj76kQt6ERBJqQXZGmFPZkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731888387; bh=XvpHFkogB0NDCo3wwLQCvShie/xuhf88A8vjIhTdSWR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bXMCaLmTHMolPeFGePkuqbF5+CKfjtZ0hZHHsR4tmJK0vfeT2Ox6LpVCNpIjgee29MKgw1cuCV/iR2ejDQiBek2qF+7BzSSQAe7jCN6lDXlwqYSuSFdcg03o5DuAgpA3WW6BpyWKc3at2tso2nZz6+FVypXv3UuIER5kzmGz9A2CEbPxIqyZxikh9yUJ7iQc9DO+ZD2sepVGx4jWaswm/rEo+HkAlUb82Zrlg5uZ5wfhQdmUjxWM0gjgEHXcRe57hbfkYVtY5XDFmvZT3S1/M0FqlfAoamq56FkFA4SSgrqi/fAikj6aYopma3yr0ZPspt13tk9nKG/TiZN3k0/R/w==
X-YMail-OSG: S59FKPMVM1kpCnS9ge_nKiG7mynvlQXg9djmEd46vzER7F4taZVXBpTAbBie9iE
 Z1jv1e0s0UnAvX4okVPcwnoKfnIGx1FcpsMvesr_qRR2uP38u2Pk9Ars1SBHlUbb0wK9IcXPZUCZ
 QHNDKXYJWApovQwQfNovAsc0cEvoNYiuFmLIIMhbvqvqBDdmqrEEc6isaYR0PeE53RnF9bFwdFbm
 wnw53xBrzODr0MJoDB7F5U4cnykrFKKXizKJaL8BSLHjSqCoIeqE2qClPnpM9oCXyhq.CknNINAB
 77.sG_cmIP520_O71g3UFA4Y4_Ciik7jUuUcvK0KukCthLCmYesJxo5Cjl58lzK8SSZ_pvT.k9PP
 y1mGCzYNUMljZ53yd7hg6GnVjmG1NjU3jMQXTiRxnD9vWpbADRY8tyOkvAKQuXX3OJZwUDQNA.Id
 TzULIQadoJQ1CvDvkJTZuk_Dfsp5n9ZcMS.0Xjre5i_mPBoBEV9SV86.gd7OOEEMmJMTW1J2X4Vy
 vDJmQZAtPIGNXNevzMNoLYCN0oc9fQAd9TtiH.QcKH2AX1nhMiW3pC_CMM_wb7u9KkapEw5GDzQq
 BJJbPIrbKWPzl8nNjCKGMHDXzSYJ.mVQY9NYVePQVcB0Q43RCi5vPkAEoLnONPK1hiA7Hfcdf2me
 oasvWzAQAXEcmWblTG9sTTjZ2DiZazxzok2nK5rSF2mmyCNd4gRSS5oBE5HcFajs.fSO0cDVXATP
 gsoUEyIDeYDGMZGrPS1vVfj627mqbQtJOT75XXOKhSHSu7DaKpDsLNju3x7V4u03P4GXf2fMFFd1
 4114K5ioLCXMdLLFTudY1D3tQ4r2oXe3MJFXWadoKhVQfAIriFTkrxQDhT1gBOTilp_DyvU3mSIP
 XP5sh9THH_Tgak_zRXUbcOTckDex2.vYKdWUQW2oYMTwKExPgenW7BVC7sdx81lz4wwU9tx7LMT_
 G4hLP2dJC9goV62vhdxoLwrZia2PD8yrZGMpGSJ9ZRSdvvqQmZOJt2GFM2NFtXVNZziqWyEGE3J_
 WbdpKy.DobAUmhcM.IkbubpZk0BKO17B3ntMt3zPEFO2vkuZ2ja6uBTr_znhJLbBDu6vqLqbeaWZ
 Gtz4UVlngnfdhudnmsKw2U45bj0.zanqeCv_a04Un6bXocwtyfhDASv0l.PASXEamsdGEKGyFCMA
 b_8k_5t69zm.owxj8r3Os0xbSfXKxOULipLwyW2.gHgdwsTferaxOzfRgpi4ykzTyURPW8k1S.4x
 oKY4117dMdvvpmnHfsn6d9aDZpkBG9TO6TvH5N.46D_rRl2IWM4zBlDgscVTFDRNQFnoTnthZfRd
 CF76hyUDhwSmMUaOBqegQDEGqcQk0xJaa37rFZ6Ye3jwTNINZR7z3ptRlTKVOkz4360ypoBiA1J0
 FHmzXdYxlmam84mJlKQH_dltQDbQ8iAOnLvqq4NvAYUt5eDfBYR4.R7BADfGyomCIGhpO9jd9OGU
 832kYBhtgstB9VLrLsTQ85yDuHmO5sJJGI_CcpMOr3gGB0duzLzJ7lU.AGJCFmzsa4LrLp3gMvVu
 AHHTk978I5rgBKmE9W70M3B3qM3eu4qRR.Bif11wmktRUI35MGD1bM4PKQArVhQlI9UuSSa1zWwy
 5I5N3r8zySqFoL3J61ImpjiOAmZ_9ApvOoRHYqYKcXbKHqBm0DNIwSQXeHQvF4zCgm7Nhe5.mDMa
 G5C64M4ft8noHA1QeBWubgOo5C7IfNlX1Ph6Qpjwv1W3aDdohRcN7VE1LNpy9EZzwAP8Dzd7Ova8
 _Pal8ScmE3GKmxY0q2Sq1j8VUBTv_EICkLVXIee0pfTejKxlqcIuGsxoood6iSle0FSH58ZAvjEz
 Ebnxsyc1x8z2XgjsBq.NpZB2.0fRoYZSW9IZPHUQ3zF65izpanDWgG32yo5F1aCMfP_Am9dv.kR9
 CHakXdabfw2Ve.QxCB82NWKrII2_xiWPl40mXkznL.gSMfSb.NXbzHObV8OI3gKfNVhQMzfzSFgg
 5cLpzb_tsAhk1IcYdQdk939SS3kP7_wwjRVg1ShyGNuziQNNvlNShZb4v.SlI0ZOh4B2KDHJ_L0q
 .lvqoIW7RXjCIiY5x23RUe0bl5FbAqO_SKZ6fgamalhrF.Q1Df5zdk8iCYndEUiF2bv7p.yJSoCc
 nf87ZeUeH2sXzMjzt2717yMk7G3D6fCOe8.sZPLpbEQOtmwFRnS50npr8n8hfLYOWYZdK4Dh7.WQ
 REG5cfmJ7CGa35Zz_HdE3JBpVtw88p30q.KGXHqQE8BSqMvNZsIazEHjXUAGrOBo-
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: c5f9e86c-2920-4ada-bd15-5c35f4c19cc5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 18 Nov 2024 00:06:27 +0000
Received: by hermes--production-ne1-bfc75c9cd-m9q8x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e8940a2352a515f37c8ad5174ebcd87e;
          Sun, 17 Nov 2024 23:36:04 +0000 (UTC)
From: dullfire@yahoo.com
To: dullfire@yahoo.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA before any reads
Date: Sun, 17 Nov 2024 17:35:43 -0600
Message-ID: <20241117233544.18227-2-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117233544.18227-1-dullfire@yahoo.com>
References: <20241117233544.18227-1-dullfire@yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Currier <dullfire@yahoo.com>

Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
chips, the niu module, will cause an error and/or fatal trap if any MSIX
table entry is read before the corresponding ENTRY_DATA field is written
to. This patch adds an optional early writel() in msix_prepare_msi_desc().

Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 drivers/pci/msi/msi.c | 2 ++
 include/linux/pci.h   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879d85db..50d87fb5e37f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -611,6 +611,8 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 	if (desc->pci.msi_attrib.can_mask) {
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
+		if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+			writel(0, addr + PCI_MSIX_ENTRY_DATA);
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 37d97bef060f..b8b95b58d522 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.45.2


