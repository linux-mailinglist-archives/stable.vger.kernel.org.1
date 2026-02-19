Return-Path: <stable+bounces-217495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK6iLDJVl2lPxAIAu9opvQ
	(envelope-from <stable+bounces-217495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:23:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F457161A32
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 140B03006B2F
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3802D248D;
	Thu, 19 Feb 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESYspwue"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A289235071
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525308; cv=pass; b=eHJlYvlWKK4NTjOtD19hRqPGKU8K5vsT6Ec6r6T0MCiyo6n3bK/zr6PVtuanT23qTU+WnxsXqzKPa1xhnOv23nl/f6A7ciWIFCMM4XHxfG/PkwJ1u8xjHjZDKpLfpQ887HEN97Kb1g6AsTWUsd8WfAZmDrytU1QVz6uUepzTl4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525308; c=relaxed/simple;
	bh=dgJHI9snxdytU+3GmhayEdEGKcQ0qINXjz3gcxfeHjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDLTrBZrZB3ubFHCc+AedUJYoJg63pvh125KgZdzE/wangp3MEmNxUWzqcj+vLaqHdnRuPAe9ZJaVFPniFqA3qvDDWOU+AQrUzptLZ2Luvs0oY7xCi476d9PNSMAuk5lxuH9Py8Z6gnD0B5ANNJHLBTaXY69m1UJ/gPnM30mFQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESYspwue; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-127337e3870so107979c88.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 10:21:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771525306; cv=none;
        d=google.com; s=arc-20240605;
        b=RfuBpvEqJzJRLJ46xll1k3Y0YfO0ZEB0vrsoAjDkS//0tOkN0YQeaVs4BfcZPL4fpC
         krmKKL6VwdaoXpIX08wHjLrhMKGbiZCwlU3xVeMFTlwqLa6htbC0hHc+XCAHM5RcADn4
         pjGzidjqB31bpVi8tr4Ilk+mDWnj22ahvSU4Bg/Z2iRd1MS8b9hubOT9w3JQQpRhUErH
         1uIEiAKw1PPB6LyfZZN+NAHWXWQFZxIOkh6Nrsna4Z7xk6tRKptkLC4qWhLecCV8nQs3
         P0a9aAtH/1pxD6OeXo+gO8L6OgQHMFuwcjoZLc7gZ0YM6WkAv90LXHdhS/4Y2MCwwshx
         TS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FgE2S53jYPXZ9GIDCQFg6vwQPQ36fuRo1S4yJGAnCbw=;
        fh=1YLC0jWz8GJlXECAxfJozAr6f3HC2CXDj+2fA3PvF3I=;
        b=lvVzgyoHHdG5MqCVBK+jT+b/5YA6y7A0s12CpXXHZP6c922DK/I2bYDkGV3gh0yisd
         N4R5Q4HKjFlH8nCppl/H7vzNCyH0kg2DuHxMNK40OGZknvhswIGllohQL0iRIBsPwSC0
         APHazk1KoEM6ny1Jh0CCYWrSBHsPZ4QBY5zRKEefw2gNXvAdyB4tnv+AbnUNYaV51rKE
         SjyDjLwDVt2vaMaJabmQZR7zTdDT04jTsJ75Z5c+hApqWtDZF3oOzzH2qzce2G9Qpb+M
         UEqVo0jUeUMQ7ueqyYAz5v9NUT/ZKP3AZf7vV14Y6Y3wz7BpEZLptkWKIsb+yr5dXgI/
         utPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771525306; x=1772130106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgE2S53jYPXZ9GIDCQFg6vwQPQ36fuRo1S4yJGAnCbw=;
        b=ESYspwue+LOvifnFVrTS9y0sBztQ6oS/5F8zEv+euTlBE7k1qyvmK3Dbu/0hDJWlFJ
         B+ppNSTAIGzYYTh6CFhXbsEXsZrKmpzSkmLL3qMGI4OCe7k5Bkgg7R7aFkKCdUy16U8D
         qRe5ScE3Hx8b2FQbzpbFOG3FGzv94xpKxfDrRtBewjCpOYJYQjb33stRgUrFNG8atjwb
         ShWobqjMjt+02Fj3mM1cqNalgI1VKXBn00ey9rQcElFkrFwbdkmothXDXixYpk1zvp95
         7CwYunqSkM4baiCbeBIgDOEnhFxZSq5dFlkeqWIszEAUmVuBLVvB1IPLU0bN3cUFie4t
         0KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771525306; x=1772130106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FgE2S53jYPXZ9GIDCQFg6vwQPQ36fuRo1S4yJGAnCbw=;
        b=IaI/gXgODVME5bb9CISnt6JsSYUufvLPvF7hYQ5Ah+XzwI2FSPApxmGS8UAhkaipyb
         E20yl/sxuL0BPVy4jgiTCBJTRndEKNcdv5b/itndFSJDGqtSNeagVj/kIh4830xywwtA
         +g6l83xTDs4kYIjORKFmfFVHp6Drjhyo5fKJvm+OEdkxpjiETaBBrEV3PwZQPl5H9vJh
         CZVo29I9ECzg0ArYFpZEvP29aGruX9WusrDOSQPYGu71j2rjWC+Hw/RK+qtK/L2ORC0U
         /u/sO8YALCZFJPlphZ5prQhj0IhLwzyOuclpY+QsLTa8vkY48DgTe/qVot0ED5X5mLBB
         UsLA==
X-Forwarded-Encrypted: i=1; AJvYcCVL7Qwckh8fOb60sisiEjO5UYUzKjXXP8atxgjuLp1uKM9El67SVXqiL2h4iJSlJ5c2QaEj1AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeoAzuClImg+goBDuo7LHgAhFZoD0jweCP9Fnh+HzWWGU8EKOo
	n8cmCkCRmqfa53dyX34+q+TijnBm0E37CsTSVmv2KS2T1q/a4rhzNMWSIldh7LmUiydNUZ1tlpX
	Nrkf0oUXhOMQaeRfxUKTyiywKOuYaGTs=
X-Gm-Gg: AZuq6aIUnYNhZlFl6sa0HTOEX0N2/xBDwLQezBSPNA+lqtZIaxftrP9mUaFj8hqNYCW
	2vh6Ixg8cNGRqfJCpuvunopb5sPlkyAY3LyL3on9Ovlw2RIfkh2Y1lADEDA30T9wVY0VoAOy5Bv
	CuFmOY21PFIbenoo13zWlX9bxlyzS2T+PhWojzI1fJN9fR8tiubVKe9Vv56tans/fZzair7ebZ9
	Y3XD8momNzYlPEJmef8b4GAa5v9XwTO3rR+FUAhjrDUId/GAdRelRIPVl7+0h1x9Na++yrpKJXr
	pnUgI0o6f20wZujpsW+U8kv2pqWrFmhCmv4ntm4QFr2rZD65EAZexCCqhBkCteB1YR62A7vjApU
	PFSBd07SyHh7r63s/qxjlWinW
X-Received: by 2002:a05:7300:e60c:b0:2ba:8204:3f81 with SMTP id
 5a478bee46e88-2baba0f8623mr5563965eec.9.1771525306395; Thu, 19 Feb 2026
 10:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216131613.45344-3-phasta@kernel.org>
In-Reply-To: <20260216131613.45344-3-phasta@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Feb 2026 19:21:34 +0100
X-Gm-Features: AaiRm53mdbj9iMyTwWczfecm9VLxe_fOFL__qbVKSsEs8kKHbe9xW22UYVL04zI
Message-ID: <CANiq72mMzRop4aF4b62CcbqW=ey+ykse4gya36txAbhLDG+Khw@mail.gmail.com>
Subject: Re: [PATCH v4] rust: list: Add unsafe for container_of
To: Philipp Stanner <phasta@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alice Ryhl <aliceryhl@google.com>, Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217495-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,umich.edu,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0F457161A32
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 2:17=E2=80=AFPM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Hmm... Where do these Reviewed-by's come from?

Ah, I see them now -- a copy of this patch was moved into another series:

  https://lore.kernel.org/rust-for-linux/20260203081403.68733-3-phasta@kern=
el.org/

I understand it was an RFC series, and perhaps you didn't intend to
land the patch, so addressing the previous feedback wasn't important
for the patch series.

Nevertheless, a note about it would have been nice -- we weren't Cc'd
for some reason, and there was no notification about the move nor a
link to the previous version.

I see Gary and Alice pointed out feedback that I had already given
before -- that is why it is important to mention that this was not the
first version of the patch or better, mention that there was feedback
yet to be addressed. Otherwise, reviewers may end up mentioning again
the same feedback, just like it happened here.

> +                // SAFETY: The caller must guarantee that `links_field` =
is a valid pointer of type
> +                // ListLinks.
> +                let container =3D unsafe { $crate::container_of!(

> +                // SAFETY: By the same reasoning above, `links_field` is=
 a valid pointer.
> +                let container =3D unsafe { $crate::container_of!(

I don't think these two comments justify the requirement of
`container_of!`, which is:

    /// # Safety
    ///
    /// The pointer passed to this macro, and the pointer returned by
this macro, must both be in
    /// bounds of the same allocation.

i.e. even if `links_field` is valid, it could still be UB.

By the way, the "Reviewed-by" tags don't really apply to the `//
SAFETY:` comments, so I would have probably dropped

To make progress to get the build fix done, and to avoid dropping
those tags, I think I will apply the fix without the comments. Then
please feel free to send the safety comments separately, which can be
iterated independently. (In fact, we may want to reorganize a bit the
safety comments within the macro...).

Sounds good to everyone?

(The formatting is also still not right -- this was pointed out by at
least a couple people now. Anyway, I will fix it myself.).

Cheers,
Miguel

