Return-Path: <stable+bounces-95475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB69D90A9
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 04:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCD5287FD8
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 03:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D504142AA2;
	Tue, 26 Nov 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoUp2Mtf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED128E3F
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590825; cv=none; b=tAcVjN3vvlRa1jmldPTYM7mcweRvYSu7IJedsB2akV8/+fATAuRSrqMc+mwEbV4pIEYIxxlev4oJaEPIEgnynSymRjo1XvD/kBFGYTLLzsw6JZC+a/CQtKRVsZUZUpmitx+r7yCEhz2SlehCF1FAOVW3YayQLdEx8csECiV6MTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590825; c=relaxed/simple;
	bh=gc74abTM4y6bFw9TPu+9B4gir9UHkc9VJ5g960IMh+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+ualrMMjn4KciPHanWZDTjBocLAvoMy2nguqc9q2x1HVrfQUDD1dqqAZUeW/fra9KILujz0qd45Z7Dx+4iyS/t2xb8Ro0TI414LxNIQz0yLd3SqC2L76oIdn1DTpwxYEDh3ka9uqlBtORhIMK8De5uYpsK8/9YRMJ8z8Qs1QYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoUp2Mtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C05C4CECE;
	Tue, 26 Nov 2024 03:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732590825;
	bh=gc74abTM4y6bFw9TPu+9B4gir9UHkc9VJ5g960IMh+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XoUp2MtfVTYmATYMEZ6gRBWeayiBDP9fzwie/1cAuzHxnRhgVl12aAy/hCT4tWa3N
	 pBqpL8lKRE15mKz0MlTyY9feZnz0eh80I2vwFNNABMSPbD2xxSUQWp4yhVV0yXc0Rs
	 KfeRGTne252WqLrZkZEvfTuRYmAI0L2jGhFT+wsIL0PrfyBC3htaRexs/vDMSKB4ug
	 EkXW/abQOWxuuED16d68+QQONdcpoo+NFhoYII+G3y0Zs7a8YdDceY+7LgQfiR3WdG
	 HZCFk1/3HeYsuYG/gr+GWu9V1xbr6iIzLqph+U8oUIfYN6Y37hitjc80nxfr1DTRYs
	 LRDur+tjMEjJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] serial: sc16is7xx: fix invalid FIFO access with special register set
Date: Mon, 25 Nov 2024 22:13:43 -0500
Message-ID: <20241125213652-485aa8aaa283363e@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126021831.399947-1-bin.lan.cn@windriver.com>
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
6.6.y | Present (different SHA1: 19c41869465c)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 21:31:42.179789487 -0500
+++ /tmp/tmp.38G55Mxp3K	2024-11-25 21:31:42.172164427 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7d3b793faaab1305994ce568b59d61927235f57b ]
+
 When enabling access to the special register set, Receiver time-out and
 RHR interrupts can happen. In this case, the IRQ handler will try to read
 from the FIFO thru the RHR register at address 0x00, but address 0x00 is
@@ -22,25 +24,27 @@
 Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
 Link: https://lore.kernel.org/r/20240723125302.1305372-3-hugo@hugovil.com
 Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+[ Resolve minor conflicts ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  drivers/tty/serial/sc16is7xx.c | 4 ++++
  1 file changed, 4 insertions(+)
 
 diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
-index 58696e05492ca..b4c1798a1df2a 100644
+index 7a9924d9b294..d7728920853e 100644
 --- a/drivers/tty/serial/sc16is7xx.c
 +++ b/drivers/tty/serial/sc16is7xx.c
-@@ -592,6 +592,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
+@@ -545,6 +545,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
  			      SC16IS7XX_MCR_CLKSEL_BIT,
  			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
  
 +	mutex_lock(&one->efr_lock);
-+
- 	/* Backup LCR and access special register set (DLL/DLH) */
- 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
++	
+ 	/* Open the LCR divisors for configuration */
  	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-@@ -606,6 +608,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
- 	/* Restore LCR and access to general register set */
+ 			     SC16IS7XX_LCR_CONF_MODE_A);
+@@ -558,6 +560,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
+ 	/* Put LCR back to the normal mode */
  	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
  
 +	mutex_unlock(&one->efr_lock);
@@ -48,3 +52,6 @@
  	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
  }
  
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

