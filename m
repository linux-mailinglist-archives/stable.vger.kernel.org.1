Return-Path: <stable+bounces-94572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6D9D597A
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 07:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0FC282787
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214571632DC;
	Fri, 22 Nov 2024 06:43:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062316087B
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257799; cv=none; b=CNmxWB3rtqjejllw6uuj46/Osi9EGJmueHAcG92/1YJA0J/0AeO4SNtTb8xLXxDTUN/USQiNE6VRpUCNKU+Sn2kPxWR7dC6RG2S/18Yg51/8qdOYfcDSObhkpXOKhtGxTbHnIFK0Mxl9909qaPycFl1J3mzgRSDyYxTExRFUNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257799; c=relaxed/simple;
	bh=SZZt/ADXASc/AzjZvSxdlgrYmLuzcBINcy1a8q+TA0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tR2qrttFPrDWxK6oDFgUYCagWLBbBRBLC6lfq9R8b8i2FSiLmy9GzantYTz4nmdcHRr/uf2aMUBADai6eXIDmekPa7dyVx0nRwLNb1WM9nQNMKjPVdwSRJ+HTz5nDKZ6rC1xhZikp3HcdHW2NN0Tl6REQa5H1d77yMLz7p1e+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM6gOQk004731;
	Thu, 21 Nov 2024 22:43:13 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xusq6av6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Nov 2024 22:43:13 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 21 Nov 2024 22:43:12 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 21 Nov 2024 22:43:12 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>, <hvilleneuve@dimonoff.com>
Subject: [PATCH 6.6] serial: sc16is7xx: fix invalid FIFO access with special register set
Date: Fri, 22 Nov 2024 14:43:31 +0800
Message-ID: <20241122064331.3863447-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mp6SkrMADBZCczrsjbxvT3IQDYMivEJi
X-Proofpoint-ORIG-GUID: mp6SkrMADBZCczrsjbxvT3IQDYMivEJi
X-Authority-Analysis: v=2.4 cv=d9mnygjE c=1 sm=1 tr=0 ts=67402801 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=ANv9NCA0AAAA:8 a=PjLayv2rAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8
 a=jPX3o1wNCZPjv_iFlU4A:9 a=Hn0ac7NHSattSG0oRJar:22 a=qJi-GwaokQ_QderyKa0y:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_01,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411220054

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 7d3b793faaab1305994ce568b59d61927235f57b ]

When enabling access to the special register set, Receiver time-out and
RHR interrupts can happen. In this case, the IRQ handler will try to read
from the FIFO thru the RHR register at address 0x00, but address 0x00 is
mapped to DLL register, resulting in erroneous FIFO reading.

Call graph example:
    sc16is7xx_startup(): entry
    sc16is7xx_ms_proc(): entry
    sc16is7xx_set_termios(): entry
    sc16is7xx_set_baud(): DLH/DLL = $009C --> access special register set
    sc16is7xx_port_irq() entry            --> IIR is 0x0C
    sc16is7xx_handle_rx() entry
    sc16is7xx_fifo_read(): --> unable to access FIFO (RHR) because it is
                               mapped to DLL (LCR=LCR_CONF_MODE_A)
    sc16is7xx_set_baud(): exit --> Restore access to general register set

Fix the problem by claiming the efr_lock mutex when accessing the Special
register set.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240723125302.1305372-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Resolve minor conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/tty/serial/sc16is7xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7a9924d9b294..f290fbe21d63 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -545,6 +545,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      SC16IS7XX_MCR_CLKSEL_BIT,
 			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
+	mutex_lock(&one->efr_lock);
+
 	/* Open the LCR divisors for configuration */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
 			     SC16IS7XX_LCR_CONF_MODE_A);
@@ -558,6 +560,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
+	mutex_unlock(&one->efr_lock);
+
 	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 
-- 
2.43.0


