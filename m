Return-Path: <stable+bounces-233815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL2VDA4M1mlnAwgAu9opvQ
	(envelope-from <stable+bounces-233815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:04:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973B3B8B27
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCCBF30179D2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105B39B962;
	Wed,  8 Apr 2026 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr1dGgN9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5C39B95F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635419; cv=none; b=OKFC+b2D4Wal+fqTxtuxGE8vV782h3uOB6wLF/mXtgrQQTlUAVA9EOwOdS4vq1kMSKmcOx0zcUQ+esp6opDcnf4/8P9kIyRfntMz7huKiGw0oHn6YN5z6LbPiJOtt/ULjZrcMZDi65hbMZPnpvpiZz8AJSwe5yl0Gtw3GaqZ4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635419; c=relaxed/simple;
	bh=Va0s2f1AaEPkx+AyyRL54sxCExc+KPnWIV4rltBNZ1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAS/QkAeaLFpiYbIA24P4pAPuWyQpYDPT8SlU4gVoXqRCbZmbEAJgiwl0ph42YUPjiiBkvPtMn5Da7iUojUJ7lLlDqL1grwAvxTo5aYvbCW65c9UdpiUcgVG8bgv0iVs5jt2gyUDjrBzMOpxu2KubBz0aHHbBGBpGxGoplMShlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr1dGgN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8344AC2BCB0
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 08:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775635419;
	bh=Va0s2f1AaEPkx+AyyRL54sxCExc+KPnWIV4rltBNZ1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mr1dGgN9a8otqKlemMZ5N15Fpo3rfPizy4YRyWZ5jZOEAMyKEUDf9JpoH7GA4YWzt
	 YkrI3NfL2aTfW+TfUJu0rQ9PVWk8RaopjX2WtDRyJlRKoodGFYEIRoYCTrlfc0gkBW
	 0vsCNM1JgYcg3m6yht4a7iER/UxUGki9Xw8tVUW3Xj5NN7Ul0gXLzUi7fidB0KOtsE
	 Vcg8o2Mn4aToXLgkkYpWKvpaBQgwJSfk6Cx0C/NbVuRWQpWXDUqXcG9Aj9jpnjmzk3
	 Eqo5ilSLkm7gjRip0Qpx3Q2ZIM5M8fbwMHLkVGVhd69pk7eV33GTGT+jR46oAlgMpE
	 GyrDf2ZHwa5cA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66f3093a9c7so3654548a12.0
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 01:03:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YxM7zByDvGOEQk2eOHnjLHIMEzSfItGvQUCgC1lMJubQM2EWBeZ
	roS3D8Nx64em8GWl69UJHAQ6uC8zjx9elxgHWuQYDNeKR03f1zr4LzhSKwKMObVOdGBTg8CdNde
	u8QKfYb5X+Tn7Fpl8H+ibnxGsK5a/dU8=
X-Received: by 2002:a17:907:9614:b0:b98:48b1:b129 with SMTP id
 a640c23a62f3a-b9c67a328d2mr1082279766b.47.1775635417945; Wed, 08 Apr 2026
 01:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408005837.743802-1-sashal@kernel.org>
In-Reply-To: <20260408005837.743802-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 8 Apr 2026 16:03:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4AR3bxwk5SD9HKHgFigSry9bY50m_6g+hy24d_H0toYQ@mail.gmail.com>
X-Gm-Features: AQROBzDAXEuFuSUWiJNK0OJJVAbVrG7HpQh6UzYF5TkB3WawbeFUsI9KNRXIGiQ
Message-ID: <CAAhV-H4AR3bxwk5SD9HKHgFigSry9bY50m_6g+hy24d_H0toYQ@mail.gmail.com>
Subject: Re: Patch "Revert "LoongArch: Remove unnecessary checks for ORC
 unwinder"" has been added to the 6.12-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, sashal@kernel.org, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-233815-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0973B3B8B27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Sasha,

On Wed, Apr 8, 2026 at 8:58=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> This is a note to let you know that I've just added the patch titled
>
>     Revert "LoongArch: Remove unnecessary checks for ORC unwinder"
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      revert-loongarch-remove-unnecessary-checks-for-orc-u.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
We only need to revert "LoongArch/orc: Use RCU in all users of
__module_address()", and this patch can be applied by adjusting one
line context.

Huacai

>
>
> commit 3d853399df67f50d070f6ba643d69894ee9d0986
> Author: Sasha Levin <sashal@kernel.org>
> Date:   Tue Apr 7 20:00:57 2026 -0400
>
>     Revert "LoongArch: Remove unnecessary checks for ORC unwinder"
>
>     This reverts commit 5d8e3b81aee2c18610c5f440936f0bf3b6426e56.
>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/u=
nwind_orc.c
> index 4924d1ecc4579..59809c3406c03 100644
> --- a/arch/loongarch/kernel/unwind_orc.c
> +++ b/arch/loongarch/kernel/unwind_orc.c
> @@ -359,6 +359,12 @@ static inline unsigned long bt_address(unsigned long=
 ra)
>  {
>         extern unsigned long eentry;
>
> +       if (__kernel_text_address(ra))
> +               return ra;
> +
> +       if (__module_text_address(ra))
> +               return ra;
> +
>         if (ra >=3D eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
>                 unsigned long func;
>                 unsigned long type =3D (ra - eentry) / VECSIZE;
> @@ -376,13 +382,10 @@ static inline unsigned long bt_address(unsigned lon=
g ra)
>                         break;
>                 }
>
> -               ra =3D func + offset;
> +               return func + offset;
>         }
>
> -       if (__kernel_text_address(ra))
> -               return ra;
> -
> -       return 0;
> +       return ra;
>  }
>
>  bool unwind_next_frame(struct unwind_state *state)
> @@ -508,6 +511,9 @@ bool unwind_next_frame(struct unwind_state *state)
>                 goto err;
>         }
>
> +       if (!__kernel_text_address(state->pc))
> +               goto err;
> +
>         return true;
>
>  err:

