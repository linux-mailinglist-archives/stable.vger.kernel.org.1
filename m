Return-Path: <stable+bounces-254158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OERTHOVfFGqgMwcAu9opvQ
	(envelope-from <stable+bounces-254158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:42:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D33055CBD2C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D129A3029745
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF93F164A;
	Mon, 25 May 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfdu9Cqw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECD3F076F
	for <stable@vger.kernel.org>; Mon, 25 May 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720124; cv=pass; b=X9Sv8EtOaAqTtMRwuaGqYVy0bfizEna0D92PnI5R1wjgh6SD1AKmrb/CfGFk/VVmdDLibCAmlGKA9xNtK8UAZ08ctWe08LNj4cLjUnZkOHKmoaKokHyH+hMGJeFZWN3+XTPa8gvGP2y26jtFYB+qsi4XR28Ujy8nN/44e6uSTdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720124; c=relaxed/simple;
	bh=YTuMnBMg3svQrVT3iPgZ+7XfrkHVUtrtijddiVruEqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0nrE0zuOLAuBhzbSshVolvzSOFAUjrxYlCZO6cHo43Ue+UbksFVmHy/Ly5AbQZpT2frhDKuEBdRXDaGfjRLqvfw7YtsAYVKZiggoWVCFM8gYv2UnD2MZs1KoCvnsZ44Cc1OmSOxV+Kmnk0MVcYJczVE5eGIceYI0tKbWo+s7u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfdu9Cqw; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e568ab0bc5so10498448a34.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 07:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779720122; cv=none;
        d=google.com; s=arc-20240605;
        b=MmMcGAUzkizruvLVo1t3T8Xr+YOp4PROAoSzksC3hUQYSr2o5k+vfCTX3+rcRjU/PL
         b+6bnm6oPGNtSbDdyxlcYOkigx9vJDOrzPj3WwW6A/l3Mp+EeQ1qI4p9j47kIh0lzIH6
         C62hkqwqN2EWO1oupMtZBLb+tX9/smYhihWXFtuAgpzWsIPKKTHdDx4hEYhQj+NLvixY
         LiKizY6XrsaL6Zx+NFNweSO3h1eneAQ7awFFVPCQvi5r0PcqIZjKD7Q1WO84bQXt7Tg/
         akr9i+IF+qxI6C1iAFRfIZXXIJVzHklmZYTIriPwp3VAqz+fgx7VfhwL1vm0bSYp77gk
         r3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xMBnzwzJz296KjH5+A4Xajrymf2+B5pQp3Q83aozziE=;
        fh=3dGVHSW8Pufo7V9+zCsKv9jcWppcmgrJogQBGXDRHlg=;
        b=JO/xkjJ/Zt9C7yZ08xSaZn0h7kZ2FpfONoWxjKVL3fsM3uclQYULwQcVbqjF81QqyN
         RUCN/N9nzqGoCW5eV+Hd3w7TJ3TGglr1rJmQS3GcqTWOU6yueZFGBpXKfFZhshfs3wbR
         n6lsD27Z4mf37GwGzXTN/7qA6zMRs8PfectzSgpx9mMF0ejjN2jDyqRnDDaWVE1mrlJn
         TTX5OIC/NhERo8gcnngdiAcyjHGk/nAkwu5SQfnWjqcnxbpjXELwEmQmjzVoNMZIDxwq
         w6g4TVsgvMOaUvsf1WcHyl1b7Rpt/xtS8mGirUrI3O4BTNDffpIdtJBkJ674EP48Pcza
         IqWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779720122; x=1780324922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMBnzwzJz296KjH5+A4Xajrymf2+B5pQp3Q83aozziE=;
        b=Sfdu9CqwG8xA0yypJU9OVGTEITpds9hry5IZgV2XYZLqXUjuptGJ7dADPV/f9afvKX
         4ETAw5AozSm3uhCXm+bFf9Ls+fsjTA3y+1Tir30tLuUviGNedBfgDLrnlXX97njkqDM8
         1rLaO8NbIPVsTG7DBx1sgV7stP41XO8FM0LUY1zk7iubbYrjZANresBZXYhhVob4Bt4T
         6NeTW6myWO2lR6uWmdHSjrQxvW2WBt5CVUm0TWHV1Gza+YlH9NOTvGhmrwvf/puvo7iT
         2cHWsC1/tSziDDL5uvoNqosx5ucX69WZc6D9pu/s2oLqvm9S5fnFdfBzQJZaBZkc+qle
         MV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779720122; x=1780324922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xMBnzwzJz296KjH5+A4Xajrymf2+B5pQp3Q83aozziE=;
        b=o+F3Tm4S3tYilC9cGNvaQD6R0M8/HgIQG5+L8d/UXoN406WCokuYXlLEU5HN5hdd3D
         7hFRJ8qADG5xi3DOIN9HjSbf315OqmqrnupAcgC/uvStRmz+dgBDSvifzF54SU88MZsp
         Sj9OvRkz6gsE0MT/UKkxyMG9JNDcqQM4ZX6xx6e8U0htEvFzLFXUKrm8FyIcNTZ4bPHW
         FrwStvMyB3uE43K3ZWAwag4FHmaf/0ICt0BLwWI2c+EBB3Thjvnn/JO+8io3p7VK22rb
         v36IrtgbE0HIjZtC+3PrqRQ1klxQurlM3xINUepETY4xw2wv4kIVtQo9tONUfh3JNuV2
         Ol+g==
X-Forwarded-Encrypted: i=1; AFNElJ8UOEja6h041mqAKH75pPC0fIIbIfJMtmScuyS09UWa8opJW7CXFV8d5DAO1yn11YtCTNAC7lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/ZD9i7KaDOgB9qbZ/XWwoXSstmxVw3PCUcFV9UKVTt4y7Xwf
	Ng4M7a7FutpgaffEQi7R8a3yS7NgAzm2Wd1XkYZAKLTHlFw8OUbiEnJrAyyAgZZd31dxZvC2vAM
	n8QatyRNdcJ9N/V0tIeCByEssel3tHxqaDjkJFFsXPg==
X-Gm-Gg: Acq92OH12VuUyOI+x44MSp/0AKxO/WA+vJuTMOQtBo4fbuiQKGn3zNzrRguC5tS6Qmk
	DhYqEySrqMiutxde5qsEIV8Wp/6gsiBcgHWmF2NUIF+Mo+3W4ABqW5e+A08d2TqMhfnsckQksIB
	AsdYBo/aXEn6RSNmB/1RH8IWlP46u+BZgjOazoBQTISVgZvzOSRZxUOpqRKls7VuinsIitBiL4k
	3/+Ec+oHk4VsRzUfhMwhtvu0aXIZvat6l7oCx4ByJuSejxD28Eff+V/jHcWrRTCQmnBu4CppSjC
	ZgbHh8OHfcJW3IzgLclEaw/pdOO5bOVuTPbXrVOD4vS+kT1ArQkE6Is/7505e6wYEEtVHtsb2A=
	=
X-Received: by 2002:a05:6830:668c:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7e5ffe89160mr7589477a34.6.1779720121820; Mon, 25 May 2026
 07:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADgB2mF95N09=gOvBZ+4ePSQ-0wCynx-rbu=aiyQecT=iDdyRw@mail.gmail.com>
 <2026052525-devotee-reclaim-7673@gregkh>
In-Reply-To: <2026052525-devotee-reclaim-7673@gregkh>
From: Adrian Korwel <adriank20047@gmail.com>
Date: Mon, 25 May 2026 09:41:50 -0500
X-Gm-Features: AVHnY4I58R9esu4tmdCiHqkJeIwjwKnMWVBW3nbv3naG6fYsTOTcmGjmyyyYvZM
Message-ID: <CADgB2mFhLm8AUvARc3OigPDWZ1PUy+=+WJDywugrQDH3-Vhd4A@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: io_ti: fix heap overflows in
 get_manuf_info() and build_i2c_fw_hdr()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, johan@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254158-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D33055CBD2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 26, 2026 at 12:57AM, Greg KH wrote:
> Should be 2 patches, right?
> What tool found and fixed these issues?
> Your patch is corrupted and can not be applied :(

Apologies for the issues. I will send a v2 as two separate patches.

These issues were found by manual code review =E2=80=94 auditing USB serial
drivers for unvalidated device-controlled length fields used in
kmalloc or memcpy without bounds checking against the destination
buffer size.

No automated tool was involved.

On Mon, May 25, 2026 at 12:57=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sun, May 24, 2026 at 09:20:51PM -0500, Adrian Korwel wrote:
> > Two heap overflows exist in this driver:
> >
> > 1. get_manuf_info() reads le16_to_cpu(rom_desc->Size) bytes from the
> >    device I2C EEPROM into a buffer allocated with kmalloc_obj(), which
> >    is sizeof(struct edge_ti_manuf_descriptor) =3D 10 bytes.
> >
> >    The Size field comes from the device and is only validated to fit
> >    within TI_MAX_I2C_SIZE (16384 bytes), not against the destination
> >    buffer size. A malicious USB device can therefore set Size to any
> >    value up to 16383, causing a heap overflow of up to 16373 bytes
> >    when plugged into a host running this driver.
> >
> >    valid_csum() is called after read_rom() and also iterates
> >    buffer[0..Size-1], compounding the out-of-bounds access.
> >
> >    Fix by rejecting descriptors larger than the destination struct
> >    before calling read_rom().
> >
> > 2. build_i2c_fw_hdr() allocates a fixed-size buffer of
> >    (16*1024 - 512) + sizeof(struct ti_i2c_firmware_rec) bytes, then
> >    copies le16_to_cpu(img_header->Length) bytes into it without
> >    validating that Length fits within the available space after the
> >    firmware record header. img_header->Length is a __le16 from the
> >    firmware file and can be up to 65535. check_fw_sanity() validates
> >    the total firmware size but not img_header->Length specifically.
>
> Should be 2 patches, right?
>
> >
> >    Fix by rejecting images where img_header->Length exceeds the
> >    available destination space.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
>
> What tool found and fixed these issues?
>
> > ---
> >  drivers/usb/serial/io_ti.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
> > index cb55370e036f..afe29fdf9536 100644
> > --- a/drivers/usb/serial/io_ti.c
> > +++ b/drivers/usb/serial/io_ti.c
> > @@ -773,6 +773,12 @@ static int get_manuf_info(struct edgeport_serial
> > *serial, u8 *buffer)
> >         }
> >
> >         /* Read the descriptor data */
> > +       if (le16_to_cpu(rom_desc->Size) > sizeof(struct
> > edge_ti_manuf_descriptor)) {
>
> Your patch is corrupted and can not be applied :(
>
> thanks,
>
> greg k-h

