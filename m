Return-Path: <stable+bounces-108083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B75A074BC
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33703A2415
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14002165FD;
	Thu,  9 Jan 2025 11:30:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C01A23B0;
	Thu,  9 Jan 2025 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422221; cv=none; b=RIasZFs+JkO1d9hq7meOXOk2++19cD3wVMb5nOMGInqadzLgVe+34qix8vBbgDwDmcVyV7J9lj3eekiT1nYZTOmwHo8ZHk+wzHuB7idZZaaqVFcCgOOxAAAP4TOQRFjmPTi/W2bj5lVPkgi4a1EPQI4UitahqCmC+guyA0Ypa+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422221; c=relaxed/simple;
	bh=lb95zDcFf4pHNYtU0mfMsr//Td60UKrcikJ1/j9k9LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFb7H0jN2nPNXTmiJnwCdQ08x5xfBDGX/g92zvKGeykhU25NwOK1SKKPNEkCMbitXhJD2/u3HuZS5f+2OHbQbVg2s+f3dJ9rVtw7oj7tshBHaQtN5zSblPEYAqvF/2bvD8Cb7UkgN3tNY5fde7fwisG7LnPa9IqqQWyGrmuZYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.63])
	by gateway (Coremail) with SMTP id _____8DxK6xGs39nmJdgAA--.4200S3;
	Thu, 09 Jan 2025 19:30:14 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.63])
	by front1 (Coremail) with SMTP id qMiowMBxjcU_s39npy0bAA--.47595S2;
	Thu, 09 Jan 2025 19:30:11 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-clk@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	stable@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH v2] clk: clk-loongson2: Fix the number count of clk provider
Date: Thu,  9 Jan 2025 19:30:04 +0800
Message-ID: <20250109113004.2473331-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxjcU_s39npy0bAA--.47595S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF13ZF43XryUZry5JryfXwc_yoW8Cw45pF
	W3A34jkr48ta1rZF1DJw4I9FyYk34FvFyrCFW7C3WkZrn8W34jgF1rAFW0qay3GF48uF1F
	qryqkrW8CFWvkFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

Since commit 02fb4f008433 ("clk: clk-loongson2: Fix potential buffer
overflow in flexible-array member access"), the clk provider register is
failed.

The count of `clks_num` is shown below:

	for (p = data; p->name; p++)
		clks_num++;

In fact, `clks_num` represents the number of SoC clocks and should be
expressed as the maximum value of the clock binding id in use (p->id + 1).

Now we fix it to avoid the following error when trying to register a clk
provider:

[ 13.409595] of_clk_hw_onecell_get: invalid index 17

Cc: stable@vger.kernel.org
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Fixes: 02fb4f008433 ("clk: clk-loongson2: Fix potential buffer overflow in flexible-array member access")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
V2:
- Add Gustavo A. R. Silva to cc list;
- Populate the onecell data with -ENOENT error pointers to avoid
  returning NULL, for it is a valid clock.

Link to V1:
https://lore.kernel.org/all/20241225060600.3094154-1-zhoubinbin@loongson.cn/

 drivers/clk/clk-loongson2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
index 6bf51d5a49a1..9c240a2308f5 100644
--- a/drivers/clk/clk-loongson2.c
+++ b/drivers/clk/clk-loongson2.c
@@ -294,7 +294,7 @@ static int loongson2_clk_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	for (p = data; p->name; p++)
-		clks_num++;
+		clks_num = max(clks_num, p->id + 1);
 
 	clp = devm_kzalloc(dev, struct_size(clp, clk_data.hws, clks_num),
 			   GFP_KERNEL);
@@ -309,6 +309,9 @@ static int loongson2_clk_probe(struct platform_device *pdev)
 	clp->clk_data.num = clks_num;
 	clp->dev = dev;
 
+	/* Avoid returning NULL for unused id */
+	memset_p((void **)&clp->clk_data.hws, ERR_PTR(-ENOENT), clks_num);
+
 	for (i = 0; i < clks_num; i++) {
 		p = &data[i];
 		switch (p->type) {
-- 
2.43.5


