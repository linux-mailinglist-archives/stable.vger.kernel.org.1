Return-Path: <stable+bounces-142333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01881AAEA2D
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11AD3B2AC3
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B652116E9;
	Wed,  7 May 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Dsdf1Db"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3461FF5EC;
	Wed,  7 May 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643928; cv=none; b=nPWjgKrG5cFNUFt/6xrhVwsswgTc8NOVp7r0I3ePhoqAGkroOAL8RHlwIxK1dODwKKx7YNQOkOnZTMuOtdi8biAA63FRPES6TgmD+cws9OoY0mCbvHe3odfxcWH+VavyKpVhWyTgG9gf+5aAVQDqUFynVXYogzaGNA3KHZYSv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643928; c=relaxed/simple;
	bh=Fs8wvE75da4ikAw/bLeV/l8PDqwuAwasxUP/nHGuE1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBrnByvyb8Sv3Pv4Am2laMO5wPuUsVCkCYZCV8iuAjLfBlX1RaRZ+675KqBXnSweTw4HFqSmny/WF7SfPdvql7/Bh+xnDy7q6YOH29ovuBUuBLSqRhQ9twGk0YYwLeAKjKKbtCViEZHQKQC4MvCbKJU0BImsV6uvGps4ATo/TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Dsdf1Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94314C4CEE2;
	Wed,  7 May 2025 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643928;
	bh=Fs8wvE75da4ikAw/bLeV/l8PDqwuAwasxUP/nHGuE1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Dsdf1Db5IxXLnI02y7XN3eIzXX/ALNDhxuiAXPElyCAgSI0hSLyQZI35UKsXYwFl
	 dyrRuLUWKCB/GBumJ/elcpf+j9i+SjizubxC9Ylg5PK2fQJxg2s52AwnB5nLUsnhz8
	 CQA0KgEB3I39BtbFthR6SaWBuLC9MgS/n6FpC2t0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7d4f142f6c288de8abfe@syzkaller.appspotmail.com,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 064/183] wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release
Date: Wed,  7 May 2025 20:38:29 +0200
Message-ID: <20250507183827.288344150@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

[ Upstream commit 0fb15ae3b0a9221be01715dac0335647c79f3362 ]

plfxlc_mac_release() asserts that mac->lock is held. This assertion is
incorrect, because even if it was possible, it would not be the valid
behaviour. The function is used when probe fails or after the device is
disconnected. In both cases mac->lock can not be held as the driver is
not working with the device at the moment. All functions that use mac->lock
unlock it just after it was held. There is also no need to hold mac->lock
for plfxlc_mac_release() itself, as mac data is not affected, except for
mac->flags, which is modified atomically.

This bug leads to the following warning:
================================================================
WARNING: CPU: 0 PID: 127 at drivers/net/wireless/purelifi/plfxlc/mac.c:106 plfxlc_mac_release+0x7d/0xa0
Modules linked in:
CPU: 0 PID: 127 Comm: kworker/0:2 Not tainted 6.1.124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:plfxlc_mac_release+0x7d/0xa0 drivers/net/wireless/purelifi/plfxlc/mac.c:106
Call Trace:
 <TASK>
 probe+0x941/0xbd0 drivers/net/wireless/purelifi/plfxlc/usb.c:694
 usb_probe_interface+0x5c0/0xaf0 drivers/usb/core/driver.c:396
 really_probe+0x2ab/0xcb0 drivers/base/dd.c:639
 __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:785
 driver_probe_device+0x50/0x420 drivers/base/dd.c:815
 __device_attach_driver+0x2cf/0x510 drivers/base/dd.c:943
 bus_for_each_drv+0x183/0x200 drivers/base/bus.c:429
 __device_attach+0x359/0x570 drivers/base/dd.c:1015
 bus_probe_device+0xba/0x1e0 drivers/base/bus.c:489
 device_add+0xb48/0xfd0 drivers/base/core.c:3696
 usb_set_configuration+0x19dd/0x2020 drivers/usb/core/message.c:2165
 usb_generic_driver_probe+0x84/0x140 drivers/usb/core/generic.c:238
 usb_probe_device+0x130/0x260 drivers/usb/core/driver.c:293
 really_probe+0x2ab/0xcb0 drivers/base/dd.c:639
 __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:785
 driver_probe_device+0x50/0x420 drivers/base/dd.c:815
 __device_attach_driver+0x2cf/0x510 drivers/base/dd.c:943
 bus_for_each_drv+0x183/0x200 drivers/base/bus.c:429
 __device_attach+0x359/0x570 drivers/base/dd.c:1015
 bus_probe_device+0xba/0x1e0 drivers/base/bus.c:489
 device_add+0xb48/0xfd0 drivers/base/core.c:3696
 usb_new_device+0xbdd/0x18f0 drivers/usb/core/hub.c:2620
 hub_port_connect drivers/usb/core/hub.c:5477 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5617 [inline]
 port_event drivers/usb/core/hub.c:5773 [inline]
 hub_event+0x2efe/0x5730 drivers/usb/core/hub.c:5855
 process_one_work+0x8a9/0x11d0 kernel/workqueue.c:2292
 worker_thread+0xa47/0x1200 kernel/workqueue.c:2439
 kthread+0x28d/0x320 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
================================================================

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")
Reported-by: syzbot+7d4f142f6c288de8abfe@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7d4f142f6c288de8abfe
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Link: https://patch.msgid.link/20250321185226.71-2-m.masimov@mt-integration.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/purelifi/plfxlc/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index eae93efa61504..82d1bf7edba20 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -102,7 +102,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 void plfxlc_mac_release(struct plfxlc_mac *mac)
 {
 	plfxlc_chip_release(&mac->chip);
-	lockdep_assert_held(&mac->lock);
 }
 
 int plfxlc_op_start(struct ieee80211_hw *hw)
-- 
2.39.5




