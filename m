Return-Path: <stable+bounces-222510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADIyGcgbpWnk3QUAu9opvQ
	(envelope-from <stable+bounces-222510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 06:10:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E11D307E
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 06:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48F343013B7C
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 05:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FFA2F1FED;
	Mon,  2 Mar 2026 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="guLcVbdR"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05622D59E8;
	Mon,  2 Mar 2026 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428226; cv=pass; b=Rvm32VD3MclF27tf9yFmydaLtAFmtZ9mIu34QNoLWVAxQAjFIx2a4aVNBUMvTtwBYKOBa6rn1CIb7KZgoq+vXiCr6etH7/AiG7MIkDsezWOWIp49TeZJo2zejbbViEtb7khaBkKHQNBTxkJPWENgcRcUxrNNc8JgSBkiENIt6B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428226; c=relaxed/simple;
	bh=Qj2wp9jEQDVZ/hHozPkhTK/NdIEXtv4WAF0fMEet8Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQFl5KrHqYfU7n8tBN+2ss9WCI3t1CRlOaPA1bG1YmvOo0xTJ8mHTCntPJnmhdoKDROz2L30pqtrMLW+jZ4/0S9IpuV9c2jAPK30pz+YjQyZurG77ixtj2BxrYoANbfRDMuHIL37RWqkwarXudQpv9cr78d2lq2OJMKkIc68dzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=guLcVbdR; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1772428207; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UusJT7aqwKGG7hfsNjemBchZTvwoZsg8GqTe0N+iM/62tBhx+lgcvXUAan6t6zWeweNBR8YCw0sbQtilK0CNW4gPtdycu+tV38HLflzVuJ7XmqLd98gTaxTFVrDRCyiNxJtIiRyAxZ4hEYke5sjbx7LzNrRQSeXEbry1dVNkcDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772428207; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xcK28VDkLsZ4dQqZ/ksFK0o1697lcQ7iv5sWBWHuqx8=; 
	b=eZM+1fmq+vYxTQ23vNFzaUwG6DuvcNW8fVnHezH2rUSMV1IKDWM3my6hsjt3empOnqncm1aI0aZJXDcAWB2YLD6G6jO3mZ2LwIT2Ueuy4F04a8Z57tpSF5lpCM8Wv+uSX844ARgxbk45QgqOEoKjiKYeCfRd8NkLQah1mMIU8Qw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772428207;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=xcK28VDkLsZ4dQqZ/ksFK0o1697lcQ7iv5sWBWHuqx8=;
	b=guLcVbdRJdD+b8qTzD5smkfZaie/8lplikn0d8eGe6aOVDFORrRafg/0oXuEHvG3
	sDo75kMxRF7zb4TvWx4hf8k5Yrh1Yec7dn7zP7BmQj9msyZUES/TEcfgIHHVByhtnem
	sfL8mJxtT1oFb3VABO0A10+a34CG30PhmCb3/PYY=
Received: by mx.zohomail.com with SMTPS id 1772428205067532.9894331942066;
	Sun, 1 Mar 2026 21:10:05 -0800 (PST)
Date: Mon, 2 Mar 2026 05:09:59 +0000
From: Yao Zi <me@ziyao.cc>
To: David Laight <david.laight.linux@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Message-ID: <aaUbpzOB9jUqys4H@pie>
References: <20260228173704.62460-1-me@ziyao.cc>
 <20260228190615.GDaaM8p65-qJFWzgK2@fat_crate.local>
 <aaQGgQOyU877bT1L@pie>
 <20260301183747.7ccb50a2@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301183747.7ccb50a2@pumpkin>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:email,ziyao.cc:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222510-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	NEURAL_SPAM(0.00)[0.991];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziyao.cc:email,ziyao.cc:dkim]
X-Rspamd-Queue-Id: D09E11D307E
X-Rspamd-Action: add header
X-Spam: Yes

On Sun, Mar 01, 2026 at 06:37:47PM +0000, David Laight wrote:
> On Sun, 1 Mar 2026 09:27:29 +0000
> Yao Zi <me@ziyao.cc> wrote:
> 
> > On Sat, Feb 28, 2026 at 08:06:15PM +0100, Borislav Petkov wrote:
> > > On Sat, Feb 28, 2026 at 05:37:04PM +0000, Yao Zi wrote:  
> > > > Zhaoxin C4600, which names itself as CentaurHauls, claims
> > > > X86_FEATURE_FSGSBASE support in CPUID, while execution of fsgsbase-
> > > > related instructions fails with #UD exception. This will cause kernel
> > > > to crash early in current_save_fsgs().
> > > > 
> > > > Let's disable the feature on this problematic CPU and warn the user
> > > > about the quirk. x86_model_id is used to match the platform to avoid
> > > > unexpectedly breaking other CentaurHauls cores with conflicting
> > > > family/model ID.  
> > > 
> > > Please use passive voice in your commit message: no "we" or "I", etc,
> > > and describe your changes in imperative mood.
> > > 
> > > Also, pls read section "2) Describe your changes" in
> > > Documentation/process/submitting-patches.rst for more details.
> > > 
> > > Also, see section "Changelog" in
> > > Documentation/process/maintainer-tip.rst  
> > 
> > Okay.
> > 
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > > ---
> > > >  arch/x86/kernel/cpu/centaur.c | 25 +++++++++++++++++++++++++
> > > >  1 file changed, 25 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
> > > > index 81695da9c524..3773784ba6a9 100644
> > > > --- a/arch/x86/kernel/cpu/centaur.c
> > > > +++ b/arch/x86/kernel/cpu/centaur.c
> > > > @@ -108,6 +108,29 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
> > > >  	}
> > > >  }
> > > >  
> > > > +/*
> > > > + * Zhaoxin C4600 (family 6, model 15) names itself as CentaurHauls, it claims
> > > > + * X86_FEATURE_FSGSBASE support in CPUID, while executing any fsgsbase-related
> > > > + * instructions on it results in #UD.
> > > > + */
> > > > +static void fixup_zhaoxin_fsgsbase(struct cpuinfo_x86 *c)  
> > > 
> > > s/fixup/disable/  
> > 
> > Okay.
> > 
> > > > +{
> > > > +	const char *name, *model_names[] = {
> > > > +		"C-QuadCore C4600"
> > > > +	};  
> > > 
> > > Why is this an array with a single string in it?
> > >   
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(model_names); i++) {  
> > > 
> > > So that you can loop once with it?
> > > 
> > > Silly.  
> > 
> > Though I don't have the conditions to confirm it, it's likely other CPUs
> > in the same generation of designs from Zhaoxin have similar issues:
> > their specifications[1] are mostly identical except the core frequency,
> > thus they're likely the same die. So I leave a loop here to ease latter
> > additions if necessary. Sorry not to make it clear.
> > 
> > This may be a little farsight. Dave suggests declaring an x86_cpu_id
> > array and switching to x86_cpu_match(), do you think it's acceptable? Or
> > should I focus only on the known problematic model and use a simple
> > if to match Zhaoxin C4600 for now?
> 
> Is it possible to try executing one of the instructions and see if it traps?
> That saves having to maintain a list of broken cpu.

Sounds like a good idea, I'll give it a try with extable.

> 	David

Regards,
Yao Zi

> > 
> > > > +		name = model_names[i];
> > > > +
> > > > +		if (!strncmp(c->x86_model_id, name, strlen(name))) {
> > > > +			pr_warn_once("CPU has broken FSGSBASE support\n");
> > > > +			setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> > > > +			return;
> > > > +		}
> > > > +	}
> > > > +}  
> > > 
> > > -- 
> > > Regards/Gruss,
> > >     Boris.
> > > 
> > > https://people.kernel.org/tglx/notes-about-netiquette  
> > 
> > Regards,
> > Yao Zi
> > 
> > [1]: https://www.zhaoxin.com/qt.aspx?nid=3&typeid=90
> > 
> 

