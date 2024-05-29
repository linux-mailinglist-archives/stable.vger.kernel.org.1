Return-Path: <stable+bounces-47657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4F98D3E62
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 20:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FC31F23777
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213E1A38F4;
	Wed, 29 May 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xsct1ZJ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0015B990;
	Wed, 29 May 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007590; cv=none; b=kuDLMLsN8RAJkrnIYAQBRGH3G7W9E9jjL8iGjCzWwpPyTct3pB+yz/9BMeFAel952QHUrr3gGpj+M1hob796VEWePt/ivvxaSZeFtEeyzGjR4+wAMEn91Iz/WV/B7Gcce4YuF6czSw2D6itz7LLEUofZiU17wGibCrG1cwnhKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007590; c=relaxed/simple;
	bh=xSGo4qhJT8Vc7QZwuMSfPbFgntWQs7o0u+3tkSo/IjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgMbOqbblx3rJBiVybtY1a+f1saTqdCX6Eo+nT5xT6Xp2Oy0DXJYXzh+aZ45RmJdy2/t6u9o0nqaUdPlMCQWfNi/s2gOItEHvurJMXxMKJZ+9Ra8yoGwEi3xeNkZDzliFd+3dmQ+zXJa8+t/twsQSgtrvIaXplliXsPafJ/qP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xsct1ZJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E277C113CC;
	Wed, 29 May 2024 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717007590;
	bh=xSGo4qhJT8Vc7QZwuMSfPbFgntWQs7o0u+3tkSo/IjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xsct1ZJ296mVzd5Bx2cjuJH+KC5VHKNKvXSF1wEc4SNTk55CVKQxfbhbKI8WobVEL
	 Jp5dgoDnZjuzokdATQJfHv9efrAFrrct21tOPDb4iVHehHfa1M1vC8VxlxwibZAFTe
	 aU2A0YE/3DyrJxncovGEgDxzeHTkFOSTO/5BRTsFiowbhauPwVWUUaYoEqiIubVgPb
	 XWFgVaNgCliYHmIcGnqO66qrSBmpX1Z30SIOxlC8xpbNoi7Cqyv4Aih3aP2gqAvZg8
	 pjNwwI7/SfUzxHTfXquHl7HkpSYjbK9+mYuhKr2tpYlinkyXz8gDxSVSrlE056CHzm
	 cTM3Sf2SFWozA==
Date: Wed, 29 May 2024 20:33:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tim Teichmann <teichmanntim@outlook.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev,
	x86@kernel.org, stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
Message-ID: <Zld03FTNQ5q5uQyN@ryzen.lan>
References: <87h6ejd0wt.ffs@tglx>
 <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <874jajcn9r.ffs@tglx>
 <PR3PR02MB6012EDF7EBA8045FBB03C434B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87msobb2dp.ffs@tglx>
 <PR3PR02MB6012D4B2D513F6FA9D29BE5EB3F12@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87bk4pbve8.ffs@tglx>
 <f3b909f3-de1d-4781-aa7a-1967abe24125@kernel.dk>
 <ZlY8SbGVMHho-dLz@ryzen.lan>
 <PR3PR02MB60127B753B3B4BA69A737BBDB3F22@PR3PR02MB6012.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3PR02MB60127B753B3B4BA69A737BBDB3F22@PR3PR02MB6012.eurprd02.prod.outlook.com>

On Wed, May 29, 2024 at 03:02:45PM +0200, Tim Teichmann wrote:
> Hello Niklas,
> 
> > ata3 (TOSHIBA HDWD110) appears to work correctly.
> > 
> > ata2 (Apacer AS340 120GB) results in command timeouts and
> > "a change in device presence has been detected" being set in PxSERR.DIAG.X.
> > 
> > > >> [    2.964262] ata2.00: exception Emask 0x10 SAct 0x80 SErr 0x40d0002 action 0xe frozen
> > > >> [    2.964274] ata2.00: irq_stat 0x00000040, connection status changed
> > > >> [    2.964279] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
> > > >> [    2.964288] ata2.00: failed command: READ FPDMA QUEUED
> > > >> [    2.964291] ata2.00: cmd 60/08:38:80:ff:f1/00:00:0d:00:00/40 tag 7 ncq dma 4096 in
> > > >>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
> > > >> [    2.964307] ata2.00: status: { DRDY }
> > > >> [    2.964318] ata2: hard resetting link
> > 
> > 
> > Could you please try the following patch (quirk):
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index c449d60d9bb9..24ebcad65b65 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4199,6 +4199,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
> >                                                 ATA_HORKAGE_ZERO_AFTER_TRIM |
> >                                                 ATA_HORKAGE_NOLPM },
> >  
> > +       /* Apacer models with LPM issues */
> > +       { "Apacer AS340*",              NULL,   ATA_HORKAGE_NOLPM },
> > +
> >         /* These specific Samsung models/firmware-revs do not handle LPM well */
> >         { "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
> >         { "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },
> > 
> > 
> > 
> > Kind regards,
> > Niklas
> 
> I've just tested the patch you've provided [0] and it works without
> throwing ATA exceptions.
> 
> The full dmesg output is attached below.
> 

Thank you Tim.


I intend to send out a real patch for this,
but before I do could you please run:

$ hdparm -I /dev/sdX

against both your SATA drives and paste the output.

(I just want to make sure that the device actually advertizes
some kind of power management support.)


Kind regards,
Niklas

