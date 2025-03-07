Return-Path: <stable+bounces-121356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1D0A5644C
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6B8188A444
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3920C47E;
	Fri,  7 Mar 2025 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="p+Hcw5aI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UzytjmCR"
X-Original-To: stable@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DA1A5BB6
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340916; cv=none; b=MXF2ijgRgRCOASs67RMLNGQFCE9Ic3mBAT1zmFuG0jJsi6z0+NmHnGiZBB7cdS0YpgTKn/WgeQT9yDA4sbPe5pe3Rgi3/gB48ba1oG7rwMbEroN78mgupwD3NKPb2ky2iF0cqedCsV5IfMoL2xW6ZADd9DX/NKJx6PczC7AqnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340916; c=relaxed/simple;
	bh=/4rivfDv+QV2ArrGmD1A+1h1ywUOmtoogjzFVCvnIN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCCfCa1FN5CfJJXoTMerILP1rWjJ45kbJouUlR1r/L9Rba2+rSAb0Qu/jxHH8DPHjTsaX6lIVw+MaeWB4Q+NKSEpfrV4ClJmXjiUBqw1GnIzHE4Vr4fqvggT5Sv7/NlOt1t3Mb///8k+qbUz6PDscQSUDVAPNVuJocFqencwRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=p+Hcw5aI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UzytjmCR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 3392313827AA;
	Fri,  7 Mar 2025 04:48:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Fri, 07 Mar 2025 04:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741340912; x=1741427312; bh=JVxIWI6ZE+
	EqBH4pg4kbIbzY01nqmieaXMgCEYgq+GY=; b=p+Hcw5aIYcKt4oTBEKvh9wba2g
	7pdMRSLr0CStVw3LYVpfqNKI5C80YDxMNYALrFIIBsvjlcX1m0MUgKhpTCrr57K3
	I8ocKc38EATFQf7efCjiZsoT/BkE9YU41jCxPGKzp2IXQ1HdSQ4usGWrPLP7Au/j
	1+SGpK33S/tayF4waWKucI6LV9pToVyKImFJ+Ect8Dsiglbqv2xeU3vuuQkndDWs
	6BTT+dcJ7dzfs4/sBIRTaAjUD4lZKYs4o+jfXfpWgVLwh3gHFgwOcBRiq3NbUJa7
	UbNSwUUevbyoBRzWlSgyC5hz+lbUs5SNRTDHtklH3W5lx8qI9EppIARx43AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741340912; x=1741427312; bh=JVxIWI6ZE+EqBH4pg4kbIbzY01nqmieaXMg
	CEYgq+GY=; b=UzytjmCRRn1/HKM272Pkac3UhNm9Z16vfWsy+g5LHgtmTja5dU5
	Kb2ZRmh5RRDEJo/DGm+P4wsup1ieAsyIAOLcp6b/O5jL1LKSqo3QutjwkthoLv2M
	IhyfmjrBDUQglTliulbrKyAOEGD/sIYIWUADUgIVHVMjLCaMdLcvsAofFKarO8v1
	JL6l5E3nmTguyjVfEA/oZfAUbaCRKnw2Kwe7orBV9+ZZg6T8SnZFnS2ZGPiGoSjC
	DMjvX3IFhnS/BccZuex+37qNeSrdGPTEr+sd4blXWAbFgg29Qit7z17gA0yLBxM+
	1gJOvgxAfrvZWSjAFKASq2oo5zM312Ogt+g==
X-ME-Sender: <xms:78DKZ4YjvBleDLl4qKEIp87ifkZn4OhblTCSqSVOreJReA-mUv9fow>
    <xme:78DKZzaggzimIKq_aZJpPj8_fWid1JP4PdfiSS9xdwaIx3DqPTFYnjx2wC_H5Y8me
    U_X4v0LOrZwcR7J1w>
X-ME-Received: <xmr:78DKZy8TJM_KvTgEkHxzs2HKjuHNGzWR4bUORyvrHeBBFZyOmXvm3tFl54Rya_wUyxdhU7y7E5fyR15Gho0EPaGmxdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddt
    vdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqne
    cuggftrfgrthhtvghrnheptdejueetkeehfeeuleeugfevieffkefhteefiedvfeehuefh
    jeegvdeiffeihfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnohhishihtghoihhlseguihhsrhhoohhtrdhorh
    hgpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghi
    lhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhi
    nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:78DKZyrRz1FjIgBSPcICmJS3kFc4-xdbYvU53IyDglHC7IQG8yVksQ>
    <xmx:78DKZzqPYwZ5Wg0IBszomqd1eRt4_REGiUvINOvtY0EOl6_adGp0Yg>
    <xmx:78DKZwS0cAEr5FSFyXO5m3z4oWBR6kWYwp9XzP6yeNrThjaNR3ddnQ>
    <xmx:78DKZzrPBb2JOzULWoj98zUYhTHtP6jhhL690W5qt5TTQJc-Q29_UQ>
    <xmx:8MDKZ0d2MQXChkBe-1ol22Eyy-IH5oCQwDw6YuhPdv1B3hq3Mouq6u0K>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 04:48:31 -0500 (EST)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 50E9D7F60AC3; Fri, 07 Mar 2025 10:48:30 +0100 (CET)
Date: Fri, 7 Mar 2025 10:48:30 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	NoisyCoil <noisycoil@disroot.org>
Subject: Re: Apply 3 commits for 6.13.y
Message-ID: <eotqeb6tyriytvnkjignfkjnie5wb7nzcwjimahxmgnbzxcpmw@mhpoanbqzmiz>
References: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pkknlcjens5vhxae"
Content-Disposition: inline
In-Reply-To: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>


--pkknlcjens5vhxae
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: Apply 3 commits for 6.13.y
MIME-Version: 1.0

On Sat, Feb 22, 2025 at 04:12:56PM +0100, Miguel Ojeda wrote:
> Hi Greg, Sasha,
>
> Please consider applying the following commits for 6.13.y:
>
>     27c7518e7f1c ("rust: finish using custom FFI integer types")
>     1bae8729e50a ("rust: map `long` to `isize` and `char` to `u8`")
>     9b98be76855f ("rust: cleanup unnecessary casts")
>
> They should apply cleanly.
>
> This backports the custom FFI integer types, which in turn solves a
> build failure under `CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y`.
>
> I will have to send something similar to 6.12.y, but it requires more
> commits -- I may do the `alloc` backport first we discussed the other
> day.

Hi Miguel,

Has anything come of these 6.12.y backports?  It sounds like we're
otherwise about to have to disable features in NixOS's default kernel
due to build regressions with Rust 1.85.0.

--pkknlcjens5vhxae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCZ8rA6wAKCRBbRZGEIw/w
orazAP9YlZ5rxjY/wuDHBybj4H1vZuLs743yN1GmFGCYg/90vQD/bCPErxuUXxVM
hqBuKUU8z15T/VJz5Ts2pgFRJgUQ7gc=
=+zDz
-----END PGP SIGNATURE-----

--pkknlcjens5vhxae--

