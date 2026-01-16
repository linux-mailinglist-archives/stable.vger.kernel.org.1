Return-Path: <stable+bounces-210038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48595D30927
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 007EC310EA64
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523437B3EB;
	Fri, 16 Jan 2026 11:39:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AC2EB87D;
	Fri, 16 Jan 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563554; cv=none; b=SRET5WsqWvmkZPkLfeFD543sk6gdt8yDQbIqXDkQYFpPqML6CGtf/kNvi0eXL2gs5IhSJMSiBs1pISuKtsrvuplF6DSENvS1HeqePL5nXX+Nre1Avwr111Z6ypd79oEpMCYkDx5IlTGxwj/8AxNx0Ex8XZGpNy2MzYIpHczkXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563554; c=relaxed/simple;
	bh=M3vM7wuGXUDGMOm1gsHecMoC3vq28dry1w+H07aPvu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3RaSORxJos6PxwE3buSitbcz33hzF+0/EVpzvCGogf9KMjELjy0cuYli2M9KpHpUqNZiEZ8WVufAcWD42pW2+RBtzOHA6E9KXYpp//H2yHxJNxZCs1Z/pdYe/lp+6Lgp3h/I9XMbYyKoiaqzi9BfLbgtieKmAzpvP4MDlfDiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowAC3TBBMI2ppZbMsBQ--.56400S3;
	Fri, 16 Jan 2026 19:39:03 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] clk: st: clkgen-pll: Fix a memory leak in clkgen_odf_register()
Date: Fri, 16 Jan 2026 19:38:41 +0800
Message-Id: <20260116113847.1827694-2-lihaoxiang@isrc.iscas.ac.cn>
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
X-CM-TRANSID:zQCowAC3TBBMI2ppZbMsBQ--.56400S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyftw4rGr45XF4rCF4xXrb_yoWfGFcEy3
	y7X3sav34rCF43A3WUAw47ZryF93Wkurn3Wa1SyFW5K345XryUKrWFqrZ5Jr15WFWrGryD
	Gws7Aw15Cr47AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbhAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
	x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUemhwUUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwkJE2lp3rvU-AAAsZ

If clk_register_composite() fails, call kfree() to release
div and gate.

Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/clk/st/clkgen-pll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index c258ff87a171..a7d605b52cf3 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -742,8 +742,11 @@ static struct clk * __init clkgen_odf_register(const char *parent_name,
 				     &div->hw, &clk_divider_ops,
 				     &gate->hw, &clk_gate_ops,
 				     flags);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		kfree(div);
+		kfree(gate);
 		return clk;
+	}
 
 	pr_debug("%s: parent %s rate %lu\n",
 			__clk_get_name(clk),
-- 
2.25.1


