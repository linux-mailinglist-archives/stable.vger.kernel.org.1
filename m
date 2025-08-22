Return-Path: <stable+bounces-172429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B747EB31C1F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB12606F82
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45778337685;
	Fri, 22 Aug 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eTjjxCbk"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B527AC43;
	Fri, 22 Aug 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872723; cv=none; b=MBPEYQy6/kkue5E+Vpu7rIoMdbkVUFfr54X1tC0NS42dYokefD7KeHS5ZWof4RTp3MCtImffEjm5/dCWHnJonlg8epk3lRebrWu6fxBUucpm/XaZ4cZGXiQOW9rqddMQerSRMGVwdf9q4cN9kzQEO+xS0ua6+S6e6RP5acOP1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872723; c=relaxed/simple;
	bh=xb5TOEehY2vIAhaP312qMAw6NVGL99DD0VXXKP45u2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kGB7pXoLYgxAC1QjQQPTa69nlm65JMHlZArXYg3FxwrGDoF2OEPb3GYR2FQ7Ae142VJ1NICD7wbA/SJVkhA2ryimLcl8VGioHJXacJv7KBpjl2MfGl9YyjKtanZS9vSftSOK7IgywHkdw/zQZh79IudEHD6Lkf5epaDhlF4m/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eTjjxCbk; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MBtbtR002505;
	Fri, 22 Aug 2025 16:24:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=3LeisAj1Cwd8ZHYc3VbqAj
	scWGD/Uc/4Za/fl9paTp0=; b=eTjjxCbkO343Al1uCRDS42GMaZzbXxH2BYhSFg
	lIvoh3f8adhmPYHz20R+FKBkXFX99TD9rq5gK2RIxN6GAc8qIOXQMbhztYRoDsMA
	WQHaZf9h0XSMHtia7O+jaf5iP8qrB2epg6pAVGzqij8O0Ll7xrWD3xxgjLOGeVD/
	JT2V4UvMM0dwjl0urBcdgBI9tPn005dAazZYVMPXfO5CyJdM4Tl01SgxGXSsXghF
	QWV/hGXITO0vcXs4arRV94305menIabMEj77MVv20zc9Z61t/BEvZrpoStkyqOxJ
	EdLHKbjAlASzKhKIqNRUbGw/DwzY1hwJEBgG5UJmxzUZU/fw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n754kemw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 16:24:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 23BDB40045;
	Fri, 22 Aug 2025 16:23:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 572F26C9834;
	Fri, 22 Aug 2025 16:22:19 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 16:22:19 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Douglas Anderson <dianders@chromium.org>,
        Zong Jiang
	<quic_zongjian@quicinc.com>,
        Robert Marko <robert.marko@sartura.hr>,
        "Thierry
 Bultel" <thierry.bultel.yh@bp.renesas.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Kartik Rajput <kkartik@nvidia.com>,
        "Peter
 Hurley" <peter@hurleysoftware.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Vladimir Zapolskiy
	<vladimir_zapolskiy@mentor.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] serial: stm32: allow selecting console when the driver is module
Date: Fri, 22 Aug 2025 16:19:23 +0200
Message-ID: <20250822141923.61133-1-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

Console can be enabled on the UART compile as module.
Change dependency to allow console mode when the driver is built as module.

Fixes: 48a6092fb41fa ("serial: stm32-usart: Add STM32 USART Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
Changes in v2:
- Cced stable tree
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e661f5951f558..1e27a822c1cba 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1420,7 +1420,7 @@ config SERIAL_STM32
 
 config SERIAL_STM32_CONSOLE
 	bool "Support for console on STM32"
-	depends on SERIAL_STM32=y
+	depends on SERIAL_STM32
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 
-- 
2.25.1


