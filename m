Return-Path: <stable+bounces-42269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A868B722C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BA71C2280E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773CB12C819;
	Tue, 30 Apr 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mhxmgSKH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235712C462;
	Tue, 30 Apr 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475114; cv=none; b=X2es57sdx37oVIEy7uUwjM5dax6fpopGskHa67A9ipXle0zxUym8Btk89nbVtvvUhG2d9/giwHb7HItwcARZK3XKpOiQ6gb4ySK4kiqgDHOTjyCgqY45yjqZxyqS/LWYhwW5bXOvOX57DzW2a5FBapcgfnRf8WlBMnydACrPb+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475114; c=relaxed/simple;
	bh=h0wxBOyPxdvS5W5LukIkjtepB+t//sE3jvW5jlUl7BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUqCRY6rewn6SQ60dPIzxIaRIzv1vo7ZBqxH42ywTOu3ZmHqfyeWN4kgjSap6CV6CK2dyIYDnQdpHo2WRInEWTV4X4yHHNxCb49cvgRaD9owEBRIAYkeUAOaoT0SLrVVETVoJimDWCraAUpgXPNzDW1Yrq1qq+jT6Vdi8/ay9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mhxmgSKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA50C2BBFC;
	Tue, 30 Apr 2024 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475114;
	bh=h0wxBOyPxdvS5W5LukIkjtepB+t//sE3jvW5jlUl7BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhxmgSKHfMIlZZBVeJOxJ1W8+2egGS3h4jBpafor5G29upIRjJAHaxLGWdLrRFMSX
	 8POjBoM9VacoFGwFv9yBgFqtQEsgHOzRh5TDe7HZEKB41DUC3nG7Vh4lj4elMOabw9
	 0+bqfQNEhSlkFoap7UmzPkhrPdYaEZ+6u5GTFxcM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 5.10 137/138] serial: core: fix kernel-doc for uart_port_unlock_irqrestore()
Date: Tue, 30 Apr 2024 12:40:22 +0200
Message-ID: <20240430103053.436966559@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -330,7 +330,7 @@ static inline void uart_port_unlock_irq(
 }
 
 /**
- * uart_port_lock_irqrestore - Unlock the UART port, restore interrupts
+ * uart_port_unlock_irqrestore - Unlock the UART port, restore interrupts
  * @up:		Pointer to UART port structure
  * @flags:	The saved interrupt flags for restore
  */



