Return-Path: <stable+bounces-116502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69511A36FC1
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 18:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8CD3B07FB
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902B1F37BA;
	Sat, 15 Feb 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="upQVhLhy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05751EDA16
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640290; cv=none; b=Q9BQkdFIGZ8uhdv8LTUjenqwphnV2FQcz7OoEpVNSGQw/noOIKjAkGuaoJvUlFmKoJe5tG62FcWwKOZeWJ1eWsmRIRVz/OB/CzvZRXirl/QPE00niCakKi2ZXUIw605ngMCYqd2kjBu626QFjF1hSrDrtb1+jTnfk7eKSBm+NPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640290; c=relaxed/simple;
	bh=teKQ4hdjN7BYX7EoxvrsCHltx1se2slKk6pRdKtxyvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvIyOoBaj3pZbP6DyVjXFAfd4oqS8C8QhoTdmcLigL5gRuIcFARFlRLsZ8yNYb7GZpYtoSs4to8L4EAa7rUualHooeWxFlb5TWguaMWUMZUjifTAfhvBv9N2VJpev92uOcal3NmBJtGK4gPIFmYcJKUuZLmogQxY6Vh8H3Lq018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=upQVhLhy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso550693366b.3
        for <stable@vger.kernel.org>; Sat, 15 Feb 2025 09:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1739640287; x=1740245087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEbvPfbzlqpfyi/ZuM8Sn6es2AIq+nlH6qd/TbLpx0Q=;
        b=upQVhLhy5Bl/GTttGIKOuzvK/L/50AttRV7rT8SDHkSt96BZNuIsUheLsTm97SW2v/
         aQx+dB9P/OKJFLdzB42gwocfTjdQ+MjPjl00Wl4CRiScD3NvlFreYPKzpWyj4ViOgJU4
         d64yFC1RDVQ5Y2eZkksizIzGsXqUeDwTTZ0/VJ+ddQlagLZyBWL6A5YTwCLio03i18zm
         cpbzGQ0Z9/e3KyXhsTpRvaR7HXZU84Pikh2uWLPoArrrGVmhig2jeEcPO5ubwwMqELRf
         HNMmBxFStSsACgVRc2btnWqI11RdR6PTxgv3EWTw5jwKuFyfYZM/0ocl6q8VbNVNbEiA
         KO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739640287; x=1740245087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEbvPfbzlqpfyi/ZuM8Sn6es2AIq+nlH6qd/TbLpx0Q=;
        b=ehrBVftnokv52vgMMwGazoKOQQrrA/2F0HdEYuYuISL0TrPTpI5oIxZLD/ErakJ2dB
         PDvc735Eh2AXVfAuvvjxjrtXut8i4f7s5o0Q596OOCLe6LUX4azJW6xb11lunMV4h4f2
         /cx9f2+W/OafnYSp0vNvpUL5nm8OGLQ7JGivgJPs7ee8dQ6YQReX5J9LHUp8h0k5/VB0
         dXN343DV9kFVlVQu60TUGCiYjq0X8Q9vzZzg1k+8Fkb/DAzGXi8etBLoYXBEI5FeWRrD
         sOm8tjHSp1aBDSVaXWgXCjd2PoREm0KXolqMJNLfKtJ6LkNDq3vkoknjfMPtALQQUHUP
         7PZw==
X-Gm-Message-State: AOJu0YyCEVUklpJOBlC16g5KXIDsB61ASUWGsnhlO5va4VOoMGOB23UD
	iSrPu/l1M3aXBDTAOhD4Kw6dI96h3CWGpHeOI+XAtC+DsNvuTvrCeZ5UK7WkWyIm4B/Tr4FOuZc
	RgERUpfJuLL6XsZHwZmgc44NSq8Rkfcx5uwKVupDVCUXHNr1yfzYJoKWC
X-Gm-Gg: ASbGncsi/M/tryenyhUusyTsgJA6VMS4BnwAILx+3Q9P0uDqpEQzbV1Z8m0/ZV+V8Sh
	O/laphRjOKo8TPY5zE2i/aTPH4y6H6ALqJIZVPBJKMCbvAgd4AfQyuYAYlSCOgcbJJ2UqPNSK
X-Google-Smtp-Source: AGHT+IHpM1eqc8tlYMhaHVIvfcF2/sov/Rb7t32A/3fz4T8tN5Lqj5CbXTDRT00b6qYe7eMIRGaa1Dgm4UxTcOcxbsM=
X-Received: by 2002:a17:906:c153:b0:ab7:c3d4:2551 with SMTP id
 a640c23a62f3a-abb70dde461mr387599866b.33.1739640286846; Sat, 15 Feb 2025
 09:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075701.840225877@linuxfoundation.org>
In-Reply-To: <20250215075701.840225877@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Sat, 15 Feb 2025 12:24:35 -0500
X-Gm-Features: AWEUYZlLRXmnBt-692KO7vYcJFwLxQMOVLPLKrHkNbf4YYJGv_M_v-aJo302zFo
Message-ID: <CA+pv=HP-_uNh=Tdx4L30uN2TUO8K2pN2adYoXs_1HH=ScG0t2A@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/418] 6.12.14-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 2:59=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 418 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 17 Feb 2025 07:52:41 +0000.
> Anything received after that time might be too late.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

