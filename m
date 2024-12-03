Return-Path: <stable+bounces-97979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951C9E2899
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2723B39499
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341D1F76BF;
	Tue,  3 Dec 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DUbtiJm2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105481ADA;
	Tue,  3 Dec 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242391; cv=none; b=qP14kMlVcJH5E8QViHgOw9lxUSXf4hP5nY3jxx3BB9Q35/o9mqPZjv3F/36icmHWiQCzw1+NKCI/6GZDPl7bHqcyv4ctBe8wYxrqMF7Bl85SjqX2HELibcUTmxtLIbwVgiQH/+FYv/EB0Hh/tR2t2ThfYI7370WGcmvSVnVcKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242391; c=relaxed/simple;
	bh=aXgOrlkUMZfnInA+lDH6k6AZbVlkh7QcnilP00wzeHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rrfvh8PhfTJOJ0ANWjmp23Wj9p8RGpZA0xxWgFfTX3MP17DV37CuslUJNvaNGB6/cKYAYdNROcYCp8xQoLTacvYp2D3MR7r63EwgtTkB+gDf52E9d8mMf79ihCA22GnAg1cSXJFzOP5B/fyLdok1fYxfTtgVoIg7HsDBaOYbb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DUbtiJm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0638C4CECF;
	Tue,  3 Dec 2024 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242391;
	bh=aXgOrlkUMZfnInA+lDH6k6AZbVlkh7QcnilP00wzeHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUbtiJm2Wrh8P5jFvWV8qhcSDYdeIsn3UJGAvqHNVdU7MCP7pW7YCWfMwEQAyShtS
	 wTAXPCT/m8fU9FEFQz+zfmaXdec91rIJ5aVVZYn3hZvJs/5rhfTndehXZGg0Pxt/mH
	 3RMWnE3DeerhDU1x7CL2H5nhm8sAoWlI/zZqv+FE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 6.12 682/826] wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures
Date: Tue,  3 Dec 2024 15:46:49 +0100
Message-ID: <20241203144810.360574761@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

From: Guilherme G. Piccoli <gpiccoli@igalia.com>

commit 5c1b544563005a00591a3aa86ecff62ed4d11be3 upstream.

Syzkaller reported a hung task with uevent_show() on stack trace. That
specific issue was addressed by another commit [0], but even with that
fix applied (for example, running v6.12-rc5) we face another type of hung
task that comes from the same reproducer [1]. By investigating that, we
could narrow it to the following path:

(a) Syzkaller emulates a Realtek USB WiFi adapter using raw-gadget and
dummy_hcd infrastructure.

(b) During the probe of rtl8192cu, the driver ends-up performing an efuse
read procedure (which is related to EEPROM load IIUC), and here lies the
issue: the function read_efuse() calls read_efuse_byte() many times, as
loop iterations depending on the efuse size (in our example, 512 in total).

This procedure for reading efuse bytes relies in a loop that performs an
I/O read up to *10k* times in case of failures. We measured the time of
the loop inside read_efuse_byte() alone, and in this reproducer (which
involves the dummy_hcd emulation layer), it takes 15 seconds each. As a
consequence, we have the driver stuck in its probe routine for big time,
exposing a stack trace like below if we attempt to reboot the system, for
example:

task:kworker/0:3 state:D stack:0 pid:662 tgid:662 ppid:2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 __schedule+0xe22/0xeb6
 schedule_timeout+0xe7/0x132
 __wait_for_common+0xb5/0x12e
 usb_start_wait_urb+0xc5/0x1ef
 ? usb_alloc_urb+0x95/0xa4
 usb_control_msg+0xff/0x184
 _usbctrl_vendorreq_sync+0xa0/0x161
 _usb_read_sync+0xb3/0xc5
 read_efuse_byte+0x13c/0x146
 read_efuse+0x351/0x5f0
 efuse_read_all_map+0x42/0x52
 rtl_efuse_shadow_map_update+0x60/0xef
 rtl_get_hwinfo+0x5d/0x1c2
 rtl92cu_read_eeprom_info+0x10a/0x8d5
 ? rtl92c_read_chip_version+0x14f/0x17e
 rtl_usb_probe+0x323/0x851
 usb_probe_interface+0x278/0x34b
 really_probe+0x202/0x4a4
 __driver_probe_device+0x166/0x1b2
 driver_probe_device+0x2f/0xd8
 [...]

We propose hereby to drastically reduce the attempts of doing the I/O
reads in case of failures, restricted to USB devices (given that
they're inherently slower than PCIe ones). By retrying up to 10 times
(instead of 10000), we got reponsiveness in the reproducer, while seems
reasonable to believe that there's no sane USB device implementation in
the field requiring this amount of retries at every I/O read in order
to properly work. Based on that assumption, it'd be good to have it
backported to stable but maybe not since driver implementation (the 10k
number comes from day 0), perhaps up to 6.x series makes sense.

[0] Commit 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race")

[1] A note about that: this syzkaller report presents multiple reproducers
that differs by the type of emulated USB device. For this specific case,
check the entry from 2024/08/08 06:23 in the list of crashes; the C repro
is available at https://syzkaller.appspot.com/text?tag=ReproC&x=1521fc83980000.

Cc: stable@vger.kernel.org # v6.1+
Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241101193412.1390391-1-gpiccoli@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/efuse.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -162,10 +162,19 @@ void efuse_write_1byte(struct ieee80211_
 void read_efuse_byte(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u16 max_attempts = 10000;
 	u32 value32;
 	u8 readbyte;
 	u16 retry;
 
+	/*
+	 * In case of USB devices, transfer speeds are limited, hence
+	 * efuse I/O reads could be (way) slower. So, decrease (a lot)
+	 * the read attempts in case of failures.
+	 */
+	if (rtlpriv->rtlhal.interface == INTF_USB)
+		max_attempts = 10;
+
 	rtl_write_byte(rtlpriv, rtlpriv->cfg->maps[EFUSE_CTRL] + 1,
 		       (_offset & 0xff));
 	readbyte = rtl_read_byte(rtlpriv, rtlpriv->cfg->maps[EFUSE_CTRL] + 2);
@@ -178,7 +187,7 @@ void read_efuse_byte(struct ieee80211_hw
 
 	retry = 0;
 	value32 = rtl_read_dword(rtlpriv, rtlpriv->cfg->maps[EFUSE_CTRL]);
-	while (!(((value32 >> 24) & 0xff) & 0x80) && (retry < 10000)) {
+	while (!(((value32 >> 24) & 0xff) & 0x80) && (retry < max_attempts)) {
 		value32 = rtl_read_dword(rtlpriv,
 					 rtlpriv->cfg->maps[EFUSE_CTRL]);
 		retry++;



