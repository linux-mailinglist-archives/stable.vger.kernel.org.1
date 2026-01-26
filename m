Return-Path: <stable+bounces-211502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEBcEwTNdmktWwEAu9opvQ
	(envelope-from <stable+bounces-211502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:10:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08801836BF
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C689B300398D
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 02:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6C23A9B0;
	Mon, 26 Jan 2026 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPlAVJWs"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9EC21CFF6
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393393; cv=pass; b=jRFThldj9/DiNRQH5kS3eaT74g02jcwCqOawbEUF9PlQV6fUKnvQFnbARzigpPRUSsJDFkSclH8NJtOjgQRQ3k/CC9kAvlYEzx2HbqjNstC89WSGlns8WTxj9wylZW7/klXzo6N5r3znzPPxTYg4tLgqMcWYuWAz7bjG+Ev0EzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393393; c=relaxed/simple;
	bh=lXUI+k5wQ5a7GPnYd6Nwa5Oc8r73Dh5oLetiGPMWw2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaHRuRfXJFOGN9pa5YyN+pzpN58ls6P1Zt0IRXd/fJBAG0cKWlWGyESj8AeHTUDTf3bQb+nsWlZXZ/O36h2TnMTpGR/7IoSLrIoCR3qH0RPHP3YO3HT+/eQvptOydkcV8kVt961MJLA4AF/wFzUCoID3s8n+r+rU0pLPHlSVQIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPlAVJWs; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b718524994so153109eec.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 18:09:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769393391; cv=none;
        d=google.com; s=arc-20240605;
        b=Z3XhqWqoN/mdvd1DC/DQpA9ltBcX7H+3IHeLl8x6DBuuXd6vioJdx4PZJu8HhdY3ig
         vl9ziZCxN3qvUtFdxNLdks9fYcYwerCRZJFwrzNyQn4Xuyl0Z06nWxTayqzJLbu5+9Gs
         tcykL7jJoqfPmxqx54kEEiEqPWY5HGckv7/rz87N1DI0qi0gyOV7OKxOinGh3VcOAUnh
         N4AYmlsNBP9SQQpYOJVLw2xkm8Vllh8IqZ3IeICYTdJ9M+FyQS4E5JPvBea8nahR7QuH
         f6KaRBuio6hh//t4nD+mQ78ObXv7xC0JBkef5Tf367QTQYQMdedwh1GgHXg2ZgYk78rO
         3X0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lXUI+k5wQ5a7GPnYd6Nwa5Oc8r73Dh5oLetiGPMWw2E=;
        fh=EcaoveHT6vLf/WtiF5axa2KTogLsIOHLBjqClc/RhXE=;
        b=CapkKz3znpKK2mvHYhB94mt1le13sN68Idhe9fpxMRyIjE2vVeeeOPVBkvk6IuJY37
         3uIHID7gWumohtkxCbCmfuDAcPGWmE1dsItG2J/ma7DwdNlVjupfi6Y83ooDOu9Wq2db
         +tN6zVC7bUXwOa76T/d03ogSexBWcpagLOx+fnRL1VYnSstHidYVYdt6VGO27Es1Rh2V
         hWUv+iFHKt7uIEUB9yl8cdEf7o6DQpugZxD0Bi3iAAkvnm9rcUoXnSm50Pvux1z3eiEi
         ZvgkC93KdlXmyqEQFrUtPcxTvu6QFpKLdb/BruXZUNu8GIuwZ8TMbb2boVxvDfHl9cZm
         UbqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769393391; x=1769998191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXUI+k5wQ5a7GPnYd6Nwa5Oc8r73Dh5oLetiGPMWw2E=;
        b=JPlAVJWskNY3gDOKvmhLN7VadCKpza2M+nnv1xugkSP8ymA4W1owWUga4KczPk7Hfk
         TsrN69lPI0NF8fHrEKFHjKz+QZyn95j6ZEC+zfcTiDgzq9QnlE6teaTJ/B3AsLq6iU/V
         r2/zbJoLPowtmTqykPVD9VIG3oUJOqTlTGgWO/tXigW/FcSzCQZsBqCdtTf9giOP0ZGj
         QF3GTTgkh1IUeszidk1YgBCR7WbV5jWZjU0XkyF8J5VFWYhGTXQLcDlXyhB/qj0J6s5C
         PbLizjgZfhM4uRH0Saj2Kqg+HmUKa1gHrHxwtJwDNc5FOX06cdW5GYJAj0+VAqDce0fu
         tlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769393391; x=1769998191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXUI+k5wQ5a7GPnYd6Nwa5Oc8r73Dh5oLetiGPMWw2E=;
        b=L75/4rsQ1NBGrEOGcj7kkJJF+wl6qNae5Twbcqh8UrQYPDSejOjMQN//4jlGbTpBsg
         n9smLWMufGv6N06dp6iIeMenyBIvCeg+LKxu2q7BsWpOwDqekXfReN7Od7+ShYkDg0d/
         joU6pMuUEAQO1uth/J7guLp0uwkzVyeZHBH7iPdKRxgxNHgsH+Crx/hh89EaM4AWu8t/
         1u1uao6dQdghUGLJwANnz0Kgf4HuufP8tpH+Bjdr21hQX5gJ+G/ErFtoIPPptDNVo0iA
         uKkvcQCIdnShQcyvdSaICv+bhAC8JEEVwfeZLS/meE9hpdrc4jaJ2aZ6cqhqAuZTsFyk
         nRrw==
X-Forwarded-Encrypted: i=1; AJvYcCUmNPM46JcNkNneFh++5aOQt3JA2W931YKlyUrd81T1m5+lGLa4h6Fw8jF4tlCnUvZrlUM+GJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvrKYBVeuQhgciyo/MsCzwW7Vl28ZLzgtouri6MITQx2oXFzre
	8Rr9TesY2O5GJmGDClTSKkjg1ZQzMmEcN/6smPFclIqnwQQuBQs3OzfeYheYy8fn94hPIIFX5k/
	1a0sRgJ2p6XtVG1KCGYI5Txk5Nf0FNcs=
X-Gm-Gg: AZuq6aJmovwG2kZUwPOpC9X6Vefufnnj0E0cAV50JEXEASVwtY2Tx4VtXwOohbOLzup
	a3VePMBURjiTZL/R10RwOL8R1tvHimRHe6zzCTLwxP9RwJ3Lw0vfQcuDAQHLtkjdkXaf78C7LFf
	uVP+aG05g6uY+TkAP8GqThgsYxMEPnNCDCnlx00TqP3ejVVoQ4Ht9QzEMy+LmhqZySDDXOXKsUm
	2ybL339Tm5Cc0Q1frck5hBFaxtwQn7pqB2wadPVEfLCHRpp/P+3XkHhQBxDuBiSUNfat7QcY/rl
	gxGpDopxZNsUwl7jIQxt3MvhhlDLu6GHY2rs2+4gJRqscGSUR4rTXLUB88cKpjya+SuLenf/Vfd
	hf4DDIsE3p3u+hwSAhNJk+OI=
X-Received: by 2002:a05:7300:4309:b0:2b7:121a:99f with SMTP id
 5a478bee46e88-2b764154191mr724382eec.0.1769393391065; Sun, 25 Jan 2026
 18:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-fd-leak-v1-1-945577813b20@kernel.org>
In-Reply-To: <20260122-rust-analyzer-fd-leak-v1-1-945577813b20@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 03:09:38 +0100
X-Gm-Features: AZwV_QjR7P_1yy5HgeZ8uLeqmpPnBZ8hrr0Jne8Ya2pgOpAyWay8I_JzCc7eaKo
Message-ID: <CANiq72=+2s48M5imZ7tZj-0SN==f_mLmw_2cWfQYKtBhD1ROCA@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211502-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,web.de,vger.kernel.org,collabora.com,kloenk.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08801836BF
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 5:44=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Use a context manager to avoid leaking file descriptors.

This may have been intentionally written like that for simplicity,
since I think CPython closes them immediately in practice even if it
does not guarantee it (and I think the kernel may be assuming CPython
given the version requirement?).

Nevertheless, it is better to be explicit and proper, but it is not
urgent, so I would say let's put this in rust-analyzer after the merge
window even if you end up considering it a fix.

Like in the other one, I don't see the Tested-by from Daniel, so I
would suggest taking the chance to double-check that meanwhile too.

Thanks!

Cheers,
Miguel

