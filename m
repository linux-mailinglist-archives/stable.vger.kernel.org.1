Return-Path: <stable+bounces-192338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59AC2FB50
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 08:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A881D3A7A3E
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 07:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5130AAC0;
	Tue,  4 Nov 2025 07:42:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062FD2D4811;
	Tue,  4 Nov 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242170; cv=none; b=KUQhoWzQ5J0U2WfqpZvIda+BpSCUtdF1TcHzLBajBPTZyVz6Uv9qIqlaYs71jrrRM2LbcYWtn70KlCOysA7YzkAPmFbLz4rw8Dmjcp2s7j1/fcaO2RZLAj6/xEWwHp4tTN0m6xR1zEREw3x44ypTXEiTIaVOcwx2XA+kCXgQSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242170; c=relaxed/simple;
	bh=Q7jngGv1NawQYZtSpvS73CXJteQqxzmFEIciwhtX3dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ICWP2o4TgVLHu13w/qsRagUoS3wpdCRgei/3JOa6eS7/rxN8ASYV4m2jklgonTaz2hRhQonMj3/yFhsSBvIgKlXFMQZeL9VJg4d5LZ6lye2lW2m9BkslVrS2QUWGsr5fI6P7PQGW7fMcPs/fJ/VQ/G73TLTFrtpkE2YssSh9dpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADHMWxprglpK3RaAQ--.1025S2;
	Tue, 04 Nov 2025 15:42:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: pdeschrijver@nvidia.com,
	pgaikwad@nvidia.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clk: tegra: tegra124-emc: Fix memory leak in load_timings_from_dt() on krealloc() failure
Date: Tue,  4 Nov 2025 07:42:29 +0000
Message-Id: <20251104074229.543546-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHMWxprglpK3RaAQ--.1025S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7uF18CF4fCFWxAFy7KFg_yoW8Cr48pF
	48G34qyry0vrWUJFnrJrnruFyYga43trWUKw1FyayFvrs8JFy0yryxArWF9a17Ar9avF4U
	JrWUWa1jqa1jvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOku4UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYQA2kJiUkkJwABs7

The function load_timings_from_dt() directly assigns the result of
krealloc() to tegra->timings, which causes a memory leak when
krealloc() fails. When krealloc() returns NULL, the original pointer
is lost, making it impossible to free the previously allocated memory.

This fix uses a temporary variable to store the krealloc() result and
only updates tegra->timings after successful allocation, preserving
the original pointer in case of failure.

Fixes: 888ca40e2843 ("clk: tegra: emc: Support multiple RAM codes")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clk/tegra/clk-tegra124-emc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 2a6db0434281..ed4972fa6dab 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -444,6 +444,7 @@ static int load_timings_from_dt(struct tegra_clk_emc *tegra,
 				u32 ram_code)
 {
 	struct emc_timing *timings_ptr;
+	struct emc_timing *new_timings;
 	struct device_node *child;
 	int child_count = of_get_child_count(node);
 	int i = 0, err;
@@ -451,10 +452,15 @@ static int load_timings_from_dt(struct tegra_clk_emc *tegra,
 
 	size = (tegra->num_timings + child_count) * sizeof(struct emc_timing);
 
-	tegra->timings = krealloc(tegra->timings, size, GFP_KERNEL);
-	if (!tegra->timings)
+	new_timings  = krealloc(tegra->timings, size, GFP_KERNEL);
+	if (!new_timings) {
+		kfree(tegra->timings);
+		tegra->timings = NULL;
+		tegra->num_timings = 0;
 		return -ENOMEM;
+	}
 
+	tegra->timings = new_timings;
 	timings_ptr = tegra->timings + tegra->num_timings;
 	tegra->num_timings += child_count;
 
-- 
2.34.1


