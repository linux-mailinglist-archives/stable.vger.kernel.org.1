Return-Path: <stable+bounces-215839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJQzNraDjGmfqAAAu9opvQ
	(envelope-from <stable+bounces-215839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 14:27:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A64124BB4
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 14:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 864B23006455
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE81258CD9;
	Wed, 11 Feb 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnsteEVk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2424A049
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770816433; cv=pass; b=CFOmVTV4MgWkkzeQ24RFn2FGDUuuugl6KQEU4EHRCpci4onPbfSD7FevK3LpLnVayhWy+7ddp92JQxpZi1vqtbZMoc/mRQkIDLZ/+sTnSUx3OMKK3qf2jNCECWK6LN5doTmmMpYoUt6/haYLfwuuGOBqpKxuHOd9i1ewDapCRNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770816433; c=relaxed/simple;
	bh=4FDrHCkVWXS/VwYkhc6RadyjTesUf/W239JfUi/CFQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB1RwWZFyPTGz9OFQZ4Dm0WhUynvay88ASRL5RZHUovCCbx/kC91QHmgCnPycwsnykG3NIHR316XOY4o98+k4MYfhVsDSltMFG6BGliONIJAWpeKsqpC5j9zJN3gER34RLODAOTs5OlerGI63GuyjYk8kxwRGa3fGQiTTJ9+ExA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnsteEVk; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b8095668ebso554637eec.2
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 05:27:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770816432; cv=none;
        d=google.com; s=arc-20240605;
        b=cFnGpUJWLjhSs5+P4ZdyTirqBFtk7bSHeASpX1VnjQpjxnwdMXAlMKiYMqo/WI++oA
         OwW9pB/4rhOY7Vz2LI2khpcOrQ6MuNWYVVQEjtGBirDwDc8uc4JvBrga3JG0DP03jQWj
         D2z9c9a/d5XBy3RSTZzMfllgJlic94lRHUqNGZfcRauAX4KHQdnBilB+YKmAWTx7ONyz
         Hk/EO2LkMrUnbUE+6fvfTUhTl69ysuf73IbwNtFfN51NEfzdW9I2djzePpjI+9RrHXfw
         8aA52x8wKiWMC5f3DCvWzDlIv/T7Yd4UB8UVQ5A0qPlwkMszVvXZwNhn5YOrDEArVBcT
         2IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ydXgQTl/HrsorvtS7pbkIpZLZb4j7VznGUWQKvfye24=;
        fh=IDLnJOyFwAYgkVttGpg/6OS3rJWaCfiuwJkjwxUp9VY=;
        b=K6fY2t2OyTlrOWIcl9ZQ71Jj0D3lCQLgh/pQDZZNMdlg4kPwFllGTH6JFLcAjy7NJS
         LqGFHqGb7PiqKqwfNPslmQEpl1GfuSJba7ak9F83NJ5ng+s6uJg2IMhOWTQEfhgdkSlS
         7jWmjqWqugm/gSdE1KKrV+qJbH5jZEkOVAXXYoOpU3RzOdj00PFoHEb3Qi7tG4fs4kTV
         rZJD4BCrPYGNhr4w50liL4pXaXrO/ycIZxEpA232oOI861hfDkAGMbu4Giup6FomwiAs
         aHX0Ysf0erqlW4hrRkYTZyEcV7v1DQVHPKo4ydWif+zS0I4TyT9Mj+c7x4Io22wBpFQ5
         MC7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770816432; x=1771421232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydXgQTl/HrsorvtS7pbkIpZLZb4j7VznGUWQKvfye24=;
        b=ZnsteEVk/50084WLn7LwpbafnELspFOTMI72fIbPrHewRyb11mP5NdBNRLucZWjU7Z
         mWcO3EUpDAHXCZxO5yIKcq+Je6IudP94EsLX5Y2n68lWVOdwwzQPosgpf0sL5VxgtkR+
         DIS9Lz8lllN3Om27ApJ4XZnZsQ6rBisG+Pb3vi4+hed+nZE/aJiHrA9yI+kJ26qq8Lu6
         +6+kPDcu/K/CkGDJjB68/VxVZmSeZBf4zOudOmKm6zal3Qwuy0i+CU03HvAUjIbjOfHN
         6lE6Jdh2dhN3KNEljxmwidNS+QxTXzVFMAvLkyz7teeVEW5fzTPmXZUjp1sTDuyMPEIY
         JnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770816432; x=1771421232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ydXgQTl/HrsorvtS7pbkIpZLZb4j7VznGUWQKvfye24=;
        b=RpzHkbI4/nukHhyLn7/1hAr82iZEjamGpdOhlypW3erf+9hmoWSiAkTZhEkBgocBpb
         0ssPPsySWBUxdaLoRt8v+kRGEh1VAQogZEbUvfCpsMES7jQI+3+nfePAdUiU3C9PeRx2
         ve4z85a+DKn+ra7+jmGUEgl/KcFYRFxabMTvs3B7LFKzY4edBQ+vPBX0A6G0MFrf7UzC
         OwE+oYRixkLVaEXJqARope9KXu6QpqTtqIXeGdwzYLDuIC/2VJpDqVif2Bb1DdpxjWXp
         K6mbP7uVz2lcTyl8imcZgQFj5LfdrEsSINrfGRdvZEwHd3erVuCbZIjyDqJ5I6ar7+5U
         urhw==
X-Forwarded-Encrypted: i=1; AJvYcCVZLhI1Uvx7Sd9d7Eyb+UUGEFIQ04f6HjtDvWFxNsw+1oft3DlmHP3u0vSutd9wmL5WrtqFjac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRZEyZsC/N7cwUvitzgNHuonLvTNu1f0qd7emDiLnJdGmkPEl
	piwOjMXWdLgfPxG17iWBxN5r3j/uc9RwDDkmajoARi6nTT6034sBR38NVJSJa4vFAd7me9elHAB
	HSDPJZgxNRVnSzeQroscKsfk2Atjt0H8=
X-Gm-Gg: AZuq6aJv3ayFDTyUiVnjjI0Tdsm7pCLJaFDvIwjbpFbARDMBrTMq/klopAsUkXLFj2Z
	JWI4clfaSIb09njkXz9KwZPNPrrsnaoCJO/uws2+yu8KIs8pdGstFqMcF7sxhU6PsdV9epoTEf/
	YU+UZg04p8M1/DjTZ8Iv2QSiXUNcWQBcQ55ag/iDktGznIsP1S/u/JGaNGG6s2yDnldVANBK6I4
	7u4EIhrMGayOBJ3TWE2Z8IjcrET9xKr8aFxTtMDBYULfpjuNgkKYMR1SHgXAUZFy7iRVqNgvzCM
	9I2XkGM9bsLGKZGYDVB4DwkKt3O2xIiMXMGMhcWcO1rRPJoT4sG2dyWxYxfS7Yt6lDsgIu1gEK7
	YV7jVSBniIQWt8SIv2e2/0ETm
X-Received: by 2002:a05:7300:7c0f:b0:2b7:3678:2d1a with SMTP id
 5a478bee46e88-2ba9e160d88mr408678eec.6.1770816431570; Wed, 11 Feb 2026
 05:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-fd-leak-v1-1-945577813b20@kernel.org>
 <CANiq72=+2s48M5imZ7tZj-0SN==f_mLmw_2cWfQYKtBhD1ROCA@mail.gmail.com> <CAJ-ks9kps0L-VenCoHdYuTvRphe7-dk75koutbiRfNUKGi5zjA@mail.gmail.com>
In-Reply-To: <CAJ-ks9kps0L-VenCoHdYuTvRphe7-dk75koutbiRfNUKGi5zjA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Feb 2026 14:26:58 +0100
X-Gm-Features: AZwV_Qjw77-MwLOLcUdccsuyFc9ezvElnVTszg7lVmI6AHWii4FLt9UmkdDWYxE
Message-ID: <CANiq72n3OzakTkdWPhxS_nTAtN-9ddeaE3iNcGLnKfqV_4rgnQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: generate_rust_analyzer.py: avoid FD leak
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215839-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,web.de,vger.kernel.org,collabora.com,kloenk.dev];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,python.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49A64124BB4
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:39=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> I'm not sure how CPython could close the FD immediately - it would
> require the GC to run, at least? Anyway, agree with you below:

At least it looked to be immediately closed from a quick test I did.

I assume it knows because the temporary goes away and thus the
refcount goes to zero, without needing a GC run:

  https://docs.python.org/3/reference/datamodel.html

> Thanks for reviewing!

You're welcome!

Cheers,
Miguel

