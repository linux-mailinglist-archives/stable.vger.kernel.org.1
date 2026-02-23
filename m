Return-Path: <stable+bounces-217809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNAoL0iTnGnRJQQAu9opvQ
	(envelope-from <stable+bounces-217809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:50:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0F317B11F
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76FF7303FFDD
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD183382FD;
	Mon, 23 Feb 2026 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdhY91xI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51815337BB3
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868810; cv=pass; b=Azx8OKjU1Ajeg7VVF6xrbbkDpUg9hIV7bCwpaMPMkq1Hgdl81qyJ1euSzGP88wiPzYph8clBzZzCFi4m3kpHrXs1wJNV0UUuRaH1wvnMZ+TT0yE4BqmXkJc9HoFgYJI5NoFvQohPMrcd6pijxCWdiCyQaDLxdloaLFLxq1ocWMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868810; c=relaxed/simple;
	bh=uRM75KelixGIsxm/+IM8nHx9hpzHQFEP2u2MRjBYNQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUanOtOfF9zl9Vj/WU3l28SrPd5O+M29Pi4Wsm7LpzNQ3+T2erVfzyEgxTul2xsaHFOhx4IqMhk89VAlbR0L56rTzfKRNq/Wv72sR3mw3fJK8QNXJap9M9jMdba0kTyecGp4h4Zt2Ue0naUcq0SAmhv355UfSmorCEbYNUl8YD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdhY91xI; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bda3b4318dso116236eec.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:46:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771868808; cv=none;
        d=google.com; s=arc-20240605;
        b=ikx6QnCt/P17bKTWz0y7ZXAAwMcwl//Z8hsLu31tnU/cKxYYpeT9Kcbt1bcEOYtg54
         wtDKcnvpc4TVxW1d8rjCNfCkAtxjEiU3OJ0yh8okAooXz9wHZS+81edbP9NbhU1NGJzl
         B7URgzvbbloefzd6m3dkVqnMK5SIjGzwICfZlK3Q5Ri0sth9YuINLki7etF8LM9fdBjC
         xuxqDXUc+wLt7Zww7DLdwKUnmrj7QXbMxj8d8lT3HLlNU59yYDVNe7BBNuwz6GEGDVBt
         GRNTeM4xNK4T7HRFYOHhVvegsxETGzrIuRS72fyrfphwaGpLHfU0cxjv9qlyHzwMyZzX
         ydvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uRM75KelixGIsxm/+IM8nHx9hpzHQFEP2u2MRjBYNQU=;
        fh=Eb6SV5bFsQejIIKX5WeUr9THOmqJ7t1qfAt6q2FGDRc=;
        b=L5sGZ/NKhyMavo0j3uQKyylvjSEaKVHNxbdcdAXtMrOPHGD0TvZiyJyxdB9xijdgX9
         9Hg0v4ZDJPuUMk/G1arIPistKSFslq9/7YFLmqjZY4i2b1AGTFNVtYeHWTVdfcJ941/k
         l9XuwUBsPTS277YZcSKUrc5OCXRoZCbEA4LoFKgh87ivsI0tRDXr2V7gislXXEDAeQbE
         OguxhH+/d5LNsXh0DQi1YZf5LCEVSKdv5ZGzehFl0MYnEAodf9QfP9Fudxv07w5Xy8R4
         h8AyJZHAkmhrgHUI2muLzTe4XQdwtsmlcyOC/6pVblC+ufiwHUnhB1Yo61aauhrtDZMv
         utiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868808; x=1772473608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRM75KelixGIsxm/+IM8nHx9hpzHQFEP2u2MRjBYNQU=;
        b=ZdhY91xIy0ZWY+/a4OONW0Az9OQmKGQqloJFiU1z5w2gSHD1xw0r6qdASemmN8yXdK
         +8LpsYHSFkqRyC7qZ7lpvK/vytpOkBicTJtij6JYNT9ZCxaCjPVN5m22oQMFs/fycSNA
         wuCqN50DatRJsSCRVLwR318lyknfeRvMfxiuYnpMS5cwPOomIRVaHXLjhxyeaCZEMzoG
         JoIbye5YgFls5sEKlSN9ZIHqsY+sw9xCKTIDCbBZCMVLfLSjQmj8SKpvTe5/1j6FqgqO
         BKMjl8bEtVk4SXi2vuyBkxNF6ONomAhcW4FRY948auzSqT667yIIAFx8o+fzDppeueT4
         OMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868808; x=1772473608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRM75KelixGIsxm/+IM8nHx9hpzHQFEP2u2MRjBYNQU=;
        b=SgMOYOIiJGmZQLtNZ7EklJhxr1AzRNg4f0kkRejlWXZ0RYwap6p0kNPyJUjaOmc/K9
         ZqAmIY/GzCEsNPVtulwkJsNzTZfvjCr3U1BC3xYAJQTqQ2t+K5ZQqK3cV738ksOoRTr6
         g4f45y9GE4i90ippbR4g8FqYqFG5nY1fjaf2oLNM/fPfYJXF5NNDSGxUPpvCPG4zgm5+
         V5aNUNtYMQ7fBO3KyJ+LeQwDL4AHhM9b6vK0KNmdt1L17wS1YDc3hf3UTPurXNjeENzF
         pYUZL8/ua5uKQc9ufBc0tVq8n9wKzt2xkDdaypbhk6m2Co2uonSu33xMaeKZ71t4dX+S
         213A==
X-Forwarded-Encrypted: i=1; AJvYcCUMXwfUCx1USL4mwk78rWyaqkiM8v+g21wO+Mw7lwYHBcodkQhIB1Herr3NMflB8D4nszCO/jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjh469vnFVe3Jq2mFVB3mrl9lDsr6VtVkvd+Zleqch2qYP/JZo
	Myb5xtC4AeuoqV2qYumR4WdZCTXKY9w60zMbhMbnzHJewGGDRGCLabxAiCueOIfhHBDvsYrTFRL
	yikmZWJ0bU5OQGxxJ2nV0FVjfyl2kojg=
X-Gm-Gg: ATEYQzyWp5jABz4R/QluwrJ54jj6Ioresg1l3vrSsph2NNPhNXgHMTZMMm5f/mBZjUr
	/gD/DVLJeMdGzCGSDUbfWglehBmyYsO5kFOKGUVMx+nirYC/QqETS7xUhZaxp2D2oldMUm7s1eC
	ulL00SEqxdGfsTFwYcovoacFiAE8cq1sBpSHP6WVLURgwqLHrnHRpq7k6drZrOi/SDEtf8qxQ8y
	5fVRQfmyZwUjud7b9qW6jrtQDAxQGs3EBllOgQNnjjrMiefC5N/3T3Ym0Ab2wn3JMtqoUYq70k6
	6Yq9SZPuoizeaZA65GRrfAfIaH06CRoaP6/8U0C4tyMk4jcnSJ3iVDKS/VMn8JrrOcQsIDFE5Zk
	Rj94kPSqBvLnODLJ1cLgXWPs+
X-Received: by 2002:a05:7300:cc0b:b0:2b7:24a1:865d with SMTP id
 5a478bee46e88-2bd7bd59ff2mr2223350eec.3.1771868808231; Mon, 23 Feb 2026
 09:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216131613.45344-3-phasta@kernel.org> <CANiq72kgsgSW5tPj3xA0DLhJS8yBS_uDT=xDbNE=rf8t-H8Qzw@mail.gmail.com>
 <fa1c81f58b05faccf69dce8645a337f7bd35a9f7.camel@mailbox.org>
In-Reply-To: <fa1c81f58b05faccf69dce8645a337f7bd35a9f7.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Feb 2026 18:46:35 +0100
X-Gm-Features: AaiRm52e7_dK58aZncwTrkjNj-Bo9SEK7apgIGA9TqEWNRFW15KQs_C8BO6v0k0
Message-ID: <CANiq72=O4KZCLZx0iJtOC3QFxtX+g08VMt4tp+CBPbS2pPw9SA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: list: Add unsafe for container_of
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217809-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mailbox.org:email]
X-Rspamd-Queue-Id: 1F0F317B11F
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 8:34=E2=80=AFAM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> Feel free to drop it for now, I can go through it properly with the
> list author to see what the most accurate formulation would be.

The commit is in v7.0-rc1 -- please feel free to send the improvements
on top of that.

Thanks!

Cheers,
Miguel

