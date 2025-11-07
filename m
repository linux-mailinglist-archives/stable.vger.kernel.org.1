Return-Path: <stable+bounces-192740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5BEC40A5C
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 16:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7836B4EB25C
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFD2D7394;
	Fri,  7 Nov 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="N2KSJ4I3"
X-Original-To: stable@vger.kernel.org
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D8125B2;
	Fri,  7 Nov 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530343; cv=none; b=keKi81hcCdY2dCJu43tzyM0Noi/5KsFsXfkciS+/lOWrk/08F97RfU6xai0FkXsor64l33S6hjDS8i/SADHSx6DXK7su15jvFVD3mhzucFartWBqmOQ0S4gOctHS3c+WSiW245wujvMNEK6oJ7dK7IgF+3nXPaLmdqb3DG+IljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530343; c=relaxed/simple;
	bh=gSVyAnwa/eT2IrQeUH6B6InqjR5qZpkSV+VtOrAMIBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoPELley74Oi/uCCwDXwfZQ0AaysF6ckEHwUvP4zhPCjhkRo3u41CvbNm8h1CXhdw/dQRHzdRd7b+AhXOOnoHHnIX9Z/GXNa9zC8UPdUryf3tzUdBFLABFjlalU8uKztSMfXLLCNVCD2SkFsBeu0s490S+uHNdOcaeSQxoVpENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=N2KSJ4I3; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1762530337;
	bh=NE3R/3BKJGW2lXDVXEr1LfPaybTpng72jTTBKj5B/yE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=N2KSJ4I3tp/27fmiCuRhHaa9eB4lzMcZDmOTxqzp2rJDcUA7Dyaj8JZSnNuNPGJC6
	 ZWf+DIBXR2G+cAE0NGYBj+jYvbUUYQvI9pcNccrZFc+MG+8a71aE4yUVqDNSJViPaq
	 Tdfj60wNEH1RhF10O2M6D4SpPo5wKkFTYPiGM8I6uqyoHJ7geAYPkDod10iyBbyuwA
	 X1b2ZCWiEcHaJ+s7bElDJnv0BQdr6aMqnt6p22jfeMVuCRevLIRd7YoSf0YlXS2CIT
	 HPWbfw5mBSSTLhuNBRTnIrll54xBetXV3Ebu29VykqRvmGhbe9eH9liHoE/NZJgXq6
	 DYgbBQqv5G1Cg==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id 30AB03E4F07;
	Fri,  7 Nov 2025 18:45:37 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id BA6643E47E3;
	Fri,  7 Nov 2025 18:45:36 +0300 (MSK)
Received: from Nalivayko.avp.ru (10.16.105.14) by HQMAILSRV3.avp.ru
 (10.64.57.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 7 Nov
 2025 18:45:19 +0300
From: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
To: <linux-media@vger.kernel.org>
CC: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Michael Krufky <mkrufky@linuxtv.org>,
	<syzbot+f9f5333782a854509322@syzkaller.appspotmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] media: mxl111sf: fix i2c race condition during device probe
Date: Fri, 7 Nov 2025 18:44:26 +0300
Message-ID: <20251107154426.2116743-3-Sergey.Nalivayko@kaspersky.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251107154426.2116743-1-Sergey.Nalivayko@kaspersky.com>
References: <20251107154426.2116743-1-Sergey.Nalivayko@kaspersky.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV3.avp.ru (10.64.57.53) To HQMAILSRV3.avp.ru
 (10.64.57.53)
X-KSE-ServerInfo: HQMAILSRV3.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/07/2025 15:33:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197892 [Nov 07 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Sergey.Nalivayko@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 75 0.3.75
 aab2175a55dcbd410b25b8694e49bbee3c09cdde
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_one_url}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;syzkaller.appspot.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/07/2025 15:34:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/7/2025 12:14:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/11/07 15:29:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/07 15:09:00 #27893311
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/07 15:29:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

syzbot reports a KASAN issue as below:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
CPU: 1 UID: 0 PID: 5849 Comm: syz-executor279 Not tainted 6.15.0-rc2-syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:580 [inline]
RIP: 0010:__mutex_lock+0x15d/0x10c0 kernel/locking/mutex.c:746
Call Trace:
 <TASK>
 dvb_usbv2_generic_write+0x26/0x50 drivers/media/usb/dvb-usb-v2/dvb_usb_urb.c:77
 mxl111sf_ctrl_msg+0x172/0x2e0 drivers/media/usb/dvb-usb-v2/mxl111sf.c:73
 mxl111sf_write_reg+0xda/0x1f0 drivers/media/usb/dvb-usb-v2/mxl111sf.c:123
 mxl111sf_i2c_start drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c:130 [inline]
 mxl111sf_i2c_sw_xfer_msg drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c:-1 [inline]
 mxl111sf_i2c_xfer+0x923/0x8aa0 drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c:813
 __i2c_transfer+0x859/0x2250 drivers/i2c/i2c-core-base.c:-1
 i2c_transfer+0x2c2/0x430 drivers/i2c/i2c-core-base.c:2315
 i2c_transfer_buffer_flags+0x182/0x260 drivers/i2c/i2c-core-base.c:2343
 i2c_master_recv include/linux/i2c.h:79 [inline]
 i2cdev_read+0x10a/0x220 drivers/i2c/i2c-dev.c:155
 vfs_read+0x21f/0xb90 fs/read_write.c:568
 ksys_read+0x19d/0x2d0 fs/read_write.c:713
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

This occurs due to a race condition during DVB-USB-V2 device initialization.
While initialization is in progress, I2C data may be read from userspace,
leading to a NULL pointer dereference in dvb_usbv2_generic_write
and a kernel panic.

      Thread 1 (probe device)             Thread 2 (receive i2c data)
    ...
    dvb_usbv2_probe()
      ...
      d->priv = kzalloc(
          d->props->size_of_priv,
          GFP_KERNEL);
      ...
      dvb_usbv2_init()
      ...
        // can read data from i2c
        dvb_usbv2_i2c_init()
      ...
                                        ...
                                        i2cdev_read()
                                        ...
                                          // d->priv data is invalid. UB
                                          mxl111sf_i2c_xfer()
                                            ...
                                            mxl111sf_ctrl_msg()
                                              ...
                                              // null ptr deref
                                              dvb_usbv2_generic_write()
                                        ...
      ...
      // d->priv data is valid
      dvb_usbv2_adapter_init()
      ...

Add init_ready flag check to prevent I/O on uninitialized DVB-USB-V2 device.

Reported-by: syzbot+f9f5333782a854509322@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f9f5333782a854509322
Fixes: 4c66c9205c07 ("[media] dvb-usb: add ATSC support for the Hauppauge WinTV-Aero-M")
Cc: stable@vger.kernel.org
Signed-off-by: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
---
 drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c b/drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c
index 100a1052dcbc..b7bad90b16dc 100644
--- a/drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c
+++ b/drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c
@@ -804,7 +804,7 @@ int mxl111sf_i2c_xfer(struct i2c_adapter *adap,
 	int hwi2c = (state->chip_rev > MXL111SF_V6);
 	int i, ret;
 
-	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
+	if (!atomic_read(&d->init_ready) || mutex_lock_interruptible(&d->i2c_mutex) < 0)
 		return -EAGAIN;
 
 	for (i = 0; i < num; i++) {
-- 
2.39.5


