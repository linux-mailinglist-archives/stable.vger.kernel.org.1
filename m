Return-Path: <stable+bounces-94605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30039D6003
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321B2B231B0
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB677083F;
	Fri, 22 Nov 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkjP7pdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF712E7F
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283510; cv=none; b=P6wLZJ7ggHAZaaRHwVmTaEDlG/AQJpL/IbS3GdSb/NxCpQibLRqsD4/fKzGewWNVqklx0W2V68ZWSVCg+x2SbnZ5GQ7/uXLFVX7WYMTCPQMrFtpbuKoUEuj5Pf35I4M1RSq/5QlHvD/ArbCfNvFVc2LzLR9MvHdChHer2mfiyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283510; c=relaxed/simple;
	bh=d8PE0xuu+0T6zsiyZPvTR42il1pubvKmFVMftRMxP0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1bXxUWSgHQGb/RBauKJ3eBNnn4YQe6BUNTZh4jh0WE0gr/QbWeZL3u1jsnq7vqmLSm5S39VpMeZ/l7uXS8t4RH5ezVjI/LgShk2GQ6TpGQ4ra+jWW/CqfdV/FaTTQl+Z7TTXAouF4JRtYKNf3hiT/ufHXo2hX7CAk46O9pr99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkjP7pdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97AFC4CECE;
	Fri, 22 Nov 2024 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732283510;
	bh=d8PE0xuu+0T6zsiyZPvTR42il1pubvKmFVMftRMxP0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkjP7pdkDxhflpHoe0a5HxKTyHT9Zwi2X0NH77cQA+7z/4Yz8ZZd0vvNCDGUKDMFA
	 qeGZU6KsN00wV9telf18vbzqKP/OkkLj9ARpkaFCGE9JjdTdXmBSUt2GSQUuwpctsZ
	 hehPs8FG0Vro6J+0I6EJcPN7Uudg7B1LfVSM4dVByfYg1K5RWvnGX9KX02+AXUDsxr
	 gWGRXMWwXtRwj+z9efPNU5sYgsk+CJ4/XBM2a6oz+UBjkb7dSz5f36Ae8Tu8R+2uzE
	 cPUKj4O2Rm1pT+PkeJ8frYUfE7NJmQ+cr5pt8k9iI4wSmoxDzFjmjUqqzOoYOKMixs
	 c5q/Dp/jlQc2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] serial: sc16is7xx: fix invalid FIFO access with special register set
Date: Fri, 22 Nov 2024 08:51:51 -0500
Message-ID: <20241122083859-cb96d612097100e8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122071656.3885283-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 7d3b793faaab1305994ce568b59d61927235f57b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Hugo Villeneuve <hvilleneuve@dimonoff.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 08:33:28.655200931 -0500
+++ /tmp/tmp.UrRvkZ4s0A	2024-11-22 08:33:28.646962417 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7d3b793faaab1305994ce568b59d61927235f57b ]
+
 When enabling access to the special register set, Receiver time-out and
 RHR interrupts can happen. In this case, the IRQ handler will try to read
 from the FIFO thru the RHR register at address 0x00, but address 0x00 is
@@ -22,25 +24,28 @@
 Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
 Link: https://lore.kernel.org/r/20240723125302.1305372-3-hugo@hugovil.com
 Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+[ Resolve minor conflicts ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- drivers/tty/serial/sc16is7xx.c | 4 ++++
- 1 file changed, 4 insertions(+)
+ drivers/tty/serial/sc16is7xx.c | 5 +++++
+ 1 file changed, 5 insertions(+)
 
 diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
-index 58696e05492ca..b4c1798a1df2a 100644
+index a723df9b37dd..c07baf5d5a9c 100644
 --- a/drivers/tty/serial/sc16is7xx.c
 +++ b/drivers/tty/serial/sc16is7xx.c
-@@ -592,6 +592,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
+@@ -545,6 +545,9 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
  			      SC16IS7XX_MCR_CLKSEL_BIT,
  			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
  
++
 +	mutex_lock(&one->efr_lock);
 +
- 	/* Backup LCR and access special register set (DLL/DLH) */
- 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
+ 	/* Open the LCR divisors for configuration */
  	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-@@ -606,6 +608,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
- 	/* Restore LCR and access to general register set */
+ 			     SC16IS7XX_LCR_CONF_MODE_A);
+@@ -558,6 +561,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
+ 	/* Put LCR back to the normal mode */
  	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
  
 +	mutex_unlock(&one->efr_lock);
@@ -48,3 +53,6 @@
  	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
  }
  
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

