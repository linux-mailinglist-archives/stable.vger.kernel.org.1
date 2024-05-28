Return-Path: <stable+bounces-47587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A138F8D25A3
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 22:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5512D283637
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 20:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875EA78C96;
	Tue, 28 May 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOQNO7FZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8738DE0;
	Tue, 28 May 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927567; cv=none; b=OQs+CztFt9lbrqA21N8Xt1N2PByxJ2RBiqgPyz4f3BwJ8Jjfcclev78b61VpaxC42Z3HqNfUvZ18RSmNOdgHkqOoAdgj5WQHPvxxhvKLV3a6+2rKLNDvriumw43g9HjUmMpkT+XWRAl5SXPZxclMLVl+c6S0fRML6xS6Qfni0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927567; c=relaxed/simple;
	bh=1WgrUuVhMpuSQVgkRDnkzNB7+fJMuzw2rgjoK8PjPs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR8vO21uasicWw7zry0OJ8yseHRLmXaBKKTP4lD9tkJhZw7i8IJPPJK0i/K0U/JwwgJLDY+w1o9BxqP/ARV0kjz8YiLxiOzoMu3Z6nmeUgc31HGlRclKgme/L62MmsUlVNlsQ13qF3tToXNXSb4oSdW3exgTadrSTx9kLGV7As4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOQNO7FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3D4C3277B;
	Tue, 28 May 2024 20:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716927566;
	bh=1WgrUuVhMpuSQVgkRDnkzNB7+fJMuzw2rgjoK8PjPs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOQNO7FZBnOEBkWXuQs1pSIy2DvzbAMM46S7SHiUsgKZmvadfREZ4lMpfJ64/Y/vT
	 qj2DaSIevOZjd2IPNvjv+PhgSTQXqez/WtTobwzUNOxFf7FVXTDQ8gFEDWcEZREM9y
	 Hpf2BlPETo+y5an6u/clSsQaopAmBRXJ0fFXQ9JAuv+1Ii6lia27tXG1KnFicFYhr/
	 KdGjh/hbCxhMFfXWmzY4m0Em8lbhaXvAdLBnH9eEdHXsKhZkhPazui69LsZ0Hn+Yso
	 FlY6ZmqVej/FgkU1mM6G7U5kh1FIIvGqpmI1rjCmQdBZIC6OPfybpS8v+3m3AOZjyX
	 fYAc4XQpwNn1Q==
Date: Tue, 28 May 2024 22:19:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tim Teichmann <teichmanntim@outlook.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev,
	x86@kernel.org, stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
Message-ID: <ZlY8SbGVMHho-dLz@ryzen.lan>
References: <87r0dqdf0r.ffs@tglx>
 <gtgsklvltu5pzeiqn7fwaktdsywk2re75unapgbcarlmqkya5a@mt7pi4j2f7b3>
 <87h6ejd0wt.ffs@tglx>
 <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <874jajcn9r.ffs@tglx>
 <PR3PR02MB6012EDF7EBA8045FBB03C434B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87msobb2dp.ffs@tglx>
 <PR3PR02MB6012D4B2D513F6FA9D29BE5EB3F12@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87bk4pbve8.ffs@tglx>
 <f3b909f3-de1d-4781-aa7a-1967abe24125@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b909f3-de1d-4781-aa7a-1967abe24125@kernel.dk>

Hello Tim,

On Tue, May 28, 2024 at 01:17:51PM -0600, Jens Axboe wrote:
> (Adding Damien, he's the ATA guy these days - leaving the below intact)
> 
> On 5/28/24 1:15 PM, Thomas Gleixner wrote:
> > Tim!
> > 
> > On Tue, May 28 2024 at 17:43, Tim Teichmann wrote:
> >> On 24/05/27 07:17pm, Thomas Gleixner wrote:
> >> I've just tested the fix you've provided in the previous email.
> >> The exact patches are attached to the ticket in the archlinux bugtracker[0].
> > 
> > Thanks! I will write a proper changelog and ship it.
> > 
> >> The error regarding CPU scheduling disappeared for both kernel verions[0].
> >> However, the ATA bus error still occurs.
> >>
> >> Also, I suppose that the ATA bus error is the same as the previous one,
> >> because the only value that changes in the exception message is SAct.
> >>
> >> This is the message of the ATA error before the patch:
> >>
> >>>> May 23 23:36:49 archlinux kernel: smpboot: x86: Booting SMP configuration:
> >>>> May 23 23:36:49 archlinux kernel: .... node  #0, CPUs:      #2 #4 #6
> >>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 2.55 No irq handler for vector
> >>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 4.55 No irq handler for vector
> >>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 6.55 No irq handler for vector
> >>>>
> >>>> ATA stuff:
> >>>>
> >>>> May 23 23:36:59 archlinux kernel: ata2.00: exception Emask 0x10 SAct 0x1fffe000 SErr 0x40d0002 action 0xe frozen
> >>>
> >>> That's probably just the fallout of the above.
> > 
> > It's in reality not related and I saw some other AHCI fallout fly by.
> > 
> >> And that's the message after the patch:
> >>
> >> [    4.877584] ata2.00: exception Emask 0x10 SAct 0x80000000 SErr 0x40d0002 action 0xe frozen
> >>
> >> The full dmesg outputs are in the attachments.
> > 
> > Cc'ed the AHCI people and left the info around for them.

We recently (kernel v6.9) enabled LPM for all AHCI controllers if:
-The AHCI controller reports that it supports LPM, and
-The drive reports that it supports LPM (DIPM), and
-CONFIG_SATA_MOBILE_LPM_POLICY=3, and
-The port is not defined as external in the per port PxCMD register, and
-The port is not defined as hotplug capable in the per port PxCMD register.

However, there appears to be some drives (usually cheap ones that we've never
heard about) that reports that they support DIPM, but when actually turning
it on, they stop working.

Looking at the dmesg, you seem to have two SATA drives:

> >> [    0.957220] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> >> [    0.957984] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> >> [    0.958027] ata3.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
> >> [    0.958069] ata2.00: ATA-11: Apacer AS340 120GB, AP612PE0, max UDMA/133


ata3 (TOSHIBA HDWD110) appears to work correctly.

ata2 (Apacer AS340 120GB) results in command timeouts and
"a change in device presence has been detected" being set in PxSERR.DIAG.X.

> >> [    2.964262] ata2.00: exception Emask 0x10 SAct 0x80 SErr 0x40d0002 action 0xe frozen
> >> [    2.964274] ata2.00: irq_stat 0x00000040, connection status changed
> >> [    2.964279] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
> >> [    2.964288] ata2.00: failed command: READ FPDMA QUEUED
> >> [    2.964291] ata2.00: cmd 60/08:38:80:ff:f1/00:00:0d:00:00/40 tag 7 ncq dma 4096 in
> >>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
> >> [    2.964307] ata2.00: status: { DRDY }
> >> [    2.964318] ata2: hard resetting link


Could you please try the following patch (quirk):

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c449d60d9bb9..24ebcad65b65 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4199,6 +4199,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
                                                ATA_HORKAGE_ZERO_AFTER_TRIM |
                                                ATA_HORKAGE_NOLPM },
 
+       /* Apacer models with LPM issues */
+       { "Apacer AS340*",              NULL,   ATA_HORKAGE_NOLPM },
+
        /* These specific Samsung models/firmware-revs do not handle LPM well */
        { "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
        { "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },



Kind regards,
Niklas

