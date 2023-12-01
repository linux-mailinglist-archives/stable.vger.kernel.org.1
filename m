Return-Path: <stable+bounces-3599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9950C8003E6
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 07:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C68028178D
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40959D2E6;
	Fri,  1 Dec 2023 06:33:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147C1711;
	Thu, 30 Nov 2023 22:33:08 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1r8x5E-0002Ke-Cg; Fri, 01 Dec 2023 07:33:04 +0100
Message-ID: <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
Date: Fri, 1 Dec 2023 07:33:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
Content-Language: en-US, de-DE
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-bluetooth@vger.kernel.org
In-Reply-To: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701412389;c06d478a;
X-HE-SMSGID: 1r8x5E-0002Ke-Cg

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

CCing a few lists and people. Greg is among them, who might know if this
is a known issue that 6.6.4-rc1 et. al. might already fix.

If that is not the case I guess we might need a bisection between 6.6.1
and 6.6.2 know if mainline is affected might be good, too.

Cioa, Thorsten

On 01.12.23 02:54, Kris Karas (Bug Reporting) wrote:
> 
> With mainline kernel 6.6.2+ (and 6.1.63, etc), bluetooth is inoperative
> (reports "opcode 0x0c03 failed") on my motherboard's bluetooth adapter
> (Intel chipset).  Details below.
> 
> I reported this in a comment tacked onto bugzilla #218142, but got no
> response, so posting here as a possibly new issue.
> 
> Details, original email:
> ----------------------------------------------------------------------
> I have a regression going from mainline kernel 6.1.62 to 6.1.63, and
> also from kernel 6.6.1 to 6.6.2; I can bisect if patch authors can't
> locate the relevant commit.  In the most recent kernels mentioned,
> bluetooth won't function.
> 
> Hardware: ASRock "X470 Taichi" motherboard - on board chipset.
> lsusb: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth.
> dmesg: Bluetooth: hci0: Legacy ROM 2.x revision 5.0 build 25 week 20 2015
>        Bluetooth: hci0: Intel Bluetooth firmware file:
>          intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
>        Bluetooth: hci0: Intel BT fw patch 0x43 completed & activated
> bluez: Version 5.70, bluez firmware version 1.2
> Linux kernel firmware: 20231117_7124ce3
> 
> On a working kernel (such as 6.6.1), in addition to the dmesg output
> above, we have this:
> dmesg: Bluetooth: MGMT ver 1.22
>        Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
> 
> On a failed kernel (such as 6.6.2), instead of the good output above, we
> have:
> dmesg: Bluetooth: hci0: Opcode 0x0c03 failed: -110
>        Bluetooth: hci0: Opcode 0x0c03 failed: -110
>        ...
> repeats several times as bluez attempts to communicate with hci0.
> ----------------------------------------------------------------------
> 
> Since that email was sent, kernel firmware has been updated to
> 20231128_aae6052, and kernels 6.1.64 and 6.6.3 have been tried with no
> change observed.
> 
> Kris

