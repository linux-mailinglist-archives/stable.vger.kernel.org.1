Return-Path: <stable+bounces-219943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKXQATJtoWm6swQAu9opvQ
	(envelope-from <stable+bounces-219943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 11:08:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 783341B5D03
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 11:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 594EA305D6FA
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192D3A6409;
	Fri, 27 Feb 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="gY2/4Kdo"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387333624A3;
	Fri, 27 Feb 2026 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186917; cv=none; b=qUFqusvWl97KiT2jyVcAguQUtpM8y+lviwpyn1UEBr9edwQzaN9bPQvUz2Y5D5PfCKGm+DCa+VbTxTnDA5IQO9JFI4ZYZzuRSFVgVJcAbZ3200+7Kt7WXaFlFzCA2Kxlp7C3DcodvacQcyVR/3v1FkdYx+oj2zgSzAvuHhG8NSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186917; c=relaxed/simple;
	bh=xzLBxhUzHaoYvh/TPNEHN/Fc5xqc3qnU0sARp6jxXbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcMUnfPeaI0L7KXWhGbKmYsYeWftNj4aqseWvNKKwFUhYG6xrj3tabOnFEXiH0VIDFBXkMutRJGtlIjgNulPXxGsHGlgMLD7KZpWFm/5Sbv67kcd+S5FLEh6e6LTjIFyy3IeC3leaPKRcbnJ4r3YIA8WkVZvRpneQBf/IgXXEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=gY2/4Kdo; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772186913;
	bh=lygb0fPXZydd/Pz9if/FAPr5SsV7QwxcaFSXSOPPIMs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gY2/4KdoNXvIsiclthw0uBT1/mGt9dyJ73DAsNtq42qhemB9bVtRw5rCflOuGtVIM
	 /oB1/LxydPeLKYapoARFHyhCFZZlgjM7LqXsAxWMn9dBzfmb9b6hJa4DqWUjgZFKaQ
	 ySiQ8lafD2iZcVHwhPJr+FO1Ujc18VR6Z3O3fhoo=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9BB271A422D;
	Fri, 27 Feb 2026 05:08:27 -0500 (EST)
Message-ID: <dfc96603201cf067e341c13e5aa5e9bee9712e2f.camel@xry111.site>
Subject: Re: [PATCH v2] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Jinyang He <hejinyang@loongson.cn>, 
 WANG Rui <wangrui@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>, Zixing Liu
 <liushuyu@aosc.io>, "H . Peter Anvin"	 <hpa@zytor.com>,
 stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,  Menglong
 Dong <menglong8.dong@gmail.com>, Bibo Mao <maobibo@loongson.cn>, Tiezhu
 Yang <yangtiezhu@loongson.cn>,  Hanlu Li <lihanlu@loongson.cn>, Nathan
 Chancellor <nathan@kernel.org>, Jiaxun Yang	 <jiaxun.yang@flygoat.com>, Ard
 Biesheuvel <ardb@kernel.org>, Wentao Guan	 <guanwentao@uniontech.com>,
 loongarch@lists.linux.dev, 	linux-kernel@vger.kernel.org
Date: Fri, 27 Feb 2026 18:08:23 +0800
In-Reply-To: <CAAhV-H6+Q_b4cr8jj3hmy1__h3060geMohx7hm1V8NvmeKPSiQ@mail.gmail.com>
References: <20260227072031.581229-1-xry111@xry111.site>
	 <CAAhV-H5nedWAfUXL-mwuoQGgn24pvS7=w9BwQ=t+iZfqJO0CFA@mail.gmail.com>
	 <65a54e3763c903043d8051e3bc83c9cf783047b0.camel@xry111.site>
	 <CAAhV-H6+Q_b4cr8jj3hmy1__h3060geMohx7hm1V8NvmeKPSiQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219943-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[xen0n.name,loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xry111.site:mid,xry111.site:dkim,xry111.site:email]
X-Rspamd-Queue-Id: 783341B5D03
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 18:04 +0800, Huacai Chen wrote:
> On Fri, Feb 27, 2026 at 5:57=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > On Fri, 2026-02-27 at 16:58 +0800, Huacai Chen wrote:
> >=20
> > /* snip */
> >=20
> > > > diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch=
/include/asm/sigframe.h
> > > > new file mode 100644
> > > > index 000000000000..59db3de6db85
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/include/asm/sigframe.h
> > > > @@ -0,0 +1,12 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > > +/*
> > > > + * Separated from arch/loongarch/kernel/signal.c.
> > > I think this is also unnecessary.
> >=20
> > Will remove this comment.
> >=20
> > /* snip */
> >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is also the reas=
on we don't use SYM_FUNC_START.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nop
> > > > +SYM_START(__vdso_rt_sigreturn, SYM_L_GLOBAL, SYM_A_ALIGN)
> > > Is it possible to define SYM_SIGFUNC_START/SYM_SIGFUNC_END in
> > > linkage.h, and then use them here?
> >=20
> > How about SYM_FUNC_{START,END}_NOCFI instead?
> Of course I don't know how to name them, I just want to define a
> wrapper to contain all .cfi_xxxx in this patch.

Will do it.  If they contain all the .cfi_ directives your naming is
better.

--=20
Xi Ruoyao <xry111@xry111.site>

