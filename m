Return-Path: <stable+bounces-189210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70743C05077
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED75188859B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE4E3043D0;
	Fri, 24 Oct 2025 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Mq+VO9oq"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55857302CC1;
	Fri, 24 Oct 2025 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294264; cv=none; b=N8pAxSbRT9iKH95FIR9J7P5nrtPw4SS2p0b8j9P69Eb5SREKZ2338YINxmb/7L1dFpVSRIy9D+Ytjzub6JSzXk/skohb+PQq3Ut7TvIhaKGYl+LkE+pprUxZySq/9yOZmiWUKSCYg8YOvcMP9Z8xAbCRqVBYIJ0bX/+ss+gLHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294264; c=relaxed/simple;
	bh=VllH397HUZLGZlTEcc40pbNTwaXJJj+yH2kUesCtVeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiJ1gMhKe2/e4R+X63dGZFfxQQIuvJMh7GMfDLw6+88OXzmSzSOgH0CwGuFZpzC9QdgYYGtZ3KEKGB0P3eZXNEWf+2qnFIHiDDs0JbMm7qMlSMfHxOwYQI+Pd7BV/kHiyR0mWShQHZ4PbRimFbH0k9bI75LQ/Pg6ZfVDoL2kVEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Mq+VO9oq; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=we
	f/5RtKFc6j+gr1pDobNXpElTJ0PkzMN7RzTRqNfgQ=; b=Mq+VO9oqVeM67hba3i
	Gygd3w4luWJW9eoBXUGl1oquGGop2gc/Aj8tm8uuqWayGZnilgijTklvwy83Ukmx
	kwduAS5MJjLywcWJMsYZbnlDzjvzn+ESyUIcoZXugAJ6O+AJKJ4eKUtcF2IAVxVS
	VKCdxHxy29SATSATN6uOBxUwk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDX54uaN_to492MAA--.43853S2;
	Fri, 24 Oct 2025 16:23:54 +0800 (CST)
From: Shawn Guo <shawnguo2@yeah.net>
To: Mark Brown <broonie@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] regmap: irq: Correct documentation of wake_invert flag
Date: Fri, 24 Oct 2025 16:23:44 +0800
Message-ID: <20251024082344.2188895-1-shawnguo2@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgDX54uaN_to492MAA--.43853S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKr4fuw47tF4Utr4UCFWxWFg_yoW8JF1xpF
	ZrCa1Fyr48Kry0vayDZ3Wj9FyUtwnrG3y3C3yDJr4jv3s0gry0qF4v9FyYqa4kJrWUCF4j
	gwn7KrWj9a1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO_-9UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNxoNcmj7N5ohyAAA3F

From: Shawn Guo <shawnguo@kernel.org>

Per commit 9442490a0286 ("regmap: irq: Support wake IRQ mask inversion")
the wake_invert flag is to support enable register, so cleared bits are
wake disabled.

Fixes: 68622bdfefb9 ("regmap: irq: document mask/wake_invert flags")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 include/linux/regmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4e1ac1fbcec4..55343795644b 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1643,7 +1643,7 @@ struct regmap_irq_chip_data;
  * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @status_is_level: Status register is actuall signal level: Xor status
  *		     register with previous value to get active interrupts.
- * @wake_invert: Inverted wake register: cleared bits are wake enabled.
+ * @wake_invert: Inverted wake register: cleared bits are wake disabled.
  * @type_in_mask: Use the mask registers for controlling irq type. Use this if
  *		  the hardware provides separate bits for rising/falling edge
  *		  or low/high level interrupts and they should be combined into
-- 
2.43.0


