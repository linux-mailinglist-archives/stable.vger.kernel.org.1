Return-Path: <stable+bounces-45484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954AC8CA9A7
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06BD8B222CD
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84354663;
	Tue, 21 May 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a57UL3If"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2A2209F;
	Tue, 21 May 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278857; cv=none; b=fMnNZa8HOtusXGX+vwGZrxM4F9PJ2SHJmV70zG0d997+SFC3IKVFpjrTCnHHo1QIEgYOev+dLNwbRUiB4SYZ888qrz5u9AMlZksi0xHl/KZVgDxrzsngVcmNC2SmCSC2lXIQ9W7H/AygDeuNK71C+QmkZah/uLsLdVrTCtqdhCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278857; c=relaxed/simple;
	bh=hBUirWutusPtAd5yaIQhJwK+OZj1KlZPuozs+O8z/cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEK6ezKTTy0B0CW/LafV5oTKylFvUrMujQfaNshkAyGlkbZpHunuUswzKi838n9UBBAchiW2Mbqw2LfeWAS44XIaZZ9+IFvOgA18Uaeu6UWA+CELX1ulVotuyefNQSfM5AJGn8/LN8IrwCF4P3nqaQf2Wf5p5CGW2/6fVUbzGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a57UL3If; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-663d2e6a3d7so1896000a12.0;
        Tue, 21 May 2024 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716278855; x=1716883655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBUirWutusPtAd5yaIQhJwK+OZj1KlZPuozs+O8z/cw=;
        b=a57UL3If20IgzWKcpBuzOXj7JubOgF7gAdPHkfC/otkKm17oXIhhUNiFqnX0k6sNAA
         f828wXAeWgt0ffT/sYV9VmUKtwxoBrauijsvKHd3zCDgy3IVutPteyBsvJ+ySfam9dOG
         PRi0vuoCxmRHtCdaB2HputIKzNJDCQPJALaVUmZvLnVfsF8aTd459JEUQ5kCse1a240O
         jKBeq2zxz82BGkh5Uv+xyADyWvAyojeTJ7HVciiAhrM/zITg8I2n3zmltTOyT37HIx+l
         BRE6al1xOq70dQgZb3jQ96tHJ6Kz9Zt2XF9ZC8ZQ5YRoD3gtZ/J3fKh9Jhmva7aMfseJ
         aHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716278855; x=1716883655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBUirWutusPtAd5yaIQhJwK+OZj1KlZPuozs+O8z/cw=;
        b=iz3BF4GiVexPELyM+XSHsoK/0O1KKbNofgJMc9tc7bI/bmD9az+be5UH3cf/Qp7ikS
         3y6TSq/L5qLFy2LLTmstuFtf3M2qb50MWSm2HMgNh9RiJbqmDk9QVXPUpQBYG7yQxKWY
         W1R6ZULcH45EN3GcviTIJZ7nlDsL+tdfMDbvnvwB3QQPz4kzjlQ3t1EgfnQ83vaazYwb
         ZjxKASGnghXo/Sk1wy3+VgU3MFauVmlMRplduDhs5YgDivHNwq8ELtMDzSVlHNJHDHcm
         OaCJDSBSuCoK2fCGjfGZWxtXAtPa2zPjkNrYDzv8vJx5NV5DgTc8dmQQMNCKfSlpDw9z
         VxPA==
X-Forwarded-Encrypted: i=1; AJvYcCU//mHtqXmqVocMYnZ5Re7ZGF8QL4SOxrHAXHpJ6D7nOTXilHQIegQEIp/DJyD2PycI0ou61xDOe6yFUsWX6dNmcjtd6xNqpJDRZRO0MV03tXrb3cFasB4DwOS7tNH7F11TRaov5CzkuNE7mhfn3OuXiDIlNkvqxXe20FH9n47b
X-Gm-Message-State: AOJu0YzoxFiDBNRrnUTpSUmQ24skPoMe7BF39OCv0dSTrlWo6LUa/C7n
	SL8rli7cFFPo8PVM9VRknN4aGDEbk1bR9/o3bB93PurZXmCQsNb9wbOcX5e4DO3eWtwxfedYE95
	nFvRTbLII/6UlOVicQv/voScs7fItX7GZFz8=
X-Google-Smtp-Source: AGHT+IGmfAeYbPUIkVmO8kZCcRcccTLZauVNvcfzcB7SNd4lIdVN8vxwNDRATuv964jxZEOekKjrWFp08NKB5cRA558=
X-Received: by 2002:a17:90a:4a88:b0:2b2:195a:d7bd with SMTP id
 98e67ed59e1d1-2bd60352ae4mr10916962a91.2.1716278855107; Tue, 21 May 2024
 01:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info> <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com> <CAHe5sWY_YJsyiuwf2TsfRTS9AoGoYh4+UxkkZZ0G9z2pXfbnzg@mail.gmail.com>
 <20240521051525.GL1421138@black.fi.intel.com>
In-Reply-To: <20240521051525.GL1421138@black.fi.intel.com>
From: Gia <giacomo.gio@gmail.com>
Date: Tue, 21 May 2024 10:07:23 +0200
Message-ID: <CAHe5sWY3P7AopLqwaeXSO7n-SFwEZom+MfWpLKGmbuA7L=VdmA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Christian Heusel <christian@heusel.eu>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kernel@micha.zone" <kernel@micha.zone>, 
	Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>, 
	"S, Sanath" <Sanath.S@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Mika,

Here you have the output of sudo journalctl -k without enabling the
kernel option "pcie_aspm=3Doff": https://codeshare.io/7JPgpE. Without
"pcie_aspm=3Doff", "thunderbolt.host_reset=3Dfalse" is not needed, my
thunderbolt dock does work. I also connected a 4k monitor to the
thunderbolt dock thinking it could provide more data.

I'm almost sure I used this option when I set up this system because
it solved some issues with system suspending, but it happened many
months ago.



On Tue, May 21, 2024 at 7:15=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, May 20, 2024 at 05:57:42PM +0200, Gia wrote:
> > Hi Mario,
> >
> > In my case in both cases the value for:
> >
> > $ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection
> >
> > is 0.
> >
> > Output of sudo journalctl -k with kernel option thunderbolt.dyndbg=3D+p=
:
> > https://codeshare.io/qAXLoj
> >
> > Output of sudo dmesg with kernel option thunderbolt.dyndbg=3D+p:
> > https://codeshare.io/zlPgRb
>
> I see you have "pcie_aspm=3Doff" in the kernel command line. That kind of
> affects things. Can you drop that and see if it changes anything? And
> also provide a new full dmesg with "thunderbolt.dyndbg=3D+p" in the
> command line (dropping pcie_aspm_off)?
>
> Also is there any particular reason you have it there?

