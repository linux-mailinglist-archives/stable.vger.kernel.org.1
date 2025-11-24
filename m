Return-Path: <stable+bounces-196788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A0C823DB
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5761B3ABA6B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E242D239A;
	Mon, 24 Nov 2025 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG8mRcC5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B352147E6;
	Mon, 24 Nov 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011478; cv=none; b=OmdNic571o3sVi76w5tZPAK6Dkn1rdCLWajfoUEmHTtRKEoE7eGTIJiTW1QEffC+mwJ/jqM+VEfeRGIyLVZzEqvY7XR2g1I6G8I31XCxlRcTj/cU7NypuVHGdkQ02Wh7v0TYlrVM1ItKEqrgJRf+371x20DIihqijjgU1s/K3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011478; c=relaxed/simple;
	bh=O3EyU3E5bo9vSzH59x8bJJr1BEBx3anTP1amwii3DyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gUVDXjN61T5miSS5mu570IQvE31PXGR573LfXVmmMy+NauPOluS5fhif6A1/jwUTjVeMXkltmmKZTJZcS6Z9I5oQ8RmaO/+0Um896ypnHgO9tSBHKS5bVuxCTjKxs8utQS0GGpZTYzh2o/rzGPf00dBbgaHIHHysy2jpKxSQDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG8mRcC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B88C4CEF1;
	Mon, 24 Nov 2025 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764011478;
	bh=O3EyU3E5bo9vSzH59x8bJJr1BEBx3anTP1amwii3DyI=;
	h=From:Date:Subject:To:Cc:From;
	b=QG8mRcC579NKEbAZxe3afv0EhlOFaXQB4THuLOwr+uDjWlasFCKCWFKRoLxmEvVLu
	 oc7bqMqxhOlj4Q3GiPBIsYhnJI8XB1O5NbsjCGIQeIWMFSJx0asHIS0SDOGiEbdiJK
	 Or1vEf+RbdI6b1nMW6EOs7xVaNg2LKFksR7LUPIRT1HTD3ncTlXNRu4nz0wJT5fVN5
	 mRkzdoSwO0+eRde2lFv4VYSP9D6rbcgqcX18W2eKP1hCQPZICuA4l6Qy5ImX2bhXW+
	 L63bVsvoS9DbbuPgbAhi3mIfLQryJQNQuojFrl/zh/Wl2uaxVpKfSXEQ6Zs+JjZZ8U
	 MT6TZiKzY7fZA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 24 Nov 2025 12:11:06 -0700
Subject: [PATCH] clk: samsung: exynos-clkout: Assign .num before accessing
 .hws
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMqtJGkC/yXN0QrCMAyF4VcZuTawdo6qryJerF3UqDSSrDIZe
 3erXn5w+M8CRspkcGgWUHqxseQKt2kgXYd8IeSxGnzre+f8Fml+ZzFMj7uUCc88Y4k2ZIxS8mh
 IqqK479rgutBTCjuoqadSXf5ujqe/rcQbpenbhnX9AEXISzGIAAAA
X-Change-ID: 20251124-exynos-clkout-fix-ubsan-bounds-error-93071375ec78
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, stable@vger.kernel.org, 
 Jochen Sprickerhof <jochen@sprickerhof.de>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434; i=nathan@kernel.org;
 h=from:subject:message-id; bh=O3EyU3E5bo9vSzH59x8bJJr1BEBx3anTP1amwii3DyI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJkqay9VW7gv2v0sLjfCWjXnqNZ295dH9dZ9mhenlPQoS
 D24NZy9o5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAExk0UuG/3m2W2MLXBl9HBy2
 t4lO3vphj5PbJJUPVlv+v+tc2yr5NYThn81vm4jAieJnbeLFI/i1Jv/yF6u/L5m3Sobv0+UrEz5
 f4gcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
__counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
about the number of elements in .hws[], so that it can warn when .hws[]
is accessed out of bounds. As noted in that change, the __counted_by
member must be initialized with the number of elements before the first
array access happens, otherwise there will be a warning from each access
prior to the initialization because the number of elements is zero. This
occurs in exynos_clkout_probe() due to .num being assigned after .hws[]
has been accessed:

  UBSAN: array-index-out-of-bounds in drivers/clk/samsung/clk-exynos-clkout.c:178:18
  index 0 is out of range for type 'clk_hw *[*]'

Move the .num initialization to before the first access of .hws[],
clearing up the warning.

Cc: stable@vger.kernel.org
Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
Reported-by: Jochen Sprickerhof <jochen@sprickerhof.de>
Closes: https://lore.kernel.org/aSIYDN5eyKFKoXKL@eldamar.lan/
Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index 5f1a4f5e2e59..5b21025338bd 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -175,6 +175,7 @@ static int exynos_clkout_probe(struct platform_device *pdev)
 	clkout->mux.shift = EXYNOS_CLKOUT_MUX_SHIFT;
 	clkout->mux.lock = &clkout->slock;
 
+	clkout->data.num = EXYNOS_CLKOUT_NR_CLKS;
 	clkout->data.hws[0] = clk_hw_register_composite(NULL, "clkout",
 				parent_names, parent_count, &clkout->mux.hw,
 				&clk_mux_ops, NULL, NULL, &clkout->gate.hw,
@@ -185,7 +186,6 @@ static int exynos_clkout_probe(struct platform_device *pdev)
 		goto err_unmap;
 	}
 
-	clkout->data.num = EXYNOS_CLKOUT_NR_CLKS;
 	ret = of_clk_add_hw_provider(clkout->np, of_clk_hw_onecell_get, &clkout->data);
 	if (ret)
 		goto err_clk_unreg;

---
base-commit: b6430552c8cd95e90bb842ce2f421e7a5381859f
change-id: 20251124-exynos-clkout-fix-ubsan-bounds-error-93071375ec78

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


