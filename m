Return-Path: <stable+bounces-219942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBb+Kg5toWm6swQAu9opvQ
	(envelope-from <stable+bounces-219942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 11:08:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5711B5CF4
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 11:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC6D30F7CEB
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C33A1E97;
	Fri, 27 Feb 2026 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqXtJK7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A539525E
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186665; cv=none; b=F3LDzx5R0EN4b1ylU0AebLntyU1E9lxhq80DDH1YOBfzuSYWM4kJwJm5r4g3BqQTccgaOvR5EaygfoTZYSOV6GFoyZXDLTL+yJaHsLdOgUyq9x5p3L1gz549NmX9zZCp2U+RGy3xTPlkUtA+ksYDiGrxHJKCzNpk2NPWP6gLI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186665; c=relaxed/simple;
	bh=CqiXjdEuAh6VhbCOPAP03nQl+N1BQZlYDVT7h65fvsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLs9CMBEiGLfJqa6AdxlJ4Fu/q2BHE0E9kRiFc1smZ5ltzuykxkeS+8Bw5fPa5C/Cf5tM71kx7Ovdr7ebfrLKYDWYOQ+2Qfi2hTIWjOJYL+omLnaCDR5DoW+rb9A7luxHuNYZwuoknMKb/a9tNFjgCrjfSUHteWUOMmnZJz6FUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqXtJK7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D7DC2BC9E
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772186664;
	bh=CqiXjdEuAh6VhbCOPAP03nQl+N1BQZlYDVT7h65fvsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GqXtJK7V35n9ROgrXEN1aYmmIJUFschBDdvHyC0jsyNhs0yT/ZWmvZMnQ7lc9OH3S
	 +tNX+Lpkjh5T4yT9AM44qVPlEBSzLNDKMjUtoA8vHmccrNF8CR97S9a/bhsnoOOKmU
	 3ALfGonDEKtWp75HVyRBDWH7HNKu6Ff5Xvrjp/EAGtLrvEXY3aMd+AySqLiNdj8uKT
	 /VAwaHrcSaEz1fegepdDbPzXJ7Np1cUZgPlWqp72HRPL+hx9uKRGPqOi0b4auh/Lsu
	 Hnundrf8h6l9U75/gssYS9JtKkqVvFaAtPDYsTEb/CZqdzzupt+OdpdBwDPvoLrT63
	 UUrjJUwws3JLg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65c187dfc82so3008610a12.2
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 02:04:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtnwiF/xY9uQk5HTiP8u/nmy/CZ63MxvGKLWrFoiz11nnU0D+jfxhzN4vd+xa+z79QQc4llfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywraa/YbI1CGOGwEJPmdUB7G/PekJYHcbO5IbVeVBzaEZ41skSD
	HbvLdpnYFPQ1BZ7d5Eg42awtFFdzy0WE0h/KQ+gl6UQEx29U+6dbZweZ4R2YqsBLK0a3mGAICUM
	2J3DILAThfBNE9BVypKbPBeoxMdOZCE4=
X-Received: by 2002:a05:6402:13c9:b0:658:b76f:da7c with SMTP id
 4fb4d7f45d1cf-65fdd6d9f81mr1663776a12.13.1772186663157; Fri, 27 Feb 2026
 02:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227072031.581229-1-xry111@xry111.site> <CAAhV-H5nedWAfUXL-mwuoQGgn24pvS7=w9BwQ=t+iZfqJO0CFA@mail.gmail.com>
 <65a54e3763c903043d8051e3bc83c9cf783047b0.camel@xry111.site>
In-Reply-To: <65a54e3763c903043d8051e3bc83c9cf783047b0.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 27 Feb 2026 18:04:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6+Q_b4cr8jj3hmy1__h3060geMohx7hm1V8NvmeKPSiQ@mail.gmail.com>
X-Gm-Features: AaiRm53DMgyS0YfDP1J0J9HKzqlWUeydOKZ4Mi_TU31TciSZ5gjFEIcbmyBbK2Y
Message-ID: <CAAhV-H6+Q_b4cr8jj3hmy1__h3060geMohx7hm1V8NvmeKPSiQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Jinyang He <hejinyang@loongson.cn>, 
	WANG Rui <wangrui@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>, Zixing Liu <liushuyu@aosc.io>, 
	"H . Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong8.dong@gmail.com>, 
	Bibo Mao <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Hanlu Li <lihanlu@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Wentao Guan <guanwentao@uniontech.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219942-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[xen0n.name,loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xry111.site:email]
X-Rspamd-Queue-Id: 0E5711B5CF4
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 5:57=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Fri, 2026-02-27 at 16:58 +0800, Huacai Chen wrote:
>
> /* snip */
>
> > > diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch/i=
nclude/asm/sigframe.h
> > > new file mode 100644
> > > index 000000000000..59db3de6db85
> > > --- /dev/null
> > > +++ b/arch/loongarch/include/asm/sigframe.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Separated from arch/loongarch/kernel/signal.c.
> > I think this is also unnecessary.
>
> Will remove this comment.
>
> /* snip */
>
> > > +        * This is also the reason we don't use SYM_FUNC_START.
> > > +        */
> > > +       nop
> > > +SYM_START(__vdso_rt_sigreturn, SYM_L_GLOBAL, SYM_A_ALIGN)
> > Is it possible to define SYM_SIGFUNC_START/SYM_SIGFUNC_END in
> > linkage.h, and then use them here?
>
> How about SYM_FUNC_{START,END}_NOCFI instead?
Of course I don't know how to name them, I just want to define a
wrapper to contain all .cfi_xxxx in this patch.

Huacai

> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
>

