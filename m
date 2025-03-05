Return-Path: <stable+bounces-120497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A7FA50706
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894117A176B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B419253335;
	Wed,  5 Mar 2025 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WpxXbVEU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF5253324;
	Wed,  5 Mar 2025 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197132; cv=none; b=Dy2fi3oF1F5wWgwFeF/KC7LOCaIb2u65olqqXyyS19hCsUH7qSZ19anf9cANRQIjmtX236WbOOOrnUzTIIuOTomKDw+strbP+pNs2f2thoy9I9xXAPDnrnSNNCJTQS6R2vdxPGp8EnShqp1acdIvJ/HUOSWrRMtt6+GiSmZJR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197132; c=relaxed/simple;
	bh=8PtGuLEwZOi6ErnmueEXHpS6fPWe74Xn2qILWQlZzvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk3MPqXN3q2E46sGCHf29kpPBNiY9RjvLXDyLHFWk8/FjSS4gh8K6TpNzm73aL58BH7kAtdVJUbMhkvArHwwyzPreaS2liTqN5IlRz1q1M6T5xzYpbmcI/XD4pqw/eYrn7hlOnYT+rxkEVypuaT1fcPZNT3DbwvaZdC+gImwxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WpxXbVEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF38C4CEE9;
	Wed,  5 Mar 2025 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197132;
	bh=8PtGuLEwZOi6ErnmueEXHpS6fPWe74Xn2qILWQlZzvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpxXbVEUNDEk4QL+RRQx0FLu8/qpK5hcp0wRFEnqmyqaxMbETaFY4kaFxgnoRVlI9
	 qRoIWbpMRQCwDHoa/MWucAWwo+sxlbc6BAyQi3NKHXGzHuHjnjfN/+Ve7z7xn/fFf5
	 BrqH9Hy/0MSV312IzI+X+HNTsMoTm2bdeo/odXAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/176] soc: mediatek: mtk-devapc: Fix leaking IO map on driver remove
Date: Wed,  5 Mar 2025 18:46:42 +0100
Message-ID: <20250305174506.794526882@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c9c0036c1990da8d2dd33563e327e05a775fcf10 ]

Driver removal should fully clean up - unmap the memory.

Fixes: 0890beb22618 ("soc: mediatek: add mt6779 devapc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250104142012.115974-2-krzysztof.kozlowski@linaro.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/mediatek/mtk-devapc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index 226a79f43492f..7269ab8d29b64 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -305,6 +305,7 @@ static void mtk_devapc_remove(struct platform_device *pdev)
 	struct mtk_devapc_context *ctx = platform_get_drvdata(pdev);
 
 	stop_devapc(ctx);
+	iounmap(ctx->infra_base);
 }
 
 static struct platform_driver mtk_devapc_driver = {
-- 
2.39.5




