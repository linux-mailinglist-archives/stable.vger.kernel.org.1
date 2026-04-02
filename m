Return-Path: <stable+bounces-233051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJOMD5yVzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:13:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9545638BB03
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D963036764
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6553ECBF7;
	Thu,  2 Apr 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHOsIhaG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F223E95A3
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145955; cv=none; b=hXuDAZw3iERiUAZ6zRRoZLTb8ZoBilbtBtIQ1R0IiyQh6BqhDuxOrXKj9oQ68b+/syoPfnZzhn/Is97ttQ/LcT3Az3x8O0o8KCR/w6UDsXlaNSda5tpJhub1yLYGLcJId7uOQIJEN5gejVk8w5y7PC2tVrBZTl9ZFjH9MMoiYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145955; c=relaxed/simple;
	bh=EKWeK6O4/zG/Ra04kfn17P+7eqy5Udvr8t9NRdcLQ0M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc6+IhFuY8Fs01K4mi/StSA2k8DMRURQe8W+Qr4UDJKa090W8LA/ANp858pwth6+xupyw8mIRHGHy0hU+FFKtqHo+JWs/3AQqq8P6s0pstKF0ISiQWSK/uPrE26wL/H6uQtrmDbh6YzLRF4Oxm/CcXSXezy55a1mQDF6un4M1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHOsIhaG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38cbb1ad0b6so9136471fa.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775145951; x=1775750751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMeE4O3tYspnb1+uRYcEC9JhynEoZ/6Jf/EDgOFDWZk=;
        b=UHOsIhaG0dRlsyOfAsz6syvIuwKCrUvIZRUr2F6nLWxgmWmHYrk0HyXOrxWJkbtcR4
         gnOqDNF1J0PBnFIU2s4gwnx0LIEfHAL6o8HimcyQYkGmSYZIdLH/eMMIuMN25QAWwOfX
         b9+NvP9oXcs0+U4IGIrUZHftJ17P5WWJdJpcJKTor5awb8nragJlx6QNQqenRZFcBlBU
         3Zjp/yLn/quF3tJNvULJxsqXebpn1h4t9hpEB5IdcPWwH2RrnGlTQjSMQI8gN3s15wtm
         YB4Lx/Y1lv1SGMJX+fa0e+ngvI4h3645keow/GX+5u/PI3Ey3t/LWr9m8kgXmc6RBZfP
         HMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145951; x=1775750751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMeE4O3tYspnb1+uRYcEC9JhynEoZ/6Jf/EDgOFDWZk=;
        b=sX4teWTmPA4HRAyPFRcDy2fTLTcuw2srRzRBAHbuQcmK2IIeRBEjtiGeex/EzxSkex
         VFEHn6YAWvA+ySdargfRWB9C5FIzkfgGpM8BazVYMa/gMBbH82D4sjL70aKgnOWj6jtb
         tMLbzWZXpV1JH5lwTgZ1I1JNBBTtGkYKKJ5pHFqcuE2az8r3N/iMUAByBr6b+CNUCIRq
         yhaeA29YMytyxlBSyF4VKRva+ZDiQay201680NP2mp4mQzwu/gr0lQEoT29AWBrP/+ih
         DCfUIbS3JWhr36JCUGHX902FHe4EkrzdZr8yrfzA3O3IoAK6z2c2vPUqKeC9eZ1Saqyk
         HF9g==
X-Forwarded-Encrypted: i=1; AJvYcCUnS78oM+6kZ5861im+wERRq2Cfqqc4EmJxXVv+hRhZVgPUixYEyDQgQVArWNTfI+guunSZmV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1SF+gVegEXkd2o3eANiDm80Z3pKFg3L683tA8gkNexH/n8i6+
	ueXuDQFfpNHMXTPCyuxPg18lIF2lI8SEdW4R2wHIXAar2HGo/iUfLwO0
X-Gm-Gg: ATEYQzwP8LBUejM0DGo6d1cEACnECSt+ilvGBCHaS+w9slhCggo+NaUf2jdHKTWAAJb
	ZBWi+g8jOBTYpF2hBe28q38DRjgmWQuMvy0XQ+Jbpu2FAV7OWKecSx1H76xjoe5/5mojhRUKbe6
	1Zss5wNMs57JSgkB2iFRyYEu0wscJloSqT3ZiH+WLYxYNgoOdr7gQ6hxMdsNr/itN40U+7LjsVa
	jub4Ik3q4J0g9p5caRHwN2iw4gEXhpOW9IKnBRlmQW1C5eulWOoa12V2yCZLD3tWWFOt4Zw9lWf
	jtqdPNJuML3A/SgzOELow8Bz+bm5jZjYh/1aa9Zi1TQC9Dk+3ogPfh6LAnM8BxeWzJf5T7KmuLe
	EokYyYfMo3DC2EL9CiBIki2l1R1mX79fwXWsQ/qba0VCt/ECwwlZCvpYZQF2PxyaI
X-Received: by 2002:a05:651c:3242:b0:38b:e048:57c with SMTP id 38308e7fff4ca-38cc2f3898amr32309411fa.7.1775145950759;
        Thu, 02 Apr 2026 09:05:50 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd1fa77c8sm6209681fa.6.2026.04.02.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:05:50 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 2 Apr 2026 18:05:48 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	lirongqing <lirongqing@baidu.com>
Subject: Re: [PATCH v3] mm/vmalloc: Use dedicated unbound workqueues for vmap
 drain
Message-ID: <ac6T3MS23Up8LJHZ@milan>
References: <20260331202352.879718-1-urezki@gmail.com>
 <aczpyc7sxzBL4MQn@fedora>
 <ac22zMBjWgQnLfpI@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac22zMBjWgQnLfpI@fedora>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,vger.kernel.org,baidu.com];
	TAGGED_FROM(0.00)[bounces-233051-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 9545638BB03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 08:22:36AM +0800, Baoquan He wrote:
> On 04/01/26 at 05:47pm, Baoquan He wrote:
> > On 03/31/26 at 10:23pm, Uladzislau Rezki (Sony) wrote:
> > > drain_vmap_area_work() function can take >10ms to complete
> > > when there are many accumulated vmap areas in a system with
> > > high CPU count, causing workqueue watchdog warnings when run
> > > via schedule_work():
> > > 
> > >   workqueue: drain_vmap_area_work hogged CPU for >10000us
> > > 
> > > Move the top-level drain work to a dedicated WQ_UNBOUND
> > > workqueue so the scheduler can run this background work
> > > on any available CPU, improving responsiveness. Use the
> > > WQ_MEM_RECLAIM to ensure forward progress under memory
> > > pressure.
> > > 
> > > Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
> > > workqueue. This allows drain_vmap_work to wait for helpers
> > > completion without creating dependency on the same rescuer
> > > thread and avoid a potential parent/child deadlock.
> > ...snip...  
> > > @@ -2385,29 +2390,31 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
> > >  		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
> > >  		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
> > >  
> > > -		for_each_cpu(i, &purge_nodes) {
> > > -			vn = &vmap_nodes[i];
> > > +		for_each_vmap_node(vn) {
> > > +			vn->work_queued = false;
> > > +
> > > +			if (list_empty(&vn->purge_list))
> > > +				continue;
> > >  
> > >  			if (nr_purge_helpers > 0) {
> > >  				INIT_WORK(&vn->purge_work, purge_vmap_node);
> > > +				vn->work_queued = schedule_drain_vmap_work(
> > > +					READ_ONCE(drain_vmap_helpers_wq), &vn->purge_work);
> > 
> > The new schedule_drain_vmap_work() could submit all purge_work on one
> > CPU, do we need use queue_work_on(cpu, wq, work) instead?
> 
> Forgot the specified WQ_UNBOUND on alloc_workqueue(), sorry for the
> noise. Then this patch looks great to me.
> 
Right. When a worker is created for UNBOUND queue, its cpumask is
updated so it can be awaken on any CPU. Scheduler decides.

--
Uladzislau Rezki

