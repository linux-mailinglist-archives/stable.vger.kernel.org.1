Return-Path: <stable+bounces-224884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D+AM3DksmkcQwAAu9opvQ
	(envelope-from <stable+bounces-224884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:06:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A12752D1
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD625300C33C
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57003CF694;
	Thu, 12 Mar 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rbLc8vZ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88338757E
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331325; cv=none; b=n4whQmGjQ+Xr94q9GjmIyJd1S+9aF/UPLOO3747XLeK+cX2fSFEP3VxRqBEhsp+v2jsRZYfQ87w/jMzQW8JPOj+FnVGdWvl5x/3TXjRflRHE/9b80CyiCpRC6aXf1nOcfaz2ocRVTEab/6VkqfE+bURmEV2wTpoQlsW/qDygdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331325; c=relaxed/simple;
	bh=Pk6i8yoSLmvjbHvV1MTtVmz1qPYslpyIivwjKzVBn8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJwMHcK0KpdrY9BL6UfkWo+L7JiYZx+Sm3QRxhQuie/i5NBIMOsY4D/jjnWAE/znjkmwdxhluCKmYQng/TZlUe5BZqov45XEQf+vXyTktLykGloWJU87ZTc4o0w1rMdHaD3r6wjf6urLJ0QQ6ltem5B2/886bSYr+ckVYPxh8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rbLc8vZ/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-794719afcd4so11947377b3.1
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773331323; x=1773936123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy73+iGNGeECV0rQjpRLn6tiSFKzdH9itGL02lldZDY=;
        b=rbLc8vZ/FcDkhvwgG62p7BH84BmsDhlouJqv20KeeVZXwAdbkr/BR4+NMeooweOoZn
         TMHrT+ReYzyZB6sqN+Re28uCz+O0R8VqZLVFDQflZdcniwQkJoM9S3oxXsTN1y4Naeeh
         Ky2lxze5YixfoJIlJUyCz3JOfH5lJeTDpRh+eLD92jhJULina3EpzBhpS+eYiPLq/xvw
         d3hOoZiIVGZg1pLCunZQPDWQTej/UiTWIvLUni8TpQn7pqWDX7xr5jskr36FR+fkmJz/
         PRWvItN7ZPaOrgJC5JQd9s3wXET+13MrJLPVN218S+mjcrfoJ9YuW5abbphmVmPhWhbe
         P3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773331323; x=1773936123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy73+iGNGeECV0rQjpRLn6tiSFKzdH9itGL02lldZDY=;
        b=lhoeNbTiXFqUmZutR5hR5MqK0k7ofGXIZEzQIyZaNI8ZLLzbQx0xgo70OP7dOb7Bst
         5bFcTIzWH8Yd5xpESmQ4NV9G4n494phPKuwUqC2QJVaxU3jfpSeUs+Uyhf6hchXseC4J
         CdZajTI6Iro7U0erLoF23abzdFpCtP4q/jgP3mahLUvFj8CtqPIDTfKSuaBtJUGnDh/l
         p8WPRjePWrwJhetmGKAB7lx72rG+bThYxDKGVGhoKoXTOuKI9lTFo4bQSfUFNUHjdr0u
         pNjXy5Czcf0PZTFbrENaCBqLGixenAyg9TqWB8HJ1SI1HbZ6lqPro1bW18H6JthEBOok
         uZCw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Yb+dCtliGDe4Kh8tc2i+PdGV7Bw0xLaRYo57i3csd1JgDFAX8WYyAl+4OyHTp+bpYWvRJAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjnc5ICRR53YCHO/P8vPZ7CMEsHYlxfh18/Zv5otb29Rf6LzRq
	aE6HLye8WQesdO2IMQc8lF2Fh8znfpJsMCBoxQpSQS3gZJDI6k27W9XmwYgF5XD25iQ=
X-Gm-Gg: ATEYQzwEDeUkp2QuywU1hUF9xttdJDiaGAe+WUjJ4BKvOjT20pMnRM0FXQHLLoPgDXU
	io+0M73xbVfX+xiub52HgekpYnuTJ9BML2H3qy4eUsYkQ0rmS6gvDj48t2kB40oX+Opg9WavGpv
	nzSc5t8fM4ocGTrdwxaBpMhkpD32C5vxkLoqYw92MycCFfQOiYuaUcRcZKwI4D77jm/AofFmxdE
	3rBfxsTXMcQXVA5oDU/+AJuhYLktPK9cVRXX1U2VkOgZzvD828/6JF3yLDkX1HlGZU8xu+i6w4B
	WG8U07HTVuMF+yN/aeUi7Afm+3b08u/mqXUi2Axmwu5CuHkEQK7kY8O+xqw11/wfAhRn8SLgBq1
	zD4j46UCpnHdy9wDrQxA2+DH34UxDW6nNp1Dy2kVTTydNjkgmtqFtZfbXVDEzFINbmwW78VlGK+
	/Clw+KXCDBUONflDFRCB8/PXNSNT2AcgPclq1VKg7WXAX5/fMERLU0hG+Wwa5Y1vKrL36E9kxe5
	6gn8rwpOA==
X-Received: by 2002:a05:690c:6389:b0:796:45d4:9e2d with SMTP id 00721157ae682-79a1c1dce28mr556267b3.53.1773331321722;
        Thu, 12 Mar 2026 09:02:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d2160asm37260386d6.52.2026.03.12.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:02:01 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:01:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org,
	alexghiti@kernel.org, kernel-team@meta.com, akinobu.mita@gmail.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, apopple@nvidia.com,
	byungchul@sk.com, joshua.hahnjy@gmail.com, matthew.brost@intel.com,
	rakie.kim@sk.com, ying.huang@linux.alibaba.com, ziy@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Bing Jiao <bingjiao@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: Fix demotion gfp by clearing GFP_RECLAIM after
 setting GFP_TRANSHUGE
Message-ID: <abLjdSC1DOIyTnPa@gourry-fedora-PF4VCD3F>
References: <20260311110314.237315-1-alex@ghiti.fr>
 <20260311110314.237315-4-alex@ghiti.fr>
 <abGsagHIieEobFbB@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abGsagHIieEobFbB@cmpxchg.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224884-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[ghiti.fr,linux-foundation.org,kernel.org,meta.com,gmail.com,oracle.com,google.com,suse.com,bytedance.com,linux.dev,nvidia.com,sk.com,intel.com,linux.alibaba.com,kvack.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gourry.net:dkim,ghiti.fr:email]
X-Rspamd-Queue-Id: 719A12752D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:54:50PM -0400, Johannes Weiner wrote:
> On Wed, Mar 11, 2026 at 12:02:42PM +0100, Alexandre Ghiti wrote:
> > GFP_TRANSHUGE sets __GFP_DIRECT_RECLAIM so we must clear GFP_RECLAIM
> > after, not before.
> > 
> > Reported-by: Bing Jiao <bingjiao@google.com>
> > Closes: https://lore.kernel.org/linux-mm/aXlKOxGGI9zne8sl@google.com/
> > Fixes: 9933a0c8a539 ("mm/migrate: clear __GFP_RECLAIM to make the migration callback consistent with regular THP allocations")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> >  mm/migrate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 2c3d489ecf51..ee533a4d38db 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2190,12 +2190,12 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
> >  	}
> >  
> >  	if (folio_test_large(src)) {
> > +		gfp_mask |= GFP_TRANSHUGE;
> >  		/*
> >  		 * clear __GFP_RECLAIM to make the migration callback
> >  		 * consistent with regular THP allocations.
> >  		 */
> >  		gfp_mask &= ~__GFP_RECLAIM;
> > -		gfp_mask |= GFP_TRANSHUGE;
> 
> I don't think this is right.
> 
> The Fixes: did it this way to disable kswapd for THP allocations,
> while still allowing the customary direct reclaim. Maybe a better
> comment would have been: /* GFP_TRANSHUGE has its own reclaim policy */
> 

The bigger issue how many times we see this particular flag getting
masked and apparently added back in at multiple layers. We saw two
or three paths (some unreachable) that can twiddle RECLAIM flags in
the stack for demotion (which is in reclaim already, so do the flags
matter?).

It makes it difficult to reason about what the GFP flags actually
are at any given point.

But yeah I wasn't sure to make of this code, it could be as you
suggested just a bad comment.

~Gregory

