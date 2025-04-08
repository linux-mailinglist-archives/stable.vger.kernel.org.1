Return-Path: <stable+bounces-129531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D92A8001D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAC4421579
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DFB267F65;
	Tue,  8 Apr 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsVvgKrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CD224F6;
	Tue,  8 Apr 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111282; cv=none; b=LwjdWBgnZm2MDZXcVqJDiFpzPM6hL11gfADCONv/B4jDsTN9D0CZvisELZ7+SqtSIkfZ/cjK4I9d/WrTrB/yXKESAb6jL/Ety2ULyDaPhDioYW+uqyKrQ+VO0PCERMJEDGkHzztb7Wd9TCVo4/sWsZTzwIMYkU/1pzNc90L7+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111282; c=relaxed/simple;
	bh=vCkvmuPED+9IH7ynkiw9H2DkxYuMhjisCY1YOT3BtZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQPc9/qpOwynEEyHZ33cpvc2YEPqDjOGYfF/Wn1F8pB7Zlf9+5qv7YmBWwxQ5sEBhY8HdF6WLqxABhgRBqJFsRaZy5FSrPoEHJe4zAtBTnoO0AjZX/h3zTYz88UCN8tcvjZhmDwaLZKI+c+jPG0bqhcdMq+Os9lL8d5Uti7827U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsVvgKrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F22C4CEE7;
	Tue,  8 Apr 2025 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111282;
	bh=vCkvmuPED+9IH7ynkiw9H2DkxYuMhjisCY1YOT3BtZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zsVvgKrAmg9k+tatVrClfEU4SP7F+yVFeo+0vKaoYGhLvzgsNNgdHjqqeSZHR3dga
	 M4KAvfZouqQqcYz7NY18yYduHJ86D9OdX6DCeaQdaSVF21oYfSuMFqEkzjcljZNiAw
	 JPv8pen7eeJBkIbizCo2x7uanEOKkPlD/rfkPoO8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Will McVicker <willmcvicker@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 374/731] clk: samsung: Fix UBSAN panic in samsung_clk_init()
Date: Tue,  8 Apr 2025 12:44:31 +0200
Message-ID: <20250408104922.976315463@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will McVicker <willmcvicker@google.com>

[ Upstream commit d19d7345a7bcdb083b65568a11b11adffe0687af ]

With UBSAN_ARRAY_BOUNDS=y, I'm hitting the below panic due to
dereferencing `ctx->clk_data.hws` before setting
`ctx->clk_data.num = nr_clks`. Move that up to fix the crash.

  UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
  <snip>
  Call trace:
   samsung_clk_init+0x110/0x124 (P)
   samsung_clk_init+0x48/0x124 (L)
   samsung_cmu_register_one+0x3c/0xa0
   exynos_arm64_register_cmu+0x54/0x64
   __gs101_cmu_top_of_clk_init_declare+0x28/0x60
   ...

Fixes: e620a1e061c4 ("drivers/clk: convert VL struct to struct_size")
Signed-off-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250212183253.509771-1-willmcvicker@google.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 283c523763e6b..8d440cf56bd45 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -74,12 +74,12 @@ struct samsung_clk_provider * __init samsung_clk_init(struct device *dev,
 	if (!ctx)
 		panic("could not allocate clock provider context.\n");
 
+	ctx->clk_data.num = nr_clks;
 	for (i = 0; i < nr_clks; ++i)
 		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
 	ctx->dev = dev;
 	ctx->reg_base = base;
-	ctx->clk_data.num = nr_clks;
 	spin_lock_init(&ctx->lock);
 
 	return ctx;
-- 
2.39.5




