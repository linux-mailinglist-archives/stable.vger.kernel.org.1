Return-Path: <stable+bounces-86393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8699FAD8
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 00:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E6BB22BC2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 22:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388651B0F25;
	Tue, 15 Oct 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="aDlf69vK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCB38DE9
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029903; cv=none; b=JGRrNfKud8QDKPzAIfHAeh3c53zHVqXcgHlzqVJ1sEVoFybg2Skr61aSG4p1wL/zK2dMA7U44E6fc+mrhzg2mJCYSopnD6v3ZocS7MJxJCxWRbMfo7kinqRr0XZ/deipCUiHNqr62f/vVU3aDrP4ACKNa9SPgKDOiRIhGTxvk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029903; c=relaxed/simple;
	bh=Pkk12nfRRJgVGUWEMa5YLLUkxQaxe30MNbzyRFlwSEM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NU7o18PqiBmKfruqHIa2kX9lV3jLU1atOm8M/JWPkzi8gS36bdvAopbNDG0fZc8q5dCGjrnaus1VjWfilSwkcoF8lvUhFawPPjpu2bcq3708geqSu9MQHGdk35U1LaPk2Q4PKcrffvEYjdhC3ObinBmeqhEybkmfGmAxupp1LhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=aDlf69vK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so2082836f8f.3
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1729029899; x=1729634699; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkk12nfRRJgVGUWEMa5YLLUkxQaxe30MNbzyRFlwSEM=;
        b=aDlf69vKTvEWLxeU1LV5g/tCQS0wWqRpdkb6skm/gocTBggo/5xcT1NDR20nVWJSXe
         YIODM5BmPh1G/nMUhe6ng/HQAQpQ0TF7WCvgbfNFwksx78NVepbUZw1U309/AXotgxG6
         L0rXukK7TVL50si9cSvw1XAAO63KJt3zWE89pcgPzzzVCSeGGS8seN5ugOvoaHjzOwNV
         q7NflTtR7jjRGw8dcjzr/EN4L4z9xP53U06AhAkbzO+2tAtBfU8JEnEvYfQfNfRPmpAf
         q4ZW8va7CMUFfBesZ/qHgZgzGHPN4XW+npoFXvQWnUmRsIM39Rxa9ASyL0MgXSG8u2RG
         0u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029899; x=1729634699;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkk12nfRRJgVGUWEMa5YLLUkxQaxe30MNbzyRFlwSEM=;
        b=hoKhHKxFHflJDusErEnJllEe6CwEJEwMBL44yAusqJDccKAE06LwbYIIPkegk4q1L+
         ONziAaQdyz/LvFl5NxHt1rNWp5mEZyV4MpVTPlFHaXc6c7B3k/3TX1ijkewFe28BqZSY
         3XaRf1TMOrizy+Ymx4tfdIcOEwALDIcdTTgi0zZYKbSmMlznNpyaFvQqtI3kwWudPAjq
         JMMfp3MMHImAXUly42K+buEUqwCKTAiozGx7HaUIXapR7NabxmJvru1KxoiQ65UeLkYp
         BjcKn7QUqrv6AmS4PchJ9AE47eHI4cH057LBEhVPhyhBKVnsvF8XlXPQgM4oiuQq/+vE
         f+WA==
X-Forwarded-Encrypted: i=1; AJvYcCX+v+dQFDy0vsvi9zsdjtOAjuF1OpY53b4it988+nLtsT894Y1rGEX0RULCfLOmnoMyz5EG5wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpB1iBhF+z0Rkba2PfgU/faZvrazMuIkoxFcw4W9K2LOoz118
	0gk8qQ8PmK4cEbkl6xOWEi+aRRspWNh9I20azQMRoONg+/oyJfpoLIDOHkZeI/A=
X-Google-Smtp-Source: AGHT+IF9x5wF1b+0KR/aLBuLslCfjie/2+kpmUaaubzh4LXZULAmGakNPlrriV3NAszZ91sIWuH2cQ==
X-Received: by 2002:a5d:574e:0:b0:37d:518f:995d with SMTP id ffacd0b85a97d-37d552d92c7mr10802530f8f.56.1729029899444;
        Tue, 15 Oct 2024 15:04:59 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf857fsm2622593f8f.74.2024.10.15.15.04.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:04:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH -fixes] riscv: Do not use fortify in early code
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20241009072749.45006-1-alexghiti@rivosinc.com>
Date: Tue, 15 Oct 2024 23:04:47 +0100
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Stuebner <heiko@sntech.de>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Jason Montleon <jmontleo@redhat.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
References: <20241009072749.45006-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)

On 9 Oct 2024, at 08:27, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>=20
> Early code designates the code executed when the MMU is not yet =
enabled,
> and this comes with some limitations (see
> Documentation/arch/riscv/boot.rst, section "Pre-MMU execution").
>=20
> FORTIFY_SOURCE must be disabled then since it can trigger kernel =
panics
> as reported in [1].
>=20
> Reported-by: Jason Montleon <jmontleo@redhat.com>
> Closes: =
https://lore.kernel.org/linux-riscv/CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-q=
CT2NGS7Q9HODg@mail.gmail.com/ [1]
> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the =
command line")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Is the problem in [1] not just that the early boot path uses memcpy on
the result of ALT_OLD_PTR, which is a wildly out-of-bounds pointer from
the compiler=E2=80=99s perspective? If so, it would seem better to use
unsafe_memcpy for that one call site rather than use the big
__NO_FORTIFY hammer, surely?

Presumably the non-early path is just as bad to the compiler, but works
because patch_text_nosync isn=E2=80=99t instrumented, so that would just =
align
the two.

Getting the implementation to not be silent on failure during early
boot would also be a good idea, but it=E2=80=99s surely better to have
FORTIFY_SOURCE enabled with no output for positives than disable the
checking in the first place and risk uncaught corruption.

Jess


