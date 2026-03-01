Return-Path: <stable+bounces-222448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LPrJRIVpGkPWwUAu9opvQ
	(envelope-from <stable+bounces-222448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:29:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FC1CF2F6
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA439301918F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA2421257B;
	Sun,  1 Mar 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eQMTaDTa"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20412B94;
	Sun,  1 Mar 2026 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360972; cv=none; b=m9xeaFDokNfBVEVbyomGR+c9JbW7DDRUdpRUiNoBjmIJM5YHQgBSAMDiI6WA7yyZaOYMeXW3G2JTM2weV2ShR9stW54XfrYqmLdteZ1aWzvN4f8DRaYzdj3pceYFt/uzhbYrc0YDPObFfzAj4y3hL7hEqLCgh/o6arqfPEo+Wh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360972; c=relaxed/simple;
	bh=UQiCSWgYyslyuyAGrfE/yDjLph4TsjP4wVmuLMTb+GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i497F+scjy82CkWHVTJf/D9uKdeCcgxJmupoO3hpD6A6q2+YaU061XbSaEvmuM3odeQ4ih9M2VVoBiyV5h1svDeEDbbHLvDJ+XdO9ywpCxabKGzEqLz5NwptJZtMdfD/yasu3JnPurjXppzoT+n7N5BB9wePc3KezTs52GvwTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eQMTaDTa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1501640E00DA;
	Sun,  1 Mar 2026 10:29:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ESrbC4JY5h0A; Sun,  1 Mar 2026 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772360962; bh=QxW8dGZTs5On2geuqoO8m3DzkPsyi0zXwuetfK2CMHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQMTaDTacdFgFtBbUD5PVw1aCKstJUXXFJwpzTgULB2jZafG+OXoKNxnRBcYYht9X
	 EUdBCaQB7994MjMfEcoaqqFwt057Zm76AeUYTLbEShcwvQI7poNj6J6SEciWYoUnug
	 2t628yKHF5J5smKx9GAp8as/0gxQ56+jXE1+6R3P3xtfeJdigaiWivrl1gdLN7IAfy
	 t5Mf0shBX4srXa6BiGCZVkTIVkitgaTTdQ0ybJ7Zf1rnnjpobuk7A8DBvUB+vLkxPb
	 l2XKLJvWrWgh/erN1CTDER13wxyFesp4uCr6l8Fkz4/EZyE0rljU70+VA9WLLdbw44
	 bjcmcej5W+KBuI6kO+ddC5B+dkDNOKLWfKrhXYq8sC+KujtVdNRD/3cf8aMLDyQnke
	 mdIf9/TodsbuPeDyoFfvfyNAxvJRixU2vZ50slqmfxpfRDdYAvURQyQ11VMiW22uyK
	 h2sq14GdekIEmbN77ATCr8sSIBa13P7lvtA/ukXCuUvPy80CDwuvo12X+QrVd2i1zU
	 kuhUqqy1t6ECSSj9e9YoynY+Ce2pq+S0p7S/5xXLlD1YM4rymUNOC/uwaVXLe0Ly0a
	 ev9keVDZfcGPLZgyREZ1rDgKDEAwY4F190NG5F1/dZCu06gUsiLH9+62ou6Y4TMOM9
	 TllJtZVV5JVjtB9HoZyLtVPQ=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 085C140E0028;
	Sun,  1 Mar 2026 10:29:00 +0000 (UTC)
Date: Sun, 1 Mar 2026 11:28:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yao Zi <me@ziyao.cc>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
	David Wang <davidwang@zhaoxin.com>, lukelin@viacpu.com,
	brucechang@via-alliance.com, timguo@zhaoxin.com,
	cooperyan@zhaoxin.com, benjaminpan@viatech.com,
	TimGuo-oc@zhaoxin.com, QiyuanWang@zhaoxin.com,
	HerryYang@zhaoxin.com, CobeChen@zhaoxin.com
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Message-ID: <20260301102854.GAaaQU5odOkqHqPIqe@fat_crate.local>
References: <20260228173704.62460-1-me@ziyao.cc>
 <72356849-27d0-46c7-b659-c1a3b260de8c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72356849-27d0-46c7-b659-c1a3b260de8c@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222448-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fat_crate.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: 022FC1CF2F6
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 04:33:18PM -0800, Dave Hansen wrote:
> On 2/28/26 09:37, Yao Zi wrote:
> > Let's disable the feature on this problematic CPU and warn the user
> > about the quirk. x86_model_id is used to match the platform to avoid
> > unexpectedly breaking other CentaurHauls cores with conflicting
> > family/model ID.
> 
> Wait a sec. There are lots of different microarchitectures with the same
> family/model and no other way to identify them but the model id string?
> 
> We've used string in a handful of places, but it's an absolute last
> resort. Are you *sure* there's no stepping or anything?
> 
> I kinda think we should keep this like all the other vendors and keep it
> to model/family/stepping. If the vendor has grouped too many
> non-vulnerable CPUs under that, then ... this is going to be a good
> learning to bring back to the CPU design team.

Except that you'll be punishing perfectly fine CPUs... that is if those other
ones do really support the FSGSBASE set... and frankly, I don't care too
deeply if that particular zoo of models would use a model string if really
necessary.

But, the first thing we should do, is figure out whether the VIA design is
affected the same way.

Lemme CC some more folks who I can dig out from patches touching that area...

All those newly CCed folks, thread starts here:

https://lore.kernel.org/r/20260228173704.62460-1-me@ziyao.cc

Please have a look and let us know if you can whether VIA CPUs of family 6,
model 15 and use the "CentaurHauls" model string also claim that

CPUID(7)_EBX[0 /* FSGSBASE */] = 1b

but they also #UD on those insns.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

