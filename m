Return-Path: <stable+bounces-222480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIgQLIKHpGlsjQUAu9opvQ
	(envelope-from <stable+bounces-222480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 19:37:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F96C1D11DF
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 19:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66B75300B197
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D88A32572F;
	Sun,  1 Mar 2026 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrxfwBun"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5128C87C
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390272; cv=none; b=qOdhxe1qBZ8XxXG9nUddk++F6amhAKdnC0MahOpBnGIf5dxK9UbQahGWTlwy/xM9X8QQV3MyX6kXemGheazSEZIkhp8ouvJ45HOcfFUsSwa9Tg1OtrhfYLm1KWoz4Ap1lzWTCpxo4Cs8jP1Ed2yht/nOnglymaWaJHjmjT/stEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390272; c=relaxed/simple;
	bh=2pOHsK9RSJwGIDZz4SDXC8N0u8o8KXZ2yG7GmScshL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOgs7N97zrdQ4PF4BbD/zDp7lvXOyZkD2Z2d6ncv0GJ3N2BqD/TVvZHHPiXFMd1hhl3I9ilL5HH2Y+VmPoUNOWB4tHkLRn+nJ1XlJG/Fhm64CLRUneM9XnjPYK5Y0/YcdrbNzBtdJSsU2XekNKU40AbvWKQXH+2RuiD3Kefy5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrxfwBun; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-436309f1ad7so2937781f8f.3
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 10:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772390269; x=1772995069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/CRFM666ZOglRBUixDp3KMMUhqr+IiA1uFR3UsAuA4=;
        b=XrxfwBun7SpKYA9ncCZ8TDSNQJeh3+fzB6Go4FKeh9gry2YOHd5p9TFaroPo3i2CdS
         U3uQHijSu5IYPeS1lqzdXbApckjkaR0T8tvK49K1yQu/9tBakkJmnFB6kMvoHSO3t4W0
         OZLSVYxT5fK1kld2jtNWqiXoEGiJvqaIwTyysmHlO7P5ynrxvRqI4FAumPDqQ0WUgtJz
         HVXUXzhpDk2bMe+cjBUWbc9HpGS113eSYYav6/hIe3mJ0WgMUmaYiMhogxO2f/VNJyPF
         NgSckiuyF7vapSbJ5qI+an4/4nPeQq1XP0CCBPh4+5/rOee/7AqPI+vMoVSl0rG/c12g
         xJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772390269; x=1772995069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/CRFM666ZOglRBUixDp3KMMUhqr+IiA1uFR3UsAuA4=;
        b=NTRQtBA/IPoQLSAE6TLVMjgYdONw3nqhxhJGfu6Q9FyqhOxaZBDCb/gU7IPD7DxYPY
         NKdvp2D3J8czD8qkXZCxJXPUOLj0vw8GfHnNcqwBnIIhHrJ3BrD1+1cy08kW+EW1PNTg
         oV1AA+prUFvVW3QuYWogG5x75qjGoSlN/fxvz6Z1wWKB/3dq+YSQS0UZlPkhM2vAy/vv
         sRyusc4zTG+2lBSIufzalLUM4ZfujLuOlK3paeb5+BB1BcSBATrzvSiKhZBs+hDVteEW
         /o2L9aQGkOoUrZeVoc0TsVojFyWyf7sVp9ctGeOYUypQXWigKEhRWqIk/ehWCNuJ/f9N
         mxHA==
X-Forwarded-Encrypted: i=1; AJvYcCVNpKO+VlNL6JCRNBsC8d18VbW9baMdjcKuSZkN467lMOB2c917jUpFzyU0Pnp1RBwkbjsqW8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6YlZFbPX6sb2TiVuYXR4K+0NxWC1t3mf5Lng2D93xPOVuaC0
	YfjYanbk7mITMC4I8y4WujRP/h/q57XqVoxoqhxRW8gSATm4ilkoxLRn
X-Gm-Gg: ATEYQzxXZI3TF2dETs2yGl3lj2mt6R0b+cSirW3ySbxSLnpYuD+FeUGPON+IIptSD+t
	9gUhRx2ZAvv/oTZMEhWHeax8qHHwfmk9olK2WMB7ZzutRV3FN612Lwd2+RrTnxj4oIoky5gZUoM
	gQub+WLB4xzbNe5XWk0DdpM4AIF8iPaY0+oW6s+H5NsEFOw52GKYtEUb/E1GV1uXhZilIz365ke
	Xf5QlaLA+6XPzTYe14EN8/NEl/nBE8b/Yo7lojIf8GP6yb2H3V9q0VdzGyh1qkXC8R0gkt473mH
	xn/7B6fMiRtYHT1ruPn+OrilsuPJth2ZylzkMJMnl8RP1J1IjzRCWeUqXvYj+XggXGYaVgtKJqi
	aTFsb3DqiNbVVfumDecksAjwhy6nGdgAYu2okNm2ImFUPb8YtmvJ2fBUMrs5WXNEajdAhziZZZZ
	52jZWn/cDwjvWz/wksVqfuQNRwY7YtEZE4CdBpyB4PNbmZ37qeHsVUr+Wa0c59QQCZ
X-Received: by 2002:a05:600c:a085:b0:483:badb:618f with SMTP id 5b1f17b1804b1-483c9bc5b7dmr162436685e9.25.1772390268635;
        Sun, 01 Mar 2026 10:37:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b59723fesm3676376f8f.38.2026.03.01.10.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 10:37:48 -0800 (PST)
Date: Sun, 1 Mar 2026 18:37:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yao Zi <me@ziyao.cc>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on
 Zhaoxin C4600
Message-ID: <20260301183747.7ccb50a2@pumpkin>
In-Reply-To: <aaQGgQOyU877bT1L@pie>
References: <20260228173704.62460-1-me@ziyao.cc>
	<20260228190615.GDaaM8p65-qJFWzgK2@fat_crate.local>
	<aaQGgQOyU877bT1L@pie>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.84 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-222480-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.842];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziyao.cc:email]
X-Rspamd-Queue-Id: 3F96C1D11DF
X-Rspamd-Action: add header
X-Spam: Yes

On Sun, 1 Mar 2026 09:27:29 +0000
Yao Zi <me@ziyao.cc> wrote:

> On Sat, Feb 28, 2026 at 08:06:15PM +0100, Borislav Petkov wrote:
> > On Sat, Feb 28, 2026 at 05:37:04PM +0000, Yao Zi wrote:  
> > > Zhaoxin C4600, which names itself as CentaurHauls, claims
> > > X86_FEATURE_FSGSBASE support in CPUID, while execution of fsgsbase-
> > > related instructions fails with #UD exception. This will cause kernel
> > > to crash early in current_save_fsgs().
> > > 
> > > Let's disable the feature on this problematic CPU and warn the user
> > > about the quirk. x86_model_id is used to match the platform to avoid
> > > unexpectedly breaking other CentaurHauls cores with conflicting
> > > family/model ID.  
> > 
> > Please use passive voice in your commit message: no "we" or "I", etc,
> > and describe your changes in imperative mood.
> > 
> > Also, pls read section "2) Describe your changes" in
> > Documentation/process/submitting-patches.rst for more details.
> > 
> > Also, see section "Changelog" in
> > Documentation/process/maintainer-tip.rst  
> 
> Okay.
> 
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > ---
> > >  arch/x86/kernel/cpu/centaur.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
> > > index 81695da9c524..3773784ba6a9 100644
> > > --- a/arch/x86/kernel/cpu/centaur.c
> > > +++ b/arch/x86/kernel/cpu/centaur.c
> > > @@ -108,6 +108,29 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
> > >  	}
> > >  }
> > >  
> > > +/*
> > > + * Zhaoxin C4600 (family 6, model 15) names itself as CentaurHauls, it claims
> > > + * X86_FEATURE_FSGSBASE support in CPUID, while executing any fsgsbase-related
> > > + * instructions on it results in #UD.
> > > + */
> > > +static void fixup_zhaoxin_fsgsbase(struct cpuinfo_x86 *c)  
> > 
> > s/fixup/disable/  
> 
> Okay.
> 
> > > +{
> > > +	const char *name, *model_names[] = {
> > > +		"C-QuadCore C4600"
> > > +	};  
> > 
> > Why is this an array with a single string in it?
> >   
> > > +	int i;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(model_names); i++) {  
> > 
> > So that you can loop once with it?
> > 
> > Silly.  
> 
> Though I don't have the conditions to confirm it, it's likely other CPUs
> in the same generation of designs from Zhaoxin have similar issues:
> their specifications[1] are mostly identical except the core frequency,
> thus they're likely the same die. So I leave a loop here to ease latter
> additions if necessary. Sorry not to make it clear.
> 
> This may be a little farsight. Dave suggests declaring an x86_cpu_id
> array and switching to x86_cpu_match(), do you think it's acceptable? Or
> should I focus only on the known problematic model and use a simple
> if to match Zhaoxin C4600 for now?

Is it possible to try executing one of the instructions and see if it traps?
That saves having to maintain a list of broken cpu.

	David

> 
> > > +		name = model_names[i];
> > > +
> > > +		if (!strncmp(c->x86_model_id, name, strlen(name))) {
> > > +			pr_warn_once("CPU has broken FSGSBASE support\n");
> > > +			setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> > > +			return;
> > > +		}
> > > +	}
> > > +}  
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette  
> 
> Regards,
> Yao Zi
> 
> [1]: https://www.zhaoxin.com/qt.aspx?nid=3&typeid=90
> 


