Return-Path: <stable+bounces-169359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB724B2463F
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335921AA5952
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610A82D3EDA;
	Wed, 13 Aug 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvbFgI2s"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF8156230;
	Wed, 13 Aug 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078537; cv=none; b=SfQHywOHhX6u421soe3gXeg3E4Tyfw+HImbL5OdbTq8v5eeX8h55rYnDba3tzCJs/LqPKkDmiPitUFa/urc6jCO6q5TZ6ycI4s2mkXd+0ICyKyZhcj5NGyHZT1/N6uXrKoc/SEf2IAzn59wDPAiwt4ErdsACkCdotaV5sd76+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078537; c=relaxed/simple;
	bh=Q5dcK0CjHMvjXYurPdmUBdrbabL9m7N+1bo3WB63TvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evIVqkFI3kJXMgm5Gvu4oOOs+ORbmIvYljr/TOlHpunT7C5fmmjqoL8XeRV7aMYXBawZHDgwS4cY2+EiDY5xqaI2eXA8yQDLfx+OwR1hNgZFHHjHXx1bViGvuWwm0WGJAyrWxRXfCwm8b/BMVGaRMSMbNPjyFhOo5fBoXftSnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvbFgI2s; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55cd7d66b2bso1857429e87.0;
        Wed, 13 Aug 2025 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755078533; x=1755683333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5dcK0CjHMvjXYurPdmUBdrbabL9m7N+1bo3WB63TvY=;
        b=UvbFgI2sCHdlWWvIl2KzrZkHXuMd1Eo6kHikVZHSroXZ+xz9hvXQiHZVBArIaVkVB1
         JlmxYuP7rfh4+yTqBPeCS1tr9aC8d/WbT4h9/LfKj1GOgGs12HQr0qtT2h7S9hl9T1zb
         bJT2cjol7Q8OAJknQ1YWyScmGO3FwsQ4bsbAtUpDrzyjKkteTm/27vyyholdy1r5Tlo+
         tbzIE7GFDXCAcKjM0/u77pJpgbJnsIOyPDeo6VoNqd+f2vDNexLsV2//4pZtQzTzQF+0
         Q+r9CAXW2Nn89qn9iKhkBV0cEsx2GoKq/7wTLXqAj/jJP5S8Dy3DgfnyT8Wj1LsDJubR
         WPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078533; x=1755683333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5dcK0CjHMvjXYurPdmUBdrbabL9m7N+1bo3WB63TvY=;
        b=S5qfKUc3Idd5QSfCCDWvaXNWzT8HHfoUbWU3g6+1qPjp1IAkYjxmFkkwex66rEugIG
         KNTuYQFTS+X5/eu1a3jRHjBHKXCGPCc92tOeLUV6un8OflahEONA6JJYIuyuRcHE5263
         rdXklRATRfZIA40xF5dbNj1hiMfujYHjvKj4PG8EtWVmHIp2y/jC46mWHXwl4VDA+2Rd
         RKAo61FokRtIbPwuu+U+LO+HRCTMZOR77564sdgMVFutvgzGYfeZ39mMH2ccorIK+HyC
         q3UIUFsHc/7SOeIftAR+LyZWPsjhvaFenz9Oklbv7Md/xHjtcwNB9z03v5tfj6TL8QFz
         zCHg==
X-Forwarded-Encrypted: i=1; AJvYcCUnniiMaR5TZNRuoS0KVfELR+4WGOE2vrjxaGL9pKxU65ZJ5oEcq8AFmJoaYYfuCP3YepME+WnC@vger.kernel.org, AJvYcCW5dGfzmM+ddQU2zKN4Dt8BMchHkFoolccGnzenwQMlW/D6p2hFbvTBt7G+HyRDjX0tPr1VhNvYLFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzA0cN8lvjOnxLBAmXJ9UdvLShZ8DCN7ftfQbjCMsvdz5vyBs9
	gFDFCWeKoFa2S0akxoVejwFJsWlOADRaQoKle/suZO2kQeaLf1FT+GZU
X-Gm-Gg: ASbGncsgDYq4u/xj1yOSwDX9h2ReZSfQDYGzJhmfAHVE//mcunBLOHMMxpHa21oxUZa
	5n4NzbadXvzASQwR+mdGjdgRo06Tt5qK1qCIrQ5Ff06Uv14Y9pWg42roXh1ii1TsmwDfUyZuIes
	26pqHggV4GjP5PRwRoXiUoerkUVUVlpMB6a4YWihXvxdW7QzHD+OtD16W4e7cyk3I3wwZ+h/tU6
	uGPzHgUnBDlAcYUhCPCN9Gl4UTeNmPM3H4blMAFsv8Xdiv9dwkLGs5fooqxcRi4M/vdwOkv2BA4
	r+Luy1EfUUej7tpxUl4vdrt4m7ZnC6j1vOVf8sB14+RzfVcwpRkV/oPVP84feUjqgKV1nLRLLYR
	iqdK7V/ZtvcRq+Pkm83uZoo97pGvnVJAr9JA=
X-Google-Smtp-Source: AGHT+IFIQwXVC6UUg5hivH6IV28yuGpDjLff3Eva5APWkdxAXHisZpw8Oc4IUYN519k6xnsEGmDcAQ==
X-Received: by 2002:a05:6512:3ca6:b0:55b:96e4:11b5 with SMTP id 2adb3069b0e04-55ce01418d4mr655852e87.1.1755078533079;
        Wed, 13 Aug 2025 02:48:53 -0700 (PDT)
Received: from foxbook (bfd208.neoplus.adsl.tpnet.pl. [83.28.41.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cb7c4dsm5262362e87.170.2025.08.13.02.48.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Aug 2025 02:48:52 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:48:48 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Marcus =?UTF-8?B?UsO8Y2tlcnQ=?= <kernel@nordisch.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby	
 <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?B?xYF1a2Fzeg==?= Bartosik
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
Message-ID: <20250813114848.71a3ad70@foxbook>
In-Reply-To: <746fdb857648d048fd210fb9dc3b27067da71dff.camel@nordisch.org>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
	<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
	<5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
	<4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
	<20250813000248.36d9689e@foxbook>
	<bea9aa71d198ba7def318e6701612dfe7358b693.camel@nordisch.org>
	<20250813084252.4dcd1dc5@foxbook>
	<746fdb857648d048fd210fb9dc3b27067da71dff.camel@nordisch.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Aug 2025 11:14:04 +0200, Marcus R=C3=BCckert wrote:=20
> Jul 24 15:56:34 kernel: usb 1-2: reset full-speed USB device number 14
> using xhci_hcd
> Jul 24 15:56:35 kernel: usb 1-2: reset full-speed USB device number 14
> using xhci_hcd
> Jul 24 15:56:36 kernel: usb 1-2: reset full-speed USB device number 14
> using xhci_hcd
> Jul 24 15:56:37 kernel: usb 1-2: reset full-speed USB device number 14
> using xhci_hcd
> Jul 24 15:57:56 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up
> Jul 31 19:53:02 kernel: usb 1-2: reset full-speed USB device number 50
> using xhci_hcd
> Jul 31 19:53:03 kernel: usb 1-2: reset full-speed USB device number 50
> using xhci_hcd
> Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
> using xhci_hcd
> Jul 31 19:53:04 kernel: usb 1-2: reset full-speed USB device number 50
> using xhci_hcd
> Jul 31 19:55:05 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up
> Aug 06 16:51:34 kernel: usb 1-2: reset full-speed USB device number 12
> using xhci_hcd
> Aug 06 16:51:35 kernel: usb 1-2: reset full-speed USB device number 12
> using xhci_hcd
> Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
> using xhci_hcd
> Aug 06 16:51:36 kernel: usb 1-2: reset full-speed USB device number 12
> using xhci_hcd
> Aug 06 16:52:50 kernel: xhci_hcd 0000:0e:00.0: HC died; cleaning up
>=20
>=20
> all HC died events were connected to reset full-speed.

OK, three reset loops and three HC died in the last month, both at
the same time, about once a week. Possibly not a coincidence ;)

Not sure if we can confidently say that reverting this patch helped,
because a week is just passing today. But the same hardware worked
fine for weeks/months/years? before a recent kernel upgrade, correct?

Random idea: would anything happen if you run 'usbreset' to manually
reset this device? Maybe a few times.

