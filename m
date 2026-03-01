Return-Path: <stable+bounces-222446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IeZAYETpGk2WgUAu9opvQ
	(envelope-from <stable+bounces-222446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:22:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788E1CF25F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64355301919F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794A175A86;
	Sun,  1 Mar 2026 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKCyh2Ka"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF592139C9
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360569; cv=pass; b=K/j10ZX9tuWXW3PP5kUXJceD6dRid0LUdCZZ28i5Qg1/pbqM7jongVuFsrqc7SEK3/eOO+1pWs8dMhJ+uqXF83mvLxUWR2hDy+xe2mNSS3u692JDevHtcYkc57IxKMi86eRTk8MOJ+WST93AoTzH+nJo7bu97fB/JEYjeXcUEy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360569; c=relaxed/simple;
	bh=WW/Bcz/vZ+9s+u7SK7RKM7h92kQtr5RPEQ42Aeeif5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9UVGEGra5Ve1y8na2H/JxtzwM2e2QwjsUvh60Oxp4FUd6/pqFY5GQWM3FKd/OGIIyyUFGi8ly7Cc6LJGNOJtyAHqpN8VNMoB2N0obrFOlRxNASfUzRAn4QVOw5mWQG94TP3EY1lErhgOsAEHF6PzQEp9At1Aix4wLPi/uqWrks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKCyh2Ka; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124713e4244so176697c88.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360567; cv=none;
        d=google.com; s=arc-20240605;
        b=XYHjJnHRRssUTzagialzsBPFNKxda3dGCploG6YzJuCtF+aUvMomiFp7bvaHhwYMPY
         dIXvn1UhYcfoVO53NALWJXtAWYJQdrD3ALHO52F8UiFOUYUlJ+7VP1fmnNldJSTneJSq
         La0qvP9eM9WfZnkyBY+uZrsfH3PZLVR+mnO+P0LO+RKAtzCCjYrdLYSeOYbcXS7i8JaS
         CSXv7x5yFXg3V4eakQA2KZJmrqxfNbQhwnWv7y3Pdb3SqV/Q7W07hNwiIkMUbwC8uy0j
         0UrXrbkA5i911UNemD9mkrVvTzM1jkmRUnws4hsq821g/iYtTPClo7tVSRk0CIJqrCwp
         +oPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WW/Bcz/vZ+9s+u7SK7RKM7h92kQtr5RPEQ42Aeeif5c=;
        fh=6SlAK/s1LDjYOpJGfmZa0f6MYkX0DKJLke/nL7xIdlg=;
        b=Oc/UDwQWelJbkET9o0wxMP9huBljZ7talf7NNaxaKTRih9kFr58V1AgfcR5vKTTvQ7
         XEtEzHvqENIdluyeJr4J2tQlRlkNcCXNq77vqNTY7wKpGV0/E5/CJXF2JMnwS+Uzl47h
         7GZMk/lokzovwqXpi4IwarW1oCvqrlh/EQ8LcZlIiATThaMdwgbHEHsKXIBHonXU5U5t
         UwGmIpBlcCLd9paG+h/Qs8oQp2YqBJiPflSgtCvqAMTsCBhYrBc7KYeii/CFqjcQjfi5
         71VLU20RjqSmjjFE3hqvBM19EXhDNbFO9wh8B12D21o3mn9Q/HaWP5TLc1KfcziqoaIc
         V9nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360567; x=1772965367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW/Bcz/vZ+9s+u7SK7RKM7h92kQtr5RPEQ42Aeeif5c=;
        b=CKCyh2KaOOb7Tw9dEqXyFbgm6pExuwzXUI5b0dx+JlAWik/qFgsSlM1kg3FRcj7Db3
         ZpGLqob8w1QdtJQ+DOQ4Lmu/cccBTJw1xsvVt+WUASWmuRAn00pkiqtog8hQykphyEbt
         GEgcTCcng7o4vLe76vFhf3rQExsG7ms8VwNHpFarq1W/3AbDCFQkJhnZMhs5BJmlScDH
         R/NGcmpKaZjTmoJjP/xlbX2McFAGwlGi77xtUKAVRbospVrrBZlPX1ep+isX2sY3YkSW
         ur0zfEUJyPIM1AOR+rLUJ6Xmxuecs/XvtTunGdWov719q5dNBGAbT1UXyXFBu8E5GP2g
         Qd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360567; x=1772965367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WW/Bcz/vZ+9s+u7SK7RKM7h92kQtr5RPEQ42Aeeif5c=;
        b=LNNvUjOsSve+bQz4frUdxsHJE/PHmwQ9rViTwHFS8Ga2I9agOUu8YqUcgoUjrN3PO9
         yFTw6bE2GG3QtrQiu73zLVXQnxmpuBVfZECT7on0i1TcQ16xFVEZTA2+CXcXc0j2Mmej
         2lLmFjt1hHNpyhmzCFnCoMOczqdfw3QA7uytprS0mdeUY0imcf7WWhogp4f9XaOARUaU
         indnELgVeBltv44mYZd+YYIG2zzvWOcPqeOr4Tja30Xh53N+zZOkxWIZ5TODfpHC8Dw2
         qP0l62JWzncLpoMh79JbleXgdHd8gIK5L0IlqlR/Dw7Cf6yUqIY0o06wI06W/vfv6Fh4
         LAIQ==
X-Gm-Message-State: AOJu0YzEac8uAwOpNulZPXKqpSeAEuU9S9FwS7r8B1rktLr0RmQV0UVz
	/Zng9un0jcL1c4ovRwdR3GXGc7So+iMUJlrHYUrLvMmK1IQ7/op4pEweBaXQD03brAc8RzS/phu
	+TBInHOfz7sEvKXfRxkMkJe4ZP7tNQ2/tXEYeq6s=
X-Gm-Gg: ATEYQzxpjBsBGvCfn1Ri1CsggTfIKINHphq4kT/t5WJldhnW68nPG129teQwP3Bqs+T
	5P0kTPHrdYIlVIxZBvHGhaB1o+IIEih0eWweKq4ib+qBFaFbnWueQyCFaV8nQWSZSsogNuRKNC3
	NIQuSAzea1mr2Kjm9kFO3XWLsKkP9JYFa5bfuG1df8Ynsv3+Jk4P+TiPrCH88OHuMufWJrzfe3I
	xIMV4Rq5iMhfe2AdUzad29GzfJHOVeYh9X0SkrnGMu5+Hg1hoIsK1brTJlO/N5C1SaQtfLAJQaI
	Su5Gr1/jZQbCfuLKxCjSWzncSBC0x68BZVwxmovYRqehsVcUUPGAvZOKGy0eRTPEzlkM0l7S9zW
	2wUL/W2/CRppw0qhwwOafZZhoDFZR
X-Received: by 2002:a05:7022:688b:b0:127:332d:62d with SMTP id
 a92af1059eb24-1278fd1158bmr1721541c88.6.1772360566797; Sun, 01 Mar 2026
 02:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012928.1687248-1-sashal@kernel.org>
In-Reply-To: <20260301012928.1687248-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:22:34 +0100
X-Gm-Features: AaiRm50czIpPXXdgvyv-aou8JdT19ghdT2Vl7WOGNnj5TsVeNNgdJIxmsC9j6h4
Message-ID: <CANiq72=P_A+O3KYU5HXtubBP0qmUNvk8WpoN_LWaEsa6LuH1gg@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: pin-init: replace clippy `expect` with
 `allow`" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, lossin@kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222446-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4788E1CF25F
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:29=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

These functions were added later than 6.12.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.

Cheers,
Miguel

