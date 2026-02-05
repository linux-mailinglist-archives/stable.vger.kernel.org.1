Return-Path: <stable+bounces-214471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eITyC9SohGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:27:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FCF3ED8
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15D623011C4E
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9AD3EFD3F;
	Thu,  5 Feb 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yxu2FXV4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87573E8C57
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301647; cv=pass; b=ODGcFgFQGrIWy6xskacVDAU2i7wHY60NRRv+ZO+jvzoReLnOTzPbh0XeNS/RTfQYKmZZmUqE1RtxAxXL2ujP1RN4ofYIfZ2ElbWD4zqIZ0VmnaFhviKl9uxxBYwIZHb/Mjsd8SpdBrDlYwwPgIbdxspv1rzCJAzLqs7tE7W1dps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301647; c=relaxed/simple;
	bh=VEKVNWvDGNeZ3EwF+mhobIka6edblb6RspOlfIgXGKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWTB3RdRTNRG43xCbugOMch2VRx+ZxaPc2MehRy9AJfpPBnJeEjRxhlT5EGbW5UXccSMwgGAuRdUNnt4dV//mAHefbAwiqahLWpdg/0yBlTLQ5DA6rkUKw1llPAyqorUW4jlzGgmp3H/gwsTsNzvIN54s/+lqyOCClISi4ydfEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yxu2FXV4; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so11479755e9.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 06:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770301645; cv=none;
        d=google.com; s=arc-20240605;
        b=cWAKcyyBI6FtX0tczt6E9ODCLTH0NUn9jF0Y/PJlZ2syHAOXNMrkyn/wID/lnyc128
         VVEDEW4KE3d9Q4Sz5Ds8m+H2tTvgPyIJPbycdLusEG/oWSVGVmQcynT1yci408QIWe9n
         lm64yPbgUM98Ra9SlfPJjD2UDF/D3kjokJ7nXg1ksXkn5yxszjHMXSWg5vh8wXzZCcG2
         KvY0eKx0ByvTJXUJOcGfTNzhmnRjgCiTEcbKOIdbDwmirmG3/qvjouY5YFtxvbL88Ywk
         KfIsxxBsTi6cwMX2SE8EuuXYKfkq+V9H/CsA/zEPaH0aktlePHYUqplyMtKeMFScN/JC
         Q13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8882JAz0V+sIVJtavBbRuvKI7GliooWI/Xmd2Gbarc4=;
        fh=aCsn/pvTuh5sKfy1rsVWk7UkR2g1jYtTDQ3RJav63dE=;
        b=bVkGT3KejTYfL2F6cSaqix1fJ6C/0vcrTX5lLFG+OCbjwtZdPI4x6wepk1unxeJYja
         wD2fues28lMFndORHHWALQEdQCO/Ckl6CFdhPIB0kFb1Qrj4GrtV3KEuo//na3MbMz7a
         9QrScr7daqaSNW3qjS5h8w8r4LAQ6SSvbSV1G+17ar7AAh39MivhfCls1FsT93Gpr3m9
         XXdEUv9K4lqaGT5g4aqWxiufYAvw5JAT2N26qS6RCPL1N3hH1R1546ONjSSbdsUIzApC
         zG21waABpA8Kx37zWnXH/sRqfEILtNZgYzNYTR56txoDUTTEbMiPzXe0k5BVYB9IhLa8
         raig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770301645; x=1770906445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8882JAz0V+sIVJtavBbRuvKI7GliooWI/Xmd2Gbarc4=;
        b=Yxu2FXV4cBrzURL9VV8OPkYnjrHLqjthFJCwAkngkBzugxWrIxUaDl5oxHOgtv0f57
         xDmGYNXa/fK94eOOrQLqHwExOfI2rgcYHliOmVT/S+36HelUTVTkNG5aEuCAA1Y1b0qu
         obeFNCHJFsHY2cMKtHhktO8rXdDC8C/c6rUGqdJzEa6YVnh1ivg/G28ZAaQfneHxOU6u
         4/ylaAoebz8Mfbf3hsAUT/k1y1dsPRiGW3eagYacsLTanyrCiTSbt1SWIDSROgfdOWXU
         ZHlkZqEdlH/tMtTRBIegKlrOZAGcy/cv4k+buGOkMmr/jJiF5N9S6D+TfUzM7TKP6j1C
         c5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770301645; x=1770906445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8882JAz0V+sIVJtavBbRuvKI7GliooWI/Xmd2Gbarc4=;
        b=jP/g0n5bgYPimNxH8VYtbpZMMAURIXoKKDyF2SyyryGZO7ghvsY6zHU/xlPBiaVe5p
         cj37M6PQna5Ohj7i+IG8MtVzfMteOasLgRnjLzl5AquIajKyQNy8D/WMnSSRTvEdwgQP
         16/1HV9tn1RtFu93GZ2aMHeS4jALFZYk6XsNtoJWbHwzpEiAzRlogGhSrQ9nyced14F+
         KSzntHqZUxSEKZfqV5AIOAq+8ITTJXiSiPhRjGreULjQzPmfmmkvtcJoBkJUCi+9J2uj
         vIontbw/WD1onllCo/qoFqRTYX90hpooiDqiOZdY2U0W05FO7tAoA7PjJ7vhFwrgZQtc
         dntQ==
X-Gm-Message-State: AOJu0YwPjby49DdBlvN718+bXPRKRL9Kzex+qytGP2yZS7lb+pu2q50t
	k/pglWba5L29aUL+Xp5gV+xsJsLn8p+5YgTpJcUlxpErdbDjvipzeMyAYfyZQ1C97ShRSC4gSBJ
	UDGa9RUO1apy9Glmet2h5nfLvhdIm+WLq8MB7nMlF
X-Gm-Gg: AZuq6aK9Ej/tZOlKgMQ/tRa2LhuHqTc/2Uv8XNTWihJeh8g/TbV/j+L12yfvPvM2LPg
	0MtNSeJQHCdQREszkhjaYGWkA93NeV5CtvlVg3ciZlw1E42gPybbCz8ekx6yAz2843/SsgeU4A6
	MpTsMw8PH4up2c9Ai2gJrEdW5chux6bam/xthwBdVePddRKXHEC9VPupuWbZZDlkxfGDmMDpTkB
	TDN6Mo4GvTbJkEDr8zPFFUYnpWjlNNxWoZNAKH/y67Rw9Dqwa/Ruh3Auut+rcDT+/t3lPiwgrNq
	7EfDXOJ8MRoulUs8PVQ3I+ntjaFrv/O8b4zN
X-Received: by 2002:a05:600c:4fd0:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-4830e92cbc0mr93916125e9.8.1770301644968; Thu, 05 Feb 2026
 06:27:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026020339-trickery-vegan-e9c3@gregkh> <20260205095323.3149138-1-pimyn@google.com>
 <2026020546-nimble-mower-1202@gregkh>
In-Reply-To: <2026020546-nimble-mower-1202@gregkh>
From: Pimyn Girgis <pimyn@google.com>
Date: Thu, 5 Feb 2026 15:27:13 +0100
X-Gm-Features: AZwV_QgmgdADeaXlRRIKwwL9rj05-RWLuKEa17b6ca-zU14BD3CgkLKSU8y3YK4
Message-ID: <CAJWNTGw42Jx2_oOFm2Hib5DzMJxws1cEUZ8RFUB4cyQyCA7Pnw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y v2] mm/kfence: randomize the freelist on initialization
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214471-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pimyn@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 814FCF3ED8
X-Rspamd-Action: no action

> What changed from v1?

addr calculation in case of an error is handled in the appropriate loop in v2.
This ensures that `i` will have the correct value. In v1, multiple `goto err`
statements risked using an uninitialized or incorrect `i`.

>  Always put that below the --- line, like any
> other kernel patch.

I'll keep that in mind for future patches :)

