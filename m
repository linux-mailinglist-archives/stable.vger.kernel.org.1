Return-Path: <stable+bounces-224710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDd2DLuSsWmRDgAAu9opvQ
	(envelope-from <stable+bounces-224710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:05:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBDA266F2E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F233E30156D8
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54EA3DC4A3;
	Wed, 11 Mar 2026 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrZfgftP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965E371893
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245105; cv=pass; b=iztv1AaQt2mRRw+tWHbGm/imTUwVw2n9ttmXSLrpdIzizV2Y0T2ADm3c9ukxdaeyiGUpzdwarU8dVhsQVrhxzAptgPi9v4IepNK2Ux8vI2YDVY7wG1RHkYVW5e8jiiLx+IfmGwzpv7oGPvuGzup5Epm7W4geohxTL9KFCJIn7wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245105; c=relaxed/simple;
	bh=U3fsvXaDbFRBM3Sa+C2LCFylj/LiFFcDtRhLdgWtNOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATIn3Hl7d9xJFfc12TQWfg6PCT88BeAGATWkM2uFP4TqObqEKGHwjcuXqyZUCFdG853v6DAKzVzaYvq3Gn4A5AzO3iqb9vWIGUQ2si11UUfWq9r2nM0vOh86MHwQ+SKgDKeTeiGMv4hwlJYtFdPcBhbXnHRV85yrkGFRbB+GfNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrZfgftP; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b7c2788dso34265f8f.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245103; cv=none;
        d=google.com; s=arc-20240605;
        b=NQ4m4hVJiPM+Kw1CHN3iU8gzkTtN9a6xl7EqRITzJwqg0Y+8TE1LZafzv0HHHbeABf
         RX3BbSk+iL/xXAt2mHL7nwnLGSPib0GJZOGZbkIPN2TLjjwOk7mVSLoV/5SGBkX4/WoA
         isdxQPjKjHT2EwHb1FTlGkgSJfcSt7nojyWvfWNDUXO3sCISk8YR9sUvKl4bjUB2XYtE
         MQTM8Rpy9g0qx4Rq/g9g6il6PTT0uuC24hDZ+mqWgmQ02iZY3rw5l7z8gzG5qcwS696i
         sCWuvkKsvFP9xhdlc6FDdntC5jyqv0xe5xWXn/RRroQ7ulSPTezamle+ApQK38PeGjgg
         fkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U3fsvXaDbFRBM3Sa+C2LCFylj/LiFFcDtRhLdgWtNOA=;
        fh=DGbSBFwWuoc/66p32Mdb/AJC62sVqm8Y24Mui7WR3aE=;
        b=RXGEi/f7xUtYqYTNFq8wyJeayw8diSeyYFIPGVmnTObwfLASQjlgVTW+YZpfWAshV+
         TtwJcZBgBMI6v1tRvsSlDFh84e2+zf6T2PXx+2lvzfyNTq9JtgNmQc2R8CKupQCZo6vz
         PAQvyhu49oH3eORwt7Qpt5huD0Z9ITgJvHfe2d4FMZhCHao+FHuNsERi6+EBQVrAjbn7
         fvbRjASod+nNiLzrcfU8jc6rUDZOjEkV4zmd0rAdjgCp9aKwIMKh95bHu4qBhnaP2xX3
         7SbrU+xti80Ck8vZeEnBKQAP0/QVCJUtCaAiZ8Lh2c026xuqXNsltQjkYq54awx7CPjl
         gczw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773245103; x=1773849903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3fsvXaDbFRBM3Sa+C2LCFylj/LiFFcDtRhLdgWtNOA=;
        b=wrZfgftP987fL+umJmvHY4jK8p2XEFBaOQ4P0dx68Uo2PPtMSrU1mfsB/rLELkipfX
         5OF0LQLt75OMvrZ90qjHp+R+GhTM1uWGeHfAi9g6vhvBQSI5IcZ9Af8BzA4CRQiDEtlw
         ubTzkCyFFPPUCputgJ9GEDfF2p/DmAbKXTTAE2fN4haPPRuGaJrLFeW+sT4Mb33r5kFl
         SrhySAc9an6XBHR/hyb05oflUwxX7coVmvwvMoBx4eso6a3RabT9mS5OusguktGEPsU+
         uymcsQLvBFhuHFwyKqPvOMVU0UpT4hZfsI77voYodFHo6Vj0mwTMeBCEpO5he5ZcRoWk
         l2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245103; x=1773849903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U3fsvXaDbFRBM3Sa+C2LCFylj/LiFFcDtRhLdgWtNOA=;
        b=w0QgJXSjCze/kDdJJunCemciWrLj6mJ9krhBfi972muKkDmtFEA4ucCnl3XvdDd3CY
         ok+/9z8A5vlF0a6mJOYzoInyiU0xcBqJZgh816G7bUZq4YwE2uuvOqLYuynN3IHuUDkY
         x7k3heySIlPHDWFED4IquhNizVbJyEZS/VcjxBidLEuUdRz9qd8rgMOemYSW+7ftWyH8
         8ecRPl7QggcealX1i/tt5M9AHdIznELbHlmqdNiqMomH0hqbjYccol9u/hFyMjvHdIGE
         RszwDQDFSppg3MB33bTCvHIxr0zwxvjiUv/NSwfJiQdtsxcYAxqXPaHnubGydJxn+bdG
         hHQg==
X-Forwarded-Encrypted: i=1; AJvYcCWXQEBFnSR5pqERMhQKu/ib+BQvYVvuayQLghs7cB5GoabLnR5yjvqQ6Jp6vjpN56V8nvWCyZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdO2Od8DDMLyWiJLQR7kzHD6SeFVlyEu0vRkXSYDsbCoL8VCD7
	N/mRYdgvFYILgPjv4xeO1g3XfPNS+uCI5BWCCSHlxFFn5jDBX1RvmgBlncnmdD3Z4oOpTLq/7zE
	tfRxOEWWiKD4/xrh/tevF7LOnC0W8SowqgJOwqBQJ
X-Gm-Gg: ATEYQzw4BnVHXkcr4m/A1ubTT1uQ93SNbS0egvIxlOrODIW4kJAFiix8bPCVD6NO2lG
	aiqSWPdv7l1j22N4zIhDU1qh0VgcXAXs04+VBQZyg/ixYI59/xgqXH6BdztDN1l2AjBhxToFaHK
	czhBYnXa2JCfuJRxtz1fL+oHZKw6sH/Ny4njWJIcV8XVpPkPlW46XLVXicd2HsmBdOraJjZ7gSD
	/Y6d26IaNJXUXqecmYFWJGuO2Jfyr3k+tW7pvdVgYNsRoB9Bo5yQXTgnr2DisWNLVq31wHrSAOt
	iApNbo7Sgf0Qgmwxr1jOYn2KmlsC3TP/mjPAi4EFEt+QSK8QmfaWJ4ZAQl3KeBs7YjxUYg==
X-Received: by 2002:a05:6000:3113:b0:439:c5cf:fc68 with SMTP id
 ffacd0b85a97d-439f81bd343mr6053569f8f.1.1773245102244; Wed, 11 Mar 2026
 09:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311105056.1425041-1-lossin@kernel.org> <DGZZ0XF0YYGN.1W5UIBXK16HL3@kernel.org>
In-Reply-To: <DGZZ0XF0YYGN.1W5UIBXK16HL3@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Mar 2026 17:04:50 +0100
X-Gm-Features: AaiRm51Rxg9U6-q_qux-w3-AwPBA5mUWrvAyhEf6VBVZZzasHDrWZRbvvZv_09o
Message-ID: <CAH5fLgjdiXMf=xybyf+d+_MWYv6r0SSw+dCNKOLoMmxDdMh9Ag@mail.gmail.com>
Subject: Re: [PATCH] rust: pin-init: replace shadowed return token by
 `unsafe`-to-create token
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>, 
	Tim Chirananthavat <theemathas@gmail.com>, stable@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224710-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,kloenk.dev,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9EBDA266F2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 2:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed Mar 11, 2026 at 11:50 AM CET, Benno Lossin wrote:
> > In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
> > this solution no longer works [1]. The shadowed struct can be named
> > through type inference. In addition, there is an RFC proposing to add
> > the feature of path inference to Rust, which would similarly allow [2]
>
> NIT: I'm not sure if the sentence is supposed to end here, at least it mi=
sses a
> period.
>
> Besides that, is my understanding correct that the changes mentioned abov=
e are
> targeting a subsequent Rust edition?

I don't think it's currently clear when/if the changes mentioned will
land. But on the topic of editions, it's worth keeping in mind that
macros don't know the edition they are expanding code into, so the
macro can't have different logic per edition.

Alice

