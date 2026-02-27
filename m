Return-Path: <stable+bounces-219941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAfuGoVqoWkOswQAu9opvQ
	(envelope-from <stable+bounces-219941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:57:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD01B5A59
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 10:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC890302B50E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471338B7DA;
	Fri, 27 Feb 2026 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="NDDxO1EW"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809A35A3A6;
	Fri, 27 Feb 2026 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186242; cv=none; b=Ebg9nX80RDuPvp+ZBKS1schPTpzGOZkm7ZoGrBPnr4ILS049fKkjqNw0VtJMPwkciMQH8R09yM1oG4EHu5e3YsheApS7z/IY4N3YbBxtwyixfr7e+L6cimmYq0H+30ENS3+7FV2JYZdkMPI/P+9XYTVioJwMplMnDp90wwMSSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186242; c=relaxed/simple;
	bh=U8KjsawmFn9EyBHO+DBqcFRZKBwY3+Sev0YcB+s929E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4MyFLh0gXEy7lle948A5+lZAsVlIxjw46VArw85OwhyQ0FQX30u8UNCZR4igqW6G1SAEGd0B0quHf35qR9RtFSzby9FtawGiIMibCO+sdazoRJqNzyHY+p0qFvpHV9x+Fz6tAoiaS/GVDSz+HEtWrG5mUw96GVT67UvtFn6k9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=NDDxO1EW; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772186236;
	bh=U8KjsawmFn9EyBHO+DBqcFRZKBwY3+Sev0YcB+s929E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NDDxO1EWxGTs/flt56FRnC7iYhgyjPk8AnD25WhjkX5bpTS8SxIsWIBFo/eMO9y68
	 LQbvvmL1YJJceg9mei9z6e0SXi/EtIGs34YjpSlAkz1fEWS9Y+e+JW1ql2EvW9Dpgz
	 X9wsyQTClR+cFQg/qgwp+TJX/vuwm3/kNlUnLnug=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E84C01A4229;
	Fri, 27 Feb 2026 04:57:10 -0500 (EST)
Message-ID: <65a54e3763c903043d8051e3bc83c9cf783047b0.camel@xry111.site>
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
Date: Fri, 27 Feb 2026 17:57:07 +0800
In-Reply-To: <CAAhV-H5nedWAfUXL-mwuoQGgn24pvS7=w9BwQ=t+iZfqJO0CFA@mail.gmail.com>
References: <20260227072031.581229-1-xry111@xry111.site>
	 <CAAhV-H5nedWAfUXL-mwuoQGgn24pvS7=w9BwQ=t+iZfqJO0CFA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219941-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[xen0n.name,loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xry111.site:mid,xry111.site:dkim,xry111.site:email]
X-Rspamd-Queue-Id: DBCD01B5A59
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 16:58 +0800, Huacai Chen wrote:

/* snip */

> > diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch/inc=
lude/asm/sigframe.h
> > new file mode 100644
> > index 000000000000..59db3de6db85
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/sigframe.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Separated from arch/loongarch/kernel/signal.c.
> I think this is also unnecessary.

Will remove this comment.

/* snip */

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is also the reason w=
e don't use SYM_FUNC_START.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nop
> > +SYM_START(__vdso_rt_sigreturn, SYM_L_GLOBAL, SYM_A_ALIGN)
> Is it possible to define SYM_SIGFUNC_START/SYM_SIGFUNC_END in
> linkage.h, and then use them here?

How about SYM_FUNC_{START,END}_NOCFI instead?
>=20

--=20
Xi Ruoyao <xry111@xry111.site>

