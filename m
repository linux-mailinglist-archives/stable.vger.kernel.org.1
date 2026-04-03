Return-Path: <stable+bounces-233182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CbbNhS8z2mj0AYAu9opvQ
	(envelope-from <stable+bounces-233182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 15:09:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE6394559
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952CD305AD62
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6F3A9D93;
	Fri,  3 Apr 2026 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBA7C0LY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD237AA81
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221650; cv=pass; b=DBu0paQccVOD99XO1rLsu7RRtCXbDlqwmXcWJrDYFKO/ky2U/X1UuTvl18TDU8M1cgxnfB7Ku/QAt36gUOXoNp2REMSGpSX9S8q0Pha6gHRIuLpfj3sOue0fa/ATsV+dFgTwtgQdsviSNx1Pm0XVPrsgLJKDVa3Y4DSRM9vyk+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221650; c=relaxed/simple;
	bh=+uZaDMP/AozcYqTZf/oaFF3EszPbfJb/aEebqbPHujU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF91kgTXau3V8mnz4+x+iMn+If2vqQ5tysw5ojoF5Wsed8dx93MHhbEAHJNAC0LXbprS6R7tUsauAWbi5ejjLlzUOyFI7j4CyJ3zYu7ferJZ14a6nuXBKVYlZVh+MCn8NbVTBsz7CqeyzidJqyTFq1Wu5Nltm1PRFMwJdtgIJLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBA7C0LY; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd801b40dbso166948eec.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 06:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775221646; cv=none;
        d=google.com; s=arc-20240605;
        b=IBeyiQriwxkCfGfoLH8TGAyhriLC+zM1+//hAoEL2M1yICzye4ayMbJonWWlMNhhOv
         0GgdmijIMd4DTwhzcTtsilHFmSSjb1Jh5skiXejEDMuFI4K37jnMWwU4HRJgpoPNm6M0
         4Z7KlJVRaP/dyEdKXi7eMa57ObZerq+RrtZEmdUbI5Ph6nvCIeyS4QHmKgXkNn+IyZCY
         RvMa0lZ6Q4p4jCSJvP7zqfTM4nsGFAqcpr3m/bCjuLC4UQiAgYuA0pLH6Qz8zwGqMm+P
         dl7A6sUsAr+i5knCe1tjlXOFq+GhEZVYA22ijsJCVoQNx1mIDp6jCJ6R8SSGF5BzdSX9
         orgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8LexMMltL/kK/wLwnO1jphEmsYhPwoj9kNcnexg4bI8=;
        fh=CiPka628RN/XwvnbLd6N0OK90ndupJA6A/HIenM1Z1s=;
        b=UrRB5Lyofup5BWezwOzwnAAt/jrSzm2JgcBwOb5mxzkHX0bJIvs3rbh379vApo+IUr
         NGSb1SMGCSSSaAfhK/p/mWUEYnssmFwhb1cfihCTHFJeg95tyH/mUmKvG5uUZYjRcXil
         Upa20Jy5ux2ZgSi/h9lBPr/gW2AJTeepL19+3P47DJS1NwK0xsKz+6xY/e6swK8pOmrq
         KhjhjfJxalsaz1muVJivRAZnTG0pN+b/lUe7yHSN3EO4/J8ABIwzuXh+P6xOg3okbFQL
         79fyTI859pU1BrHJhmJ+8BYre2LPeAgP/FK69wrDKGSIj+NVqF+P+XPo7XiI8jgdjct9
         YeQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775221646; x=1775826446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LexMMltL/kK/wLwnO1jphEmsYhPwoj9kNcnexg4bI8=;
        b=ZBA7C0LYezdbT1eDixqh2nwBPi6Y/sO93F7TCx7DyANmm6gIDgbFFxef+JZijrv975
         tduR58jh/u2ErihNLY/8s8OYU6/ZS1qhZpd8bmVLN/XbQxAHNCJuNZRIUIklqojelYHi
         vS9Fg5Axg+GG3RAVC+mIeO7hWo/YSw4e3LV8savuLGj5CFn0Jnjwgqz6IcoDyMMbdq1I
         1nsLQt+VePCtm/wEcXJHvN9yTpOol7iPLAgmvSeh2rEg2CHOxCqH2pVrPJlCkimfCj2i
         TWe5j561urXIGJJT/jppo89HR6EQcRqD41zUbjkkZCNjMneOy3Q2I0euYG3eBbXyF8vq
         QoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775221646; x=1775826446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LexMMltL/kK/wLwnO1jphEmsYhPwoj9kNcnexg4bI8=;
        b=IkYCms8/Tn+eek5vDMk7ceYCE/180Fw8XS9Og1hv8hV+nGkhknmYgZnPXVT+lvE3cr
         j1Dsl+M+NADPlUd442HxA/nRBDINiok9u+0omcQQvEJnCIFcoVmXgd1LJJkjCO7H6kO3
         Be7543zvxfSc5Hu9acWJoThNyQn4DxBNok8P+m/5iRm9vEs1XupKMWvkR0nCkcp7HSo+
         xVmEqrAI3tT2BCK2UXpuS+iPBqY3yFlqZUzjcQwxwNYg3RlO7evCyA9a0TKx9Q8L5nzo
         3+OAV4Q8xikJijD7W/9EzL39Xcew/Lw0hrQqQJGTK64Mg1cwf1Fu3mGcBguAMa8Mm/o0
         anCA==
X-Forwarded-Encrypted: i=1; AJvYcCWI9jlDcOjAAv01+u7VJpWMAdZGgfiR/MsnOkMKtUv0i5L5w2ROH0q9L0OcVXxU9/6NmXc6iMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEC1VF4Qv46Vhbupt3Sp+7j+iFWMNN5UN7LIjCRPxu9aP664eF
	hQr+aTHvJqwu4u+Ih5Y3BLnBp6jbO3Ymt+gyTCPvwj5JCxJF1fH6OuRtiyUQO59lAemH9yiVQ64
	MYD9gjiV7S5lGLv8Szv5xvfT0uNxl2zk=
X-Gm-Gg: AeBDiesOMRxoEt9XrjUV9wjyaqOaxKs8JVWowqz7hUhLU39VjACUYGa8AWi9n0lEemM
	LDEq5/cbV6yHuPY3QIxOT7f0izrga8Y6pOG2AmVauhRKeReRlGy7j7ji2Xx+4u2GrOmxyuAUOaS
	Ip1xm2/YM14pJ4hDHLgN/q/F9XjI16s7dV5MvO8VXJk3HHWx4JgSQKdFBxX8TQ6iSkqjNOvnhKj
	iVD5E8dPFBj6oft7X0Nr9MIZuXW47+Qo+98xO1EdLT5pdEQaNVtl9fL3a6pUkZdxQen+pokE7Ow
	8bXRDsTlbrVIgXuQDTG6JrkqSPBvUOuWlda9w2YXvd/SpOEPpE5mNkdmhnHFe8eWupYMwBxqQzd
	kQ8zYcduF7gyO0W5YcW0y6V8=
X-Received: by 2002:a05:7301:6093:b0:2c0:c55c:156f with SMTP id
 5a478bee46e88-2cbfbc82969mr602584eec.4.1775221646195; Fri, 03 Apr 2026
 06:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <CAJ-ks9nqv30SOiCia8LE6XbKEURNCa9qwwcszsQ0a8FRxR0Msg@mail.gmail.com>
In-Reply-To: <CAJ-ks9nqv30SOiCia8LE6XbKEURNCa9qwwcszsQ0a8FRxR0Msg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 15:07:12 +0200
X-Gm-Features: AQROBzAi7I-5aiPFC3vwoZZjn0KQTGSqr8-BroXwKxkn5hps7t8T0SwwfFMqiV4
Message-ID: <CANiq72mKuQgK_R=xs6270nwYigzCvJiFJ1PcOB+WT3OdXO7E0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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
	TAGGED_FROM(0.00)[bounces-233182-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,google.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,atomlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40FE6394559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 12:25=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Seeing this patch a bit late but in clippy 1.85.0 there is
> `#[clippy::format_args]` which would permit us to make the lint work
> with our custom macros.

+1, that may be good to consider, especially with the bump -- added
and backlinked in:

  https://github.com/Rust-for-Linux/linux/issues/349

Maybe an issue would be good to create too.

It is good to see Clippy adding more attributes, because I requested a
similar one for other lints involving macros in that list, e.g.

  https://github.com/rust-lang/rust-clippy/issues/11303

So hopefully we will eventually get those too.

Thanks!

Cheers,
Miguel

