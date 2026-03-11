Return-Path: <stable+bounces-224738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBm9HZKssWmzEQAAu9opvQ
	(envelope-from <stable+bounces-224738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:55:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D910E2684FF
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FA4830BF297
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CEE3E6394;
	Wed, 11 Mar 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="YWJLc5iF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786A3DD51F
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251699; cv=none; b=Ox/+9SiX/8vvcAmset2/IHkDaFzqkrpscTFg1uOg+16Ux8BrX1C250M3YpAO3cwn/hgJ74Z+7xpOOlmS1G5IcyxmekjYWQeA5vg1swEUVMh40dsE6ZKb+PKFkwROdD+jL/J2WwO5KX/vDRO3mlCcMmIRKO29XklVmh2dqMGYCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251699; c=relaxed/simple;
	bh=v5+UeDuKotevKJvDZYUrwuucwOLZLoYF6V6Qc5jOBds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ7OyhA3pcdzGnYoyDyrfU5yRhtgQtbC9HX00ND8tdNh/KipNBQuwS0ZAQOa0szEg2pC/O3OwBEo+mujDH7MQfDCMrptg1zCF3PxxFVs5H+3Qd+dT/00cGHoWT810bB9HBfkEC3L1hScjKVq85mszc97jQucV3Kt7s2TLP8o/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=YWJLc5iF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd81963e73so10240285a.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1773251695; x=1773856495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBORJCSAmU4MdfkW4MURe7WkkGRHnZxTHtzIl30bPMU=;
        b=YWJLc5iFfl51ToQ8eZkByXyg+Mtb41iPYr4tYENGUaoP3rJzX2i0xXcotU5G3GIn31
         QmcthMb5Ykg/jaWTcDEDJekCnC5nEfbNwZV+ewJMqz3D2ag1eLYk7+RtbMPpkPwlwpxA
         Vji9cUSjAT77VlgGRNH5GreHh28Ti8cqx4Se85GL5vjM72kzpcmudyXgKfbRgQNr9J51
         S1gLuOAxWIFFJILc5BVHyK64RC+I5MzV4U4CZBujb0wv3Jb+lOihmtKaUr32T0u8oduJ
         qp4bmQRHYka8b9kNnSHvSlBvA6l41onk49b15XNPdB8864BfhsZOiBam9wgiPNxnUhn1
         T/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251695; x=1773856495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBORJCSAmU4MdfkW4MURe7WkkGRHnZxTHtzIl30bPMU=;
        b=WB4X0Z+3cNZNnjmSQ7jDDxu7Z9D798TrDIVd1C469mjr7V/xvZU0/7c1gzxWcitmOI
         HP739C6ObTi4JM4lrBqs54pJUSKhhT4hyghxixbMxrpBu1339dquft4Y2mIGG25Iz8+M
         kMlBQYXLhoYPIVRyHDAEiO9YuD7PnFjfboUG7PxhjdfKVuGS1ODXOaasy96UmL41XuYe
         ZJlPRGd0f0ga1Byze2zXPtUUrSAXPP+psv3E7N83tmc6m3NlRrFsm+0h52uYl3B1AIEA
         e7yKyUta099rzyCrXMkQG7vxNApRjkU/1uZE20WVAED8/Lj7BunDBsrfaxDxhrNRoKPh
         BO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9HZBgzxGtHt8Bq1iEwkFCTkeRkExfPn0EQ4ucF/aWtUwpdUxBZpIInT2rp02wawefrcWzZzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRehS3RTQmFIY4uFhj/BPgiMptW+19uvDaCRJYjD+02CtczZB
	EuIM40fR/GIXVkhF+IdMNAwNOfPL6mjYeIUBrlCiE+rQqzaySOoBUJNRX9Wj6OttIF0=
X-Gm-Gg: ATEYQzz9kMC+x3rarLhcpyRBtWMb0SIqvjiYHmH9/ZbzeTqr4h/5WNFG5x0Xc9kodZe
	F2NvO8Rq0/XwK5ma6QYjYidUqyqm11aC+SKy1COiQ3lhMJ1wSfC3niGHOhbw8pyaPlo51EsQhTr
	4Ck3TI4NL4XJwmq5PMR7Ru3nQ0eQM/8+CZ4buP0HjKucB0HAH54E6tTqvuBqAFebFr+/XcvM6me
	waxnOePNaIw1eHNgbcSn5z+TCaLuiVfQFUbzwERAV7MB98r2J2Tn7WqCOaExYB7Qbcq+Krbp6eb
	jVgAQfn4gOplT9uYwIBcnQd2vMOU6BkYAaKcsuoqhBmLFHY2BrguKuyZ3CO484y2zEr9uRQsChR
	PBILts7FKiUgMQrnhj4Y1LHMlBLgv303Yf1+Y2xn+WhLBwOWnT1npj8HHgINO5AZiRPSmFse/uP
	GpyaEMIVD/FegkkOfIu6uP+A==
X-Received: by 2002:a05:620a:46a0:b0:8cd:78fe:35e4 with SMTP id af79cd13be357-8cda1a45948mr470255485a.62.1773251694997;
        Wed, 11 Mar 2026 10:54:54 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21100b8sm181981685a.29.2026.03.11.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:54:54 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:54:50 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: akpm@linux-foundation.org, alexghiti@kernel.org, kernel-team@meta.com,
	akinobu.mita@gmail.com, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	gourry@gourry.net, apopple@nvidia.com, byungchul@sk.com,
	joshua.hahnjy@gmail.com, matthew.brost@intel.com, rakie.kim@sk.com,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Bing Jiao <bingjiao@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: Fix demotion gfp by clearing GFP_RECLAIM after
 setting GFP_TRANSHUGE
Message-ID: <abGsagHIieEobFbB@cmpxchg.org>
References: <20260311110314.237315-1-alex@ghiti.fr>
 <20260311110314.237315-4-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311110314.237315-4-alex@ghiti.fr>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224738-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,meta.com,gmail.com,oracle.com,google.com,suse.com,bytedance.com,linux.dev,gourry.net,nvidia.com,sk.com,intel.com,linux.alibaba.com,kvack.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ghiti.fr:email]
X-Rspamd-Queue-Id: D910E2684FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:02:42PM +0100, Alexandre Ghiti wrote:
> GFP_TRANSHUGE sets __GFP_DIRECT_RECLAIM so we must clear GFP_RECLAIM
> after, not before.
> 
> Reported-by: Bing Jiao <bingjiao@google.com>
> Closes: https://lore.kernel.org/linux-mm/aXlKOxGGI9zne8sl@google.com/
> Fixes: 9933a0c8a539 ("mm/migrate: clear __GFP_RECLAIM to make the migration callback consistent with regular THP allocations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 2c3d489ecf51..ee533a4d38db 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2190,12 +2190,12 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
>  	}
>  
>  	if (folio_test_large(src)) {
> +		gfp_mask |= GFP_TRANSHUGE;
>  		/*
>  		 * clear __GFP_RECLAIM to make the migration callback
>  		 * consistent with regular THP allocations.
>  		 */
>  		gfp_mask &= ~__GFP_RECLAIM;
> -		gfp_mask |= GFP_TRANSHUGE;

I don't think this is right.

The Fixes: did it this way to disable kswapd for THP allocations,
while still allowing the customary direct reclaim. Maybe a better
comment would have been: /* GFP_TRANSHUGE has its own reclaim policy */

After your fix, direct reclaim isn't allowed either, which makes the
request unnecessarily wimpy.

The Closes: refers to reclaim that should be avoided during demotion.
But if this path is taken during demotion it will already not recurse
into direct reclaim due to PF_MEMALLOC.

So I don't see a bug in the existing code. But maybe the comment could
be clearer.

