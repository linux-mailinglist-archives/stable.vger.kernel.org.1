Return-Path: <stable+bounces-210040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E494BD3092B
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E984310EF8E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3237B40A;
	Fri, 16 Jan 2026 11:39:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3535FF69;
	Fri, 16 Jan 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563555; cv=none; b=Sysx0Xs5qfldzBsLkbmQXy2ahUIjJ3aU5E/vuXTNIcb92ZxhaM7XM1zUwhv9Gu21Ut/+ZjCXIilgJSJGsqSjH4sIHCmJ0FVdnyd0Z49Jgr/bAtFrgGUantFq6mrQfRbjFnIAllgUAeyfRUniw5gG742mCIAXoAKp8oiN8krlmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563555; c=relaxed/simple;
	bh=gXaaqGMwviSycFsCjnH8LyzyxS+OcfBfyf7/rQri/54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEjUXkmkc09fQZWl2K9XIRXHpbQ/Vv5+bB/xGpZ6F5QrSd55Dtdtm1WFHwBimRufcOeSW5u5LR4OZy0YQhHMU6yaMp2W/Xz3Z9umuYYS8jyId3rhS26RKqFW/ZEn9rQCUGLHGMlFlBQgV4MrHrL3h+gvpkiSthlt/t8zay2YK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowAC3TBBMI2ppZbMsBQ--.56400S6;
	Fri, 16 Jan 2026 19:39:05 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 4/7] clk: st: clkgen-pll: Add iounmap() in clkgen_c32_pll_setup()
Date: Fri, 16 Jan 2026 19:38:44 +0800
Message-Id: <20260116113847.1827694-5-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260116113847.1827694-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260116113847.1827694-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3TBBMI2ppZbMsBQ--.56400S6
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWxXFyfuw1rJr1kCw47twb_yoWkuwcEv3
	y0g34Ig345Gw1rAr1UWw4Sv34Yyws5uF1xWr18tayfta45XryUKrWFvrs3trySgF4akFyD
	Gw17Wr43Cr1UJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6kFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYcTQUUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCREJE2lp34rSowAAsm

Add a iounmap() to release the memory allocated by
clkgen_get_register_base() in error path.

Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/clk/st/clkgen-pll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 4ff9b35fe399..0239835b4015 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -778,8 +778,8 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 
 	pll_clk = clkgen_pll_register(parent_name, datac->data, pll_base, pll_flags,
 				  np->name, datac->data->lock);
-		return;
 	if (IS_ERR(pll_clk))
+		goto err_unmap;
 
 	pll_name = __clk_get_name(pll_clk);
 
@@ -829,7 +829,11 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 	kfree(pll_name);
 	kfree(clk_data->clks);
 	kfree(clk_data);
+err_unmap:
+	if (pll_base)
+		iounmap(pll_base);
 }
+
 static void __init clkgen_c32_pll0_setup(struct device_node *np)
 {
 	clkgen_c32_pll_setup(np,
-- 
2.25.1


