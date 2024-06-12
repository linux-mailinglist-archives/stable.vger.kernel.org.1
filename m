Return-Path: <stable+bounces-50250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1643A9052E5
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32C71F2114D
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EFE172BC1;
	Wed, 12 Jun 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eqe/9oJg"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88AD153509;
	Wed, 12 Jun 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196567; cv=none; b=r47dWW4ISSi6VBPvG58HbxQeAwD1Jy3PTiohin/JdZgGgnzgwiwiHiPdHx3BnI2ugHlVm0pebLIp+fOpFMuSqJYDmoHEtvrwJ8XNPALLIsSAAgYYFoUxOnR5zILHkv/js32WB95gpvSyDEKa12nGfb8EarL2fy4Qvm5lApoc0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196567; c=relaxed/simple;
	bh=jml4Li8jRIuKDzQQJHvxjVmuIVdQD/S+n68zDOjWbwc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZcwp1xPunRevyi3aRiIgUNkNyRwEaItNvIN7KOfgixSQaeucBr1z12hYeuC1bGCkGxmTxGIrWXdrh29Eib4LCz3rHBRd57AfTTjr3RLPgt0hT4a4nBuJQ9q+ES2QnFJt2ThFTXkfJqLxFC/x72gt2HhWyJX8sJfvofwllXiFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eqe/9oJg; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CBgWMZ016579;
	Wed, 12 Jun 2024 14:48:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=+7VI0+0yWgu+99TXdk1RwS
	Mz8s0/dUbNSHBFUKF/9IQ=; b=eqe/9oJgCQbH8XTb1sRoXJPTLEmFq1Cdx9qS0r
	17cNTGfJ8lQPrJdDqhqyRygeS/rwKu7wVsQu/4gR1enXPHSPrultScJQqY7C5ey2
	sXMReUiV2OLWRT/N94aXRuTqfkygzn6fCsldRiwP7aMsN2W7lCUutBDRr45TNDrT
	PJuIvIt5ERp9wPGiHMbItVk0IlMaLF3oww0rqjOdw+ID43XE+M7Ozjc5yQhA6IT9
	w1ipyp4b98oRzeRunV/WCbLay58Sv+B+db13K/sUT0HguiOrN/p+pJPqsKYeNPzq
	zjkha5vpisayMQE4LrCQoC5Vir75WNtdHiZiTp8JlQcHfNtg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp4qrn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 14:48:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5DD0C40047;
	Wed, 12 Jun 2024 14:47:50 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 73DB7215BF7;
	Wed, 12 Jun 2024 14:47:16 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 12 Jun
 2024 14:47:16 +0200
Received: from localhost (10.252.17.208) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 12 Jun
 2024 14:47:15 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2] usb: ucsi: stm32: fix command completion handling
Date: Wed, 12 Jun 2024 14:46:56 +0200
Message-ID: <20240612124656.2305603-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_02,2024-05-17_01

Sometimes errors are seen, when doing DR swap, like:
[   24.672481] ucsi-stm32g0-i2c 0-0035: UCSI_GET_PDOS failed (-5)
[   24.720188] ucsi-stm32g0-i2c 0-0035: ucsi_handle_connector_change:
 GET_CONNECTOR_STATUS failed (-5)

There may be some race, which lead to read CCI, before the command complete
flag is set, hence returning -EIO. Similar fix has been done also in
ucsi_acpi [1].

In case of a spurious or otherwise delayed notification it is
possible that CCI still reports the previous completion. The
UCSI spec is aware of this and provides two completion bits in
CCI, one for normal commands and one for acks. As acks and commands
alternate the notification handler can determine if the completion
bit is from the current command.

To fix this add the ACK_PENDING bit for ucsi_stm32g0 and only complete
commands if the completion bit matches.

[1] https://lore.kernel.org/lkml/20240121204123.275441-3-lk@c--e.de/

Fixes: 72849d4fcee7 ("usb: typec: ucsi: stm32g0: add support for stm32g0 controller")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2: rebase and define ACK_PENDING as commented by Dmitry.
---
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index ac48b7763114..ac69288e8bb0 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -65,6 +65,7 @@ struct ucsi_stm32g0 {
 	struct device *dev;
 	unsigned long flags;
 #define COMMAND_PENDING	1
+#define ACK_PENDING	2
 	const char *fw_name;
 	struct ucsi *ucsi;
 	bool suspended;
@@ -396,9 +397,13 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
 				   size_t len)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
 	int ret;
 
-	set_bit(COMMAND_PENDING, &g0->flags);
+	if (ack)
+		set_bit(ACK_PENDING, &g0->flags);
+	else
+		set_bit(COMMAND_PENDING, &g0->flags);
 
 	ret = ucsi_stm32g0_async_write(ucsi, offset, val, len);
 	if (ret)
@@ -406,9 +411,14 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
 
 	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
 		ret = -ETIMEDOUT;
+	else
+		return 0;
 
 out_clear_bit:
-	clear_bit(COMMAND_PENDING, &g0->flags);
+	if (ack)
+		clear_bit(ACK_PENDING, &g0->flags);
+	else
+		clear_bit(COMMAND_PENDING, &g0->flags);
 
 	return ret;
 }
@@ -429,8 +439,9 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(COMMAND_PENDING, &g0->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+	if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
+		complete(&g0->complete);
+	if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
 		complete(&g0->complete);
 
 	return IRQ_HANDLED;
-- 
2.25.1


