Return-Path: <stable+bounces-72954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E696ADF3
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 03:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E518D1C244D9
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 01:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD01CC153;
	Wed,  4 Sep 2024 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7hM7RgA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A5A567D;
	Wed,  4 Sep 2024 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413654; cv=none; b=CP7hG3zxo1uUtiS9wtEijdFUZdT8ZUTOesoSRrntZUZq85ARJD9mSDrTtJKMoXv8sybopBDv3ABJBBXAmkVJyNPyaZiF023YKCKLVZuijLQ1pnJYwITOis2ATMayT8SDyi5fD56vdU7ERfJTNYPipN0KCLIZGv2aZb7mIM2l3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413654; c=relaxed/simple;
	bh=93FgyLKkVo2N1tBHkMC3aUUtyplqFSBZGLIS2ASQJQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIgwOivaQyagjPLKJDEExfyyCW3sjtK6NKZ7amHvuszXSAnkbTj/gjyFGf4yxYR3uNZ92/bBmSuzjJacxFfYW8fw6Afv5O9IB0Ny/mI6cRBZ5f9UwJzy/YvRWqYQCGIt38V6niMaUWSEUN/7fk0JK0TdmIPD32ea368ZYcaoVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7hM7RgA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c180d123so1944224f8f.3;
        Tue, 03 Sep 2024 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725413651; x=1726018451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93FgyLKkVo2N1tBHkMC3aUUtyplqFSBZGLIS2ASQJQE=;
        b=U7hM7RgA2IutSs23yRxebEsYpVtfH/yAFBZxg9ypylpqGSgdIUIWV13Zh1fAt62cEy
         6IMIpRtr9Ki0IEEiPGJ6DSlv7d2Rau2L9B4uJYBc5uc2B3cbLstjKBF493A1pyk1wdia
         0SFXiAPu2A/d0xtzsCLdU3R/JViY4uzb/OvfEexc7WmGL3lwmPZ4y2OGySf00nNBmlVl
         C1XEUe3adqY7AukE7dcU3pvxLo5QWCapigJY8T25/0U3luz29cOUQBi1t300/vbMXEVo
         GZXqJBiBRHlCdVVVHNPj9yNqSZrYIDRKpAP3EQ7jnx7oPNC9i5Li1SpmhfkAQGG/YxSM
         Lw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725413651; x=1726018451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93FgyLKkVo2N1tBHkMC3aUUtyplqFSBZGLIS2ASQJQE=;
        b=KLnW5qAtw5WzD8qxrjjED5ZD/wC8Hv+QH8uTNBuMEICFfQ4OLHIf0rPl44TOZTtumB
         aJbt52oX6qzqjEi87qLTFsQeInA098vPGQqKkn7x+C77BZqBix1/ZEPfvJv5Jvw47Y5f
         zfkOnRzt4HMy1P2/wCv6Itqu3lxbmBXFeOm+QmwP9CZVBYLBbLsKWzLHdwlQC32wkFuD
         vJ1Y1VU1f3BnvxeM1cPQxhlUPm9oSI+86HcW9fGlcJy2S+Snum1Ny1cB+Vf/MAkKTFLq
         klpUOVecdh+y/Bln3LK7BCWmX203eYDlOqZwlHBIeOelshyBl9uyWc5FJoUMAxbKdrNx
         SSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+VmJsj6FyYtlgydPPHO1Id9cEez0SpmQNHSq5ypB6aHZORMxLOX6Y6zjLHHHCMRdeaeydae2u@vger.kernel.org, AJvYcCUg27Z7UtUjLoFwOmLaBYyr7qfJivomAcwmhAn0T9pQbvmRujfmCX+tsvoJ1ZllXpmSSID3tz+H2Dab3Jg=@vger.kernel.org, AJvYcCVf+ejGX4AxirnhZRSO8eDipg9dNPsDdJlnZRaMlnnvT12+xzR+2ltnCGRMsz8dic2UZotkYfytZkL4@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJvcJXc0OOEzfhwaebqfd0j6/BucVYWesTk/1U7x26T1lzPDo
	FILWp+bePfHMaDxQxMFE0Cmy5rVAN83eF5PA1YN1BOYfIVA3ctrNwoii7osHbxCn2SvC9Db0MYQ
	yF8ft4rqYjzf3W6mvxTp+OkRLx6A=
X-Google-Smtp-Source: AGHT+IG9uqGECrHc4951OxM9JY1Wh54YGaI8TOge11mwJKOFkewOsNpY+jxpyh1CbkS6/cfXB5GcYuoGQob6XsHn+KA=
X-Received: by 2002:a05:6000:1886:b0:376:65fc:6cbf with SMTP id
 ffacd0b85a97d-37665fc6d98mr3028566f8f.23.1725413651088; Tue, 03 Sep 2024
 18:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729022316.92219-1-andrey.konovalov@linux.dev>
 <CA+fCnZc7qVTmH2neiCn3T44+C-CCyxfCKNc0FP3F9Cu0oKtBRQ@mail.gmail.com> <2024090332-whomever-careless-5b7d@gregkh>
In-Reply-To: <2024090332-whomever-careless-5b7d@gregkh>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 4 Sep 2024 03:34:00 +0200
Message-ID: <CA+fCnZdCwpxc4gL7FeUEJ0cbMESe3d2tRe-NTCyDH9uZTR_tZQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: dummy_hcd: execute hrtimer callback in
 softirq context
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Marcello Sylvester Bauer <sylv@sylv.io>, 
	Dmitry Vyukov <dvyukov@google.com>, Aleksandr Nogikh <nogikh@google.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com, 
	syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:09=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> > Hi Greg,
> >
> > Could you pick up either this or Marcello's patch
> > (https://lkml.org/lkml/2024/6/26/969)? In case they got lost.
>
> Both are lost now, (and please use lore.kernel.org, not lkml.org), can
> you resend the one that you wish to see accepted?

Done: https://lore.kernel.org/linux-usb/20240904013051.4409-1-andrey.konova=
lov@linux.dev/T/#u

Thanks!

