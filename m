Return-Path: <stable+bounces-101836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6AF9EEEDA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE025169B49
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613AA2210E3;
	Thu, 12 Dec 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fof1L5tW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7314A82;
	Thu, 12 Dec 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018975; cv=none; b=tVrVqvJZqWTFstvz1+9pXr9JkH3pbY/FY45emodvgsNEu2Tq+hjynmwAD+IELk0WqMs7XTxahDxQ2UBVnuNJJQgRcXBJtylLkbQH/RHWYkpf77uwNAPo6UKtHMo4s/BU/40s4vGcMT5gecpQbKQreTX3srNykaA/NtL7qY6C0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018975; c=relaxed/simple;
	bh=EilRNLA/xFgEbfLVtYLxFAt5enzcnnUiE2kEyfbiqvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHUgDgOzEJXcitJif5/hiu8TnnRApxQDejB38KJBtoTNpGZE1HDdItElIlrPy35hZW56Hn8Fw5r86luJUZU6834qnQF9f/n6waRgAvdkHKEcdL5uWm1N2rLI0hxAqKBrhuUCtsz07mN+PT6+zLAKP4DlniuKJzYxHIPmUGhQ20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fof1L5tW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67128C4CECE;
	Thu, 12 Dec 2024 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018975;
	bh=EilRNLA/xFgEbfLVtYLxFAt5enzcnnUiE2kEyfbiqvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fof1L5tWVk5TEogLFlIlkRaq19AK7lH/zBFtwXorTkfTSu26aJvI3o91JjbkbdpWZ
	 AL+dv+EkAI1IUKd5sk/oLNaadcbimWDpRn3siCuSQ1kJqMbmQ6Tx+T8xCA40QnYvqh
	 KoPKnmhMGYpjNyrX8+zKzMqLFv819K7QMYgGRdiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 083/772] crypto: cavium - Fix an error handling path in cpt_ucode_load_fw()
Date: Thu, 12 Dec 2024 15:50:28 +0100
Message-ID: <20241212144353.368010209@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index ec17beee24c07..54de869e5374c 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -302,6 +302,8 @@ static int cpt_ucode_load_fw(struct cpt_device *cpt, const u8 *fw, bool is_ae)
 
 	ret = do_cpt_init(cpt, mcode);
 	if (ret) {
+		dma_free_coherent(&cpt->pdev->dev, mcode->code_size,
+				  mcode->code, mcode->phys_base);
 		dev_err(dev, "do_cpt_init failed with ret: %d\n", ret);
 		goto fw_release;
 	}
-- 
2.43.0




