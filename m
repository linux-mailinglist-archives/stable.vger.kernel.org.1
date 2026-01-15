Return-Path: <stable+bounces-208416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E655ED2265E
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 05:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B02302AB92
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 04:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E720A2D3ED1;
	Thu, 15 Jan 2026 04:55:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F426ED25;
	Thu, 15 Jan 2026 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768452938; cv=none; b=r7BlqJAVRxgt4wWXu5hdCHCVEUpp5ALBUBmju2OqRx6+xtVgvmyzrqDwKDHorwRzFXwLud0x5jiKh4iz3Qs1rWfbCj9ZHGfC6wGRO3xa1jS4D87S0OXbcfjDPczO+Asu8epM4R7L3G42f8gZ3weWCPVCbUi/HmWATKz6dPAy3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768452938; c=relaxed/simple;
	bh=M3vM7wuGXUDGMOm1gsHecMoC3vq28dry1w+H07aPvu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bMdD5GAEDm+OawiM8TSgS428BYdIl01Bf6qMrJ3N4vzk0EnoPsel1zZ4SssLNDSBMr+Ai/IRLO2JP+PA3zNLQozACyttEoWVg7Oy1TlKScuDBe98Fxj8dRSJRrt3qgH1ViGXPL3QOdRX2/nId07Qyh+868OkIqt02U7PzEo4r0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowAAn0Gs9c2hpAMHBBA--.30272S2;
	Thu, 15 Jan 2026 12:55:25 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	mturquette@linaro.org,
	pankaj.dev@st.com,
	gabriel.fernandez@st.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clk: st: clkgen-pll: Fix a memory leak in clkgen_odf_register()
Date: Thu, 15 Jan 2026 12:55:24 +0800
Message-Id: <20260115045524.640427-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAn0Gs9c2hpAMHBBA--.30272S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyftw4rGr45XF4rCF4xXrb_yoWfGFcEy3
	y7X3sav34rCF43A3WUAw47ZryF93Wkurn3Wa1SyFW5K345XryUKrWFqrZ5Jr15WFWrGryD
	Gws7Aw15Cr47AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwkIE2loPJu0FQAAsS

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


