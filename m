Return-Path: <stable+bounces-270069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yr8nBgNRRGqNsgoAu9opvQ
	(envelope-from <stable+bounces-270069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 01:28:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 147C76E8A54
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 01:28:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=k5LEu7ob;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270069-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270069-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C031300F24C
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 23:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796123346BE;
	Tue, 30 Jun 2026 23:27:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077EC2E739D
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 23:27:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862076; cv=none; b=HVpZzdLPCHUqbmO8F8ooXsemeta7Zr0sJNyEKVsotFAyq5CXCiTd/PYd1d4jU8iQQD865OF1P8HL1/vo3E3F6b1LI+qLKP8vEGF6bEuK7Md95Ei2ZT203RQExgCkRoQO5ItaxVMc1EXUUOq+tBCs+MevX/XPZr9I2NSDGJJR6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862076; c=relaxed/simple;
	bh=GtHzYMaaF3v4UBjAVj7EndqKG4BL/qmUFDM/olQsFVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQBUrE7LpGJA0Yi2b8sY7a9TuYlGfSIKaEAxKTFFs8cqkOUtPwTElFkDjvz1hGGzlCIGOatXyd+2iV7GXIsSMhsVasjZvTbY080FmU+yI87JBGFzJIrMVCFl6Rgree783CxDr648HY/E6PjX4ull6uvKBEG2ARRz+0usdWW3x04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=k5LEu7ob; arc=none smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c1372f84dso62891cf.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782862074; x=1783466874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8VxY8AgSRitjH8l91RmH5GEBz/bwewUsAZtM00QZ6k=;
        b=k5LEu7obEJGhrxqVDbKKcu0G36eYKHCbpTdLbjizGjcq6w8K0ov34s6kQ/LSHWXQst
         eZbv31sdRujBmp3RQqyu1CW5vSO5GOlN5Yu/9GrX0h3FAq5irg5Pol1Q2kmQQQCX9x3Y
         n29+FMpqo5rFpmogUW8TgwU4ndKCL58dkEXi3pUfJpLU5wZRBpE0+ncvNrzGjji+OtLE
         RmiDU+mkTceV3NOnzDhM60i1dGaMMF6nCKmV1CrK63dbQYpK6pJhi4VYcozl86dG5M6u
         gtkE+7SBmNqCrLnxWSvKltQ5dVTTQxSlA7YMli69G8vLxmeFSQUp7MhP1xXm3jhs8KAk
         9XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782862074; x=1783466874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8VxY8AgSRitjH8l91RmH5GEBz/bwewUsAZtM00QZ6k=;
        b=VlMKtdrFCXMcOCRVAvb1XrEVcf5QVn8rtA9qEU5nURqC1GUaixnBRV39F12t2LcMWC
         gJ+uJB+RDlKxq4TNY/WSH+9pAfJZd8Spi28WeiF42ozmmXxI01N3e+GHSLkhGWabAJjU
         QzNy2vIzd5wdzSuNT7DZ6QtVpL3ivY+s7bKjI9rSn0MY89rkB+2myG70y6IZNeNQfHKg
         vtTm9I8eTzpVGh4X/M+dK5MHUnPeXsxiaKWAJb7TtQq4D1vS7pub9goKU2uHas5l8/+C
         mKqHT4/zaVvW3sDJ7IqRmkxTg7aVTwvs71GNkFuk1fvYcTryW+6pBZbvVfhc2rmF7lUC
         cM1g==
X-Forwarded-Encrypted: i=1; AFNElJ9iBwFKPVmJiDpk1yKRuiP79AhDB/RXlQZcGnG5FVSZ4YSUsKwTIBjw0/yqdYcI/2AuxNWXT6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrPRmWSBoRsQJANdNbKwBC+okLMYs7nawYQbXpkwhXIBEPD21
	KjApB7TgQ+oqFB5mWhjOy3uDKQvNYue8cKD+B5MvZTNoCWnTIHb+xBW9vwhUMGwlkH8=
X-Gm-Gg: AfdE7cn0G9DhRSjIW6A8EjIIGYtVPfSBsX2Tt4Y6vVv1IFrPB2GFZfx2ZjiXHlv/E5S
	5h/giGsHzMEEFSAoXsgN216rPHPBWEIC04UoxJRcniObtw+LneVyWT74xasM59O4NgRBYW59oCE
	Q2rK3ov+nYdbXY+4qrG4ELY65S3MtCcaBqLy87ACF1ANkDhjccDuN/vRb+GX5jh1msQO/aUh8Q/
	afQTKvVndAeT5AJGQvejEsskuys11dq3bNbNE+pWn4vjgc3Y+v6zbZuyT633tNBZ30hUVVqqnnF
	aXzIkz8PtGH8XfkhVmUVN52TixlvsPxABIvWhL/D/Pn1HKjjndFtN/T7gYi09xwNlCIz19HsPES
	+BMKvuS/N3DtULW3kA0neffZUf4rVV6hbPDs/jK7939Yrn9NpNs8qzsPH9yLr0MLX7DGjgzTuKn
	3nnjiEasCUy8DmHYu5nA+LRtzyBe8/ZHqZgbbVF7yBjUJ+eRmBqb2u3vPpULb3+zLWjy9P
X-Received: by 2002:a05:622a:349:b0:51a:84b8:df75 with SMTP id d75a77b69052e-51c108a0f92mr82576621cf.50.1782862073978;
        Tue, 30 Jun 2026 16:27:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3618b6b13sm2985436d6.34.2026.06.30.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 16:27:53 -0700 (PDT)
Date: Tue, 30 Jun 2026 19:27:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rppt@kernel.org, vbabka@kernel.org, mgorman@techsingularity.net,
	hannes@cmpxchg.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmstat: fold stranded per-cpu node stats when a
 node comes online
Message-ID: <akRQ9KB6-HzLwqwC@gourry-fedora-PF4VCD3F>
References: <20260627202243.758289-1-gourry@gourry.net>
 <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>
 <akQtx7zhP7pxNCiy@gourry-fedora-PF4VCD3F>
 <20260630155517.38a99de9f32d20abcbf9440b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630155517.38a99de9f32d20abcbf9440b@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270069-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:rppt@kernel.org,m:vbabka@kernel.org,m:mgorman@techsingularity.net,m:hannes@cmpxchg.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 147C76E8A54

On Tue, Jun 30, 2026 at 03:55:17PM -0700, Andrew Morton wrote:
> On Tue, 30 Jun 2026 16:57:43 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > On Sat, Jun 27, 2026 at 04:10:07PM -0700, Andrew Morton wrote:
> > > On Sat, 27 Jun 2026 16:22:43 -0400 Gregory Price <gourry@gourry.net> wrote:
> > > 
> > > > +		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > > >  
> > > > -		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > > > +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > > 
> > > and that's a lot of items.
> > > 
> > > I guess the overall loop count won't be large enough to cause issues,
> > > but it's large!
> > > 
> > > Perhaps there's some simple test we can do on the per_cpu_nodestat to
> > > avoid the inner loop?  Perhaps might need to add a field for this?
> > >
> > 
> > I took a look, but that would involve adding another per-cpu field and
> > then making sure all the races on that field are respected as well.
> > 
> > Not sure it's worth it for such an extremely rare event.
> > 
> > I can try to get clever on the folding logic if you'd like, let me know.
> > 
> > > btw, "for(int i..." is allowed nowadays.  It'll make this code nicer, IMO.
> > > 
> > 
> > Otherwise i can send you a respin for this.
> 
> Is OK, we could make this change in a million other places.
> 
> > > And... Sashiko seems to have found a pre-existing issue:
> > > 	https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry@gourry.net
> > > 
> > 
> > Incoming patch for this shortly.  Pretty trivial.
> 
> Cool, what was the Subject?
>

[PATCH] mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug

https://lore.kernel.org/linux-mm/20260630214039.2263562-1-gourry@gourry.net/T/#u

I didn't bother with Cc:stable because it's also 10 years old and
doesn't seem likely to actually get hit, but if you think it should be
stable let me know.

> 
> I'll queue this patch in mm-hotfixes for some testing while we await
> further review (please).
>

Thank you!

~Gregory

