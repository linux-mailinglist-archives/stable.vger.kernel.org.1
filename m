Return-Path: <stable+bounces-153074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFBADD22F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D9017D477
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB92ECE8F;
	Tue, 17 Jun 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e4b/tLY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413032ECE8E;
	Tue, 17 Jun 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174782; cv=none; b=EVjAMvOuOhu4PYpypbUtmaCRKmdR7YJh4FNRo5CKqHmtg0YS89S0xMEVJR1X1Ri0JbPrKH3RmiiY5OZwvXySljqi3fXWYt8wMeTmuM6lGe7J7ijriffsbK8r9B/qhFQi/VrSPfgO/W1E27IfHchDUvNu1gj0NPa7rBwcqiQenvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174782; c=relaxed/simple;
	bh=mjXK2qvcvocZZhn7tACb4FEn//vaIkH9YwnFHuXDjdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laKiofeRVRcdsmEtlTWwlUKvA2QmQSFCg7QJg4R4gUns5SebOSZVw/p76n+T0lOn1AXIWkRMIrhWoZ1HQ79X3an4U8Hjn3jd2CurmXGyUxSkZQRXPMYrS109eRib0yGMJG2zxqypuIhAWDNrYLhelvhTD/Mt6f+9QheLOskGBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e4b/tLY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53B1C4CEE3;
	Tue, 17 Jun 2025 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174782;
	bh=mjXK2qvcvocZZhn7tACb4FEn//vaIkH9YwnFHuXDjdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4b/tLY7d9oNXimyDtFWr3o5Truz6U3UPcYhQGs75gboPgYgrB21EBMFC7GDOpLsj
	 SOftYOlRzEsUz0Rf1WuDEhYHHkE8q/gHJJCif6LqOnTN2Pk73suO3r/G34zG/ombo6
	 8Qa7Gn9cuCbWDk3aGse3EsYpbEC0SYZmzJoRRP1s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 020/780] crypto: sun8i-ss - do not use sg_dma_len before calling DMA functions
Date: Tue, 17 Jun 2025 17:15:28 +0200
Message-ID: <20250617152452.332726414@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corentin Labbe <clabbe.montjoie@gmail.com>

[ Upstream commit 2dfc7cd74a5e062a5405560447517e7aab1c7341 ]

When testing sun8i-ss with multi_v7_defconfig, all CBC algorithm fail crypto
selftests.
This is strange since on sunxi_defconfig, everything was ok.
The problem was in the IV setup loop which never run because sg_dma_len
was 0.

Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 9b9605ce8ee62..8831bcb230c2d 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -141,7 +141,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 
 	/* we need to copy all IVs from source in case DMA is bi-directionnal */
 	while (sg && len) {
-		if (sg_dma_len(sg) == 0) {
+		if (sg->length == 0) {
 			sg = sg_next(sg);
 			continue;
 		}
-- 
2.39.5




