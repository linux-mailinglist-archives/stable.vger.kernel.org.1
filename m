Return-Path: <stable+bounces-81207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CDD9922C5
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 04:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B7328175F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE913AF9;
	Mon,  7 Oct 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kev009.com header.i=@kev009.com header.b="tuIpb769"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72F5234
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728268382; cv=none; b=E6NDz/b0msN4bfHuXuIZCwgT12bgo/LSnM4wSzem5Yuv3dIti2l/C97Ap5XuQ6oT9Tv2OH8/dbPc/L4WuCVklr0ai6LdN31by34yFPa9LcFaaOI3OWAKdUA7QKWzYZsKvw64CaaK2kXGuAIGFXgLyWtm1tGiD2cqyKJ56JT68aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728268382; c=relaxed/simple;
	bh=UmYzWjwwdRldGzMtasrj0iUPzywF33QHaFRM8bXmb/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cc3Tzkidt8zN1IxKuufzktbHldZT0DtZX3osblG2Q2XI2tBTrOUKVmwg5eZB+NGiSildwNlL+ysvncN5CX6xXp2chSks+2azBmlJZfL0yw1+tZp+aldcsX9VzkKiRSzMeZUydvVs9c16eDKyH+kRLmxu1dBP01koVP500uFyPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kev009.com; spf=pass smtp.mailfrom=kev009.com; dkim=fail (0-bit key) header.d=kev009.com header.i=@kev009.com header.b=tuIpb769 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kev009.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kev009.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4583068795eso39503391cf.1
        for <stable@vger.kernel.org>; Sun, 06 Oct 2024 19:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kev009.com; s=google; t=1728268379; x=1728873179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIagNj3XBeiwbes7ESay7OedVVX9YeO+j3SWRSuWDgU=;
        b=tuIpb769p5oD0BWU9SUrJE4RyPonSCiDvwzOKjzffMGJDU82HUKHq4lzCS/ioKYOrm
         QDXVeJV6LQjGIWPMtPKHYfrf4AEIiyZpWU3He1FOCy/6WqsM0rud7fQP4UtlJDBTZCq1
         ZjzQRzllrHWRp3q6Q9zICqXpK/uhznT/YuZoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728268379; x=1728873179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIagNj3XBeiwbes7ESay7OedVVX9YeO+j3SWRSuWDgU=;
        b=TZkqR0f05c4NX4EP1cAvSumoH9KJ8KvYEz1UpXYn6RKK4P6XKVtYTK9GwCnHVpIgZW
         Ywrk1UQ5r3kMaOvwWQQjGT7ASgQFvCUxusbRxv63BvP8COQpcN0aM0XGLEWpg/BJvb+d
         SXpCz+Rn5cHEu9Vej89aW6O+PBsYQCW0GkGCQczYv3+lxBgGcsGIhA0LS1tRh7Q3RXvf
         d+gQBhYe/cWr2bAH0S7/c1T8H6J8kU8NcAcwrz9txFXuE2vbtb4qzmz3b+W/WSOJLyMg
         MjH28lP2CSVgmEw+f+WcJcX9DTrmjcKvavKwXK7kkv7dazsWuieDJ2Uz3Lu05SUCfA8R
         34+g==
X-Forwarded-Encrypted: i=1; AJvYcCWnVGtKZhCAg7Fl0PoChpMObPwXk3Boda+CcJC3sArIQZ+JKOF39Tuo+3YZcpPhoCybb3APspA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHHGzTAIvrbDydq4qHsK7fyuQZ6UOzLRzOqAXrDiIJIcFyvTkN
	6H6F11jvvmBeWblbmuSJl1oe2+oBulpnXj3c9jQGneP4QzTuTjacCFaBfj9l1UHanOHVXnpwJyD
	mY59BJqmgU32koqynACjPbSBnBN4KStoalPzB
X-Google-Smtp-Source: AGHT+IGW6ESRO/rs7JsIqpNrzr5mR+Qf6lp+llFyFWrhgLaCLuuBhqRYKgzRWQDEQknxfpZf58As69biVB1biwW3opY=
X-Received: by 2002:ac8:5792:0:b0:45b:1d3:d9a8 with SMTP id
 d75a77b69052e-45d9ba85fdcmr172235491cf.27.1728268379057; Sun, 06 Oct 2024
 19:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801210155.89097-1-kevin.bowling@kev009.com>
In-Reply-To: <20240801210155.89097-1-kevin.bowling@kev009.com>
From: Kevin Bowling <kevin.bowling@kev009.com>
Date: Sun, 6 Oct 2024 19:32:47 -0700
Message-ID: <CAK7dMtDiL16JAXvTuTv3fOL5JNkMOCyjr6tVx44uDMKQxVnwqA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Print digitalSignature and CA link errors
To: dhowells@redhat.com, keyrings@vger.kernel.org, jarkko@kernel.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Hopefully this is pretty self explanatory, it just increases the
diagnostic capabilities of using the keyring erroneously.  How do I
get someone to look at it?

Regards,
Kevin


On Thu, Aug 1, 2024 at 2:02=E2=80=AFPM Kevin Bowling <kevin.bowling@kev009.=
com> wrote:
>
> ENOKEY is overloaded for several different failure types in these link
> functions.  In addition, by the time we are consuming the return several
> other methods can return ENOKEY.  Add some error prints to help diagnose
> fundamental certificate issues.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Bowling <kevin.bowling@kev009.com>
> ---
>  crypto/asymmetric_keys/restrict.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/r=
estrict.c
> index afcd4d101ac5..472561e451b3 100644
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -140,14 +140,20 @@ int restrict_link_by_ca(struct key *dest_keyring,
>         pkey =3D payload->data[asym_crypto];
>         if (!pkey)
>                 return -ENOPKG;
> -       if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> +       if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags)) {
> +               pr_err("Missing CA usage bit\n");
>                 return -ENOKEY;
> -       if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> +       }
> +       if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags)) {
> +               pr_err("Missing keyCertSign usage bit\n");
>                 return -ENOKEY;
> +       }
>         if (!IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX))
>                 return 0;
> -       if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> +       if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags)) {
> +               pr_err("Unexpected digitalSignature usage bit\n");
>                 return -ENOKEY;
> +       }
>
>         return 0;
>  }
> @@ -183,14 +189,20 @@ int restrict_link_by_digsig(struct key *dest_keyrin=
g,
>         if (!pkey)
>                 return -ENOPKG;
>
> -       if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> +       if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags)) {
> +               pr_err("Missing digitalSignature usage bit\n");
>                 return -ENOKEY;
> +       }
>
> -       if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> +       if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags)) {
> +               pr_err("Unexpected CA usage bit\n");
>                 return -ENOKEY;
> +       }
>
> -       if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> +       if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags)) {
> +               pr_err("Unexpected keyCertSign usage bit\n");
>                 return -ENOKEY;
> +       }
>
>         return restrict_link_by_signature(dest_keyring, type, payload,
>                                           trust_keyring);
> --
> 2.46.0
>

