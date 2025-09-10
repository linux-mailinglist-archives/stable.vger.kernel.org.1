Return-Path: <stable+bounces-179172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF0B50FA3
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F12617B614
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 07:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC27E30C370;
	Wed, 10 Sep 2025 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="BL8D1YHI"
X-Original-To: stable@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99DE3090E5;
	Wed, 10 Sep 2025 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489968; cv=none; b=FmxGjE1E4VDS3IXqsuy0zly2VVXVCPvABVmaVBbhCyQM3pcxZ/bz+F3VdebV/QNaZz9G2L+RpJeheYjKqgpf6WdhnslasMSVcRax4SCSRUkFP4Ce0k+Ov7nHPoK8qz6C1Yss8D/cio4dAxr3KYEpwuAvRtQL3LDHzQcXs6A4dH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489968; c=relaxed/simple;
	bh=Ul3ruNucFllh+Ow7DauRjgvp/CT7ZC+Y/5KwDr8f7/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvWRsRgUpz4Hk8NjExwnaSnuM7wTaPloIt0V1vHjWd8LBjhg04+6IDmg2xHxXwJXo+tfSM8V5rq4aDBisGOT2wnS9CPJ06tWTdzsl2tAf3Jr/dgew2Z90634oR+KcUrB+306jm6+l3D0XDeU8ubtjDTJBfGjOAif9f1dKUJjD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=BL8D1YHI; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pk389SrM5k3oqczV2E3Z+N0l2kO9KkGooepRvzIncEw=; t=1757489966;
	x=1758094766; b=BL8D1YHIyr4Th1PX6JGLRPF6YzB+CiNh4frrO5YKPyWJaCRmbqEQO0LOnrUSf
	0flDqoGCCcU74cF5Z8KgqkvR5/KxrO4i7P0ZDM1ZkB8mpLtcuHXN43QRbvq0TT9m5cFHWYTPX8R8Y
	XbmtZq/8mKdhUG3aFNsCALotRtkVJtdlEUe3lBVBVgysJ8xzUvSYpROX+yWkpBm2uWDE/2HLESPAC
	ZuFqiCTnDdkBnKcfTDeperCH7NJFwg1pa8LZaZLMji2uJAJSWlsp/OaI6dWtL7GqF2vgBWBgj50bt
	Nbn7P4MRj4g3lbn5GMFE9NiaLn22Y4kLWKwNAyRbJx68Tnz7yQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uwFQH-00000001YYS-15TR; Wed, 10 Sep 2025 09:39:21 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uwFQG-00000002CpR-45Rc; Wed, 10 Sep 2025 09:39:21 +0200
Message-ID: <d2942b1a5d338c35948933b0ccbf3e4f67e5fae2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Schwab <schwab@linux-m68k.org>, Finn Thain
 <fthain@linux-m68k.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Lance Yang	
 <lance.yang@linux.dev>, akpm@linux-foundation.org, amaindex@outlook.com, 
	anna.schumaker@oracle.com, boqun.feng@gmail.com, geert@linux-m68k.org, 
	ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com, 
	leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi,
 peterz@infradead.org, 	rostedt@goodmis.org, senozhatsky@chromium.org,
 tfiga@chromium.org, will@kernel.org, 	stable@vger.kernel.org
Date: Wed, 10 Sep 2025 09:39:19 +0200
In-Reply-To: <875xdqsssz.fsf@igel.home>
References: <20250909145243.17119-1-lance.yang@linux.dev>
		<yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
		<99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
	 <875xdqsssz.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2025-09-10 at 08:52 +0200, Andreas Schwab wrote:
> On Sep 10 2025, Finn Thain wrote:
>=20
> > Linux is probably the only non-trivial program that could be feasibly=
=20
> > rebuilt with -malign-int without ill effect (i.e. without breaking=20
> > userland)
>=20
> No, you can't.  It would change the layout of basic user-level
> structures, breaking the syscall ABI.

Not if you rebuild the whole userspace as well.

FWIW, the Gentoo people already created a chroot with 32-bit alignmment:

https://dev.gentoo.org/~dilfridge/m68k/

It works with qemu-user. I haven't tried it on qemu-system with a 32-bit-
aligned kernel yet.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

