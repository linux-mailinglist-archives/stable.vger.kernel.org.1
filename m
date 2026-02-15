Return-Path: <stable+bounces-216602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBlgEzIlkWnJfwEAu9opvQ
	(envelope-from <stable+bounces-216602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 02:45:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FC13DE1F
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 02:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C8233019539
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 01:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45043222582;
	Sun, 15 Feb 2026 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="PPVUolSl"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF791F4CBB;
	Sun, 15 Feb 2026 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771119916; cv=none; b=QWFktkNEekMVcmrOXtt0dXpt5BQ0Nm8vJqL6l5UIwwFn/YL2hhUb9PHK12eucqMHI/DJKI0E4eEbP5Goz3lcTSXwH/h/0CJFwVk/u3hTLHemjr8jxE+6xkcTFS8kcrdemuxe79RjHzAwjFLAQQLukOZp/Cj2U162OR36fxHQLMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771119916; c=relaxed/simple;
	bh=+Ea9uuDxuwAxMR3n5hCMzRptnqMr7YUhvoaXYvakIcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPcNDhbVITZ2PK7cVrCdcFhJTn2mVa9tHcY6mU4hEVsyWSfgUGM/dlZF4SacGIuFXvD1g3bbOZkosc0TQP69LOJnRxKJbtuTgdAJS+dC+gmycfvol8gstRjyhplsMD5SZnGGDRpj57GeYIEECaz3RY8v62sJyaxHjZIcb3ZHljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=PPVUolSl; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1771119911;
	bh=+Ea9uuDxuwAxMR3n5hCMzRptnqMr7YUhvoaXYvakIcc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PPVUolSlSHFJZlNgVHRAVI/TMEduVyfjtXavr9qjg6lPrtGlxwp+H4Wq4ayrRSIjx
	 SHUzRwmYSZxlTf9hhfbfnE1RKZ/6VGhK+OUT3h772R0D8TQkfYWC6cZevPO3qNiA09
	 K42SSwm3fO+ign3xW6Gu6ZYvC6n4TMok4mRF7KX4=
Received: from [IPv6:2408:8427:6a1:ffef:e8db:401f:fb26:6337] (unknown [IPv6:2408:8427:6a1:ffef:e8db:401f:fb26:6337])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0B83766F88;
	Sat, 14 Feb 2026 20:45:04 -0500 (EST)
Message-ID: <02ca50afa03cb21088d67bac055f0e08f70e6d1e.camel@xry111.site>
Subject: Re: [PATCH v2] rust_binder: Fix build failure if !CONFIG_COMPAT
From: Xi Ruoyao <xry111@xry111.site>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Mingcong Bai <jeffbai@aosc.io>,
 loongarch@lists.linux.dev, hev <r@hev.cc>,  Miguel Ojeda
 <ojeda@kernel.org>, stable@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?=	
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Christian Brauner	
 <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Matt Gilbride	
 <mattgilbride@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Paul Moore <paul@paul-moore.com>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, 	linux-kernel@vger.kernel.org
Date: Sun, 15 Feb 2026 09:45:01 +0800
In-Reply-To: <CANiq72naHZT+CuuMBFAoKmzTjVRZpicL+Wo9ai3QY5Rja-v1sA@mail.gmail.com>
References: <20260214133337.112720-1-xry111@xry111.site>
	 <CANiq72naHZT+CuuMBFAoKmzTjVRZpicL+Wo9ai3QY5Rja-v1sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216602-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xry111.site:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,kernel.org,xen0n.name,aosc.io,lists.linux.dev,hev.cc,vger.kernel.org,linuxfoundation.org,android.com,gmail.com,paul-moore.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xry111.site:mid,xry111.site:dkim,xry111.site:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 988FC13DE1F
X-Rspamd-Action: no action

On Sat, 2026-02-14 at 23:18 +0100, Miguel Ojeda wrote:
> On Sat, Feb 14, 2026 at 2:34=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > Reported-by: Miguel Ojeda <ojeda@kernel.org>
> > Closes:
> > https://lore.kernel.org/all/CANiq72mrVzqXnAV=3DHy2XBOonLHA6YQgH-ckZoc_h=
0VBvTGK8rA@mail.gmail.com/
>=20
> Hmm... Wasn't this applied as:
>=20
> =C2=A0 174e2a339bf7 ("rust_binder: Fix build failure if !CONFIG_COMPAT")
>=20
> Then there was also this other thread:
>=20
> =C2=A0
> https://lore.kernel.org/rust-for-linux/20260105-redefine-compat_ptr_ioctl=
-v1-1-25edb3d91acc@google.com/
>=20
> which got applied as:
>=20
> =C2=A0 68aabb29a546 ("rust: redefine `bindings::compat_ptr_ioctl` in Rust=
")

Oops, just saw the mail regarding your email address yesterday when I
was archiving mails in 2025 and I thought the patch was blocked by the
issue.

Disregard this then.


--=20
Xi Ruoyao <xry111@xry111.site>

