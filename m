Return-Path: <stable+bounces-155249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75645AE2F70
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 13:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1FD170D6B
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A9E1C5D7A;
	Sun, 22 Jun 2025 11:04:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4FC1D07BA;
	Sun, 22 Jun 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750590243; cv=none; b=FRYVl/JGfv7yu4aMC6WkYk1iBSnLXqFkF744dMwdWC4fRbVuci0bLjKE/HwmuoE1WPPG1ZegimEwp2xM1LIBlnijoI8MTNR1vnpek70pLIL8d/XaDjwBilgr8axAxEwaeSEYSGNFwOsb8LkviC9vAPfXsvI2dNvBA9n8hCcbrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750590243; c=relaxed/simple;
	bh=Qc+kl+BZULne/++22l7jmMT41bJToxl4RbYBXn5+pWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNcZV07z+z+pwua9vKGF84HaduDoJpiOWhd0+5elPEQsSynKCvZdSTkuhwYibX041IB1P+Mbr7BBOE/9XHX2j7hgVCbdponNLGYKCkBGgDEu+Cq1+LYhzWhL16zYWgLY4UiEjpdmfCgIlRFc8Tzk/GfvulkoGrHb+i8TZeBlG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8AxDGut4ldo7R0bAQ--.61247S3;
	Sun, 22 Jun 2025 19:02:05 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMAxjhum4ldoBa0lAQ--.33504S2;
	Sun, 22 Jun 2025 19:02:03 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	ziyao@disroot.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH for 6.1/6.6] platform/loongarch: laptop: Fix build error due to backport
Date: Sun, 22 Jun 2025 19:01:48 +0800
Message-ID: <20250622110148.3108758-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxjhum4ldoBa0lAQ--.33504S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4DtFyrZF1UWFyfWFWDKFX_yoW8JFWkp3
	9rC34UArWUGrs2qa1Dt348ur45Za43A3y2vay7A34q9asxX34j9r1Utas8GF12qay8Ar1Y
	qF95G3W5uF45uwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

In 6.1/6.6 there is no BACKLIGHT_POWER_ON definition so a build error
occurs due to recently backport:

  CC      drivers/platform/loongarch/loongson-laptop.o
drivers/platform/loongarch/loongson-laptop.c: In function 'laptop_backlight_register':
drivers/platform/loongarch/loongson-laptop.c:428:23: error: 'BACKLIGHT_POWER_ON' undeclared (first use in this function)
  428 |         props.power = BACKLIGHT_POWER_ON;
      |                       ^~~~~~~~~~~~~~~~~~

Use FB_BLANK_UNBLANK instead which has the same meaning.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/platform/loongarch/loongson-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index 61b18ac206c9..5fcfa3a7970b 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -425,7 +425,7 @@ static int laptop_backlight_register(void)
 
 	props.max_brightness = status;
 	props.brightness = ec_get_brightness();
-	props.power = BACKLIGHT_POWER_ON;
+	props.power = FB_BLANK_UNBLANK;
 	props.type = BACKLIGHT_PLATFORM;
 
 	backlight_device_register("loongson_laptop",
-- 
2.47.1


