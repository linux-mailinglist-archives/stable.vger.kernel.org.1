Return-Path: <stable+bounces-154560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38572ADDAE6
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B373BC50D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7E22ACF3;
	Tue, 17 Jun 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W42PiBxT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE223BBF2
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182873; cv=none; b=To6EmkwAKrQibYpwB/00CZ1yyIguczewNkbilt2HFSLIAn3/ZSnLpw0kseu+4elQ7x3JIcua62xD+eqRH8PO5XwM3V2miw2S34tWCYfq5GcNTg/uEoCZeHvGtl9JUrm+hudad1hV1sGkX+CkVm/GovT1aB7QpVx++J/CQt40Spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182873; c=relaxed/simple;
	bh=937SNCtRoVW7fSI7BjOUvEicfHLqvBS+3CUCFUdUKNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7B36mV7wzChrF2MX+ZBL/NDiVqa/zsaO2bJWjeCmxRmPsj/I0ubPvBR5geFTNADoIQZxJA4c4In0K+TPbq01S9stxwr6HhGioS2+gl8maOmH4TrQR/zqUDVCQDJao+i2nhKIpH8k92HeKn6FdIAxfEtH67LTxhNFbOL8YxjgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W42PiBxT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so976212a91.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750182871; x=1750787671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=937SNCtRoVW7fSI7BjOUvEicfHLqvBS+3CUCFUdUKNw=;
        b=W42PiBxTMz5b4U2dZ74fiDMf+drVBpSFJGO8iIxjm33YkIYnnWI7cEWTLz+4K3gn5L
         mnfw3C31eMHC2lBP3dyPjME9ueqEHwI7j9wl+HSm52iGm08CNfu/w6OpZkwB8c7gExO5
         +XvBD4pplpsfCzJs2QS1AvgjjVNV/bH2LL9jlYmRSpz8c4ZGrtVwFmMyYxEuTaTMdZK1
         Pxru56Tcnm9TaeGYQzJFmJXmivZPsTHmYa9mkobnfLRtDiQ1Ia/9Vh0zxoIbSgILbLG7
         xdpn1wdOcHRHzb8dHn5NLHicCWPEimPL8zmkHM/B7PE/4z605fP9IIrMXoYsFr2m1Mb/
         1dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750182871; x=1750787671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=937SNCtRoVW7fSI7BjOUvEicfHLqvBS+3CUCFUdUKNw=;
        b=I8U4W1DPrsYhf2VVcpOQLOpxK5LZWaif+cl3wvnkWIQFCrq628o+npvMq7jZAJgivl
         DYig3y3FGYxz7HTtgOtUFi5QsvvRbakgx3QR9tq2WOa23nerwT3gzhnVmz6Hk8x3kYm8
         sstwJoDhDFwYr2yvfIAtv8q9cdXyU/c8aPYR76ucIe2dqtpOfn0IYAMhdYxT19/Di0pm
         8Lll5mySMpgRrR92LqJPkRjX8UjTpujTXV+/iCfLznG6TZnnEJkdMjk+ZhCk/V4RDhih
         T2DJRiidhJFZJHhs9aJK0Bb/Wkz7pAWpF0x7s+6JWwo9zA+RC6GfyOfXvIEGUCq2hcZa
         Diog==
X-Forwarded-Encrypted: i=1; AJvYcCV3wHExFViMEYh6JqvJM+eGoju0f6l/2huxY8qICNjADqvtm7fjdH8DT91WuOTjVURSy+e3SYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMzMU7+YKp6ylRWRMn4rno4JcaqfS9NupaNPdErDW7Uj25Xna
	b0oPgG03W6O/5A0UiBWvD7IvG/AD+HTfKZnMZIVXGoVvsYY7JXJ9oJkykZxCHpsveGk3TE2JFj6
	mMviotGIhi/zq3Z+pItxWoHFeFvevBfM=
X-Gm-Gg: ASbGncvrNa5csf8//QlZrewOAokN0Con22SK25SAsTfNv9S0KCgUOKoeLzvosVVlKrI
	oFx9OXojdgui68U8vAdnsIAmIqBg1q9ZTSKCwTem5s9Q+4HIO06vUv5Rml5gXZI7/91+yHEE1D5
	GB7fVKxpz0bVvBgXN8eQfoQKjBP3x2lGNWXDBSHJ5tNlQ=
X-Google-Smtp-Source: AGHT+IGWvvWk11q0cPykrWuk9J+4mN0BXmmJYPB71iOvggtKYMwMAiy4m2/E7mQrFF4G7gJJnJj6y0nhKIGKBdoP9VM=
X-Received: by 2002:a17:90b:43:b0:312:25dd:1c8b with SMTP id
 98e67ed59e1d1-313f1c77faamr7959788a91.2.1750182871471; Tue, 17 Jun 2025
 10:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025061734-shale-reliably-8969@gregkh>
In-Reply-To: <2025061734-shale-reliably-8969@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Jun 2025 19:54:19 +0200
X-Gm-Features: Ac12FXyxwc1qZCgckV9N4GwvrjzXZrARU8ownR_vbAHqbmwbfmdK9yBRcaHXfb8
Message-ID: <CANiq72=GCFHpgtJrq1LppZ_Bkkw9AvPG1KySDyeo11QVW=CCQA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: compile libcore with edition 2024
 for 1.87+" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: gary@garyguo.net, est31@protonmail.com, ojeda@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:23=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.12-stable tree.

This will require an extra patch for 6.12.y -- the ones that
introduces `rustc-min-version`
(ac954145e1ee3f72033161cbe4ac0b16b5354ae7).

That one cherry-picks cleanly, but I am replying with both as patches.

Cheers,
Miguel

