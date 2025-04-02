Return-Path: <stable+bounces-127416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1566A7915A
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA8C7A5070
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2B2376F9;
	Wed,  2 Apr 2025 14:38:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365C6F30F;
	Wed,  2 Apr 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743604720; cv=none; b=LbVmDxMCThBjsKmGqpXfflqk4I31rsgrCcMDicUmYkLK7Rk0GNkwX23DhRk1iLEpHeY+rZ63cO3sxr5rVg6JTmVLGj6bcykRG67/RsFDx9hvjmcGKdLYnzphTD3PVhA26xLtfkGtggK8jGmvgIVKaWS68f2rdbMXRtmLN9bV+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743604720; c=relaxed/simple;
	bh=wZa8KqNTcy8L4w+omqE+zg6Tu8PjxZ1YS0EhwHwwt0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S58gq2pdyvRe+VnXyEx5QB9K7+CQ8o1zDLQbspdYH76NzDnvvf4hivlgXDPHQqlUxLCSVkJvOW35I74loE4JdZCkaw1NR+2VdpJMMNGwovrQyLxpAycdi7s+IHd+ow9Y5CBdw9s6Bt8+DIgbOT7OXaEKJI/jgZt2dZS//D6W5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADXfP3fS+1n_YMwBQ--.25061S2;
	Wed, 02 Apr 2025 22:38:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad-acpi: Add error handling for tpacpi_check_quirks
Date: Wed,  2 Apr 2025 22:38:07 +0800
Message-ID: <20250402143807.3650-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXfP3fS+1n_YMwBQ--.25061S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1ftr4DuF4xGr1UCFyfJFb_yoW8Gr17pr
	4I9FWIyry5Ca1DZ3W7Jr4Y9Fy5ArWS93y7Gr97Cw109a4Ykry0kry5XayYyF4DGrWrGa1x
	J3W8t3W5AanYvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsAA2ftA5rqzwAAs4

In tpacpi_battery_init(), the return value of tpacpi_check_quirks() needs
to be checked. The battery should not be hooked if there is no matched
battery information in quirk table.

Add an error check and return -ENODEV immediately if the device fail
the check.

Fixes: 1a32ebb26ba9 ("platform/x86: thinkpad_acpi: Support battery quirk")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/x86/thinkpad_acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2cfb2ac3f465..a3227f60aa43 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9969,11 +9969,15 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 
 static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
 {
+	unsigned long r;
+
 	memset(&battery_info, 0, sizeof(battery_info));
 
-	tp_features.battery_force_primary = tpacpi_check_quirks(
+	r = tp_features.battery_force_primary = tpacpi_check_quirks(
 					battery_quirk_table,
 					ARRAY_SIZE(battery_quirk_table));
+	if (!r)
+		return -ENODEV;
 
 	battery_hook_register(&battery_hook);
 	return 0;
-- 
2.42.0.windows.2


