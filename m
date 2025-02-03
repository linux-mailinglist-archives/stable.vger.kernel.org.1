Return-Path: <stable+bounces-112005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA8A257A6
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F23A8455
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69762202C22;
	Mon,  3 Feb 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="P5t01iHv"
X-Original-To: stable@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5445336E;
	Mon,  3 Feb 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580481; cv=none; b=JLZg1Q9u7ldCxcN6WnXhFLobUk0xv4L+cRLfFloy9pdwALvMFGQ4n4ym3FNteypRQzNaYjyPTOQWI/yy8onDywCOnvmXlU5dyQ/LqqK6hlR7PFFhyzPCenbpQaAF4imtSYqPMz4SxyxgoS2e6ezULXe7a64jPAwK+sfejeF4uYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580481; c=relaxed/simple;
	bh=Wc9GvEXW6rAaMvtzLT9Fv+2z4c/nr4MiaNVNxbthuQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ic+xs2yuoSqMW/VDdkTd9JiTaKaogfvLPTSPcsPJrH39Kqvfn5bLOBfW5kBXzOM6fFe9JDtvcCoYmtqWPCB0UnaVXPA0KtZ+M8OBifu/DZJXPAzz+smlDjn4bv+Z9qlH6XgBbC/35uyIM0SGuzvhnRuoNGC9VuPyp1qYMsLNdjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=P5t01iHv; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jMZatAT/7OGwDcJtMgFacVuT4rGXv3jnlVm7tY9l9aQ=; t=1738580477; x=1739185277; 
	b=P5t01iHvg7xWzGU9YMowFkSGc1+wtzsZrdMaPzpUb685huWi7u/Y+sBLZnwFQ2vp5EhwznA+n53
	q5kBxZop/6o0h94tcFsgKJSJKMjUafviWefa8K88OPOXAfwmoo+SdHsy410bR/xaro1xoYlsjMCum
	gVKJ2VFaYTuUsT17UbeEma1l69TxCRn1JToc1FmPflKwj6RvGGRNBWCDD1mafWw2JO/6bCAXbljr2
	7CwpgryEgW0+9DBkEhZPQX1vIn8o+XA5y3+yAvOYno8VUmBHPztSfwAd1lY6GiwcslOlDf5xJpY5v
	tENR4jiPHMOvKAUDbyFQsm/p6pfA79Qor1lA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1teuCN-00000002zq5-1wrx; Mon, 03 Feb 2025 12:01:03 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1teuCN-000000039aE-0vEn; Mon, 03 Feb 2025 12:01:03 +0100
Message-ID: <e66ea9e2bf462f1aa29a9ae535d5f1470668616d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/4] alpha/uapi: do not expose kernel-only stack
 frame structures
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ivan Kokshaysky <ink@unseen.parts>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Oleg
 Nesterov	 <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd
 Bergmann	 <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Magnus Lindholm
 <linmag7@gmail.com>, 	linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 03 Feb 2025 12:01:01 +0100
In-Reply-To: <20250131104129.11052-2-ink@unseen.parts>
References: <20250131104129.11052-1-ink@unseen.parts>
	 <20250131104129.11052-2-ink@unseen.parts>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ivan,

On Fri, 2025-01-31 at 11:41 +0100, Ivan Kokshaysky wrote:
> Parts of asm/ptrace.h went into UAPI with commit 96433f6ee490
> ("UAPI: (Scripted) Disintegrate arch/alpha/include/asm") back in 2012.
> At first glance it looked correct, as many other architectures expose
> 'struct pt_regs' for ptrace(2) PTRACE_GETREGS/PTRACE_SETREGS requests
> and bpf(2) BPF_PROG_TYPE_KPROBE/BPF_PROG_TYPE_PERF_EVENT program
> types.
>=20
> On Alpha, however, these requests have never been implemented;
> 'struct pt_regs' describes internal kernel stack frame which has
> nothing to do with userspace. Same applies to 'struct switch_stack',
> as PTRACE_GETFPREG/PTRACE_SETFPREG are not implemented either.
>=20
> Move this stuff back into internal asm, where we can ajust it

Typo: ajust =3D> adjust


Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

