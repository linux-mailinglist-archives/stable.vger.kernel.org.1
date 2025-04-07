Return-Path: <stable+bounces-128550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F483A7E05E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8671888FAF
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497981ADC83;
	Mon,  7 Apr 2025 13:59:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D601ADC78;
	Mon,  7 Apr 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034346; cv=none; b=nxwqptKe2MbAQQn+nuvxC8m5dAzz0HGMkflECni42IGgKwyPBmdqPQHLU9DJrFzAY21yIznv8AB/ftRV/wpwSnJ00mgfevV4/vCEySvh2849F68Px1Mo3/v2u7/uE7lIoadQzSMf8NIAV78755cNwViCoe2M+9auzXO9JzTUIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034346; c=relaxed/simple;
	bh=tyW251slBoQIpZUCApqgn8GWnpEiTP8f166g2a7Y2tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlq65s1wJlNOfL4CuUR0IBVPp302WR2z/vGorV6kf76czeXdE2hP2Qy49+GgsgOVenmQSpooW3H1mgZrMuueZStQr+FuLd6Wfur8cZNIJl6sb2YJHtNw3rue3au3zdOJgkNp/Y8voDKXuijeDtCcpDxGXErmR85UbX2zjxJj1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADHbf4W2vNnBtfhBg--.19415S2;
	Mon, 07 Apr 2025 21:58:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] platform/x86: thinkpad-acpi: Add error check for tpacpi_check_quirks()
Date: Mon,  7 Apr 2025 21:58:08 +0800
Message-ID: <20250407135808.2486-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHbf4W2vNnBtfhBg--.19415S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw1kXr1xKryDGrW3ur13CFg_yoW8Jr48pr
	W7CFWIyrW5Ga1qv3WUJw4Y9FW5A3yS93yxGr97Cw1Yv345KryrCry5JayayF4DGrWrGa17
	XF1xt3W5Aw4kZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUejjgDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUFA2fzu7haQQAAsD

In tpacpi_battery_init(), the return value of tpacpi_check_quirks() needs
to be checked. The battery should not be hooked if there is no matched
battery information in quirk table.

Add an error check and return -ENODEV immediately if the device fail
the check.

Fixes: 1a32ebb26ba9 ("platform/x86: thinkpad_acpi: Support battery quirk")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Fix double assignment error.

 drivers/platform/x86/thinkpad_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2cfb2ac3f465..93eaca3bd9d1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9973,7 +9973,9 @@ static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
 
 	tp_features.battery_force_primary = tpacpi_check_quirks(
 					battery_quirk_table,
-					ARRAY_SIZE(battery_quirk_table));
+					ARRAY_SIZE(battery_quirk_table))
+	if (!tp_features.battery_force_primary)
+		return -ENODEV;
 
 	battery_hook_register(&battery_hook);
 	return 0;
-- 
2.42.0.windows.2


