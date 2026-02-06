Return-Path: <stable+bounces-214655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH6cJc3mhWnCHwQAu9opvQ
	(envelope-from <stable+bounces-214655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:04:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA92AFDD58
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A22BD303101F
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB033CEAC;
	Fri,  6 Feb 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="ncIB12du";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KpZr8UMF"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399073019B2
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383050; cv=none; b=QWaPFuh0bJZHp77iCwjdkvmp2MwTj4DcELGAUtfxz5PSeRA/Go0Mlfl5OkguTn6nZU8e0GJj74b3eBzkKZv3rWZEk/Yp7neovBaRjnQ+XdmzlGfWSM2on7Mc65jMguSI0S3zckvmx8vwInoVKGsz1UucLMZYNNAdCIkjcAfdegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383050; c=relaxed/simple;
	bh=DJsjUA9RQOJwPIkN7F5+EnWZiuf7K1FlERtco/GMGnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqXCf+taqtH9LBJ5ooH0ySHVn28GkwkRn/NpbFQzSdJlbW18SyBZiIY7AyeLUAa4Hn4LGIDOwUs1wuZuHRXynSlXetii6c0D+GL4jMSrOvmXNqs1xoS4NQ67AriQ/ORvJ+GrKv7W1TxaX2MxMhvQXRVIGYKgstR/IN1gaHGNbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=ncIB12du; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KpZr8UMF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 30BA2EC0013;
	Fri,  6 Feb 2026 08:04:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 06 Feb 2026 08:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770383048; x=1770469448; bh=DJsjUA9RQO
	JwPIkN7F5+EnWZiuf7K1FlERtco/GMGnE=; b=ncIB12du9A7ok7oFUOCzaJLdRq
	J2+GVL4MP7i8u2aL0XobaUnXGUIduQda4jB8MRFry6HtL+je4gYObMvwebCuMrsP
	WbS/6IYi7+goGQtSe2bFfMoReIEqSOpd+Z1oJPZR/Ec/Nmk9zaf+oK/deKCyYbwm
	I0bwHkadnkW7mT4P0ux27r4YVBKWx1NtR4GfvL33WXim8cyZgd/XkRY53RllI6WN
	mt7kwqle+BVMzF1XR2aThbyBbm9VlP0cH8JI4Fn1wu6tWmNm/8+dzFP260HZT8oR
	/zSJBbS9YNtf97ERlFf958NybjpW9GR8NxHSTLo0rUPeNbiefobzNludhPCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770383048; x=1770469448; bh=DJsjUA9RQOJwPIkN7F5+EnWZiuf7K1FlERt
	co/GMGnE=; b=KpZr8UMFVQ4sSSzs7I1rQlahZuABXtujh299xM1QBormYcxidWz
	0VSWSBOrtNMt/noqwWhNkyiTVTEMJ5ytmnKxIKOJc3FZQjvUjzwKuObq7L0qVJNX
	OjSKGc8n6XafJ0kmFAnmX8HHZDSaRSXoaiNSGXIex6eYk42hSSt4PA58lfFD9w3y
	AG16eOAE/E4qWSDQ2DRKRJNptMjEpv739mW2OLKVNIsSrccmegeF8f+yBklMVCNz
	7SOf4FE/A+pzlCkHbDwaUvalhQ0VIfsoiVXF2V7xTqsI07vdo0sMNtulUAAA2j1Z
	sVuEXrGfSQwSDSbptO2s/bBn9TwhzgRsU7w==
X-ME-Sender: <xms:x-aFaSHlBxg_xF_0dQIxPjnspUffGp3z553H4IiL0SI3jKoXokNNiw>
    <xme:x-aFafKf1ehZ-SFam15lZO14uZSYDkkSubr79AzZSfS1_F091O6TvTu3Q5VAFOizu
    TUBPrFWaHVB2o-apiN_RAgryEGEEcQs_T502Q52Zz8IaT_TBT1FXBg>
X-ME-Received: <xmr:x-aFaXi_ESio_4YbYQgREyp4Xazl4QwR9qda18w13Hk_JK1hMOV_SUTUfPu5l2FV3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeetheevud
    fgjefghefhieejudelkeeljeegvdekueeuhffhgedvveefteevgeetieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
    hishdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhhs
    tgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    rhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegthh
    gvnhhhuhgrtggriheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopeifrghnghhruhhi
    sehlohhonhhgshhonhdrtghnpdhrtghpthhtohephigrnhhgthhivgiihhhusehlohhonh
    hgshhonhdrtghn
X-ME-Proxy: <xmx:x-aFaVmT4sYiRiL50mSjqu4rA9NQ-gozGGeneAr7Cr_K4HsAwD1ptg>
    <xmx:x-aFaWVJcYktvlL3U2oRmkm1bjhKRLxqj-Pwz2t7keQIB_R24ZfVAw>
    <xmx:x-aFaavPR7f6jR-3UonsLhO6Ud0jaOG4XDwT9xWAsYoXbkwKXrEPCQ>
    <xmx:x-aFaZ4bZBP8p6iAe_563zOW95gE-NGppktvMRKic4GeJPlqLY3y1w>
    <xmx:yOaFaXKyGb6YORxaUzaFl2FsUZZKX6ecTwea-1TQWsubs78L3hZPRt7m>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 08:04:06 -0500 (EST)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id CD53887CCC5D; Fri, 06 Feb 2026 14:04:03 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Huacai Chen <chenhuacai@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
 WANG Rui <wangrui@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Nicolas Schier
 <nsc@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: kbuild: support `-Cjump-tables=n` for Rust
 1.93.0
In-Reply-To: <CANiq72m4-RoG4YYS4dBuUo7mW+HWez2BZXBu6NvXXPChmBeYfQ@mail.gmail.com>
References: <20260129133715.23095-1-hi@alyssa.is>
 <CANiq72mD7BZB4KUNNnboK81zLRLVqrZ7CaQQJsG0GTqTO_ZU=Q@mail.gmail.com>
 <CANiq72kXfdBtGAxdqer_t4JC+57mjgTpEE=D1VkAeODCf2hiZQ@mail.gmail.com>
 <2026020348-rehydrate-glider-b1f3@gregkh> <87sebhvj88.fsf@alyssa.is>
 <CANiq72m4-RoG4YYS4dBuUo7mW+HWez2BZXBu6NvXXPChmBeYfQ@mail.gmail.com>
Date: Fri, 06 Feb 2026 14:04:02 +0100
Message-ID: <87bji29g71.fsf@alyssa.is>
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
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[alyssa.is:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214655-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[alyssa.is];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[alyssa.is:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hi@alyssa.is,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA92AFDD58
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Feb 3, 2026 at 6:18=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>>
>> Doesn't need to be AFAICT, because -Zno-jump-tables isn't used on 6.12.
>
> I am not sure what you mean -- the commit I referenced is the one that
> introduces `-Zno-jump-tables`.

Sorry, I got mixed up.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQGoGac7QfI+H5ZtFCZddwkt31pFQUCaYXmwgAKCRCZddwkt31p
FcTmAP9wPIaVmLekC94ICSwMILFooAMnMeNw8mai5vuNgiZ0SgEAsRJjUK66Dxn8
j82JNncZmCunRsd5Y//Uu3TGZAyIzAM=
=mY7M
-----END PGP SIGNATURE-----
--=-=-=--

