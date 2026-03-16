Return-Path: <stable+bounces-225612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIpjMX0uuGnhZgEAu9opvQ
	(envelope-from <stable+bounces-225612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:23:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3057329D447
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B1E3063A15
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6754335555;
	Mon, 16 Mar 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC/5rM9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9E33507C;
	Mon, 16 Mar 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677970; cv=none; b=uFECRBW08k80Kt7dCahOdKhHKagcp8bAPI5pPkrlGRXfAQvRZNe2IKnpqESmaU8M+CfDlf0fKZNp7kONSlPGMsSyY7PBL34cgYNGzcM423OdWIRaVHGFgJI0RA12pm0zZ/8/xe8CeG96ArKurLc/UpZjXnaS392n93K72YA/fn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677970; c=relaxed/simple;
	bh=rOUBRT544J5oes5zvZ3Lac3Nb4EGLKQIyTPm3RrhX1A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cIFwUgs74H/y/iU4Y5L02eHLf7y5//6nO+++HldWl7cTHmymfO64zyOx5Ob/qt7To5RsRuUr8bkaeeVZlFFL5rdKmuBrCh6oAYBMapWk2i3D81CElIykWTgcP2o+QrSt87CDtwDdUZ1scd1+2fQKAn9IF2nsl8aZFMoFKNfgcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC/5rM9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACD9C19421;
	Mon, 16 Mar 2026 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773677970;
	bh=rOUBRT544J5oes5zvZ3Lac3Nb4EGLKQIyTPm3RrhX1A=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=JC/5rM9d7fPHFFHn8oEWK0/z1K4Rh1h1BTKcXeijp6mBU9H9PuWSwDfZyOzURXeOz
	 8QUi4Ya+CNKysxhWuSZ6lq/rKmXWOcRda7YxSWD325uLGvcIbdN0fjQ4Q0RewsubFY
	 xXRqjTVeR9RABnv9+2FV0yf8piu/r0xnUa5lpX/Lh/Xv5xTzoD8OyMLzE4nQ6GIHEc
	 bTxzAFj/zrxm64owzJZlOjxQdvT/3RRkR8AW9QsMm+bsTkZLPgFWgmR3Ine4/VVcxo
	 Z8efa15EG3OtowKQcXE9nvme4MCI8J7Sg3q6Tk22kuPxTtw9UG+0kY5xpHm7yKRT7h
	 DVO7CJcEOZljw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 17:19:25 +0100
Message-Id: <DH4CD4IAYRS1.1P5BTFC6U3LBP@kernel.org>
Subject: Re: Patch "rust: dma: use pointer projection infra for
 `dma_{read,write}` macro" has been added to the 6.19-stable tree
Cc: "Gary Guo" <gary@garyguo.net>, <stable@vger.kernel.org>,
 <stable-commits@vger.kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260315144041.25312-1-sashal@kernel.org>
 <DH3FT8ZMGH0T.2NA5M5351UP2L@garyguo.net>
 <2026031639-duplicity-playroom-7b3f@gregkh>
In-Reply-To: <2026031639-duplicity-playroom-7b3f@gregkh>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,vger.kernel.org,google.com,nvidia.com,gmail.com,ffwll.ch,collabora.com,arm.com,kernel.org,protonmail.com,umich.edu];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3057329D447
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 16, 2026 at 3:00 PM CET, Greg KH wrote:
> On Sun, Mar 15, 2026 at 02:48:52PM +0000, Gary Guo wrote:
>> On Sun Mar 15, 2026 at 2:40 PM GMT, Sasha Levin wrote:
>> > This is a note to let you know that I've just added the patch titled
>> >
>> >     rust: dma: use pointer projection infra for `dma_{read,write}` mac=
ro
>> >
>> > to the 6.19-stable tree which can be found at:
>> >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queu=
e.git;a=3Dsummary
>> >
>> > The filename of the patch is:
>> >      rust-dma-use-pointer-projection-infra-for-dma_-read-.patch
>> > and it can be found in the queue-6.19 subdirectory.
>>=20
>> Hi Sasha,
>>=20
>> commit 08da98f18f4f ("rust: ptr: add `KnownSize` trait to support DST si=
ze info
>> extraction") and commit f41941aab3ac ("rust: ptr: add projection
>> infrastructure") are dependencies of this fix.
>>=20
>> It doesn't look like these commits are currently being picked. They're n=
eeded
>> for building.
>>=20
>> They're part of the same series: https://lore.kernel.org/rust-for-linux/=
20260302164239.284084-1-gary@kernel.org/
>
> Yeah, this breaks the build on my systems.  I'll go drop this patch for
> now, and if you want these in the stable trees, can you provide a
> backported series of them?

The DMA soundness fix, as a potential bug, is probably not crucial to backp=
ort.

There are two nova-core fixes on top of it. One of them fixes a UB conditio=
n
reading from and writing to a DMA buffer, the other one is a potential stac=
k
overflow.

nova-core is still work in progress, so I'm not too worried about this as f=
ar as
stable trees are concerned.

I think we usually backport soundness fixes anyway, plus everything should =
apply
without conflicts, so it probably doesn't hurt to pick them up regardless.

I can send a separate series if preferred.

