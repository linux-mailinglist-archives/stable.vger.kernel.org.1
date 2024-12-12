Return-Path: <stable+bounces-103174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1E89EF560
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D642854C4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA06213E9F;
	Thu, 12 Dec 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iifwf28w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE6211493;
	Thu, 12 Dec 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023767; cv=none; b=pSgAfxNy4aFK9cm9qaSKpK4tObGlWDuIRdV13QMp2DSXCtNScwWGn1pk06vzT9cJbVOxZcolpqtsD9UKQZnn1kQWr2rQP7bOkwrG0Buv1Y0QkKbulrXITKzIwRyWqp94fjhgpjYejawt+jOC02h68HAiMILm9cxaIT8XpkkI858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023767; c=relaxed/simple;
	bh=dGTsjotbgUFuwGaMUPXxzDZXkUhXwXaB4elHwfJvkng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkrzWfi5lIpRj2oHJB2sgCMBQ+BKYrwYLbDLI0q6EbdUnMriBkKszE2bY55Z9kZmiDWI+mKMl5EBdPPh3IJB6QQ1LdyNJz4Jy9oT21U/72q2ZYmJ3RkPGe9mYHMe73hqGRIer+mB0pzqbsSkQBKgJXB0l6baUU5cdqMVWUUPFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iifwf28w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07FCC4CECE;
	Thu, 12 Dec 2024 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023767;
	bh=dGTsjotbgUFuwGaMUPXxzDZXkUhXwXaB4elHwfJvkng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iifwf28wqPvTi44FhIy0ceTRgYcFc6jlaT+EsthvlJljNZPoTRtSFifP4C/PXSRRt
	 pyd9dRz3q3AyJ3V9fikhxTJPlaNT50lE8EHUmAEw9A1qA3KtZYQr46DfT0DPxbtlYm
	 pj1cUwv6/mUw5+Rqo+zGuk4491UseSts3rLinPng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 075/459] crypto: cavium - Fix an error handling path in cpt_ucode_load_fw()
Date: Thu, 12 Dec 2024 15:56:53 +0100
Message-ID: <20241212144256.484253810@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 572b7cf08403b6c67dfe0dc3e0f2efb42443254f ]

If do_cpt_init() fails, a previous dma_alloc_coherent() call needs to be
undone.

Add the needed dma_free_coherent() before returning.

Fixes: 9e2c7d99941d ("crypto: cavium - Add Support for Octeon-tx CPT Engine")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/cavium/cpt/cptpf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavium/cpt/cptpf_main.c
index b3db27b142afb..52101755d0ddf 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -303,6 +303,8 @@ static int cpt_ucode_load_fw(struct cpt_device *cpt, const u8 *fw, bool is_ae)
 
 	ret = do_cpt_init(cpt, mcode);
 	if (ret) {
+		dma_free_coherent(&cpt->pdev->dev, mcode->code_size,
+				  mcode->code, mcode->phys_base);
 		dev_err(dev, "do_cpt_init failed with ret: %d\n", ret);
 		goto fw_release;
 	}
-- 
2.43.0




