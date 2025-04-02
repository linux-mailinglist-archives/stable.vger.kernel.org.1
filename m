Return-Path: <stable+bounces-127403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920CDA78B08
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 11:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A905188F782
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04712356D7;
	Wed,  2 Apr 2025 09:25:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93A1E8837;
	Wed,  2 Apr 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585930; cv=none; b=o+k/Ow6huXc2tEa+RoRWV8f00Fg6UhGypkUkdh5PvhEpM+bYZXiwqzJJQf4ROZiXrkCrpytnw0ctQ7rxBZolvU7XARRcfDHVHvquYmOyEv3bXZd39bjF6hQC82TWwMK1C6GgtlJdCE7TTiqsn4nIfkrN4y2jpXPGTg67GO9C+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585930; c=relaxed/simple;
	bh=y90OORQmQst754NgohihyeKjzbwkvGiSh/5wkUbDPBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNBsezSgps+fSDGAV7cub/Q81Vc/vwqAN53iuapnLW7sREujsGRnx71rMlz4c/O1nNzPMjElFBUOqeXCPFokuIjy9jGAMUqh3V/60HoKVrwpQj9a6no8BkOwMZxT3iaDXw8dcKf4hcOn3aheidUe5iOCnbzhfbPDItsazJRViPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051CEC4CEDD;
	Wed,  2 Apr 2025 09:25:27 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH] irqchip/loongson-liointc: Support to set IRQ_TYPE_EDGE_BOTH
Date: Wed,  2 Apr 2025 17:25:00 +0800
Message-ID: <20250402092500.514305-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some peripheral subsystems request IRQ_TYPE_EDGE_BOTH interrupt type and
report request failures on LIOINTC. To avoid such failures we support to
set IRQ_TYPE_EDGE_BOTH type on LIOINTC, by setting LIOINTC_REG_INTC_EDGE
to true and keep LIOINTC_REG_INTC_POL as is.

Cc: stable@vger.kernel.org
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 2b1bd4a96665..c0c8ef8d27cf 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -128,6 +128,10 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
 		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
 		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
+		/* Requester need "both", keep LIOINTC_REG_INTC_POL as is */
+		break;
 	case IRQ_TYPE_EDGE_RISING:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
 		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
-- 
2.47.1


