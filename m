Return-Path: <stable+bounces-86518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF1F9A0E33
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 17:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8CD28267F
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F518C920;
	Wed, 16 Oct 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="KywTlMRR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529A1384B3
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092635; cv=none; b=lfkJ4OmlAqlEK/qbxnjSBHEQG/SBSFy3T9fXFQKDO/06qwub9gZp9Fa9629O7G5zTD1dHcYtS4jsp7fl/WVgUOa5paNFgS7Mqs9uyLfHScpY1DMQkjUcPEWbpQMfKsmHL+X+sgWGNKDHSsE8g00xMuOw4ZosNqHqNYbS/owtCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092635; c=relaxed/simple;
	bh=fu5iRgYgRkj80j9SZ3py/vD5I5PfSyJqY/THhty4v9w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uOuXwipO74EqjceLxZBaYHdBSk0H9bRqCl3UnJx4iaYrNendR6vDN+oM5tRFLF1BQxQ0gkrDFLZICKHkg0Knlp+bqBgisGto37ON1hUtKYHAV80zcwPOWg3jpNEgfA8mPvljNQJzmqLF0edj1aNVPLnJB+NS+5FYgRjRi2MXlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=KywTlMRR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4305724c12eso52080935e9.1
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1729092632; x=1729697432; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu5iRgYgRkj80j9SZ3py/vD5I5PfSyJqY/THhty4v9w=;
        b=KywTlMRRNwFzy17gIsBt1V/xAerGUZh2ERVDVACZ4bc/KJBXoFstgwJrzvZGjyGkNB
         mUCjOBoCnlAvLPjimZmCcdk/242COnDLPGeUXzPDH+9SIEFfN6EN1zaCoYzbSvBjhPI2
         goPSPLsBgFp6nZAVshElU97r5WaMUbKOLJkS0MyNqEaB41pU9r6plmOHvV7IPGl8jDrc
         TkWXc2CPcX4QjEB4BIBKfMUVKP2dbEVc1/o00IO3orNYi80Vk3rmpaBs+F5oSIJkYl/d
         qLcPYyPT4aPWFCZA0T//6Eh1tpJxvkLoeYDsqNnLaRCKX61KDYgP9yR/b+Qv5J29GoWb
         wQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092632; x=1729697432;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu5iRgYgRkj80j9SZ3py/vD5I5PfSyJqY/THhty4v9w=;
        b=sPp7YV8j6E9U8i5XLEsUa49JGhIi/6mPOQw66/MJc5RkrQ2fUqmiAih0QBPpQgfUbl
         xwrZu1wPOvX7L/FPuqFBFv/vMiPftbsU9y1PVIwUCTiuJ1xOvsPEmA4+HRXoaVksiOh/
         EfQQRfRmKo8Y11Bedh+Ds2jwkine25k1q5vND2qY1xWvs8BC1ZVHGn1UUx1QNd2TUHZ6
         zokM4D9KyWaUloR72nKMaDBET5MOF3OvoQU4NTx5bCg0nm9atrhxlHZNXQwEbCWODdpF
         tXDYO0lVyg64SA/vq25eBpUSz0VBSgvAFiC6/9ywc0hTnGtCZixFgC3MZ/7L1lUXyXVp
         zvYw==
X-Forwarded-Encrypted: i=1; AJvYcCWweWs6hH6uWxOf8vcgjwj9sI3JJIOw+damA3JFy9D+lBSrNuVa8C9OSHQd22/h6H8kbqvF3rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJ4hYvq86JL4UQpZ8iJ4TnNfPGGnEuWwxBRvOBxZqgl6Hlgb2
	x5+/Xm5CgYena5RMVmtUxXrWf2q4KhhGbd2/0XQPad9q5mHSLS4lgxRFeE0RqYc=
X-Google-Smtp-Source: AGHT+IGN4iO/Z4ByP5TditNqCj7XQIWWSN8JvAA6/qnWa/dt+s8Eo87ZFfp0PaLsleCGBhJWo3ulhA==
X-Received: by 2002:a05:600c:1c9d:b0:430:57f1:d6d with SMTP id 5b1f17b1804b1-431255d5099mr135853665e9.1.1729092631642;
        Wed, 16 Oct 2024 08:30:31 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f569aadsm52179615e9.15.2024.10.16.08.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2024 08:30:31 -0700 (PDT)
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
In-Reply-To: <3fe1e610-c863-4fbf-85cb-6e83ba7684af@ghiti.fr>
Date: Wed, 16 Oct 2024 16:30:20 +0100
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Stuebner <heiko@sntech.de>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Jason Montleon <jmontleo@redhat.com>,
 stable@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <26E1A34A-CC24-4D6B-9C12-782C837A91E1@jrtc27.com>
References: <20241009072749.45006-1-alexghiti@rivosinc.com>
 <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
 <3fe1e610-c863-4fbf-85cb-6e83ba7684af@ghiti.fr>
To: Alexandre Ghiti <alex@ghiti.fr>
X-Mailer: Apple Mail (2.3818.100.11.1.3)

On 16 Oct 2024, at 12:26, Alexandre Ghiti <alex@ghiti.fr> wrote:
>=20
> Hi Jessica,
>=20
> On 16/10/2024 00:04, Jessica Clarke wrote:
>> On 9 Oct 2024, at 08:27, Alexandre Ghiti <alexghiti@rivosinc.com> =
wrote:
>>> Early code designates the code executed when the MMU is not yet =
enabled,
>>> and this comes with some limitations (see
>>> Documentation/arch/riscv/boot.rst, section "Pre-MMU execution").
>>>=20
>>> FORTIFY_SOURCE must be disabled then since it can trigger kernel =
panics
>>> as reported in [1].
>>>=20
>>> Reported-by: Jason Montleon <jmontleo@redhat.com>
>>> Closes: =
https://lore.kernel.org/linux-riscv/CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-q=
CT2NGS7Q9HODg@mail.gmail.com/ [1]
>>> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
>>> Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the =
command line")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Is the problem in [1] not just that the early boot path uses memcpy =
on
>> the result of ALT_OLD_PTR, which is a wildly out-of-bounds pointer =
from
>> the compiler=E2=80=99s perspective? If so, it would seem better to =
use
>> unsafe_memcpy for that one call site rather than use the big
>> __NO_FORTIFY hammer, surely?
>=20
>=20
> Not sure why fortify complains here, and I have just seen that I =
forgot to cc Kees (done now).
>=20
>=20
>>=20
>> Presumably the non-early path is just as bad to the compiler, but =
works
>> because patch_text_nosync isn=E2=80=99t instrumented, so that would =
just align
>> the two.
>>=20
>> Getting the implementation to not be silent on failure during early
>> boot would also be a good idea, but it=E2=80=99s surely better to =
have
>> FORTIFY_SOURCE enabled with no output for positives than disable the
>> checking in the first place and risk uncaught corruption.
>=20
>=20
> I'm not sure to follow: you propose to use unsafe_memcpy() instead of =
disabling fortify entirely, so we would not get any warning in case of =
failure anyway right?

Yes, but no. The point is to disable it only for the problematic
function call, not the entire file, so any other fortifiable function
calls that exist now or in the future in that file don=E2=80=99t get it
unnecessarily disabled too.

> Or do you propose to modify the fortify code to somehow print a =
warning? If the latter, it's hard this soon in the boot process (where =
the mmu is disabled) to make sure that the printing warning path does =
not try to access any virtual address (which is why the boot failed in =
the first place) but maybe Kees has an idea.

Not for this patch, just observing it would be nice to have.

> And I believe that enabling fortify and using the unsafe_*() variants =
is error-prone since we'd have to make sure that all the "fortified" =
functions used in that code use the unsafe_*() variants.

I mean, that=E2=80=99s how all these things work, normally?

Jess

> So to me, it's way easier in terms of maintenance to just disabling =
fortify.
>=20
> Thanks,
>=20
> Alex
>=20
>=20
>> Jess
>>=20
>>=20
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv



