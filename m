Return-Path: <stable+bounces-260695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6yXnMO/MImpbdwEAu9opvQ
	(envelope-from <stable+bounces-260695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 15:19:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24777648781
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 15:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onurozkan.dev header.s=protonmail header.b=XAGlTJcE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260695-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260695-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=onurozkan.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E09BF3075416
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC972EEE65;
	Fri,  5 Jun 2026 13:11:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B831A3160
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:11:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665100; cv=none; b=tcA4zYFTx7qiGHJcy5zwbv5f1+q14jPi5VIs6tGvFdMf5FZzkSENmMY+yJveLMebax8camKKMgM5abbseiIjR3TgbfBzbLHVShjUHSERfn1fKLoIEBvI8o1FQjI/IsWHQzqer0FMRk2qrwiJ/72uMQOwmeK3kQx5Cu5Jko+G0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665100; c=relaxed/simple;
	bh=2adyeZcH22koCIaVV37qMXdzsfR1yVcEuF5WXqkK9d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7AuEfDwrY5y1cc+HV56Us/Z6DOZWZyJWCo8eyFBKeV3mC5gWcfNfIepYq19Kfcl9PD3xI2tXHtcXighlXyvC3iLvALyKb+ANT4TitERVMvtINAA1cY55SbACvGsqgWmr2woFiLQKlTNCvNCjPn0SEEv9wZA3uZykKZPSKIqHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=XAGlTJcE; arc=none smtp.client-ip=109.224.244.107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780665089; x=1780924289;
	bh=2adyeZcH22koCIaVV37qMXdzsfR1yVcEuF5WXqkK9d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XAGlTJcEWFO9F6/CZM3gFRTK1BvQFQz/8lahqNu61XFJ51z6AO1TQAjgdnmKDkXgh
	 iZSmTRI/gIkKg6F20KZDoFo2Mo4suBNHjUs3rlsmveyxjBh0Oi1zMXZSck90xbcans
	 dSB9EKKB6+gZkAUZjtB+ktVKoTQTa7rzKm/jTZsko9khKLDhZ2yCmkZQSeLlIBiVIJ
	 toITMGzd4brLepypHGybA3Tpvebqt2FCbHDGVYFPZzo0V1jhF5NyGu5tHXjB3SjmEH
	 pJ+sZrjQBqMs8IWckwBRvMAnuN9FSPL+5USaOZ/mJ/KRGBOHMB3rC104knIcPU0DlC
	 axMYjGbsZLT0w==
X-Pm-Submission-Id: 4gX1zL4cNCz1DF7r
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>,
	Yuan Tan <ytan089@ucr.edu>,
	ojeda@kernel.org,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org,
	zhiyunq@cs.ucr.edu,
	ardalan@uci.edu,
	pgovind2@uci.edu,
	dzueck@uci.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: firmware: return empty slice for zero-size firmware
Date: Fri,  5 Jun 2026 16:11:21 +0300
Message-ID: <20260605131124.24241-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CANiq72nE9H34DzEthWmRSmDxgaDW+XLLbrA=T6ywy=hB5FAMrg@mail.gmail.com>
References: <20260605041134.38290-1-ytan089@ucr.edu> <20260605071104.135675-1-work@onurozkan.dev> <DJ0YRJ6MHAU7.WVR4P2MQ4HIX@garyguo.net> <20260605091632.313084-1-work@onurozkan.dev> <DJ10CJ31GS5I.1ZD6WPPWGZTQN@garyguo.net> <CANiq72nE9H34DzEthWmRSmDxgaDW+XLLbrA=T6ywy=hB5FAMrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onurozkan.dev,quarantine];
	R_DKIM_ALLOW(-0.20)[onurozkan.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260695-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:miguel.ojeda.sandonis@gmail.com,m:gary@garyguo.net,m:ytan089@ucr.edu,m:ojeda@kernel.org,m:boqun@kernel.org,m:rust-for-linux@vger.kernel.org,m:zhiyunq@cs.ucr.edu,m:ardalan@uci.edu,m:pgovind2@uci.edu,m:dzueck@uci.edu,m:stable@vger.kernel.org,m:miguelojedasandonis@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[work@onurozkan.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onurozkan.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[work@onurozkan.dev,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,onurozkan.dev:mid,onurozkan.dev:from_mime,onurozkan.dev:dkim,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24777648781

On Fri, 05 Jun 2026 13:15:32 +0200=0D
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:=0D
=0D
> On Fri, Jun 5, 2026 at 11:28=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote=
:=0D
> >=0D
> > Oh right. Arguably the wrong error code, but it does prevent the path f=
rom being=0D
> > hit. xz decompression always grow at least 1 page and thus won't hit NU=
LL case=0D
> > as well.=0D
> >=0D
> > So indeed under no paths we will have a sucessful `request_firmware` wi=
th=0D
> > `buffer` is NULL.=0D
> =0D
> If we are not expecting it in practice, then at least a=0D
> `debug_assert!` would be nice, or perhaps even making it an invariant?=0D
=0D
I think `debug_assert!` would be nice.=0D
=0D
Thanks,=0D
Onur=0D
=0D
> =0D
> Cheers,=0D
> Miguel=0D

