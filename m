Return-Path: <stable+bounces-210629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCisOsMqcGmyWwAAu9opvQ
	(envelope-from <stable+bounces-210629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:24:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A354F0C6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E0B7920AB2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BEF304BBD;
	Wed, 21 Jan 2026 01:22:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210BF306D36;
	Wed, 21 Jan 2026 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958576; cv=none; b=dBGbF4HZU6Gakou9jFRBSr4/nwsCjh2SVDIv2FjvPCV9VWkbhfq4IWYUkG7908xOEZ5ZPKKUAWLUVOYtbZNlQ54mmqmuUyQIkEhQriRVFnXku94MNXPVoRH+/GCU29d08bvlGbVWdWcaXC8cmthRamwO7ZLy6U/xzcpcYj31mvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958576; c=relaxed/simple;
	bh=XCreuTY5gY2H4bs7NLVdbgcmDhbqvNA3rPMEgN0F6Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFp8XcJ2X7mSu0iQOw4xwzxFLa+bbYqfZqSSm0TetsK9ks5ooKI8cJz1RQcPPIPHpBMmhAyI5K/+jfr4RKYrTgnrEoPSOXWdWooeTARRG61HzwmVH3MxyszJhFRqHCZtdU5KB/gXPZh7KucBXtxx63LzXJ9E93LZVRGdMABACsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.108])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhFdKnBpw6_aBQ--.10840S9;
	Wed, 21 Jan 2026 09:22:47 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 7/7] clk: st: clkgen-pll: Add clk_unregister for odf_clk in clkgen_c32_pll_setup()
Date: Wed, 21 Jan 2026 09:22:23 +0800
Message-Id: <20260121012223.186199-8-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260121012223.186199-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260121012223.186199-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhFdKnBpw6_aBQ--.10840S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar48Ar1ktF4fJr1kJw4UCFg_yoW8tryUp3
	WrG34Yya4kXF4kWFs3Jr4q9F98G3Z29FW7urWYywn5Zw43Jry5Jw4Y934I93W5Cry8uw42
	qr4q9r48uF48tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
	JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYcTQUUUU
	U
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwwOE2lwF5s6QwAAs6
X-Spamd-Result: default: False [0.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihaoxiang@isrc.iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210629-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isrc.iscas.ac.cn:mid,iscas.ac.cn:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 84A354F0C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In clkgen_c32_pll_setup(), clkgen_odf_register() allocated
clk_gate and clk_divider memory and registered a clk. Add
clk_unregister() and kfree() to release the memory if
error occurs. Initialize odf to zero for safe.

Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/st/clkgen-pll.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index b8d2b97a6b9b..3fc0af4b77c6 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -761,10 +761,12 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 	struct clk *pll_clk;
 	const char *parent_name, *pll_name;
 	void __iomem *pll_base;
-	int num_odfs, odf;
+	int num_odfs, odf = 0;
 	struct clk_onecell_data *clk_data;
 	unsigned long pll_flags = 0;
 	struct clkgen_pll *pll;
+	struct clk_gate *gate;
+	struct clk_divider *div;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	if (!parent_name)
@@ -808,7 +810,7 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 			if (of_property_read_string_index(np,
 							  "clock-output-names",
 							  odf, &clk_name))
-				return;
+				goto err_odf_unregister;
 
 			of_clk_detect_critical(np, odf, &odf_flags);
 		}
@@ -817,7 +819,7 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 				odf_flags, odf, &clkgena_c32_odf_lock,
 				clk_name);
 		if (IS_ERR(odf_clk))
-			goto err;
+			goto err_odf_unregister;
 
 		clk_data->clks[odf] = odf_clk;
 	}
@@ -825,6 +827,14 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 	return;
 
+err_odf_unregister:
+	while (--odf >= 0) {
+		gate = to_clk_gate(__clk_get_hw(clk_data->clks[odf]));
+		div = to_clk_divider(__clk_get_hw(clk_data->clks[odf]));
+		clk_unregister_composite(clk_data->clks[odf]);
+		kfree(div);
+		kfree(gate);
+	}
 err:
 	kfree(clk_data->clks);
 	kfree(clk_data);
-- 
2.25.1


