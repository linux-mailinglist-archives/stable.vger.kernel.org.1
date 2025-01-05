Return-Path: <stable+bounces-106771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7E0A01CC8
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 00:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D05E3A3108
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 23:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E331D47A2;
	Sun,  5 Jan 2025 23:55:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD5143C7E;
	Sun,  5 Jan 2025 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736121357; cv=none; b=jZWsQL6kCZo3rvHkXFvMYCogjCR443x5PU1Jho4JsIWE1FD2l7nK3jYaJ+03el80N0vPGkUR7sIG4QCexE4CjIK/NV/lgavk8gen5kP3MgXID0RbBDuU0M57B83hmBluZtUF9iM5OZoq5z69bmOV8BbdUnLGjdFx36ya0TA4N7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736121357; c=relaxed/simple;
	bh=wdvQYJ/06scAyrtv1+WY9onlPLA18EJ9P7NLY5jRTsI=;
	h=From:To:Cc:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=O/tplElCa9UHTGZZiRsOte6W/pcxwOBWlNVktTARepZ/VYZD/0LS/YPmDFEeniyqNN0S5cHfDJ3vDHIk+4l1nu0TeiyL6Rzd9WPYL/1ChNxac1x6KbBWha2i+4qknL2k/Wh9vXpD42RYo1m9czoghZRbaoTlYTqFQ5JewPzJs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-191-19.static.sonic.net (192-184-191-19.static.sonic.net [192.184.191.19])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 505NgQVG026093;
	Sun, 5 Jan 2025 15:42:26 -0800
From: Forest <forestix@nom.one>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke fastboot android bootloader utility
Date: Sun, 05 Jan 2025 15:42:26 -0800
Message-ID: <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net>
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net> <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
In-Reply-To: <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVbQgt+tH4hxXIB/nQM8grS/zkMbSn3Z+efL4hhSQLQlDfGt/jB8fEHADkBDX4XSFzBo3uk708hDCS2mdXrBQALO
X-Sonic-ID: C;gkwCuL7L7xGd2KxkvwPenQ== M;bNQhuL7L7xGd2KxkvwPenQ==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd

On Thu, 2 Jan 2025 16:13:34 +0200, Mathias Nyman wrote:

>It's not clear to me why this patch would cause regression.
>
>Could you enable xhci and usb core dynamic debug before connecting the
>device, and then share dmesg after the issue is triggered.
>
>dmesg of a working case would also be good to have for comparison.

I booted kernel 9b780c845fb6 (the last good one), logged in to my desktop,
waited a couple of minutes to let things settle, and then ran 'fastboot
getvar kernel' twice with the android device in bootloader mode.
Here's the dmesg output:


[  178.056557] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  179.166570] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  179.738601] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  179.874603] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  195.331308] xhci_hcd 0000:0c:00.0: Port change event, 1-3, id 8, portsc: 0x202e1
[  195.331313] xhci_hcd 0000:0c:00.0: handle_port_status: starting usb1 port polling.
[  195.331337] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0008
[  195.331343] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x202e1, return 0x10101
[  195.331354] xhci_hcd 0000:0c:00.0: clear port3 connect change, portsc: 0x2e1
[  195.331360] usb usb1-port3: status 0101, change 0001, 12 Mb/s
[  195.331363] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  195.359097] xhci_hcd 0000:0c:00.0: xhci_hub_status_data: stopping usb1 port polling
[  195.367107] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  195.403105] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  195.439107] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  195.475109] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  195.475119] usb usb1-port3: debounce total 100ms stable 100ms status 0x101
[  195.475124] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.475222] xhci_hcd 0000:0c:00.0: Slot 5 output ctx = 0x0x00000000fff58000 (dma)
[  195.475232] xhci_hcd 0000:0c:00.0: Slot 5 input ctx = 0x0x00000000fff4e000 (dma)
[  195.475240] xhci_hcd 0000:0c:00.0: Set slot id 5 dcbaa entry 0000000014c537d8 to 0xfff58000
[  195.475261] xhci_hcd 0000:0c:00.0: set port reset, actual port 1-3 status  = 0x2e1
[  195.543104] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x331, return 0x111
[  195.543113] usb usb1-port3: not reset yet, waiting 60ms
[  195.550132] xhci_hcd 0000:0c:00.0: Port change event, 1-3, id 8, portsc: 0x200e03
[  195.550137] xhci_hcd 0000:0c:00.0: handle_port_status: starting usb1 port polling.
[  195.611110] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x200e03, return 0x100503
[  195.611123] xhci_hcd 0000:0c:00.0: clear port3 reset change, portsc: 0xe03
[  195.671106] usb 1-3: new high-speed USB device number 6 using xhci_hcd
[  195.671111] xhci_hcd 0000:0c:00.0: Slot ID 5: HW portnum 7, hcd portnum 2
[  195.671113] xhci_hcd 0000:0c:00.0: udev->tt = 0000000000000000
[  195.671115] xhci_hcd 0000:0c:00.0: udev->ttport = 0x0
[  195.671117] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.671624] xhci_hcd 0000:0c:00.0: Successful setup context command
[  195.671628] xhci_hcd 0000:0c:00.0: Op regs DCBAA ptr = 0x000000fffff000
[  195.671630] xhci_hcd 0000:0c:00.0: Slot ID 5 dcbaa entry @0000000014c537d8 = 0x000000fff58000
[  195.671633] xhci_hcd 0000:0c:00.0: Output Context DMA address = 0xfff58000
[  195.671634] xhci_hcd 0000:0c:00.0: Internal device address = 0
[  195.674197] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  195.676204] xhci_hcd 0000:0c:00.0: set port reset, actual port 1-3 status  = 0xe03
[  195.743113] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x331, return 0x111
[  195.743124] usb usb1-port3: not reset yet, waiting 60ms
[  195.751006] xhci_hcd 0000:0c:00.0: Port change event, 1-3, id 8, portsc: 0x200e03
[  195.751011] xhci_hcd 0000:0c:00.0: handle_port_status: starting usb1 port polling.
[  195.811114] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x200e03, return 0x100503
[  195.811126] xhci_hcd 0000:0c:00.0: clear port3 reset change, portsc: 0xe03
[  195.855115] xhci_hcd 0000:0c:00.0: xhci_hub_status_data: stopping usb1 port polling
[  195.871114] xhci_hcd 0000:0c:00.0: Resetting device with slot ID 5
[  195.871119] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.871155] xhci_hcd 0000:0c:00.0: Completed reset device command.
[  195.871160] xhci_hcd 0000:0c:00.0: Can't reset device (slot ID 5) in default state
[  195.871162] xhci_hcd 0000:0c:00.0: Not freeing device rings.
[  195.871165] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.871940] xhci_hcd 0000:0c:00.0: Successful setup address command
[  195.871944] xhci_hcd 0000:0c:00.0: Op regs DCBAA ptr = 0x000000fffff000
[  195.871947] xhci_hcd 0000:0c:00.0: Slot ID 5 dcbaa entry @0000000014c537d8 = 0x000000fff58000
[  195.871949] xhci_hcd 0000:0c:00.0: Output Context DMA address = 0xfff58000
[  195.871951] xhci_hcd 0000:0c:00.0: Internal device address = 5
[  195.918200] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  195.920204] usb 1-3: default language 0x0409
[  195.923197] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  195.928197] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  195.933200] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  195.935211] usb 1-3: udev 6, busnum 1, minor = 5
[  195.935215] usb 1-3: New USB device found, idVendor=0fce, idProduct=0dde, bcdDevice= 1.00
[  195.935219] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  195.935222] usb 1-3: Product: Android
[  195.935224] usb 1-3: Manufacturer: Google
[  195.935226] usb 1-3: SerialNumber: BH905BAH9E
[  195.935427] usb 1-3: usb_probe_device
[  195.935430] usb 1-3: configuration #1 chosen from 1 choice
[  195.935439] xhci_hcd 0000:0c:00.0: add ep 0x81, slot id 5, new drop flags = 0x0, new add flags = 0x8
[  195.935447] xhci_hcd 0000:0c:00.0: add ep 0x1, slot id 5, new drop flags = 0x0, new add flags = 0xc
[  195.935449] xhci_hcd 0000:0c:00.0: xhci_check_bandwidth called for udev 00000000f4c62038
[  195.935452] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.938503] xhci_hcd 0000:0c:00.0: Successful Endpoint Configure command
[  195.938523] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.938614] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 5 ep 2
[  195.938705] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.943603] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.943686] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 5 ep 1
[  195.943764] xhci_hcd 0000:0c:00.0: // Ding dong!
[  195.951200] usb 1-3: adding 1-3:1.0 (config #1, interface 0)
[  195.954200] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  200.327212] xhci_hcd 0000:0c:00.0: Get port status 1-5 read: 0xe63, return 0x507
[  200.327233] xhci_hcd 0000:0c:00.0: clear USB_PORT_FEAT_SUSPEND
[  200.327236] xhci_hcd 0000:0c:00.0: PORTSC 0e63
[  200.327239] xhci_hcd 0000:0c:00.0: Set port 1-5 link state, portsc: 0xe63, write 0x10fe1
[  200.375216] xhci_hcd 0000:0c:00.0: Set port 1-5 link state, portsc: 0xfe3, write 0x10e01
[  200.375236] usb 1-5: usb auto-resume
[  200.375486] xhci_hcd 0000:0c:00.0: Port change event, 1-5, id 10, portsc: 0x400e03
[  200.375491] xhci_hcd 0000:0c:00.0: handle_port_status: starting usb1 port polling.
[  200.375507] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0020
[  200.376723] xhci_hcd 0000:0c:00.0: underrun event on endpoint
[  200.376726] xhci_hcd 0000:0c:00.0: overrun event on endpoint
[  200.423215] xhci_hcd 0000:0c:00.0: Get port status 1-5 read: 0xe03, return 0x40503
[  200.423230] xhci_hcd 0000:0c:00.0: clear port5 suspend/resume change, portsc: 0xe03
[  200.443209] usb 1-5: Waited 0ms for CONNECT
[  200.443213] usb 1-5: finish resume
[  200.447237] xhci_hcd 0000:0c:00.0: Get port status 1-5 read: 0xe03, return 0x503
[  200.447933] xhci_hcd 0000:0c:00.0: ep 0x81 - asked for 256 bytes, 248 bytes untransferred
[  200.567210] xhci_hcd 0000:0c:00.0: xhci_hub_status_data: stopping usb1 port polling
[  201.814693] xhci_hcd 0000:0c:00.0: ep 0x81 - asked for 256 bytes, 248 bytes untransferred
[  204.209316] xhci_hcd 0000:0c:00.0: // Ding dong!
[  204.209404] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 20
[  204.209565] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 19
[  204.209721] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 6
[  204.209873] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 5
[  204.210027] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 4
[  204.210187] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 3
[  204.210342] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 2
[  204.210503] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 0
[  204.210600] xhci_hcd 0000:0c:00.0: Set port 1-5 link state, portsc: 0xe03, write 0x10e61
[  204.227291] usb 1-5: usb auto-suspend, wakeup 0


I then did the same with kernel 63a1f8454962 (the first bad one):


[  196.399094] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  197.103104] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  197.881108] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  198.021105] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  225.430197] xhci_hcd 0000:0c:00.0: Port change event, 1-3, id 8, portsc: 0x202e1
[  225.430202] xhci_hcd 0000:0c:00.0: handle_port_status: starting usb1 port polling.
[  225.430226] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0008
[  225.430233] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x202e1, return 0x10101
[  225.430244] xhci_hcd 0000:0c:00.0: clear port3 connect change, portsc: 0x2e1
[  225.430250] usb usb1-port3: status 0101, change 0001, 12 Mb/s
[  225.430254] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  225.464705] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  225.500707] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  225.536707] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  225.572708] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x2e1, return 0x101
[  225.572719] usb usb1-port3: debounce total 100ms stable 100ms status 0x101
[  225.572724] xhci_hcd 0000:0c:00.0: // Ding dong!
[  225.572826] xhci_hcd 0000:0c:00.0: Slot 5 output ctx = 0x0x00000000fff5e000 (dma)
[  225.572838] xhci_hcd 0000:0c:00.0: Slot 5 input ctx = 0x0x00000000fff54000 (dma)
[  225.572846] xhci_hcd 0000:0c:00.0: Set slot id 5 dcbaa entry 000000003fadcb3f to 0xfff5e000
[  225.572888] xhci_hcd 0000:0c:00.0: set port reset, actual port 1-3 status  = 0x2e1
[  225.616706] xhci_hcd 0000:0c:00.0: xhci_hub_status_data: stopping usb1 port polling
[  225.640709] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x331, return 0x111
[  225.640720] usb usb1-port3: not reset yet, waiting 60ms
[  225.647922] xhci_hcd 0000:0c:00.0: Port change event, 1-3, id 8, portsc: 0x200e03
[  225.647927] xhci_hcd 0000:0c:00.0: handle_port_status: starting usb1 port polling.
[  225.708710] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x200e03, return 0x100503
[  225.708723] xhci_hcd 0000:0c:00.0: clear port3 reset change, portsc: 0xe03
[  225.768711] usb 1-3: new high-speed USB device number 6 using xhci_hcd
[  225.768716] xhci_hcd 0000:0c:00.0: Slot ID 5: HW portnum 7, hcd portnum 2
[  225.768718] xhci_hcd 0000:0c:00.0: udev->tt = 0000000000000000
[  225.768720] xhci_hcd 0000:0c:00.0: udev->ttport = 0x0
[  225.768722] xhci_hcd 0000:0c:00.0: // Ding dong!
[  225.769231] xhci_hcd 0000:0c:00.0: Successful setup context command
[  225.769236] xhci_hcd 0000:0c:00.0: Op regs DCBAA ptr = 0x000000fffff000
[  225.769239] xhci_hcd 0000:0c:00.0: Slot ID 5 dcbaa entry @000000003fadcb3f = 0x000000fff5e000
[  225.769241] xhci_hcd 0000:0c:00.0: Output Context DMA address = 0xfff5e000
[  225.769243] xhci_hcd 0000:0c:00.0: Internal device address = 0
[  225.771743] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  225.773750] xhci_hcd 0000:0c:00.0: set port reset, actual port 1-3 status  = 0xe03
[  225.840714] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x331, return 0x111
[  225.840726] usb usb1-port3: not reset yet, waiting 60ms
[  225.848802] xhci_hcd 0000:0c:00.0: Port change event, 1-3, id 8, portsc: 0x200e03
[  225.848807] xhci_hcd 0000:0c:00.0: handle_port_status: starting usb1 port polling.
[  225.908732] xhci_hcd 0000:0c:00.0: Get port status 1-3 read: 0x200e03, return 0x100503
[  225.908744] xhci_hcd 0000:0c:00.0: clear port3 reset change, portsc: 0xe03
[  225.968714] xhci_hcd 0000:0c:00.0: Resetting device with slot ID 5
[  225.968718] xhci_hcd 0000:0c:00.0: // Ding dong!
[  225.968757] xhci_hcd 0000:0c:00.0: Completed reset device command.
[  225.968762] xhci_hcd 0000:0c:00.0: Can't reset device (slot ID 5) in default state
[  225.968764] xhci_hcd 0000:0c:00.0: Not freeing device rings.
[  225.968767] xhci_hcd 0000:0c:00.0: // Ding dong!
[  225.969479] xhci_hcd 0000:0c:00.0: Successful setup address command
[  225.969483] xhci_hcd 0000:0c:00.0: Op regs DCBAA ptr = 0x000000fffff000
[  225.969485] xhci_hcd 0000:0c:00.0: Slot ID 5 dcbaa entry @000000003fadcb3f = 0x000000fff5e000
[  225.969488] xhci_hcd 0000:0c:00.0: Output Context DMA address = 0xfff5e000
[  225.969490] xhci_hcd 0000:0c:00.0: Internal device address = 5
[  226.002756] xhci_hcd 0000:0c:00.0: enable port 3 USB2 hardware LPM
[  226.002765] xhci_hcd 0000:0c:00.0: Set up evaluate context for LPM MEL change.
[  226.002769] xhci_hcd 0000:0c:00.0: // Ding dong!
[  226.003125] xhci_hcd 0000:0c:00.0: Successful evaluate context command
[  226.015745] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  226.017754] usb 1-3: default language 0x0409
[  226.020737] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  226.025742] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  226.030745] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  226.032754] usb 1-3: udev 6, busnum 1, minor = 5
[  226.032759] usb 1-3: New USB device found, idVendor=0fce, idProduct=0dde, bcdDevice= 1.00
[  226.032761] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  226.032763] usb 1-3: Product: Android
[  226.032765] usb 1-3: Manufacturer: Google
[  226.032766] usb 1-3: SerialNumber: BH905BAH9E
[  226.032972] usb 1-3: usb_probe_device
[  226.032974] usb 1-3: configuration #1 chosen from 1 choice
[  226.032983] xhci_hcd 0000:0c:00.0: add ep 0x81, slot id 5, new drop flags = 0x0, new add flags = 0x8
[  226.032990] xhci_hcd 0000:0c:00.0: add ep 0x1, slot id 5, new drop flags = 0x0, new add flags = 0xc
[  226.032993] xhci_hcd 0000:0c:00.0: xhci_check_bandwidth called for udev 00000000f07964e8
[  226.032996] xhci_hcd 0000:0c:00.0: // Ding dong!
[  226.036041] xhci_hcd 0000:0c:00.0: Successful Endpoint Configure command
[  226.036058] xhci_hcd 0000:0c:00.0: // Ding dong!
[  226.036142] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 5 ep 2
[  226.036227] xhci_hcd 0000:0c:00.0: // Ding dong!
[  226.041132] xhci_hcd 0000:0c:00.0: // Ding dong!
[  226.041222] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 5 ep 1
[  226.041311] xhci_hcd 0000:0c:00.0: // Ding dong!
[  226.048744] usb 1-3: adding 1-3:1.0 (config #1, interface 0)
[  226.051745] xhci_hcd 0000:0c:00.0: Waiting for status stage event
[  226.112724] xhci_hcd 0000:0c:00.0: xhci_hub_status_data: stopping usb1 port polling
[  229.214292] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  229.358289] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  234.642446] xhci_hcd 0000:0c:00.0: Get port status 1-5 read: 0xe63, return 0x507
[  234.642466] xhci_hcd 0000:0c:00.0: clear USB_PORT_FEAT_SUSPEND
[  234.642468] xhci_hcd 0000:0c:00.0: PORTSC 0e63
[  234.642470] xhci_hcd 0000:0c:00.0: Set port 1-5 link state, portsc: 0xe63, write 0x10fe1
[  234.688896] xhci_hcd 0000:0c:00.0: Set port 1-5 link state, portsc: 0xfe3, write 0x10e01
[  234.688933] usb 1-5: usb auto-resume
[  234.689161] xhci_hcd 0000:0c:00.0: Port change event, 1-5, id 10, portsc: 0x400e03
[  234.689166] xhci_hcd 0000:0c:00.0: handle_port_status: starting usb1 port polling.
[  234.689189] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0020
[  234.690282] xhci_hcd 0000:0c:00.0: underrun event on endpoint
[  234.690285] xhci_hcd 0000:0c:00.0: overrun event on endpoint
[  234.736898] xhci_hcd 0000:0c:00.0: Get port status 1-5 read: 0xe03, return 0x40503
[  234.736914] xhci_hcd 0000:0c:00.0: clear port5 suspend/resume change, portsc: 0xe03
[  234.756897] usb 1-5: Waited 0ms for CONNECT
[  234.756901] usb 1-5: finish resume
[  234.761806] xhci_hcd 0000:0c:00.0: Get port status 1-5 read: 0xe03, return 0x503
[  234.762810] xhci_hcd 0000:0c:00.0: ep 0x81 - asked for 256 bytes, 248 bytes untransferred
[  234.792899] xhci_hcd 0000:0c:00.0: xhci_hub_status_data: stopping usb1 port polling
[  236.353577] xhci_hcd 0000:0c:00.0: ep 0x81 - asked for 256 bytes, 237 bytes untransferred
[  238.852825] xhci_hcd 0000:0c:00.0: // Ding dong!
[  238.852917] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 20
[  238.853081] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 19
[  238.853229] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 6
[  238.853388] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 5
[  238.853541] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 4
[  238.853698] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 3
[  238.853854] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 2
[  238.854015] xhci_hcd 0000:0c:00.0: Stopped on No-op or Link TRB for slot 1 ep 0
[  238.854113] xhci_hcd 0000:0c:00.0: Set port 1-5 link state, portsc: 0xe03, write 0x10e61
[  238.872988] usb 1-5: usb auto-suspend, wakeup 0
[  240.855359] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred
[  241.009359] xhci_hcd 0000:0c:00.0: ep 0x82 - asked for 32 bytes, 26 bytes untransferred


