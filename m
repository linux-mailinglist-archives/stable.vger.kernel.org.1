Return-Path: <stable+bounces-216905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wqPvOKLOlGlGIAIAu9opvQ
	(envelope-from <stable+bounces-216905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:25:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7814FEFA
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A29EE30131D6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F952D0625;
	Tue, 17 Feb 2026 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg/frqMk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EC1339B1
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359901; cv=pass; b=BobgVr64G7St/Kx4jh6/UYo6K07DYSC6ByJ+0l0gpx98ni9mItYCowDNQeufmcj1REqPmSbEGA5vqHBZbLeED1au6DQWCZsXAqAu+JZlBGhoNQJYtmzGGckYP9VOktxz+IRwxWYyHBNLz7vNRj0TCltr8lGfOzJejNhnm8nBAZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359901; c=relaxed/simple;
	bh=XzVO3FQdpM901ZMnPvp0xbdGNkh5aSYTE4RlbKGdzEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7F/R8EydiTDmiNCvF3vzJImVMazGPP7H3n4Vg9zN4DibctCwEiPNDuhfqT1h8vYwz2QsaMrpGFyi5JW/nBHtbFmTRhbMuSphWXVqLt/eRp2q7vAmsFDNXTqxZk/reTJluCOks6C70gXwOTVb+Kh3HrTi7/77X2RnUIQNB0U0JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg/frqMk; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124b07e5fe4so281856c88.3
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771359899; cv=none;
        d=google.com; s=arc-20240605;
        b=ZoqHKBsnVKm4v2aRAGCoEE3iGd6pofy5LhFIt0AJGAGj9/mMEoMw8ak1LbuGqrmbHy
         QCum229yexLvxN8oWsukMq8bnqB2BkCA6vV2bTdeTWmgkxAGWduPxNhxEMT7B/alwk4+
         EdWE2uN7Hcwi3MYaBlGW4MI5oTsd8NdrBmWeQpvaRepUfBak018Z1atp4c+UCzNVBMvC
         V24tewuqvGIPn+3mNTmYety8wLileEWXTH/Csvu6y0C3/e6ct7iEkU8gVO9uGVE5COIa
         IDDSSwQm1fHjCriP6dPMyhPOwkEoXkBsNCMtPQUxa5AcJtxKeQ2DXPuWzZazadYvwHIR
         BOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rDDEWsw4CKwwqmAURAFC3flEZcqum1GMx4CN2UKN8vA=;
        fh=zUNP5hWKsjgrHiC8XBaNSNJ7oUXcGoQlhPinW0YQkWI=;
        b=I1euU9LJlf04fSOKwH+LtUpCiA3NLjLTGELgBCd7EO4ZzDKhLmvDqLVpIRjIsOenWG
         n3p3PQaM20dgj2sLjN1ujg+F6A/nUPGN4aC3W8Y+H3jPIljtTBGgjijvGhz8uC8Bi2tW
         Kws3EoOh8vNllFFbvC4OopC+lLWeMg4fTEoQNunyf02YoWHcE7f8Vok8AFX6nTP+w4sB
         o5oKAjyjMe0xsgYOOfcykaHRP890OXMUbGLfb/BHeEsg34LaaNSA9Qmb7urBvuO4OMze
         zeYhW9hsuaQ3xX4KUUI/0JYqlqjWpLHtQ4Aw7yIluQZZqk/L/Tp/tzGi93/RGvQHsFqE
         OP0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771359899; x=1771964699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDDEWsw4CKwwqmAURAFC3flEZcqum1GMx4CN2UKN8vA=;
        b=Bg/frqMkr1bRjcjBtqJ/dTM3rtyNccQjLVrxXoQ5gOyep+nO76/gAbYWSGkNGxM5zQ
         e8W2F4TvAXcvZ8zrwt9S+A+Nqf2ENFv0VM9EDs/1AsCFEo187YPNwATcOgz5UJf2gtDG
         y6fcO/BXYgceIsyXRRQnebMp4H+wsQUdsnrY/nD6YWtOQW7P/mCe8l5S0fhojlDPtoKV
         tFxo48SIW8HafosAYz3HitAe1ZKugWUi3OJnmlMcJN61QBwL/LlxRh+dUG8dpJiPtbwq
         XTySR5e2Xnvj3XBVsLTNGyjwF2wEztbQOwK+X6q3Vnlv0Cq54SUzI6c5IX6L0+/qivRG
         WojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359899; x=1771964699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDDEWsw4CKwwqmAURAFC3flEZcqum1GMx4CN2UKN8vA=;
        b=YSzopgbiJb2Uwv7vOQM5XgWhcllX9JthFEW74JrPHLYbwxNN1AcjN8cIgYMvOW22cn
         9W+W+xfcoY/V9Gl2JoCzh0Nu0v5oF+nn6/v6e4i6DurA6KWXDKi3gEX3iIOqNFwsOaNR
         CJAVQnW1zhHBaGVEGCS76b543Zr3YlT2PObww01UEjzpuof5RDfm2mOa8KGlPwQi+bMG
         GlYpYbNxT0AyWMif6r8msSAbttvsWYF5i8ttuukjyNzHXeO/nEdYs6gjp6+ingV2+GSA
         NNziyoUu3Qsu3mHOIuStoYRy5XadkwI7ccxfV3OiruRoy0RTrQ/LywDHC2RN3p7WtO55
         VoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0ioj5r0wMZwfXSj+L3vPiofCAZkm16SYH8tOxkCOT79/0K2kyprpyaktcRP5QfehmakYGlr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPXe2C1KYz8RniWkgOx0p+uKoQQPAH2G9JQUA7NFbAhNmIZjh
	dmsb73emxtFuyN2tE3u4zVHq//GYhqdCjpBMrSTkel3ytwj72I2ymWpKxNw3IiUL8aonM6G41Gx
	rfp0i7/PPiI1tzcbW8vgVVTlq0ouZukU=
X-Gm-Gg: AZuq6aIL0Xm1sZcfV4QS8FL+Cs+TMW4NLVN28HW2L4j81ZZW68ful4VJuumjnLozp4E
	D08Oha+qwkE9GQrunYR4fiyEMMjsBD98+DAhJq9Ah/MAbI4NOh2ITdRqL+g3VUr5QQSaOPcL8vX
	tNOMx84IgXtv2dtCapkZOTTnwuypdc44Fda+MAu24db2dl3boXvVOvQF79e2Lhq4uheVTAPk+9N
	BPGsg1XxNMTMqkctyyro0TsStQtW1U1TrD6ktFnByNb33oLFKjjjd4ScSGbVApkk6DwT9HuAjZO
	dmhYPosQq3s8x4mksRkaLSYH35qu5P/NEwgcw7EOV1q6RKkHo+y25g+OByRbz4CLW4thQUKaSMy
	+IlTlK8AckVzqvscnXM54pzoM
X-Received: by 2002:a05:7300:fd18:b0:2b8:207d:6a7b with SMTP id
 5a478bee46e88-2baba0117b6mr2978273eec.2.1771359899022; Tue, 17 Feb 2026
 12:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
 <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com> <DGHC1OLDIXC7.Q4IAOOSMHIY@kernel.org>
 <CAH5fLgj2+XUzsuAnvwL=dc=5yOZvXCapBWRbFGwJAX2v5Wk4dw@mail.gmail.com>
In-Reply-To: <CAH5fLgj2+XUzsuAnvwL=dc=5yOZvXCapBWRbFGwJAX2v5Wk4dw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Feb 2026 21:24:46 +0100
X-Gm-Features: AaiRm53pWPPTZa9dK4uHNNQw0RmQntvFMMvdgsDwpfgj0y84MDt3F3iy0Ue6yrI
Message-ID: <CANiq72mw7PSEcRLPXWz3UdsE7pY9EdYZNYSEewertFx-WzKusQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust_binder: check ownership before using vma
To: Alice Ryhl <aliceryhl@google.com>, Tamir Duberstein <tamird@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Jann Horn <jannh@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-216905-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,google.com,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
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
X-Rspamd-Queue-Id: 3CF7814FEFA
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 9:13=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> How do you propose to reword "I will follow up this patch with"?

What I would have written is perhaps something like:

  "The plan is to introduce more vma abstractions to ..., but for now
let's start with ..."

> Honestly I think this one is easier to read as-is.

Cc'ing Tamir for that -- he may be interested.

Cheers,
Miguel

