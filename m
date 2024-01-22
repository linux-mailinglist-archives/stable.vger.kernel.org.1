Return-Path: <stable+bounces-13644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFFB837D3C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F7A292040
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06E4F897;
	Tue, 23 Jan 2024 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPdVWVcJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB3148CCD;
	Tue, 23 Jan 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969856; cv=none; b=pJJldxBh6XX+oQAmZL/TSHZrchahmetlBB1W9vYFp0ro1PrjRZtgc/BZk3NJSxdFdessc3NsJ+OKLqzssg/T2Di8Gie9qcou0BM+sL906OiH5wj+7SbrFSI3v7l+QcdHCtWn4pyDyKorWlV2GQqDbg/Nd+zyq1UfAQHvwmAc7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969856; c=relaxed/simple;
	bh=/zOZPwGvZWhe/cDPfHM8G77s3PBCUOs89JIS1j6cy44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlQ6820v2RCL4/EPEoT+C3MXF5okt6HRq/f8XSwCQ//E2kVJ9msXObuT6t2RltwjdbcgjbUcSYXeseExB7/lzKNuSvxDI1I7oa4uxgvJAjfYfaTbC8qGQOgfbtqdn+p/JK73rYwHmEaTRoamvBXe6qkTBKmy4Oo0doVBneb/gTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPdVWVcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92744C433C7;
	Tue, 23 Jan 2024 00:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969855;
	bh=/zOZPwGvZWhe/cDPfHM8G77s3PBCUOs89JIS1j6cy44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPdVWVcJ+9KJZ4XF/c3sInm36kA+dBUj80Ap80TnUg8ICGRzK0LTbMSFfQKwBAY/0
	 x0O9LpgzNumGLgPPCBYXiYM3GrmxuDKdfZm2/Hg3ZedCiT5Yd/z3gq5hqHUShE3kw+
	 s7p4F3AHsrCU/8KxvZUxz0hrjX4qAcgWZCvmsxGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 488/641] mfd: tps6594: Add null pointer check to tps6594_device_init()
Date: Mon, 22 Jan 2024 15:56:32 -0800
Message-ID: <20240122235833.352000098@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 825906f2ebe83977d747d8bce61675dddd72485d ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 325bec7157b3 ("mfd: tps6594: Add driver for TI TPS6594 PMIC")
Suggested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20231208033320.49345-1-chentao@kylinos.cn
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps6594-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index 0fb9c5cf213a..783ee59901e8 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -433,6 +433,9 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
 	tps6594_irq_chip.name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
 					       dev->driver->name, tps->chip_id, tps->reg);
 
+	if (!tps6594_irq_chip.name)
+		return -ENOMEM;
+
 	ret = devm_regmap_add_irq_chip(dev, tps->regmap, tps->irq, IRQF_SHARED | IRQF_ONESHOT,
 				       0, &tps6594_irq_chip, &tps->irq_data);
 	if (ret)
-- 
2.43.0




