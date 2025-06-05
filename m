Return-Path: <stable+bounces-151489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E65ACE983
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98867A447B
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 05:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F15819CC11;
	Thu,  5 Jun 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UQY28apT"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116B1DB34B;
	Thu,  5 Jun 2025 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102965; cv=none; b=RyFw/4VkTFdX4gUA3SGT5AHfC9uvOdukMsbcJwqSlmL2ofKshD87sdF5qKjXCIz4GvRe9p2Jkwix/kpi0xf8ij8mmpw2qpdZnlUetfU/ZxITfkkUD5e4b5kfMfS7/4ogltjZ2Rb6ODPhpCsxZfjhuayXmmCo9CTRbf95VvQFg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102965; c=relaxed/simple;
	bh=TiFQYvsKtNb3eu7X/TfGW0Zpc0IrlwKjViFKEuHchrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0b641MkkTDgsxlZM3GP085ZPjp0QTXLc4zj7UXryuplPEqzDdbCbQrju8qbmMPmu3XTyst6IcLxLmeqf9HxF9dKPhGsVnK6/nfZaw0/DDnGxw2zHoflN6P3KVKIiLayZ8pqI5TXjAqiI65L0aW/56AK4k37IoOtkGz/3GeuIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UQY28apT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 821B6260BB;
	Thu,  5 Jun 2025 07:56:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X7APAh8gTR1d; Thu,  5 Jun 2025 07:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1749102961; bh=TiFQYvsKtNb3eu7X/TfGW0Zpc0IrlwKjViFKEuHchrg=;
	h=From:To:Cc:Subject:Date;
	b=UQY28apTlO7/DGuRKxZZyDp7Tdr46hqi3MsMLre1YSLCS2ijeXvmOyB4uVQCwFVLa
	 UzLBISG3a6vuhZJzyFD0jbUr0g+CKv8pLgWIw3wyPOloU+gufv/TorFZCgaDaxeGKn
	 SVXjH9FHCDIzNIS9FFNtJSBj5iCxQdHVdoqsr1l/711WttyCAZhLE2fFH27qL7o35z
	 sZNUCIuoBey/TlFV4Pwsv7LZgYFA9DV/bouR0jTK9MfzxU8dH6S/e7qEmP1/0Le23E
	 qNALJzoGv4gXGMpaeFKbeCmg1WSONCGmYQkTvM/NcIpPFR9Bazal/i96XTrcsOeQEC
	 v91JREsnE+FAA==
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>,
	stable@vger.kernel.org
Subject: [PATCH] platform/loongarch: laptop: Unregister generic_sub_drivers on exit
Date: Thu,  5 Jun 2025 05:55:46 +0000
Message-ID: <20250605055546.15264-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without correct unregisteration, ACPI notify handlers and the platform
driver installed by generic_subdriver_init will become dangling
references after removing loongson_laptop module, triggering various
kernel faults when a hotkey is sent or at kernel shutdown.

Cc: stable@vger.kernel.org
Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/platform/loongarch/loongson-laptop.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index 99203584949d..cfe2cf79dbbe 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -611,11 +611,17 @@ static int __init generic_acpi_laptop_init(void)
 
 static void __exit generic_acpi_laptop_exit(void)
 {
+	int i;
+
 	if (generic_inputdev) {
-		if (input_device_registered)
+		if (input_device_registered) {
 			input_unregister_device(generic_inputdev);
-		else
+
+			for (i = 0; i < ARRAY_SIZE(generic_sub_drivers); i++)
+				generic_subdriver_exit(&generic_sub_drivers[i]);
+		} else {
 			input_free_device(generic_inputdev);
+		}
 	}
 }
 
-- 
2.49.0


