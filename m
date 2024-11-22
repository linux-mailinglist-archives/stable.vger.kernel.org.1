Return-Path: <stable+bounces-94603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C138A9D6002
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEA3B231A0
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8070812;
	Fri, 22 Nov 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0RzUZxp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39112E7F
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283506; cv=none; b=JjQyp8uHmzBjH3Jwr9A2lYGFw/VdV1/4uma0FjjC4Sk3oPyxUMvtnANWrMEBa1N0PmbNvpWnTtEIhGofrWg+YgJB301CJQYGVP3DbEcdfwVb4Uay4I9Uj6qT6u6O1GbYKw7opsigsz9qzjhLCD/6QRJxwwTILl0uNGoTmlJbEis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283506; c=relaxed/simple;
	bh=cD0gRDRyE5nD6QEfN6xPaK3+6aaCkBh3c35aBFDy/cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5G6k1Y7yq/1Q3DDXNgDT489jFU8+yxwRSy+U3Tonlgw+Qh6LpFayykZWKR4dHyaF1Ov0UZ6IUZGS7M/y4NqHLVczSFNISnaDrOiZiqO8dKWv1yrg5XdCCK8OzBSkSNVbuJ6RpsVEGZXrEQHJtag9l7I2E8Nyq+Ldzw/WPDI6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0RzUZxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C09C4CED0;
	Fri, 22 Nov 2024 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732283506;
	bh=cD0gRDRyE5nD6QEfN6xPaK3+6aaCkBh3c35aBFDy/cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0RzUZxpfSY3c/gCG+dhjEbnmsXV5yW1HAv0o6SzcshkjKYMuIHfzJ29jRRyaB7i4
	 NvmRHA54mDDC1ETPXypD0AqJk/1o6BnBlWOQgj2KSkBH1EYyZyuc5jOwbHVCSrxGBV
	 73ydkTIJUXfMp0fZtsUxXqRFAUnWzm9o6KgOMt/UgMgfQ86GYmfjY43faR0qXllrkX
	 Vx/10saooa6SDHrHg3FgnKOxJq9sqvNQqtwIu09SEuAaBmp23gNTQuT9l0NE7quY14
	 5cOMCI2gZDHiQfwzbgytSK9f/10sMRSBXuBAt81WxujcYRkgnQwTcE5rTmkEvbmkjk
	 407jvSD/6IevQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] serial: sc16is7xx: fix invalid FIFO access with special register set
Date: Fri, 22 Nov 2024 08:51:47 -0500
Message-ID: <20241122083228-3df619e519e722b2@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122064331.3863447-1-bin.lan.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 08:26:44.256901766 -0500
+++ /tmp/tmp.CWNfMe5MUW	2024-11-22 08:26:44.252793305 -0500
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
+index 7a9924d9b294..f290fbe21d63 100644
 --- a/drivers/tty/serial/sc16is7xx.c
 +++ b/drivers/tty/serial/sc16is7xx.c
-@@ -592,6 +592,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
+@@ -545,6 +545,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
  			      SC16IS7XX_MCR_CLKSEL_BIT,
  			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
  
 +	mutex_lock(&one->efr_lock);
 +
- 	/* Backup LCR and access special register set (DLL/DLH) */
- 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
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
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

