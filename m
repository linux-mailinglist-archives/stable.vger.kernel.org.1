Return-Path: <stable+bounces-232580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMg3BtY6zGlyRgYAu9opvQ
	(envelope-from <stable+bounces-232580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:21:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8744371970
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1359F30E439A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD044CF20;
	Tue, 31 Mar 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgpZbKDP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A144104A
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991688; cv=pass; b=nsqLKy1yNaZjRBF93Q6N5vz7OTRVqzIXZaWE4RiGKV+LNT5fvVtRDR/ZHZ29eUA/apOyeIpKP3RxkW+arfUiKSiEjqJGGgE9FNi6A+QztCXpy4v+J/DKeaBrD0CqXC305RGO6Sp/nWnHnYMezQjtyWOwexQ/Foi+VetmQuCOlM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991688; c=relaxed/simple;
	bh=+JxsCBfymivBX08sGiCuLcobIN7cdPrVFtFlzFTvswg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxS9glY21c3qfrf4U+gUiZyyuIglHiLS8C4NdBaRHSQ3GcsCRKqWY9hpUNfLuhka3rs2JdvJRPPn2WVqsJv91kWyxScpFwY3Y2TtQJTxGcQzcnbTkNjObxP8r71RBBgTZt6J0Kc1fvpYUibMfdW4zQBANXKna3NPn0kDe6UKlvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgpZbKDP; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38a42d3fb6bso4369091fa.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774991685; cv=none;
        d=google.com; s=arc-20240605;
        b=PmTLLvccp4nLQVcn80GbqDcGm1S1ImJi4xKi+4qo7AugwqNYDHSIVepYJAqm43odrB
         RlwmLb0iJJVSgxuUKnojjxmBnimqgYscy7+h6vA6lK/anjndxpXWnod8op4VrNMGqOqe
         NWy1US+HpBscHQhLRr/nXNffXGdJUuPEqsObECsoAM0G4ztsJea9dpEsQgoppxJRXo3i
         4BKSAjW21iA/5oHNLNP0x6NjNcESaqP69+3Mjg91nsQIFlgKYTjQ6Qj5Lf9CYGQZCJO1
         nBMMFY/q/yGS1xYp7L0P0gz+6zE5Jwk16lnVOHbysW5Cvh2QSUulTdGNe5bO5f0SzQHQ
         zaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+JxsCBfymivBX08sGiCuLcobIN7cdPrVFtFlzFTvswg=;
        fh=ZOz3nkpygXVrB87OWii3HDrv1DxejrZx8NtQyxD7K20=;
        b=QvVUch5BxzlVv0hvVJUsUjaD4xkxdObNZ6qoBONxn6g9GD+pxcMic3yKsTSgS13TNB
         IXeDyRjx+9bzTyDvxwJvQDVuZl6ecVPSFoug5Wa5VpdISy/y+1eioFCXsD9RGumdKS3u
         ms1N/aeX9Pt4KGaMY0rOjYumYJLPSPfXxZ4mCetWCAFt4Sk/WYDC1JxNgdiOyo2JkW1D
         WLhRqE3dfyt+caIIbyUSTdHkZK3X1YjjGvLEMlAIAXsEK6mhdCCEpUvwK8yCR+CztHbF
         9oVlILoWPowsePq7eQw8mEpyEcBx4KkQNI5tmZ9MI1Cx8u89/DQiq0Ru+0P6mcQIIE23
         +vwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991685; x=1775596485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JxsCBfymivBX08sGiCuLcobIN7cdPrVFtFlzFTvswg=;
        b=pgpZbKDPX5rw9ZhtnZLPYXW9O1nqFMJtqu7lejQhRDIbHBVvV0da2co4vmSlry6L2U
         J8K/AMGbwV80DKFjqhkL/rYszDWgGcwg3KjjF1CACaPU6qjZPhr/Jy1ceiio8SugpPlq
         /0FgazDqRin9FOJh1VwutKYbFG8BpKcVJUejLGGTIs/htQNMhbpQ4iWbTjY8mCCTSpIh
         LZi/OgOhJoVaO/IzY0bprpXMwM2kfITgLN7BlSVjq6DbIWrDstq7M6/W0Qot2d0hy0uQ
         6OddvKRfxFfDDLKC9Rr2/RMOG/Nszm98C61h7IoJY65AjF6fKxJORf0/+Tjnu1O2gw2J
         6W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991685; x=1775596485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JxsCBfymivBX08sGiCuLcobIN7cdPrVFtFlzFTvswg=;
        b=kZnE7qDwCQvoqSXX/LhaCoa4BonHHpwMcNy82krjha7IsuPIf83bBn3l1VYCq4OaNJ
         jOJnPdqNDy4WCtL1qKLHuhkoR+P1dRUxt4xoIBEk7B1YoJJja/+PiRI3oDqboDT8kypz
         wmDgLkaQn+VR+HTry7Nn6NU/GVayPSDRsYrNYePbchR9W9+cetyla6EM7MANzt5fnvRS
         UU4HjuA33CI9fxtvn9yxmytu4xHAmdnVu3zZru5wUyvw83nqEWBq/re2KbJGpaGWze5I
         XAieh4yUUoVD2Hb0+KudN1PqjNiMnYGojEd/0BKrze7jaahx7F7c1GMqWfpWE5PiLkLt
         7A1g==
X-Forwarded-Encrypted: i=1; AJvYcCXORW5y21rT5Tzx2FXN2pbeEk6DFhj35ovnwhuYDkvqRPv74VWL/pm69eSGGr8jeqQpuPZ//EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+xLINCuaEho/CI34QmErybJLRatYGPEBfwrA8iatsOQ9WErw
	cbcIcSj0ms+8diQuDhVBEncaF0BivGl+Qbwjbh42P67HnWoLNlLD1LC2n5UsULH+l2YnrC5ByJJ
	aEgTagzRxnz4LFxhx9oeMHcq2gl1AvjM=
X-Gm-Gg: ATEYQzyvESvEKTvQAmx/tkj6VJp4wtvjXjdH42Fu9rRDAJbj6Ry3XQz8ZpaQs2sOwbT
	pKlHRwAQs60TrX89G7P2kcRywtsrjxDgFjX0RFKueqY7cQCnCb918ZQ2WTbWrdCFWCksd4NWyyN
	VhFHDubKdZlLttGxfgpz7lILF4V+hvMJovOZPuwjuhbfuTORmDXlgV4gt6nB0ot1Us1QIeJdTNV
	nrGzA2lrF6I6iYCdTqxo2lo3HCB1qVDhq4T5dhvZ86/xH639ZN3hqhG2pBPoTHVgXwckR+q21aS
	cD8QAIie4y8ls9fSadf6Kf+BUOz4RHirHhdXzetyAdGS32EhMlP9B/vY1Jw6qNvjFCqAQ3uXzOm
	uP2z+UppqsTWXcLLmKSdX5f4=
X-Received: by 2002:a05:6512:68a:b0:5a1:3921:ab52 with SMTP id
 2adb3069b0e04-5a2c1ee0fccmr147403e87.2.1774991684307; Tue, 31 Mar 2026
 14:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <DHH9VRFULJST.383BKVSWUTZ3E@garyguo.net>
In-Reply-To: <DHH9VRFULJST.383BKVSWUTZ3E@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 23:14:26 +0200
X-Gm-Features: AQROBzDi8zFnFshWYLfIMPc2xGZV-8btLPSlxaPEnVYkLTlH9_dpustOMhcwwhA
Message-ID: <CANiq72=wsdJf1_qwAADhmKA2i7y9U+3WOm+9utE2rv52_eqnpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232580-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,google.com,protonmail.com,umich.edu,vger.kernel.org,atomlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B8744371970
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 11:07=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Does it produce a false positive, or it's a false negative? If it's the l=
atter,
> I think we don't need to disable the lint.

If you mean for custom macros, then I think it is just that it doesn't
take those into account at all. So I guess you could say false
negative if you consider that it should.

In any case, originally I just cleaned it, because it wasn't a big
deal either way, but then I thought it would be best to keep the
behavior the same. So either we disable or enable everywhere.

Cheers,
Miguel

