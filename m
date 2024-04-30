Return-Path: <stable+bounces-42647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B57A48B73F9
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2DFB20E39
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929B812D20F;
	Tue, 30 Apr 2024 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OkgJwAad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC2617592;
	Tue, 30 Apr 2024 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476333; cv=none; b=WeLjDoNh4A0hDrDkuShlVH60K1KkWQQytFWagacS0uoimiwPxVjcb1MnrrjQ/v6WlMPq5nppbkH3HGSMTD39yhvUHWShc3UNGyB4Xk5q1QJVM02BsHwFHKQv78jINwKtN2pBaKwGf+LgyWeo0xaKik1c9Y7ttqKZAgXH2Cx3wAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476333; c=relaxed/simple;
	bh=VON4CrnhYTlklndZ8oyv/DxL8x4t7Rths0DuIin/EAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvIPqFwnt2n2tWKP6tAcICsNcRVKcNVUSNjI0LhI/4wxGNNp9eTwYHZuLBFgNbp1AsUAtZa2OJ3VBWJRyNANWeOSvVQmeIp5eXlsyMhqr4MUJN7CIabWIZhPMtW75rjriEdUpuVa9akv4jlm2W6/nqSvllbI14wSZB1q4HbfDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OkgJwAad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8766C2BBFC;
	Tue, 30 Apr 2024 11:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476333;
	bh=VON4CrnhYTlklndZ8oyv/DxL8x4t7Rths0DuIin/EAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkgJwAaduXT09OfCRHvPWKaz4p4k8+Csi1lfnXAKGiScmO+r42DTp9mXlPwrcy0J5
	 eYa+2lVHPTk2flMh4K6kfXpeX1RP6y5DN5knGKbFM9FvuGepasRfC7D9KLPOadpzBn
	 ohvv6APwqOy7meNv8hDzC6+Sx0ollsQNUygcD4Hs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 5.4 107/107] serial: core: fix kernel-doc for uart_port_unlock_irqrestore()
Date: Tue, 30 Apr 2024 12:41:07 +0200
Message-ID: <20240430103047.815794098@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
References: <20240430103044.655968143@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 29bff582b74ed0bdb7e6986482ad9e6799ea4d2f upstream.

Fix the function name to avoid a kernel-doc warning:

include/linux/serial_core.h:666: warning: expecting prototype for uart_port_lock_irqrestore(). Prototype was for uart_port_unlock_irqrestore() instead

Fixes: b0af4bcb4946 ("serial: core: Provide port lock wrappers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20230927044128.4748-1-rdunlap@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -325,7 +325,7 @@ static inline void uart_port_unlock_irq(
 }
 
 /**
- * uart_port_lock_irqrestore - Unlock the UART port, restore interrupts
+ * uart_port_unlock_irqrestore - Unlock the UART port, restore interrupts
  * @up:		Pointer to UART port structure
  * @flags:	The saved interrupt flags for restore
  */



