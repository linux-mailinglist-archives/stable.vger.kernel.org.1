Return-Path: <stable+bounces-215726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG0EEnzFi2k7awAAu9opvQ
	(envelope-from <stable+bounces-215726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:55:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B759912030E
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4E73047069
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 23:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B5033ADAC;
	Tue, 10 Feb 2026 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+rIjo+y"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A0322C73
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770767734; cv=pass; b=avzGscKU3FQLva5JG9pyiOila8sKjkCUXcIsY4ZHeoFxLZPor9Uy5Q4V+4x1X1lfdbEf4MO+GY5cacCaYwrCMEEVIVzX5/Jxaeysm3APPsFly4xf6Y9O66JxaIH9+PqXErGyg+0OcTZgwxAMonaqeZhw2ZlzMd6lgOLUPHGpejY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770767734; c=relaxed/simple;
	bh=4uWbQ7qEGVK7s6dzdSol4VsuFBEkwTb07g2z1PgY5kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jy4JleYT9ipcTn72Ad/jCsRLKJjIktZIL+NkerPGZP1QtQa7DVWJ7Dw4nlXJT5t0cRwVrpROXsC9gLMo0sNji8JXlAPG8/f98VEIbciafGSwzZQU9E5MO0X7pbMLNnk3HE3UaYmDVskZcFGyaJFF/hbK99fMMGwxDqMIBPWt+EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+rIjo+y; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b867142b07so239172eec.0
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 15:55:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770767732; cv=none;
        d=google.com; s=arc-20240605;
        b=dKNW2vHs3FOnAEFkTba+HdykTzFb3laYZpFTdd9rkt6q67X1rQcYT4K30C1uq4shLU
         na14+517OcUBiquwke2bfDcA0nLi4fjIcrArKdaU56zvJNz8MknBe3MAoakSgh6Wc0uN
         eqmiGXgiAkk6vxW3qm9UEjVzqSTL3j+oL1MekdhP0aOaV/lTZOnjTbv8aarTaRyeidYL
         8+1BbZ5SoKfVoPUYcZwvEQxb40aA0xqyddKc0UFdfS4IINjmYD0kJyGweiX1Arf70Qpy
         kCb3WE2UuJsXnqE1PoMC6LV77y5kM5nfRdI91DPChMBKyv52wLWiJ6F6ibmEWUDFxxMZ
         2idg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4uWbQ7qEGVK7s6dzdSol4VsuFBEkwTb07g2z1PgY5kw=;
        fh=qYYZ6PAKUMZBPL+7wIUl0lMjgIc9ho/ByA2721shivw=;
        b=eo/ovul8ZsBibSYKg0ORzwSD3lB80awugiecEMXQZ2WfndYfTZwpHgz1kj3RCRLA9r
         SJ80E1l3bMEyUwoOGWGvA4m8VW/znuB6ftc0+Ag3k5BGZzzJ8BjPOuHRgjrgEVxGXGgQ
         g5NPY0cBa6OKXBpSpHk1CDzchgznpk1ojGDoxN1OqB2jVMYtwv1gN/wc5tJzSmAAjFzS
         fXEjNAmw4DICVGkUSjIhoWp+RxIMblKEPCvkw2bJ26WMzqqTsvwQADybEr2Uo/xWBYQp
         Qe6h6RUEXTAh53X9Fc2BHWJZAVckY3sxfCM43ot8+IltZVOQI3z9wZl6/QafYfL6IOgm
         BFUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770767732; x=1771372532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uWbQ7qEGVK7s6dzdSol4VsuFBEkwTb07g2z1PgY5kw=;
        b=R+rIjo+yeTl32D2LKK/1hPvSm0rb94oMG5avlKUGPXvh/lsjOp8hCDyvgiG9KHB+xy
         AVPE6L0A0pSlpR6hq+oG4YBbx3veMZ+XFGUh+FDVZwc2JOPSGewp/WzLOR4RwfhC/HdY
         UeAEz2R5vrB+cbYnXZvKuIUiLYKjZbFkvf6K12PA2kyu0eh7JFrgXQ7DZJrNYN9SRsT2
         0YUgbk/b741JbwYLdChRyAkfYKjiudF7yemagDr29oi9RA7qrF2GOxKTHosRp42vz+p3
         STn0WsxMupLfdp+jYEz6CDqhxiaJFaQYs7Qy2/7oZQ9Cq2usVhNYYUa5mmTKDV+bpHHx
         4P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770767732; x=1771372532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4uWbQ7qEGVK7s6dzdSol4VsuFBEkwTb07g2z1PgY5kw=;
        b=XizOYJkq8xR6gbirswHqXeBLvrFNw4IAwJvoqCjVC7inb4yChpm8ptT5cOmFmAw2EM
         EL841kO7maESCZ1DrosJI+gGdsCmd9IasETUHivN6maCN4TPYHBXAHNr1m+JweykDzSn
         eBPh9d8t8FsIjOarjfcP81cQ9ycyjvEdy9tMgUnOBuEBpDvRfbDYdHAlo7GKaTREO8iF
         k+GCntNx+Hvsjkg/ZyDRS/sTRFC5927jLh90qEsxPHIbg0WCEb0HH71CkxiWjFoWkhei
         /19url8pCEGA7rNadzTU8KWXdw6rP8bhZYiaKlem54GpTJjlmuAFCSE+0I2W+XpoJgWh
         lJIA==
X-Forwarded-Encrypted: i=1; AJvYcCVPIY1elXRaIhW8Y0UY7h6+pUkkTV5eUTCZWiq5RY2X1lsDc9w3RXyF8T4qLshTiOpx+/S1fg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoiHRrWBg9j32P9LW3ej9AYDhWsuCZD3suTRk4OzUMLrUrK9zl
	L+xTMWwzM3z/RVeph64rFUJVbarG2MA5juDg4HnUmOSw+zngQ4Fd9tlX6LWvrIBNSbZX/nuY0c1
	HcnvFOEqzG+T7FRMXs961bBQetF3aKwI=
X-Gm-Gg: AZuq6aKU/m4BIIPwM1f6/yaLE24pyRtFXtJvrEGlrCvzFT42O/CR7K7KB9QzAk1/cGL
	4+kjzMj6kqseKIrml9Lvy3McbjNdKtCwaXDDO1ErLsfPOw7RT4pRUWef5SLdLDJ1B49QJcUT+bO
	ga87box6TrJJiBx8BiLQ/6ha2q0cD04o10pdUN7T1rtZ3MsrJ60IdiAcHVYa/yutEJXawRYqcKl
	CaQa4qgNkFSy9jpgvo2PQaPMD3Z/hhIOOq+plOHjYiL2C5ddtk2RSExO35bMRnqx4eVucC3deFM
	At3n/6Hfo+WjYDOnRzHi55c8Slp/Bjv4Y+x/ZY4sMQy90Ia9NRbSUDpk+BheeqrbzjE2HGwWlXB
	1Cc+FmxiyOG0wa6Aht/Q1um+r
X-Received: by 2002:a05:693c:3b03:b0:2b0:4f9a:724b with SMTP id
 5a478bee46e88-2ba8cdb3d32mr825524eec.6.1770767732055; Tue, 10 Feb 2026
 15:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210232949.3770644-1-cmllamas@google.com>
In-Reply-To: <20260210232949.3770644-1-cmllamas@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Feb 2026 00:55:19 +0100
X-Gm-Features: AZwV_QhspIVFMH3tEzHxhp3tdie1pO5H-yKNMpIPHp3A2MnDfnLnbLxBqljb69E
Message-ID: <CANiq72nU1rUrxfAZUMeOF70gwvTPqo6Wcv6VUqYZ6mCPpyY=JQ@mail.gmail.com>
Subject: Re: [PATCH] rust_binder: fix oneway spam detection
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, Paul Moore <paul@paul-moore.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, Miguel Ojeda <ojeda@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Tiffany Yang <ynaffit@google.com>, stable@vger.kernel.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-215726-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,android.com,kernel.org,google.com,gmail.com,paul-moore.com,konsulko.se,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B759912030E
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 12:30=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> The spam detection logic in TreeRange was executed before the current
> request was inserted into the tree. So the new request was not being
> factored in the spam calculation. Fix this by moving the logic after
> the new range has been inserted.
>
> Also, the detection logic for ArrayRange was missing altogether which
> meant large spamming transactions could get away without being detected.
> Fix this by implementing an equivalent low_oneway_space() in ArrayRange.
>
> Note that I looked into centralizing this logic in RangeAllocator but
> iterating through 'state' and 'size' got a bit too complicated (for me)
> and I abandoned this effort.
>
> Cc: stable@vger.kernel.org
> Cc: Alice Ryhl <aliceryhl@google.com>
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Cc'ing rust-for-linux (we still do our best to send all Rust-related
patches there too, to have an index).

Cheers,
Miguel

