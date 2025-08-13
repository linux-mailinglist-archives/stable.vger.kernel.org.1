Return-Path: <stable+bounces-169334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 444EEB241BE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525121883F02
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06382D29D6;
	Wed, 13 Aug 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivbSqSZT"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB82E29DB88;
	Wed, 13 Aug 2025 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067384; cv=none; b=GIyecLStGVF3V0VFx3gMriolxtjvda05MQP8RDDD+Plzvs4prj5IBkQFWgZr3/+GTls7Z6L4i4bav/z21J73f5iy2d6++jYa8mlB6ZcAgJtmO0UMWktzpIxZ4dbefWhrPgrZGLVmnc1r27mAw+sNhu//JWIicrSRe2t0vm246IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067384; c=relaxed/simple;
	bh=t6Gxkv+CDON82ECDUPUEjnK0xUD+Pt0dts94fDlhUuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLfy6QhWmEXRU4fPHlXBOmnM7XU1H11LV35lOr80kC2BCCr71jEed15M+G3t6kw6dvyYQj98yDPR7HkAg2fjwfWhI7kKW6+v94rYF42BEyu/myQi3ju3WcBAI1BOZaxLuqxDZPgQQaxK70QHj6BqbNSUD9eoMGn5S5oCE6H7NWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivbSqSZT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3323afe4804so50280091fa.0;
        Tue, 12 Aug 2025 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755067381; x=1755672181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yyc4t9KTW/liBhOmzyg87dBz2efZXc6DlXeMNJMn3I=;
        b=ivbSqSZTDuIR9WTMP4+HreRBQI+W+nta46QucJyENT3NhLBhDKWcuuAIiDzZ/cIizs
         jKBdDPHLNjA1BZM2LQkm2E0akKphN1ddYme7r+QFkG6kGG2xz+g0t/yxbnCvym246bXR
         U28QCHVVk2rUysRABXAFiLstWHhGA3U7CXcxo7O4Niw0tMU2/nEjdgVY7WqAYb5T+qWL
         F22nD97aDsIudgM9kjkBplEVAiOVIrSDE/TvqEFLIBdf3RpaDZylVG1lUQfMdGHkyh/x
         DIazDgzls9V//aMTJYCIlU3nn+NZOE5nlRkcpjCoe2FXNURHHOHjRzDn9SZFGYtdZV1/
         BS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755067381; x=1755672181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yyc4t9KTW/liBhOmzyg87dBz2efZXc6DlXeMNJMn3I=;
        b=mBmZE+lti4+nL2WLhBbJaXV7gjVn6/DbDD+6m+equKvgVwwpIeNsnhCsa/K81GlsJy
         X8umH1m8W98702x8MznQoe6fsP9AQDZXaUIy1gEkw7OcjT0CUMS/0Eb2OlLRWZsFkPe0
         zyo0QIMDkLcYPhBaKjphWJ0D9L+T1e2r6tA7AyR4AzzWzZHMj3zs4r+nr4NxGhlD5odQ
         IW11a8aI0EF6iYXraPtq365Gx78HyHgHd+D8EDoAAMQ/PBjP7JXF4WBrw9Xgn7HHPDpH
         KvYSiBSM2CTzsQhs7kGw1U8Ynn+9O50og8k3G7ouFcRZnxEuD25h8bWZKaNzLp2nHAH5
         bVcA==
X-Forwarded-Encrypted: i=1; AJvYcCUzLAkMuJ6iCdenWBjwSqGXu+uCb4tB1FZAxC7QdPHzoNpGUiVioK6xx3O//HSbDXPIdg37BPzJ@vger.kernel.org, AJvYcCVNBxiDLNEQv/nenjmlUzLJHW9QHJwemyovWfOWXUQX+Xm8QnCj5beJVbigNd9Taqj2qcu6+6Dp2SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbaaVrbYJ3lARzJVknUuZNAQw9S4u24fr7wRWoSxFgV+qpohwd
	yLRGvSW5aTF4VHcg5RGLAc2dfMSFcMilkYB0fnOcvB29maMagQ/E0ndO
X-Gm-Gg: ASbGncttcd7QM1YJTknNQb8DgTy1i95XWWqievYhoAus4rQ7TB2x/8Ac0O18J5pcAJr
	GdPmkeBXQX+oNF+gubmtfz3Hf3yn/ek3qQ55oNvEy7Lc20sFRjU1N9hrlmAM8WwWWsZlnV4PFgt
	rfeONNuFsXrXZsiH8PPfSMFFco9BN3RCo9L6dsOeRQQ+29f3hdbqIrXuFsZRNPD+DGGAv9WRZ9V
	jbqnBiBXFwfBB+YaZVFd+u1Z/jL9SewMkWLJ+Xkm60c/xQ+NoORkJBvRvMtHBd023OvfEdrbrgg
	+g8HdLdUQEmWvI54WmMgdtV6mY8kuE26IzVwPtLVC8BfE3K43UWPTz8y9bJGgtd07DnSZKUhlQZ
	IMuZkBNp3mFXESfavxfG3VNVUg3Tsqa6yiWA=
X-Google-Smtp-Source: AGHT+IHVzkxuHFsUNurcuwNerNIeGKmTKOL0YHxhLhx8qbrR5z5hsl3TRN2M+qAJKnVZGBccnjMZkQ==
X-Received: by 2002:a2e:8709:0:b0:32c:a097:4198 with SMTP id 38308e7fff4ca-333e9644d55mr4007931fa.1.1755067380520;
        Tue, 12 Aug 2025 23:43:00 -0700 (PDT)
Received: from foxbook (bfd208.neoplus.adsl.tpnet.pl. [83.28.41.208])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333b216ad95sm15581501fa.66.2025.08.12.23.42.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Aug 2025 23:42:59 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:42:52 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Marcus =?UTF-8?B?UsO8Y2tlcnQ=?= <kernel@nordisch.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby	
 <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?B?xYF1a2Fzeg==?= Bartosik
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
Message-ID: <20250813084252.4dcd1dc5@foxbook>
In-Reply-To: <bea9aa71d198ba7def318e6701612dfe7358b693.camel@nordisch.org>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
	<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
	<5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
	<4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
	<20250813000248.36d9689e@foxbook>
	<bea9aa71d198ba7def318e6701612dfe7358b693.camel@nordisch.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Aug 2025 03:58:07 +0200, Marcus R=C3=BCckert wrote:
> dmesg |grep 'usb 1-2' ; dmesg |grep 'descriptor read'
> [    2.686292] [    T787] usb 1-2: new full-speed USB device number 3
> using xhci_hcd
> [    3.054496] [    T787] usb 1-2: New USB device found, idVendor=3D31e3,
> idProduct=3D1322, bcdDevice=3D 2.30
> [    3.054499] [    T787] usb 1-2: New USB device strings: Mfr=3D1,
> Product=3D2, SerialNumber=3D3
> [    3.054500] [    T787] usb 1-2: Product: Wooting 60HE+
> [    3.054501] [    T787] usb 1-2: Manufacturer: Wooting

OK, so you had a keyboard in this port during the last boot. Is this
keyboard always connected to the same port? There is no bus 1 port 2
device on your earlier lsusb output, so it was either not connected
there or not detected due to malfunction.

> journalctl --since 2025-07-01 --grep "reset full-speed USB device
> number"
>=20
> Jul 24 15:56:34 kernel: usb 1-2: reset full-speed USB device number 14
> using xhci_hcd
> Jul 24 15:56:35 kernel: usb 1-2: reset full-speed USB device number 14
> using xhci_hcd
> Jul 24 15:56:36 kernel: usb 1-2: reset full-speed USB device number 14
> using xhci_hcd
> Jul 24 15:56:37 kernel: usb 1-2: reset full-speed USB device number 14
> using xhci_hcd
> Jul 31 19:53:02 kernel: usb 1-2: reset full-speed USB device number 50
> using xhci_hcd
> Jul 31 19:53:03 kernel: usb 1-2: reset full-speed USB device number 50
> using xhci_hcd
> Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
> using xhci_hcd
> Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
> using xhci_hcd
> Aug 06 16:51:34 kernel: usb 1-2: reset full-speed USB device number 12
> using xhci_hcd
> Aug 06 16:51:35 kernel: usb 1-2: reset full-speed USB device number 12
> using xhci_hcd
> Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
> using xhci_hcd
> Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
> using xhci_hcd

So this port was getting reset in the past. Can you also check:
- how many of those resets were followed by "HC died"
- if all "HC died" events were caused by resets of port usb 1-2
  (or some other port)

And for the record, what exactly was the original problem which you
reported to Suse and believe to be caused by a kernel upgrade? Was it
"HC died" and loss of multiple devices, or just the keyborad failing
to work and spamming "reset USB device numebr x", or something else?

Regards,
Michal

