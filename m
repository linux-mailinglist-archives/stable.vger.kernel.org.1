Return-Path: <stable+bounces-200727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77035CB30F6
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 14:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 137643004D0E
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF262D7DC3;
	Wed, 10 Dec 2025 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="JUendGhR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17B1E89C
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765374243; cv=none; b=LEyacDJ/El9msp4IdtVfEhcPHA3Mx0jMlMNNcpjl9aneJMUB0TFFgd1uGZyhtCTkaM+Lbrq2QHSb0LiwfrmZnsdOzGfXwcGvngl9YxromVrTEf6xw671smrtfxkAgQnOXGjCk8MWmhg0uZOnKwO1Pj7YrrtizZaSY2TQxUPlNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765374243; c=relaxed/simple;
	bh=GuM+APiDPr9e48rTQmVrItBOFGVB3BXlHw611KTw/Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wv8IOHffnDZweQG1Om/SmyuQrv1fXjy/QPjyo1CyxY5IO0P0csBG2KmFnUmSm7a8IuFZMEAljHWXSY8lUAU5jqIrzhe/4cDAf6ddmSWDc6HAli2+mlWku1aCEXRIWrX4mx72UPWpu8cQdqTO5MPkLVRC2u2uM2UttEVdh4NgouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=JUendGhR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b76b5afdf04so1120050366b.1
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 05:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765374240; x=1765979040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTLaTmFVHHTzWGQ9T5qmByyocpfMgznjqq+AvfsV2LY=;
        b=JUendGhRLtslLWtEcKisLZ/TOghl8RwjsN6wYPsqxsrfNV9CmlNE89hKqcUkNw0lbp
         OpQsUSATPcLPGGmAzPfjnXIhiqJUmr2lQNaCPQukGa/n55ozt4OI1T5jfh6Gs+PpyRvN
         dV4SzAMVZHk7OObIxEHB4YktXYGZHSW9dATMxIeU3fcIKlfiNABrSckG1PcCH0GSNVLN
         FHPyvYmv61ACwgGb+ZSrcerfh73YCzQ7BPI0btT08QTjCx8zJY3vgk+JmZdSOQFZ2gx1
         socMuqZpTSl/WkuTSVHgPXQG9rbZ8jWgHQ33TQGOe50ZfED6olTL1IRNkqqVmihJcSm/
         XJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765374240; x=1765979040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aTLaTmFVHHTzWGQ9T5qmByyocpfMgznjqq+AvfsV2LY=;
        b=HzbdFPdPIICSBx+6L3esSbvYDxzjvWXV04igKPha/aRbRVXhOow7WuqIfPe2Lt86Xt
         xPwl/O0gd3EmuYSAjOxVP7lQfr0xBuevnsLF6V2Zl/czEDLMDqVhsajQRfmXFd2s1HB4
         UrB4UjAzgfHGmtjhSlfQeD1LbIwAf/CiLq/6eo8qPbyqi0Z0rz6aiu4SGH5ZBp5HJ9Bm
         gIiUru4EPYlXzuaq1BG06BHZo8ihv8Q0NlRTXxJ2rb9aqQd3R7M714FdLzXRcDWmcEjE
         1oEhG+IOUaZcXmS2qAl0Noh7JHPw8DGTCKLlFnbqfxaRCxmcQuJWFFrf+LgKdrVTOM9u
         h6OA==
X-Gm-Message-State: AOJu0YzLiY+GYzA5rYiq6UC+q/LeYxlXVgV3mpETEeeEwn46VsEotZHJ
	b/5cWA1TkHrAeCCCmb/QeBKGy4z/Y9mqig0WGtba8GzoogUo46Ez18ZFFZ9OKQUQFOzVZAjJEq8
	ofCDnDmOZx+QgEL67wIFXOx5vGl1QfcYrR6FQBVi5XQ==
X-Gm-Gg: ASbGncvrIOvojTjOuLrq0oqDPL3tTYF2guhGmkD3RujF2xnRnEH+pQNiWRfq+G4m6dI
	2GvIL65A0ixNAzTfEaYoUOxjgMUGEBqjV6J59SXGN1+yrdkOI0DuU8i609lmOHSfyD49CI7hFGz
	jC9xaLmK/zA+l3uRpu9bF1C3AIHn8WAJFPjljt6Yy+DFTLjnq4SiAi3d+g0ljsUiaU3jxukrime
	h3X9Ku2sDczW9OiA2nkW7vm4Vitr3ujo73Pqd8CPJKpt2NjMI8vQXcwzih9RRtddYQcKyITQeC5
	jVZgmg==
X-Google-Smtp-Source: AGHT+IHvtVJSFJsmyCkxg0ppeP2eShf7CyJVRMpQ5SDFbZptqW8DOR5DKgVlDzllhxVIyhfcGmt25RM1UE/XUfN1RiY=
X-Received: by 2002:a17:907:6e87:b0:b73:4fd4:814f with SMTP id
 a640c23a62f3a-b7ce82ddccfmr258496066b.21.1765374240128; Wed, 10 Dec 2025
 05:44:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072947.850479903@linuxfoundation.org> <CAG=yYwm==BjqjJWtgc0+WzbiGTsKsHV3e4Lvk60fcartrrABDw@mail.gmail.com>
 <2025121046-satchel-concise-1077@gregkh>
In-Reply-To: <2025121046-satchel-concise-1077@gregkh>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 10 Dec 2025 19:13:22 +0530
X-Gm-Features: AQt7F2pb70410bF1kPgvWIQ_0HFOxEQcZ1i1TWdb6R7HcLPx6dIeqDxvlH0vD6E
Message-ID: <CAG=yYwm0bVzYoccKKcdheGOc-exuxVCPeXSftDixS68qZZ7W7w@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 6:17=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 10, 2025 at 04:22:21PM +0530, Jeffrin Thalakkottoor wrote:
> >  compiled and booted 6.17.12-rc1+
> > Version: AMD A4-4000 APU with Radeon(tm) HD Graphics
> >
> > sudo dmesg -l errr  shows  error
> >
> > j$sudo dmesg -l err
> > [   39.915487] Error: Driver 'pcspkr' is already registered, aborting..=
.
> > $
>
> Is ths new?  if so, can you bisect?

this is new related. Previous stable release err and warn disappeared
(i think i changed  .config)

can you give me a  step by step tutorial  for git bisect


t


--=20
software engineer
rajagiri school of engineering and technology

