Return-Path: <stable+bounces-131429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C17A80A14
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A6E4C5022
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE11276049;
	Tue,  8 Apr 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0N0iEmJs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A0276046;
	Tue,  8 Apr 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116372; cv=none; b=e9wB1AbZFwuWPL5Hg84+AghMuisNEGWwARBMrjy7+IJdIHBRaa0feITR6JNDfRNiqEXGI7I5ZoRKOPYqW5NWVT42qsdNW+W9OUARfQwuOfe/7OYb7PTWkLpEQPwjFnmgCPz4vX3znBnSzpkxCKJLT3P7Pqxgcc95CrZbzLGKaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116372; c=relaxed/simple;
	bh=uwd79va/NARgCV45MPgGOl586uZqKBevi3P6QmpoEX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJRT8dW52DEec+aj3AzRDL83ZPDioR/pABa/bjea9VgwBiWimBR/lDHmlPdlX1Kxjp497iesgrRdg0Udtb1sl0tFo1toxRlVvA9562Gj9uXF82ITkmQB0yDxxXS+lqCtWZhRalqgRhOWq0mhGuyQRwVJjKavUgct7tU9VcYB7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0N0iEmJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E06C4CEE5;
	Tue,  8 Apr 2025 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116372;
	bh=uwd79va/NARgCV45MPgGOl586uZqKBevi3P6QmpoEX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0N0iEmJswtgPtUDliHMXUmZ73o1xv/TdYCrbZj1pQwVkLFPXVMlSOz0+M3Np4xnhE
	 omy7KZDKv9Z6941FYRv3PyZEzOKu/i1pI5rRvnLauRJaCpcw7u44oUW0tZvcPExhW5
	 EPBbP21v2UqZ6vknySr3Cx/rj9gcHuEaLgu0r2a8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Will McVicker <willmcvicker@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 116/423] clk: samsung: Fix UBSAN panic in samsung_clk_init()
Date: Tue,  8 Apr 2025 12:47:22 +0200
Message-ID: <20250408104848.430652140@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index afa5760ed3a11..e6533513f8ac2 100644
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




