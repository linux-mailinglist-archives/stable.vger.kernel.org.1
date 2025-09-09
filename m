Return-Path: <stable+bounces-179109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F2B5035B
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C1C1C6695D
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473935CECB;
	Tue,  9 Sep 2025 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MUkpfAfa"
X-Original-To: stable@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189E35E4EE;
	Tue,  9 Sep 2025 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436958; cv=none; b=UBLJBUo65H77+D/wXjxQzjgTHbDVLXO3+bONAbjOE47scY1IIeRRYABn0rd96tC3EtxBOqTKNlk0FiD3CBCCdOUUAHAb5BWi8JXEN4BPpXgQcUb6wSU3gK3aPGg/quojQFiFxnTzOxfkKPBpLpX8Ke8eNOHkuOYueBJv9Uzm16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436958; c=relaxed/simple;
	bh=ID5pBaN+J7CFVgwgGvd/b4VwA4Vonh4fLPlaGQEOJyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KirW0r+bid+Wb5q80RhkpZli6HBCiMhdkHVHeEEkrTEDZT33I4J7NCxMvkuMzQkwkKReiqVHpqluHW1wW/tJ49DSrzovZUpE/9JKiGQ5qE8uoQb6a06wsLnPtj5iiDupIfO99gQnyM490IGYwyy7CxqTF7pgQxeFN8GQI3m0LNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MUkpfAfa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=sPN0vF1fWjVPwup+IvE1wc/L2gE265AvyobNRjnRsgg=; t=1757436955;
	x=1758041755; b=MUkpfAfaExd8KFxU8mhOah+efgUEFrEXy1zfS8Ov8wGLiyMtUCeelomZbu3/l
	942Q3uFnsOkp/N3D69hy1L+EoThtdufI5sJmq9XyZLj4BStvdsHwyUhWehSONXunebNJMV7QHxr9O
	uK4NEtXV9Hi5yiltnJB2YOnO4xvl17we5LKw/W9LzfpJ/pXIssR91tGDMZjMZbGZy22TICrUCo2Ok
	BYBAG0EuEv0psOL5r9S5bOZg+w6pmGp5RCvAbuwAXseDK4LuzS4lMyUuGswZcrZnMbMWQ2nXMHELc
	Pcu7PO2281mFKLLQXKWik3dV2danh6jeeKh8gXkuMXk+e0jyQQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uw1d9-00000002IGB-3gLx; Tue, 09 Sep 2025 18:55:43 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uw1d9-000000005xt-2NaX; Tue, 09 Sep 2025 18:55:43 +0200
Message-ID: <b7db49106e6e7985ea949594f2e43cd53050d839.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Kent Overstreet <kent.overstreet@linux.dev>, Lance Yang
	 <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, amaindex@outlook.com,
 anna.schumaker@oracle.com, 	boqun.feng@gmail.com, fthain@linux-m68k.org,
 geert@linux-m68k.org, 	ioworker0@gmail.com, joel.granados@kernel.org,
 jstultz@google.com, 	leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi,
 peterz@infradead.org, 	rostedt@goodmis.org, senozhatsky@chromium.org,
 tfiga@chromium.org, will@kernel.org, 	stable@vger.kernel.org
Date: Tue, 09 Sep 2025 18:55:42 +0200
In-Reply-To: <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
References: <20250909145243.17119-1-lance.yang@linux.dev>
	 <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
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

On Tue, 2025-09-09 at 12:46 -0400, Kent Overstreet wrote:
> On Tue, Sep 09, 2025 at 10:52:43PM +0800, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> >=20
> > The blocker tracking mechanism assumes that lock pointers are at least
> > 4-byte aligned to use their lower bits for type encoding.
> >=20
> > However, as reported by Eero Tamminen, some architectures like m68k
> > only guarantee 2-byte alignment of 32-bit values. This breaks the
> > assumption and causes two related WARN_ON_ONCE checks to trigger.
>=20
> Isn't m68k the only architecture that's weird like this?

Yes, and it does this on Linux only. I have been trying to change it upstre=
am
though as the official SysV ELF ABI for m68k requires a 4-byte natural alig=
nment [1].

Adrian

> [1] https://people.debian.org/~glaubitz/m68k-sysv-abi.pdf (p. 29)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

