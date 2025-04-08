Return-Path: <stable+bounces-128805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CD0A7F255
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 03:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FAD16F9C3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148B12517B3;
	Tue,  8 Apr 2025 01:40:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BB111A8;
	Tue,  8 Apr 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744076430; cv=none; b=inVxLvLgWfBHLWzFvUHO88jP/rwVXCF2SsI2W8fHf8VP6N3dMTXil38UUd2GkO6MOn75ZNn3zNadg5fWEjrCbMzBmk/B0qyImpVZQub11F0IVHo3KhK1NlLcxJcMnCS5F949H/A3jYIvCSiR8CKSZXHrS2mUnLybB9s9PbKI9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744076430; c=relaxed/simple;
	bh=t2vUgc0ZPQzWVJuqxXQVUykXnXAnaCjBlTo5/l65u/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7GawTcaQBXAY7o3gGV5xanUnpKzg5rgnKmmAi7EX5+DS5DYNj+ZzBsQTJEz9rBxF48WBfjKZQUhxX5jtOKwLtkOMPw73JBZIyTwz9MeYUUZofaWLff+cSh5vIh1W+5Q6X02cIRxJFzzpUh/HHOgvn13CfcaH/jLvpDmqNiaLYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAB3Gvt5fvRnhHkKBw--.2111S2;
	Tue, 08 Apr 2025 09:40:15 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] platform/x86: thinkpad-acpi: Add error check for tpacpi_check_quirks
Date: Tue,  8 Apr 2025 09:39:50 +0800
Message-ID: <20250408013950.2634-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3Gvt5fvRnhHkKBw--.2111S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1kXr1xKryDGrW3ur13CFg_yoWkuFg_KF
	1fuFnrXryIkw1ayF1UKr93ury7WFZagF48Xa17tr9Iqr95XrZrXryY9rykCw48WrW0kFyD
	Cw4qy347KryakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbkR67UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0GA2f0dv0jBwAAsy

In tpacpi_battery_init(), the return value of tpacpi_check_quirks() needs
to be checked. The battery should not be hooked if there is no matched
battery information in quirk table.

Add an error check and return -ENODEV immediately if the device fail
the check.

Fixes: 1a32ebb26ba9 ("platform/x86: thinkpad_acpi: Support battery quirk")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v3: Fix error code
v2: Fix double assignment error

 drivers/platform/x86/thinkpad_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2cfb2ac3f465..ab538bf53716 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9974,6 +9974,8 @@ static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
 	tp_features.battery_force_primary = tpacpi_check_quirks(
 					battery_quirk_table,
 					ARRAY_SIZE(battery_quirk_table));
+	if (!tp_features.battery_force_primary)
+		return -ENODEV;
 
 	battery_hook_register(&battery_hook);
 	return 0;
-- 
2.42.0.windows.2


