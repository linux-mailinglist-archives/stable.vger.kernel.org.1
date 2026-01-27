Return-Path: <stable+bounces-211844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCsMCwfjeGkztwEAu9opvQ
	(envelope-from <stable+bounces-211844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:08:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 483B7976DD
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A024317BFF0
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705335CB96;
	Tue, 27 Jan 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8UD6Ghh"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AA35D5FB
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526829; cv=pass; b=LzOSVzh5EsoeTLZIHx3Nub9xLEjCOPKJQ0g3407svDtMsdTYQth0UF4jD80c+OsFf8L29BlXZNw8UnLU2NQA65y7Z/loRTbibys+O9pJv3hPn24lK9XNP1KfEJzHehm781U2ddep5znZmqyc3l95ku6OOV99hgvUASxK30xUX2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526829; c=relaxed/simple;
	bh=mKGQDNNoQv6tNUBuSd0KjK/xrNR7FXQQvDUKS+vEP2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2JvhDy+4QgFGzDfzMBLTxwBPyCYM1/IHaXGZJqWHgZcytxIqbZFBd7uahComUPwGBmYX1/5muWFQqHLnYg4eIXtt9gU1hVB/RWyf5S8WuEB4FS5C9wx8J3MedEqk9Ptx/X6g1FyxsVE3aVFIGrPc0V+umNzMja9vLIWq7Gr5CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8UD6Ghh; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b71a4fdb86so278028eec.0
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 07:13:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769526827; cv=none;
        d=google.com; s=arc-20240605;
        b=WwCAu5EcdWpOP9HDpI08+0oW78oPEoo2nso8OgkSRb3kUhlgFVVxHSHYBWFQR6IOmn
         H+GTRXrZbcE+mzRYMIZPHnZtPfs7cO2Cl1tX63Heq3hekNYIg3K8hHLtuEuk9agsv5HR
         Z+G/Y0oAAxOyBxpw+8XuAy99J7fm2dG7+Y8krlECsvwMooxnT2EnGqdoncNo1MMmRpHP
         0SoDZ9CAJrP8HRTvAgbsOMOBei8q0AFP8FdZtYSEHqyOteOtIt/LybGAIh3btXS6vR+e
         7cp2DS2FcKovn6rcl73AKN75NNzcNEsGOi7uH8jXBWnG/qWsgsmy6L7nueuQiYvna11H
         neuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mKGQDNNoQv6tNUBuSd0KjK/xrNR7FXQQvDUKS+vEP2Q=;
        fh=Ii91fNIzkgCwX5w9IUC+g0SGQMhatxX9qSY9WNb/oPg=;
        b=HNmpBmElxG3StIqLvWflf236dp1UvFL8ezRa2wH1vntKAzFLHuLLj8v41f25YTtpg0
         IhiIf6Ab7JEAtFAsmbPGXvaRuXXouCyEOUdCdUVLOPJCrWLnnVbM/H9u7XH6dkaBHucQ
         jvOLyMvOLKGwox3n9kUpvjBskaWxmUXlBh42CKr9Kd+tIPNxPCvZkf4fxRbIMbu0H2h3
         4YZT20SHfI8PSAZZdFqY3kRCnY4UWZR+/2kpnIOkFUMk+ow9wRxzsg7Mnk1JAV6zDpPg
         HYixhWcO28Fdus+LeTBKrehosqSVZtane7+LxcPrFwSKpBxCCGjsKrpMins5ahbTZAZ4
         u/Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769526827; x=1770131627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKGQDNNoQv6tNUBuSd0KjK/xrNR7FXQQvDUKS+vEP2Q=;
        b=Q8UD6Ghh9UkrU4xAIVXeC+OX/PXU5f2e4/6p6o48SDl8TpuK7DezW0KDLlB2ByneAU
         hyiQpRodJDh71Zl7zz+sWdc63YhQ7ACfreyaXe1eGQCqCcmu1S3oL6wzH3LclG4avCxV
         dnVZprIFy+lObC45ogxKxP/KhHlQKf54Vpq4TBjVQ1MOUtiwDTkxXt3j6z61jn77ofz6
         gIXVrerOjeM1X7JV3uJ/BZbILNewMVH4oXocLe/RB6YmalpoCZq7az0UsgO1cPi9MAS5
         OSypD4MDc9R/3FexLwPzDH66fNZ6Kx7evnWI0+euyxjl9c4ZF5AHWFS4ZsrRA9gEQVro
         fl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769526827; x=1770131627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKGQDNNoQv6tNUBuSd0KjK/xrNR7FXQQvDUKS+vEP2Q=;
        b=oYn18obM4TYclemQRiGcPoH2IQmh4105bNZ4VduhXP4nwJ0tjOUIxvBLy8g+g0Yy/8
         5AqpHEjoA13bf91bHsCCnEwVEw8g9BW7TCxxAPGrdP6WDmXctM2fv4apa76pC+u2vS+W
         QBsdkq3mAAPZhcgZlx7/mLTrPUHHuJJY4Q2f1rwA0FXE2Qs4PnINM0WHr4TgtEEmVZbN
         tSj6uXxSeLUtEvtO48hRWf1KCM9ypmcJCqe+1Jr4V4jQ/cEaaagYwdcinDQ6I12AHiUu
         EcGin66lVHpMfjnprmg2M1ve/NY3ZwodCQy6TMYQVJSJayl9CSozJ4nSzVaXQuzTvKZW
         IxVg==
X-Forwarded-Encrypted: i=1; AJvYcCUgoAmFbFdBuYgZ/mJekHGLDpP+fTDXjzx/LydPrZwhk45ZkxkBThHiZuCjbd2ohrltrqbL7og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwShPz2WIGS1VBJmSGhs4MHvWhMOdvSQQ20qmbEWXTQjAfFx0C/
	4FytA2nHsM2L3s7e/mpl/1O4qDRRZJuGKtpxNvNFGqRdMuuhzXLTWMP0UGWANUTAmU+hXuworO6
	rvNTyk+8RwGlNygWMf+tArDaRvTYV/8Q=
X-Gm-Gg: AZuq6aJsgh5dzxHdm/lEzzBAxkRIf+Ib7l5DtqWMHB/MrWCeRZhBj8hdj4VrG3bE0FG
	gbntIMkpsksxIercnzMr9+aXKbNNem9v71F6Wr5G4A3vKHLjXoqiEbLV2oauq53Z+c4An+ooZf6
	x8JdoLmO95PuWxmFdh6gF9BJcmz5FzbUNpm9lOofJ29T8qcve8NmxTrELjOWIFOytYQlIVc0mz/
	ZTd/bxhZNMgQ6Nk1zhuGwcWjinSRoghN1wbbcJR0JHRa4ciB3Wph7OjEhNXJ1/DcXlpJ1YMRHHz
	zLOdJ9oJi8OPMsgtvDlzpFBcYfjheemJyHDauDwxL2ORbsoyo9bY6/eUoSXwOTQtd++BaPkWfIY
	WFh6/jVILkhBiKDekpszQyI8=
X-Received: by 2002:a05:693c:3102:b0:2b0:2e6:5363 with SMTP id
 5a478bee46e88-2b78d8c78e2mr774073eec.1.1769526827166; Tue, 27 Jan 2026
 07:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org>
 <CANiq72kkxS9ACvR52q03AN+WdFV96cK+tvejnnDXKZTKuKZH9g@mail.gmail.com> <CAJ-ks9kiWZr=82sztLfYqtp-fvsQ2QTgTYqNg5hSsZMKCsvjZA@mail.gmail.com>
In-Reply-To: <CAJ-ks9kiWZr=82sztLfYqtp-fvsQ2QTgTYqNg5hSsZMKCsvjZA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Jan 2026 16:13:33 +0100
X-Gm-Features: AZwV_QgjnP1PgG85dXBlLvviCUKko3RZAOhufqqIr8pT762Zw8NgNzFun3xSq34
Message-ID: <CANiq72m8Bx=1s1+_OFxE=PFOjKrtuh_uhsomTA9VwQ4=Fz4d0g@mail.gmail.com>
Subject: Re: [PATCH] scripts: generate_rust_analyzer.py: define scripts
To: Tamir Duberstein <tamird@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211844-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,kloenk.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 483B7976DD
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:53=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> It depends on your perspective - I framed it as a fix of the commit
> that added the first script because that script was added without RA
> support. What do you think?

Yeah, I see.

So, on the implementation side, I don't think we expected scripts to
work at all, which is why it sounds to me like a feature (neither the
linked commit nor the one that added rust-analyzer overall support
mentions it that I can see, though it doesn't say otherwise either).

But perhaps someone out there expected it to actually work and thus
may think of it as a fix. I don't recall someone asking for it, but I
haven't checked. Perhaps someone would, when we use more and more Rust
scripts.

Now, for the backport part, according to the official rules, I think
it wouldn't fit. But those rules are often relaxed and who knows what
companies out there doing out-of-tree work on top of LTS kernels
want... (Commits can be submitted there even if they are not fixes, by
the way).

Cheers,
Miguel

