Return-Path: <stable+bounces-213290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK4jKCsugmlFQAMAu9opvQ
	(envelope-from <stable+bounces-213290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:19:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC7DCAE1
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235D4301CFF8
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F529257452;
	Tue,  3 Feb 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="DInIKBPx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6zXPaiL"
X-Original-To: stable@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750222126D
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139121; cv=none; b=kSxVo0iXin4ChR0oIf9J2x7iajMwuKx8wfF8ZJwAkj0j1Aud+inLR4vuE5rFXPJM36jAofyQbiXTfDja5F2ogDNbJrPhB3M3a1N0XHVSsLlo1fiR02Y1NcU9FTXOZyLbhFDUDOOX2Fpfnaa8ia7R9Au/IbIEhRns/ZbK2RCYol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139121; c=relaxed/simple;
	bh=n//OUD0h3NGG8sdRUdLzd/VPqBqzeXL0PZHawBJIIIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bfXLxNADP4kqxazG0J5EbqE9Wq93R+wLiKVke141qhGcqV4dbWOyJs0iEpMoibWjjpqJRvY0F+bszq3JK9cdAEFCpk2pcxlFWeVrYFyeNx8/cuwKcKA6wyk+xyAS39EDVWUv5R5k/ViRjqb3qxElXdXBQDxDrgjq9A8VjBI60kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=DInIKBPx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6zXPaiL; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 255A3138091C;
	Tue,  3 Feb 2026 12:18:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 03 Feb 2026 12:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770139118; x=1770146318; bh=EmMhM0fwXg
	STuaWD0hEWKMV4VJLAHQgpsmBEl+7Mhr0=; b=DInIKBPxlWPEbL5wxyVsBVH3tf
	9qsl6UREvmbJI1SSEvx22zn9XVv9e3LlWGfqIuy1FqHFb3fR8ruMNa3HGWCkmh0U
	P+qncm2g6+BLNwDYuse9SCqL2wzqljSfpgIp/SDjsX4dMKVA5KfK/SG3Jcf7H9ei
	MKjQL7hQuGjQeg8t0wXeX+a4bsLrEp6kN3I9AiPDS1QLcEW5cuB2YEb7b5QWSFwa
	Se/GB8qrLC1brkhmR/phc2w/Ex5XxwmITi63pPga2wbWxSAELfJHEbkAcxZ/gqd3
	VItVQbwmqSd9AXkMnfeFlAzakreoOUmazARrnhlouhHGyqt6jCwpwRti4rPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770139118; x=1770146318; bh=EmMhM0fwXgSTuaWD0hEWKMV4VJLAHQgpsmB
	El+7Mhr0=; b=n6zXPaiLVYpS6YOictkc8IV1xc1KMhwaTFnMp18gW10/FKxemwH
	EwrcXnskqoAbwg27ZJv3wMvU2JVBpJheFXpnAd34dG7WMMF9H/KEhcA9RJxLLrOK
	H/5NCqJyaG3v1W7m7wdCK3+TmZpdbRBxLH3ZHTDhT5+fQr7Zx4Az4hFkXahpWnrR
	qgJbn187S1WGuWm0B40G91nH/9neuGbdAETux+9+alVaQ2xT46CdMnRR1SdKg//i
	OL1lPHgVWEqQs+BDZHYh8p+fOfKJYwD5tEwSOVM1cG4wPYid4IDHfOADYF2S1hm4
	0dEPeVdpTR9m3QGLnQkRD7BtpxpezVSiQCw==
X-ME-Sender: <xms:7S2CaZzklA_JC_myhlyx6hQoAOOgIr-tRLxK54ZrmLd6w1TgZYh6-w>
    <xme:7S2CaVHpyiyB9_EN5JPQOTOure8hzjQIc3l-FPX8ESqmRp3VOtIdbpdTX5CZu_SHq
    qc87qZ2tBv9OShUXVE6jcbFrmCGb2JK9KmlgSaCYD8C6Cykjsp2>
X-ME-Received: <xmr:7S2CaetWAX2nmTH5p9IcxaeqTEuE5K85DTJXaTWyunt3ESJtzdmfgFFPTTwi948NQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeljeehvd
    duhfeuteffvedvgeejfeefueeiffeutdeigfffkefgffekteetgefhveenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmpdhmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhishdpnhgs
    pghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhguh
    gvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    rghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhhstgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhh
    eslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegthhgvnhhhuhgr
    tggriheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopeifrghnghhruhhisehlohhonh
    hgshhonhdrtghnpdhrtghpthhtohephigrnhhgthhivgiihhhusehlohhonhhgshhonhdr
    tghn
X-ME-Proxy: <xmx:7S2CaVBh-4o6oLjv7vKtmAlj5yseWViZhh9EJUp3ODA5fTaQ_tMVKw>
    <xmx:7S2CaZDlwGK-g6mMAqWd5cURs_7WxlyfXGt4DejMWQB90EL79-CWqg>
    <xmx:7S2CafrvHwbIzP6REmyyMJ4f8iS-2dFutpJ_2VL9EpHVq6b0JiyByA>
    <xmx:7S2CaUHXRB0HZ22FhBfO0Wf8yzr1aP9X0Fkpidpix7UDJESHNCg7aw>
    <xmx:7i2Cafj64vYsVKuiJBhHu2BsM3STMvCs9hAYlbHmoRLK9eRLhOhLLZtP>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 12:18:36 -0500 (EST)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id A6E1B8718575; Tue, 03 Feb 2026 18:18:33 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>,
 WANG Xuerui <kernel@xen0n.name>, WANG Rui <wangrui@loongson.cn>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, stable@vger.kernel.org, Miguel Ojeda
 <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross
 <tmgross@umich.edu>, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: kbuild: support `-Cjump-tables=n` for Rust
 1.93.0
In-Reply-To: <2026020348-rehydrate-glider-b1f3@gregkh>
References: <20260129133715.23095-1-hi@alyssa.is>
 <CANiq72mD7BZB4KUNNnboK81zLRLVqrZ7CaQQJsG0GTqTO_ZU=Q@mail.gmail.com>
 <CANiq72kXfdBtGAxdqer_t4JC+57mjgTpEE=D1VkAeODCf2hiZQ@mail.gmail.com>
 <2026020348-rehydrate-glider-b1f3@gregkh>
Date: Tue, 03 Feb 2026 18:18:31 +0100
Message-ID: <87sebhvj88.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[alyssa.is:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213290-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[alyssa.is];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[alyssa.is:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hi@alyssa.is,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 18BC7DCAE1
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Jan 29, 2026 at 04:03:06PM +0100, Miguel Ojeda wrote:
>> On Thu, Jan 29, 2026 at 3:55=E2=80=AFPM Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>> >
>> > On Thu, Jan 29, 2026 at 2:37=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wro=
te:
>> > >
>> > > From: Miguel Ojeda <ojeda@kernel.org>
>> > >
>> > > Rust 1.93.0 (expected 2026-01-22) is stabilizing `-Zno-jump-tables`
>> > > [1][2] as `-Cjump-tables=3Dn` [3].
>> > >
>> > > Without this change, one would eventually see:
>> > >
>> > >       RUSTC L rust/core.o
>> > >     error: unknown unstable option: `no-jump-tables`
>> > >
>> > > Thus support the upcoming version.
>> > >
>> > > Link: https://github.com/rust-lang/rust/issues/116592 [1]
>> > > Link: https://github.com/rust-lang/rust/pull/105812 [2]
>> > > Link: https://github.com/rust-lang/rust/pull/145974 [3]
>> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> > > Reviewed-by: Trevor Gross <tmgross@umich.edu>
>> > > Acked-by: Nicolas Schier <nsc@kernel.org>
>> > > Link: https://patch.msgid.link/20251101094011.1024534-1-ojeda@kernel=
.org
>> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>> > > (cherry picked from commit 789521b4717fd6bd85164ba5c131f621a79c9736)
>> > > Signed-off-by: Alyssa Ross <hi@alyssa.is>
>> >
>> > Thanks!
>> >
>> > Greg, Sasha: yes, please take this one -- this commit should have had:
>> >
>> >   Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is
>> > pinned in older LTSs).
>> >
>> > which was in the email thread, but I didn't pick it up and neither
>> > `b4` did, my mistake.
>>=20
>> By the way, if LoongArch (Cc'd) would like to backport commit
>>=20
>>   74f8295c6fb8 ("LoongArch: Handle jump tables options for RUST")
>>=20
>> then this would be a good chance to do so, since the one here would go
>> on top of that one (Alyssa backported the x86 subset of the patch --
>> for the future, by the way, it would be nice to note it in the commit
>> message in between [ ... ]).
>
> It doesn't apply to the 6.12.y tree cleanly :(

Doesn't need to be AFAICT, because -Zno-jump-tables isn't used on 6.12.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQGoGac7QfI+H5ZtFCZddwkt31pFQUCaYIt5wAKCRCZddwkt31p
FaEAAP9AdacfwOXSzR1rYv8efUS6jEORqIyK2L/mZ1UvFBuRQgD+NFP+FBU3xO77
uC4zBsg18CFGwwtW0dr/GOluJjMraAE=
=p71K
-----END PGP SIGNATURE-----
--=-=-=--

