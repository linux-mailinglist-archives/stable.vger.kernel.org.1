Return-Path: <stable+bounces-104614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC3D9F521F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B611885770
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B561F76A1;
	Tue, 17 Dec 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FG8BAxQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA621F7562;
	Tue, 17 Dec 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455584; cv=none; b=L7Q4+wA0P6Z01iTv/BSJN9+94CaNSrsO/xNg59fHIOy4vkUA6KHKHD6uAA/6rJ0wZH+HCK9pWsiTqUDyJAcZP3F7++lD2CxScNbLuSuwx9tZaltyDWOD7cmSca2v8UyKz8AzUMWvKUvZq5EwLs+Xl+32CJ/IbtbPC5oJRcRafYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455584; c=relaxed/simple;
	bh=ppC7ZetOXmp4dL7H52DgpTxV4nlgVfJNS4QjKgO2QMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X99Q2EeHJ4cHo2qE5DMJfE6WBdOp6U38J/nyLzLbOE8jeojpQVHQK/cwWWT0C2XkhVtiNgL14GqkkZW+KILglhc4oyIrNd1peynV8qqlfWZF0FcZqLbH8ejt2zY/gAO4cwyfUSM6tOgpfmeOHIOmQLd+NfOyo0zdu9KtWA4pnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FG8BAxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F1EC4CED3;
	Tue, 17 Dec 2024 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455584;
	bh=ppC7ZetOXmp4dL7H52DgpTxV4nlgVfJNS4QjKgO2QMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0FG8BAxQggOpIy4AKmUZisUm0TcAkWdYe/p5pNmK8fXFWxhdIYeYZ5sWiRDfZqOlz
	 sVpenuUcTDS72HC65LB7umgcmSEFnSaeh3wgIKBg8yqR+qDUYx9EiQu7/XuyaVzgbG
	 jurNXorE/i0a0QPJ7exUJvykJSfkwWDrKDLL0Qus=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 5.15 05/51] usb: dwc2: Fix HCD resume
Date: Tue, 17 Dec 2024 18:06:58 +0100
Message-ID: <20241217170520.527931860@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170520.301972474@linuxfoundation.org>
References: <20241217170520.301972474@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <wahrenst@gmx.net>

commit 336f72d3cbf5cc17df2947bbbd2ba6e2509f17e8 upstream.

The Raspberry Pi can suffer on interrupt storms on HCD resume. The dwc2
driver sometimes misses to enable HCD_FLAG_HW_ACCESSIBLE before re-enabling
the interrupts. This causes a situation where both handler ignore a incoming
port interrupt and force the upper layers to disable the dwc2 interrupt
line. This leaves the USB interface in a unusable state:

irq 66: nobody cared (try booting with the "irqpoll" option)
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G W          6.10.0-rc3
Hardware name: BCM2835
Call trace:
unwind_backtrace from show_stack+0x10/0x14
show_stack from dump_stack_lvl+0x50/0x64
dump_stack_lvl from __report_bad_irq+0x38/0xc0
__report_bad_irq from note_interrupt+0x2ac/0x2f4
note_interrupt from handle_irq_event+0x88/0x8c
handle_irq_event from handle_level_irq+0xb4/0x1ac
handle_level_irq from generic_handle_domain_irq+0x24/0x34
generic_handle_domain_irq from bcm2836_chained_handle_irq+0x24/0x28
bcm2836_chained_handle_irq from generic_handle_domain_irq+0x24/0x34
generic_handle_domain_irq from generic_handle_arch_irq+0x34/0x44
generic_handle_arch_irq from __irq_svc+0x88/0xb0
Exception stack(0xc1b01f20 to 0xc1b01f68)
1f20: 0005c0d4 00000001 00000000 00000000 c1b09780 c1d6b32c c1b04e54 c1a5eae8
1f40: c1b04e90 00000000 00000000 00000000 c1d6a8a0 c1b01f70 c11d2da8 c11d4160
1f60: 60000013 ffffffff
__irq_svc from default_idle_call+0x1c/0xb0
default_idle_call from do_idle+0x21c/0x284
do_idle from cpu_startup_entry+0x28/0x2c
cpu_startup_entry from kernel_init+0x0/0x12c
handlers:
[<f539e0f4>] dwc2_handle_common_intr
[<75cd278b>] usb_hcd_irq
Disabling IRQ #66

So enable the HCD_FLAG_HW_ACCESSIBLE flag in case there is a port
connection.

Fixes: c74c26f6e398 ("usb: dwc2: Fix partial power down exiting by system resume")
Closes: https://lore.kernel.org/linux-usb/3fd0c2fb-4752-45b3-94eb-42352703e1fd@gmx.net/T/
Link: https://lore.kernel.org/all/5e8cbce0-3260-2971-484f-fc73a3b2bd28@synopsys.com/
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/r/20241202001631.75473-2-wahrenst@gmx.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4464,6 +4464,7 @@ static int _dwc2_hcd_resume(struct usb_h
 	 * Power Down mode.
 	 */
 	if (hprt0 & HPRT0_CONNSTS) {
+		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 		hsotg->lx_state = DWC2_L0;
 		goto unlock;
 	}



