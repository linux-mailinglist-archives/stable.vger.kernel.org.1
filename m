Return-Path: <stable+bounces-179171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225CFB50F9D
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E131C81AC3
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63BE30BF4E;
	Wed, 10 Sep 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IFdEvP/0"
X-Original-To: stable@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739230648B;
	Wed, 10 Sep 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489892; cv=none; b=qvRY0+zHQTArpXd2h4sjx4OxYBrTbZgUxqp6/aShLAnmYwdcHZNl/4o1gdFwBPX8wJdArLMsopu0UaATu9tg2ymm2dOww9VM1qfqVdGYUW7HeeIzclMPdSLlb2iJWOM3VY+0ghyXthRj0oMp+JTa9esLbUaOeXYpRiZ9Cn2KPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489892; c=relaxed/simple;
	bh=0JH+UVGnsBddCjY4BBN6WymfcFwobeyMpOLUnWHWpFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8Fdzcwhy4SmynwfdFR3giDTbqKf6MaoPXcMYrsaPgTXrAgruwSoI5ixD8+TA4RJ0IW5Bp17qNiwvN8txpoJavpRJZ3V5HkjKr9LXSpt2XD0JRHUCOVl2rSWq2aGKgl0+loahzxU2Llrr9aoetqg1A25UuYDKOS7VS92rkrvPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IFdEvP/0; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=qzoSzOfhh9t55DLZ+alySBc4N+TcCCOE8CQHMSMRU+E=; t=1757489889;
	x=1758094689; b=IFdEvP/0VxNQeMSQDA2EEwfYCoQYCuFalFHuXttWI97Bqz+paami8Vbf1tq6C
	NiouVw2i4kEPhCAIuyBxyF6dlwvsR9k4XUOFre2Nfn1fSI3rTs/0yehvev71PNKNZRkBBilpvVj5m
	3B+c07V18Xi65roYaqyPosjXmQ7h4pnruEsPhps7vFJ8fqBc7BucBDwEJF6pMLleUBP42ntmy2qy/
	jSbpc0nrL8nMmYG/7IlS48HBLHdAl80UwxrPbm9NU+gL9ynRk9yL7EAwk6sTJTtLAhOEtzmpYKGSg
	/VPCT9upEnLLZDWx6+SzYkXuLnTmOZ5uJddCwZo9LqpY3pSeAA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uwFOr-00000001Y9l-3Z3B; Wed, 10 Sep 2025 09:37:53 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uwFOr-00000002CZt-2OH9; Wed, 10 Sep 2025 09:37:53 +0200
Message-ID: <b94030984037e54a61f762f9aa62776ecd8082af.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Lance Yang	
 <lance.yang@linux.dev>, akpm@linux-foundation.org, amaindex@outlook.com, 
	anna.schumaker@oracle.com, boqun.feng@gmail.com, fthain@linux-m68k.org, 
	ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com, 
	leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi,
 peterz@infradead.org, 	rostedt@goodmis.org, senozhatsky@chromium.org,
 tfiga@chromium.org, will@kernel.org, 	stable@vger.kernel.org
Date: Wed, 10 Sep 2025 09:37:52 +0200
In-Reply-To: <CAMuHMdVMw3nUMtXhfhB5mgmsEZNuagna=6ywOuRsRRMFXHYwbA@mail.gmail.com>
References: <20250909145243.17119-1-lance.yang@linux.dev>
	 <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
	 <b7db49106e6e7985ea949594f2e43cd53050d839.camel@physik.fu-berlin.de>
	 <CAMuHMdVMw3nUMtXhfhB5mgmsEZNuagna=6ywOuRsRRMFXHYwbA@mail.gmail.com>
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

On Wed, 2025-09-10 at 09:34 +0200, Geert Uytterhoeven wrote:
> > > Isn't m68k the only architecture that's weird like this?
> >=20
> > Yes, and it does this on Linux only. I have been trying to change it up=
stream
> > though as the official SysV ELF ABI for m68k requires a 4-byte natural =
alignment [1].
>=20
> M68k does this on various OSes and ABIs that predate or are not
> explicitly compatible with the SysV ELF ABI.

I know. I was talking in the context of SysV ELF systems.

> Other architectures like CRIS (1-byte alignment!) are no longer supported
> by Linux.

Yes, that's why we should take care of the alignment ;-).

> FWIW, doubles (and doublewords) are not naturally aligned in the
> SysV ELF ABI for i386, while doubles (no mention of doublewords)
> are naturally aligned in the SysV ELF ABI for m68k.

I wouldn't consider i386 a role model for us ;-).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

