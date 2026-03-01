Return-Path: <stable+bounces-222447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ7UEvgUpGkPWwUAu9opvQ
	(envelope-from <stable+bounces-222447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:29:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE81CF2E5
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F81D3015705
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6821257B;
	Sun,  1 Mar 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyfr1PQ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA212B94
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360948; cv=pass; b=JG/Y/wGWU1tdNnJa8rrJ5SjqyNkD7MPCUo+WVrCoXkRkCOY+AOeeq8eBEgP9a2MvLmoJIvfhMn25hqdp8+VBkqyxmBA9cR/JxA3YWgmE+D7g4pu3VBd/AujfRDoAm6U2wM0GSNDMNRnbmaN1M4TBzzCJuJI/akADKPEfjyy1erU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360948; c=relaxed/simple;
	bh=1OeDkV5pr+tmMF8cYRnZhIOSiO9hTHhwtQyeqqlGicQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gk9XgsQBlu7HvL93mxzljk6aMFh5rJR3uJlIx+pwJO90TleETlaG6fDGGzBRbRMphqjbIVGEybS+vzi3IAA6etvKKGf/J6LWi26AZbd9uHmwFYz7oSf2DWY9xVa70UYkmHq0is26zwmuiQpEV/EeioV6o/xn7cm0zvfIwC7RcbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyfr1PQ4; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2be054479baso15883eec.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:29:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360946; cv=none;
        d=google.com; s=arc-20240605;
        b=lw1ZWJIArQG4ALTYT/SRfu/kvoNPdhbSASLwSu8bUICU2DHGJgUTCyvxF/f84Z525J
         lKutS/Tig04NHlvOSSgeRtTqu7r8uat22KlTDtLh7wTrFnXhcXlFcgLUdwUVSy4UND5x
         EPiDz3whZvJ/5GShWgTB+FTnyTMwsUQiyWk836s51m+QbdeLA68g/3CXOzad06riLKsn
         nJJ9ZaxfhGqk882ouaqEV/d680Mimg3BEQ9H8jvSvsRuTtzYVsi7Nk25BkaIQydBaAiN
         j8hfGhPWmwl4lBj/v0YdKBogbkPWB6FgkTpfBm3Lxb/lKD6AlWVQyjcjxxcfDYX7bBFq
         VKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1OeDkV5pr+tmMF8cYRnZhIOSiO9hTHhwtQyeqqlGicQ=;
        fh=Me4lvb+0TzIoUKsfdx0+5scFQ0m9HX6KbyTr2oLN9FI=;
        b=G41923s5FBmOmjQdq8jYL1x/4dn1rF3ZVSvLgNm0GjiqPiKZEY6LEP4F55C5kNawXQ
         S+sPjADTJJkS849VJx1mMsNF4fdZzGck5YHrhPQj2CbFmZGkpircHU7yRViLI7Vhz3vj
         rJ1L+djUa1aa82jESxOH1jB1eStpxSkTc6pJQBLhqJdqBdmsX/n1cB5h+F9fhD+NSS7q
         fYcOtefWXzcmqXpwJfahG4XB/RmGot+OmSn/T7Z2uo3NVLNf1IB3NqUY2Oemtkzp38B1
         RwGYl6/p9G+Tae/e/13RiGxo4g6drTNYgyXBmc9QtnBVJepmdbE6M62pCOWhs5MUWRbr
         sE4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360946; x=1772965746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OeDkV5pr+tmMF8cYRnZhIOSiO9hTHhwtQyeqqlGicQ=;
        b=Xyfr1PQ4gnAqc1OEz2Sgb8frYVwLblJDWKkoIi74GI4sYFfjOQVQYQ5CofGajrzVk2
         MvzU0FLuZm8zoOD8+LHiO8ex7gSN7yd8btKE+rhTTYlMSjY/s3DNCjZC6seeOw4ovj+L
         g42TtiZFkX8vOiXJFqISELoVU2fiLLo+Rc9ShdbHHgPWjcKJM63ro557ci7D3ZkySsJi
         UwmLcjSW8jaoyi4nx3zrYRotF+UZ56xO0KA3LvlXuWyDYu2XxeeoDS2z7O4kB+pL8lZc
         +U/m8WXhQU1WGLJva9GDT73KbkzZS82IAxA9/VyDdsIGMrPL7XO6UbhbloGeFQU6tJXm
         T8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360946; x=1772965746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1OeDkV5pr+tmMF8cYRnZhIOSiO9hTHhwtQyeqqlGicQ=;
        b=s5y1xX+XIOa/FZuD0EBcEryVBSwW4t1ztL7RuwhUQCAfY+jlgFh0fyKaO2AOND2hNO
         i0ODvK8qwldTf7n1AivYezK0AgkJqbnpEvuV2Y979iTyGd0Iem+SAxG6dAKG7R4RE1wj
         SNth+B7c3IBqpA0B2buaCoWNiu9SYDHEtZyxT+G1JSwO+q5sc+Qri42TH7lz2cfzdT/X
         0jcMppoeCj38jkHxAGK/qSyW8dqYhWM6I/hs90dNryY0sJUNEDNzNUTr1Bf/X86m/DgL
         oqBlEpjD2v0zCww68qTr165otT1Cq1Qm3MqhxorIkT/cz2V1rJvZ3Cjq23jG5ThIncFy
         VUMQ==
X-Gm-Message-State: AOJu0YyHo5vZrRJiuu5SLbjQXXmuKJzMoXxUCutMsb1MFTaijZNsiGXf
	p8wPRWPbdR5Yw1XuJAQDxt7o5xZxbwZPDv1Ow7AlkU7yVjLxku9L0BBatpGnNeF1n8WtzvhJ92z
	P26DDna1evPcsj+lBK/s7Hkzhr5kdkZYFeeze
X-Gm-Gg: ATEYQzxNeaVeJCFX8e/pJz/G83Ycu3bE9kj/aB/oILDzx8qPdaFm5CQYXVuipdBiLfx
	/8qiadA9IY1SmqydqAVXhp9QvmWeCYYD4z68/itZhGgWRArceFXDc2Xl0i60M/ANy+lHjOKvIo8
	akjaRBaMW+z0ejGCsoGyl6iUgzv7AJqDd0hDRYPgXbLLWHCH1EonWBDcAuvk6BfUptp3p08LLFv
	OKv3biVWBw8hDY6lAPDf+q5tMhndTWnY9YLyAohMVC9wuIHvbwL/PQva8r5cmm0/vwhK1d7kU1I
	bpyGiFgIigeeGdlMj287oy1RYt/WCtCZyeuI1sij/h95uyjmFElc7cLg0KTwoIQXvYriCC8BoXT
	YiHauva4sDg7xzEA+jyaPNNatqMwT
X-Received: by 2002:a05:7301:678f:b0:2be:681:91b2 with SMTP id
 5a478bee46e88-2be0681950bmr249941eec.6.1772360946335; Sun, 01 Mar 2026
 02:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012728.1684975-1-sashal@kernel.org>
In-Reply-To: <20260301012728.1684975-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:28:54 +0100
X-Gm-Features: AaiRm52ANv5lYwXxPMzNaqkIhoneKYCzv0imsMm76EF0bp1C8gpICqacpqUsZ9w
Message-ID: <CANiq72nHESphKjW7uXm2D7HCNWNxmZ3nv+CSgrzEGgSKZ4_taA@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: kbuild: pass `-Zunstable-options` for Rust
 1.95.0" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ojeda@kernel.org, David Wood <david@davidtw.co>, 
	Wesley Wiser <wwiser@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222447-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davidtw.co,gmail.com,garyguo.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91BE81CF2E5
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Hmm... It does apply for me on top of both v6.12.74 and 6.12.75-rc1.

Do you mean you need it to apply without auto-merging?

Cheers,
Miguel

