Return-Path: <stable+bounces-108249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EBFA09F16
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 01:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6735A3A2F47
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 00:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704E7F9;
	Sat, 11 Jan 2025 00:13:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137A634;
	Sat, 11 Jan 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554427; cv=none; b=L4GuppSJfO+hJuPBJMnCQFnPfVzz6GK3xruM9kcWm3v+8TI9ncH6/UXgc0Rlm5u8sROwnTGpvXDN02/KUYaoIZ8p6zfIUP9B9PdCE12npZ9C7BjyUof6yf22ZvyB3dFsBRUrohpd8bCO9fIkPQLZbuo1g99kUx3D0fG5X8k6IAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554427; c=relaxed/simple;
	bh=kclRYrzwiJTudSJ7PWmOn5xrtuuT/jLmOYfxjO14luw=;
	h=From:To:Cc:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=b/YnQXvDOJUeziuFiqFspoMm0v+x//yWjzOyakwL5ibSof+5FO4STmljpfOCdQXPZYoUhSyBtJGiJN5Ag8zWf0pqSP4UIXEMzeJCeJWQ0xmBYk01u7/ARJU+zLfXmY5B9PPqwrx78KZEQgIy+6h8mEtRd4vKZfaRhpoC5gRY58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-189-209.static.sonic.net (192-184-189-209.static.sonic.net [192.184.189.209])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 50B00EEu029325;
	Fri, 10 Jan 2025 16:00:15 -0800
From: Forest <forestix@nom.one>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke fastboot android bootloader utility
Date: Fri, 10 Jan 2025 16:00:14 -0800
Message-ID: <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net>
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net> <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com> <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net> <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
In-Reply-To: <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVaSU/DEmVq8Q9sjepS3hiIcO0KswngLP56zoXBeZaDHVok+yHcCGfiAyfG35PHV8XW6+QXh85FxDgqCuSXsTchD
X-Sonic-ID: C;Jv0ICa/P7xGmAIGchs+snA== M;oEccCa/P7xGmAIGchs+snA==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd

On Tue, 7 Jan 2025 14:29:35 +0200, Mathias Nyman wrote:

>Does disabling USB2 hardware LPM for the device make it work again?
>
>Adding USB_QUIRK_NO_LPM quirk "k" for your device vid:pid should do it.
>i.e. add "usbcore.quirks=0fce:0dde:k" parameter to your kernel cmdline.

That fixed my test case on Debian kernel 6.12.8-amd64, which is among those
that have been failing.

>Or alternatively disable usb2 lpm  during runtime via sysfs
>(after enumeration, assuming device is "1-3" as in the log):
># echo 0 > /sys/bus/usb/devices/1-3/power/usb2_hardware_lpm

That did not fix it. Maybe it's too late once the device is connected and
enumerated?

>If those work then we need to figure out if we incorrectly try to enable
>USB2 hardware LPM, or if device just can't handle LPM even if it claims
>to be LPM capable.
>
>Host hardware LPM capability can be checked from xhci reg-ext-protocol
>fields from debugfs.
>cat /sys/kernel/debug/usb/xhci/0000:0c:00.0/reg-ext-protocol:*
>(please print content of _all_ reg_ext_protocol* files, LPM capability is
>bit 19 of EXTCAP_PORTINFO)

# cd /sys/kernel/debug/usb/xhci/0000:0c:00.0/
# grep . reg-ext-protocol:*
reg-ext-protocol:00:EXTCAP_REVISION = 0x03200802
reg-ext-protocol:00:EXTCAP_NAME = 0x20425355
reg-ext-protocol:00:EXTCAP_PORTINFO = 0x40000101
reg-ext-protocol:00:EXTCAP_PORTTYPE = 0x00000000
reg-ext-protocol:00:EXTCAP_MANTISSA1 = 0x00050134
reg-ext-protocol:00:EXTCAP_MANTISSA2 = 0x000a4135
reg-ext-protocol:00:EXTCAP_MANTISSA3 = 0x000a4136
reg-ext-protocol:00:EXTCAP_MANTISSA4 = 0x00144137
reg-ext-protocol:01:EXTCAP_REVISION = 0x03100802
reg-ext-protocol:01:EXTCAP_NAME = 0x20425355
reg-ext-protocol:01:EXTCAP_PORTINFO = 0x20000402
reg-ext-protocol:01:EXTCAP_PORTTYPE = 0x00000000
reg-ext-protocol:01:EXTCAP_MANTISSA1 = 0x00050134
reg-ext-protocol:01:EXTCAP_MANTISSA2 = 0x000a4135
reg-ext-protocol:02:EXTCAP_REVISION = 0x02000802
reg-ext-protocol:02:EXTCAP_NAME = 0x20425355
reg-ext-protocol:02:EXTCAP_PORTINFO = 0x00190c06
reg-ext-protocol:02:EXTCAP_PORTTYPE = 0x00000000

# grep EXTCAP_PORTINFO reg-ext-protocol:*
reg-ext-protocol:00:EXTCAP_PORTINFO = 0x40000101
reg-ext-protocol:01:EXTCAP_PORTINFO = 0x20000402
reg-ext-protocol:02:EXTCAP_PORTINFO = 0x00190c06

>>> bool(0x40000101 & 1 << 19)
False
>>> bool(0x20000402 & 1 << 19)
False
>>> bool(0x00190c06 & 1 << 19)
True

>Device USB2 LPM capability can be checked from the devices BOS descriptor,
>visible (as sudo/root) with lsusb -v -d 0fce:0dde

# lsusb -v -d 0fce:0dde |grep -B 5 LPM
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000006
      BESL Link Power Management (LPM) Supported

I think that says the device claims support for LPM, yes?

Maybe relevant: The failing test and lsusb were both run with the device in
fastboot mode, which allows talking to the bootloader. Is it possible that a
device would support LPM in normal operating modes, but not in bootloader
mode, yet present the same capabilities data structure in both modes?

