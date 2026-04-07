Return-Path: <stable+bounces-233712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNq8GZBU1Wkf4wcAu9opvQ
	(envelope-from <stable+bounces-233712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 21:01:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D4A3B3210
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07243303A0A2
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97533970F;
	Tue,  7 Apr 2026 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7AeZ+2K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F39346E40
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588490; cv=none; b=Of/V1R9TtygzwblTDfkjFSpzwvNLXa5nzaSxgcC1AVQDBsahooKVc+/tSwMVGjUDwXPawCNbDWHJm41+yhpJXukP7Krdt4LACQC2OBvzkbqiOiYuP9fxpfTnCdG2bHFkaxutcm8MWNCNGDrLJ1yi1miCAEvZloFTqxUkClOod8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588490; c=relaxed/simple;
	bh=f3RFse77VTR9oCyHNOxlB9ANhwaYZmNeSiWpj5Qt2t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBPz0OIVv4ovnDWl+M9nZob62ndsyx6JVOQnYbSM03qMG4r0bEuROsopoA6EG/naFoMaO1GEQEoe36PbhzaGrghuOAFnpR3Fe/ofI6kk+r/KIp1SoQ43uh1zdVzNJFIjGE2IqxLIHtZo9ucPlWg2iR34AZ1iuMVl5+RFr1Td61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7AeZ+2K; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so2987955f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775588465; x=1776193265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EybpI27ykLBReoqVN3CBYIMg5L15qes55puRafaysjo=;
        b=d7AeZ+2KM7hXd1pCEyEEhgk2OkjoKGL95cKvi5UeJucG9Bi5Auqk47jPOSPLGoo4v7
         vaJsZ0Yaufd34eUjAu0SG5yW6vg1DaS4IceR38XwIH8ETvr6lXkfrrnj1rqJAfsj7yJK
         goJDqjVX3jMZVvz0mkQ5VYYT39I53FLaksWd1k/SKn1ZU7B+S6fazOMkzHOeMhPfkmNb
         dwAP7AzDeCj2B7C6T3xXOPB+/UAjDzEuo34iwUFbAYDwqKVsr8a4JhsUo56vXJxcLkmF
         jxrMKduqzkOt4HVfiy3KqChF9U9pGYW0NdUBU0pc4xXzn6MK0kcxdy/G3GvdkJsmoWX/
         CLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588465; x=1776193265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EybpI27ykLBReoqVN3CBYIMg5L15qes55puRafaysjo=;
        b=EGhEe3tAcGtZzYGHq1Vl0I4T/c/dNZz79SrNetbt4MXuivkYOLncSfkoK03wJXqWJb
         YndzzXg717sj/5AI6b7tU6r+gpcbfhHCmwvizqn3FZ4RIpCr5Ai1Q4jCcbKDdmON4rIW
         b3ddvyxHF5zYyJUeWNP+Qx8CnL2+0HHFvMvw+1Lz2i0voiPBweXGCtamH1sT9CbVtaZi
         z+6gEnyXHFx7yyIoIXJmUhRXCwbtSh24A0R5gg8F/MXQHy6OcPlrZXvuDCYg/HOolGTW
         cgpK/AaWYDNoU1c9X2OS/aR9bHQAhbDdpmZ5S7zlbcf/QQ6U8qYsTKSPmGRNFoRpED4r
         vIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfNHC1k78twy1NRqzWEbKoue0tGwcE6Tw10YNlOmFHQkqgdaijsbcjgf53TkW6+CtDlu6iEYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kUPhod+ZXtIboo4FLDLoFAODUd81ZxOCHQTy2Lshj5Awd3Qf
	EcU1PPB1jJKhwqWc01i62UkVs2ojkpew4GaRUB0tV3zsI/Oqbl1ZqPtO
X-Gm-Gg: AeBDievVDHhztOk/JCnOAaVlsba7P8Z3C9HkXd+cqqW8wmKOPQ/pivvx2TfDR/D75A5
	mCr+N1b4+qun5fgVaLnhOkQ7wNloUR+EvWYmsM3Spn9Z4PRJzPdFkZxf+t4dhS3jUT/HLI/0EBb
	P+WMszeN3ust3oEhQMGSBkbQddRFoqdtas2GfIq4EHd/eknRzwCUSO59Cxvb6UZtWDDosBGiFek
	nyAsmkeQFG1wCGs9+CtsZVE7iVVoEA8NmVT4T42auNZC5T3ch+Bp9ySlAOVW0ehOl57S7cur7JK
	X0C7BBKX00DYdKP2COvhncYqRT3GtiSMlHNd9x89NrhRInRft6xzwsWEgR1No5BsDN3sKV1zckr
	FaBrIgr6WEmsI5v8NHil9uyv/e5Rrbmgl1iWkMXwhkty55AOqHsVOM5thUOJ7ijd549V7SiPbaS
	CKVNe0q9FkLjQq2mthSYhramYJcLzAoQ+T7yslHnEg4LwtyGBy
X-Received: by 2002:a05:600c:64cd:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488996a1c9dmr266783785e9.6.1775588464881;
        Tue, 07 Apr 2026 12:01:04 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5dac41fsm256275e9.21.2026.04.07.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:01:04 -0700 (PDT)
Date: Tue, 7 Apr 2026 21:00:55 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] landlock: Fix log_subdomains_off inheritance
 across fork()
Message-ID: <20260407.895b3256373d@gnoack.org>
References: <20260404085001.1604405-1-mic@digikod.net>
 <20260407.844e42deb531@gnoack.org>
 <20260407.wuaqueid3Pai@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407.wuaqueid3Pai@digikod.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233712-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3D4A3B3210
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 06:03:58PM +0200, Mickaël Salaün wrote:
> On Tue, Apr 07, 2026 at 09:30:40AM +0200, Günther Noack wrote:
> > On Sat, Apr 04, 2026 at 10:49:57AM +0200, Mickaël Salaün wrote:
> > > --- a/security/landlock/cred.c
> > > +++ b/security/landlock/cred.c
> > > @@ -22,10 +22,8 @@ static void hook_cred_transfer(struct cred *const new,
> > >  	const struct landlock_cred_security *const old_llcred =
> > >  		landlock_cred(old);
> > >  
> > > -	if (old_llcred->domain) {
> > > -		landlock_get_ruleset(old_llcred->domain);
> > > -		*landlock_cred(new) = *old_llcred;
> > > -	}
> > > +	landlock_get_ruleset(old_llcred->domain);
> > > +	*landlock_cred(new) = *old_llcred;
> > 
> > This fix looks correct for the hook_cred_prepare() case (and of
> > course, hook_cred_prepare() calls hook_cred_transfer() in Landlock).
> > 
> > 
> > But I'm afraid I might have spotted another issue here:
> > 
> > If I look at the code in security/keys/process_keys.c, where
> > security_tranfer_creds() is called, the "old" object is actually
> > already initialized, and if we are not checking for that, I think we
> > are leaking memory.
> 
> old is only a partially initialized credential, and the Landlock
> part is not set yet, which is the goal of hook_transfer_creds(), so
> there is no leak.

Ah, you are right.  I think we might have mixed up the names "old" and
"new" in the discussion briefly, but it's still correct - the target
credential is only partially populated and its Landlock domain is not
set, so we don't need to call landlock_put_ruleset() on it.


> > I would suggest to use the helper landlock_cred_copy() from cred.h for
> 
> This is not required but if we would like to do it anyway, that would
> not be backportable and would introduce a (minimal) performance penalty.

Fair enough, the backportability is a reasonable argument.


> > Test looks fine.
> > 
> > While I do still think we should investigate the memory leak, this
> > commit is, as it is, already a strict improvement over what we had
> > before, so:
> > 
> > Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> I'll keep your tag if this patch is ok with you as-is.

Yes, absolutely.

–Günther

