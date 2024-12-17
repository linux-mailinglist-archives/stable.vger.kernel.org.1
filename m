Return-Path: <stable+bounces-104882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F579F5384
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A0116B882
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421D1F892A;
	Tue, 17 Dec 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e6sS7+8V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218201F8924;
	Tue, 17 Dec 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456392; cv=none; b=NFG1IwrJ1ARYh7INKkuUYuKKRGDmcI+8F/UkBE9knE7qvsnkyB25Cz5zbTUib4M5khP5F4ad/X8TffM7IHzn8wWzY94WyqzLbaWBAggYliqWO1cN2ZFGAng6CGkGQ1LWQFE1OA7HfFiyrd35ligyaa3zdbsqOAgHNY1cDZ0aCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456392; c=relaxed/simple;
	bh=HSTm7h2bpWNvoSKaOTbqey3vv22Yv+SR952nmI+wONU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYqC/pNVxz+acLg45HMS17K7c13y7vV7/zU+AKn7u7lGzvtkcZr4kgchOHPJqZFhJYJibvwIh5GURW75QGXYR8cs5iE+sj12/JZAapphDj3V2zTPM5AkWc4TKeMMkRCsrACvNE3Z/RTAuee6XW6QBURyTGomPPi769M3J+f3QSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e6sS7+8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D55AC4CED3;
	Tue, 17 Dec 2024 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456391;
	bh=HSTm7h2bpWNvoSKaOTbqey3vv22Yv+SR952nmI+wONU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6sS7+8VcCzbkGVC+OVgE1eeoneM5M+8I62BRMmhUTn0cDpraYXamvlNfcMpvM5uC
	 pD9D3BYNrMGEAKar5SLqis25R+A72NFJOfpElx62reFJFyvAc+f/U7eeCHxvl1qfAH
	 88iH0k5wuYPFjnHGKnJ/lhul3+umHjtqDJZ68aFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 6.12 043/172] usb: dwc2: Fix HCD port connection race
Date: Tue, 17 Dec 2024 18:06:39 +0100
Message-ID: <20241217170548.054170063@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <wahrenst@gmx.net>

commit 1cf1bd88f129f3bd647fead4dca270a5894274bb upstream.

On Raspberry Pis without onboard USB hub frequent device reconnects
can trigger a interrupt storm after DWC2 entered host clock gating.
This is caused by a race between _dwc2_hcd_suspend() and the port
interrupt, which sets port_connect_status. The issue occurs if
port_connect_status is still 1, but there is no connection anymore:

usb 1-1: USB disconnect, device number 25
dwc2 3f980000.usb: _dwc2_hcd_suspend: port_connect_status: 1
dwc2 3f980000.usb: Entering host clock gating.
Disabling IRQ #66
irq 66: nobody cared (try booting with the "irqpoll" option)
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-gc1bb81b13202-dirty #322
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
 Exception stack(0xc1d01f20 to 0xc1d01f68)
 1f20: 0004ef3c 00000001 00000000 00000000 c1d09780 c1f6bb5c c1d04e54 c1c60ca8
 1f40: c1d04e94 00000000 00000000 c1d092a8 c1f6af20 c1d01f70 c1211b98 c1212f40
 1f60: 60000013 ffffffff
 __irq_svc from default_idle_call+0x1c/0xb0
 default_idle_call from do_idle+0x21c/0x284
 do_idle from cpu_startup_entry+0x28/0x2c
 cpu_startup_entry from kernel_init+0x0/0x12c
handlers:
 [<e3a25c00>] dwc2_handle_common_intr
 [<58bf98a3>] usb_hcd_irq
Disabling IRQ #66

So avoid this by reading the connection status directly.

Fixes: 113f86d0c302 ("usb: dwc2: Update partial power down entering by system suspend")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/r/20241202001631.75473-4-wahrenst@gmx.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4345,7 +4345,7 @@ static int _dwc2_hcd_suspend(struct usb_
 	if (hsotg->bus_suspended)
 		goto skip_power_saving;
 
-	if (hsotg->flags.b.port_connect_status == 0)
+	if (!(dwc2_read_hprt0(hsotg) & HPRT0_CONNSTS))
 		goto skip_power_saving;
 
 	switch (hsotg->params.power_down) {



