Return-Path: <stable+bounces-45485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92618CA9CB
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5033A1F2132A
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEE25028A;
	Tue, 21 May 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR3i1CBv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2315EA2;
	Tue, 21 May 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279343; cv=none; b=WjXAyB0y2tqcwCO9hV8Y1QSTreuv06R93htdslLslfyc251zkkZ+Ae6ECZreD21rSjn1x0FkNJhLwTPHhAGkYaBrQ++WK9xxAG53WdXA9xtp/Zvw3kDZINZQ2jzLDVp09cLQWzldDpbtA+eiZlAX3IrnEMbTdIS8dNAx6WmbFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279343; c=relaxed/simple;
	bh=03NnX/gPP5q80BC4asuBpkqYVv98rLURX/ei/Ofcp+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH3bDPeQEYc27QX1avUOiKRQhwLafKD4wuJyLwp12vgvSPV9Wt4bVySLMKm4Q7GOWCWCB54fV4QXLb2tuqlOz0CVliYbyBDL7Ty13FeAmzLpzwaYOOIldEI9RwNi73WPC9CfA1H2aT3iA7/8TkieBaJtNWcq1mgVjj3jIS6yuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR3i1CBv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ecd9a81966so24502275ad.0;
        Tue, 21 May 2024 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716279340; x=1716884140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fOkVqi2qkIsFMvRkB9KtVo2EQjUhNueVGG8DYcj/Qw=;
        b=SR3i1CBvX+PLCUCHCMpzu9fw8l7+17tfeV+M+CFTB3LHSlsgEI9XkhjqugNLzpEBfG
         96gDbgf94uFmZNfpjBCxzxxqUQ0i3875WwRWVRit2HAsWwmwe2kdGvUqocbWkp3Ne57h
         T36jO1Z5gVjHW0n7VnL2MS/WZWfFg+5D08BLzxl1RMadP3Vn5N+67Wxn1hfgebJ99fip
         ocbObI4EZ7ip2UnZVE0ZFE7gL84Qd7nGHKNFNCM6itjHr6LblGjDNHWTeZsMviSKYq2z
         RVKeoFU38l3hNJrpv1xEfUJsPfN07Fku43LUkLH97aTuwWB5Yrz+RH/lhqt8omRbX02M
         AHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716279340; x=1716884140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fOkVqi2qkIsFMvRkB9KtVo2EQjUhNueVGG8DYcj/Qw=;
        b=kpqAd44AooVG5lMlNl8uS/gLxurb04witapOodGc7kmrI/k6DEDId/D3LmkqkUOGoO
         r5JGu6+JNRNNrwQnDq3gIbCBjKFV6Z7evJhUffhpdXQrkZHj/Li5GXVfpAbfUmJvEhfo
         Dx31FRnnxUjxvb6pX4LB5aG4HAXSJPIZTLq6fqI49rc7MYmBqwaDigYQQJAoIiwPWqis
         SaE5MtBaWbN+hybIYVkbHHiE88zkMYXoW93lLN4uDHSbIlmyZ2EOU9+XRaE4AQzs5Idy
         jZUywXRJPJ739cLT3h/rcZCPjJSck92fzcW491IoaukPv5/mVupKtPVfZge/jdp93foS
         DVpA==
X-Forwarded-Encrypted: i=1; AJvYcCVF1qLW8Cz4ahq2zBXt+b+u7onV+v8S2nksa860EOUYCZtnIehIIQPQhFqMgERG+yrLVJk7Rw3fmB5NfwMi/0ZasWBmlmhmfzT40GdqYIk6Mf5IgCQh3RDBvDPz2sGYN+iwo4XVFiMNkF+9jnSZDvRXethOy0VX++DBhDqsOxMo
X-Gm-Message-State: AOJu0YzjyEiWZvXfmXsNL7j3yKwnHZ0ryIfJvpvOWdQUUqtPf8IZLm63
	wxNMSy8G9lOblmYFDxdwCGsDXERH9/MvZ0ldTReFxVcxhd/95el05Gp67ma+JTPyZoTpv817yf4
	B41c44J69RpQtuGrP3PIgcL8XlYc=
X-Google-Smtp-Source: AGHT+IFLaQW9QKaaME5VziwLlJJd6X1Hm84dCjjfR3MMubkylS+O4mlXM2VIdqdXQQPwKtUSwl0vHOXPPTOvjnNnkeI=
X-Received: by 2002:a17:902:c406:b0:1f2:ef8f:8573 with SMTP id
 d9443c01a7336-1f2ef8f8ce7mr92016585ad.0.1716279339681; Tue, 21 May 2024
 01:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info> <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com> <61-664b6880-3-6826fc80@79948770>
 <20240520162100.GI1421138@black.fi.intel.com> <5d-664b8000-d-70f82e80@161590144>
 <CAHe5sWazL96zPa-v9S515ciE46JLZ1ROL7gmGikfn-vhUoDaZg@mail.gmail.com> <20240521051151.GK1421138@black.fi.intel.com>
In-Reply-To: <20240521051151.GK1421138@black.fi.intel.com>
From: Gia <giacomo.gio@gmail.com>
Date: Tue, 21 May 2024 10:15:28 +0200
Message-ID: <CAHe5sWb7kHurBvu6JC6OgXZm9mSg5a2W2XK9L8gCygYaFZz7JQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>, 
	Mario Limonciello <mario.limonciello@amd.com>, Christian Heusel <christian@heusel.eu>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kernel@micha.zone" <kernel@micha.zone>, 
	Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "S, Sanath" <Sanath.S@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here you go:

0x0080 0x003c01c0 0b00000000 00111100 00000001 11000000 .... LANE_ADP_CS_0
  [00:07]       0xc0 Next Capability Pointer
  [08:15]        0x1 Capability ID
  [16:19]        0xc Supported Link Speeds
  [20:21]        0x3 Supported Link Widths (SLW)
  [22:23]        0x0 Gen 4 Asymmetric Support (G4AS)
  [26:26]        0x0 CL0s Support
  [27:27]        0x0 CL1 Support
  [28:28]        0x0 CL2 Support
0x0081 0x0828003c 0b00001000 00101000 00000000 00111100 .... LANE_ADP_CS_1
  [00:03]        0xc Target Link Speed =E2=86=92 Router shall attempt Gen 3=
 speed
  [04:05]        0x3 Target Link Width =E2=86=92 Establish a Symmetric Link
  [06:07]        0x0 Target Asymmetric Link =E2=86=92 Establish Symmetric L=
ink
  [10:10]        0x0 CL0s Enable
  [11:11]        0x0 CL1 Enable
  [12:12]        0x0 CL2 Enable
  [14:14]        0x0 Lane Disable (LD)
  [15:15]        0x0 Lane Bonding (LB)
  [16:19]        0x8 Current Link Speed =E2=86=92 Gen 2
  [20:25]        0x2 Negotiated Link Width =E2=86=92 Symmetric Link (x2)
  [26:29]        0x2 Adapter State =E2=86=92 CL0
  [30:30]        0x0 PM Secondary (PMS)

On Tue, May 21, 2024 at 7:11=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, May 20, 2024 at 07:30:28PM +0200, Gia wrote:
> > In my case I use the official Thunderbolt cable that came with my
> > CalDigit TS3 Plus and yet the log - attached in a previous email -
> > says current link speed 10.0 Gb/s. I just tried a good quality USB4
> > cable too and nothing changed.
>
> I will take a look at your logs today but in the meantime can you run
> following command on the system with the dock connected?
>
>   # tbdump -r 0 -a 1 -vv -N 2 LANE_ADP_CS_0
>
> Here tbdump comes from https://github.com/intel/tbtools. It should be
> pretty straighforward to build but let me know if any issues
> (unfortunately there is no binary package available at this time).
>
> The '-a 1' should match the adapter the dock is connected. You can get
> it for instance like this (this is an example from my system):
>
>   # tblist
>   Domain 0 Route 0: 8087:7eb2 Intel Gen14
>   Domain 0 Route 1: 003d:0011 CalDigit, Inc. TS3 Plus
>   Domain 1 Route 0: 8087:7eb2 Intel Gen14
>
> Here the CalDigit has "Route 1" so it means I use "-a 1" above. It could
> be also "Domain 0 Route 3" in which case replace the "-a 1" with "-a 3".
>
> This command should dump two lane adapter registers LANE_ADP_CS_0/1 that
> show the link capabilities.

