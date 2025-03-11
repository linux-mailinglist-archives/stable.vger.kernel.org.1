Return-Path: <stable+bounces-124060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270A2A5CC24
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F46177A5C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F922627E6;
	Tue, 11 Mar 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HxoaFUfb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE12620E1
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714193; cv=none; b=Y50e+t3d9QPl/1N1h567b/IMb7GJWgf3EbzE22WJPwn4S8UnlwwmYOC/1DpZfUUL90fQj5+k1IvMmJl/ZnosbUPBOBkxRyBEZq0bibgeH82VswCVtjC/orxcirfS/Vi8SHHp/qG6xE9/3iO7nWLYT76Sm2pZdH4QhMSx0bttNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714193; c=relaxed/simple;
	bh=bz4i3vwBWiRTM/4WsD2Sgt4Gf4wuWjf4iqMscKzae8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLJT5qO8unyHCMruxJpJX5DcVpdSIRmjK0P8Xsad9FiICHUkpwDUuzFsaWBHMGfXduQbDW//O0fLebBI3wHzuWfT2tsYmr5sewK4CGyimF4nHMrfuBGGkz8Y5L4N0eHW/eLgswSuhPpolrtqsHFcRF2o9JWXNLPUZ5Vqj2xYNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HxoaFUfb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c54a9d3fcaso300136885a.2
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741714190; x=1742318990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InkYCZuBh6NtBXn1ZPIqBAGqEuGWZOKnkIkfR4YnU14=;
        b=HxoaFUfbrZUrQq+54bTOc/oqToROTePvuagj1D5v+cyKComqRU14NdCmShFRTPdOVp
         a7TMb4e+swXMqAAEVmHtr+8YEBCgExulU+c/qiHzRvUIeoY4+nO6pFWTJVaLcpijsr2a
         afm0tuR4i1wOTqEuHpOqny5/WpHoMS2D/FEuVBD5kcES6caqdXfQWEvRKn1KtG3TZfzf
         DbNjEEmvJWJgfYzgPNzAVZ4b5cQ9KKi4Jx80+3mgNJSPH3yFR08oP6JJezc0H1THqYNV
         t+RMxhNa4bhz8rGiFo4e75wXaZFJknNFMIzBr3jMt1HeOfXXIUBu8jl1WubAjWU1afbn
         aFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714190; x=1742318990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InkYCZuBh6NtBXn1ZPIqBAGqEuGWZOKnkIkfR4YnU14=;
        b=PQCbtTF053WTZH92vU/0KuQNu6U0f4stu4jGdQ+7Su/cLjQ/Yq095RR9ow87GM3YD9
         TrD+TqrFvFauI/GkmpoiOE8sc14XdJHUI+0YKDFMqFV3IwG4CU9Rl8BXrcXJ+1+tqVVx
         bYsFJI6e9B+RcddRQy+Kbc9acUuZDcYbU3ew+7QG/phaKHAaOFMkK3V9AFEJdOi610Er
         gg0IOei/nX0MiPZigcV/uccb5WDNvH3x1nVAAa9y7Bqr0SuldWyq/1OwKge4zJtaKSW+
         pbNBHXuXNVaI8GyEVF9qx/TCme67KohcMkWBbCni/r/E0L72ms+aWEfIMEWsPAxrUf8x
         aIFA==
X-Forwarded-Encrypted: i=1; AJvYcCX+I/HQNhevI63YmsksIZtWcf0A3eZnjO2AsgeqJnLIj8t229BW8BrEoNd2KFU8JNAeC7gwpGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfr1sklsdY5Sy02hg/i5cPnxMEgHtU9DgGQ3095qzHUwxR2jKT
	umVj5pTSA5Tn9MygIvGc2zHx95cwbaKj79KQPbpOxjLuZOMCrc1Sbpd2x5rkKE0=
X-Gm-Gg: ASbGncvlYuwsHdnllQYgYVaXB0CaxA7lEc9XtKfaipdo2dvWjMTw6D1RLZkkXsf8myq
	rmdBn/SrGn40Bpkv8J/UL4KSny+Ggxeew7mvqmxmd0FJDj9EbP0fVhmW24AmVjLcStJtZ5c0zvJ
	7UmLOH6dUBBTP/CuH2yrs28O0qODdEB/7hR7o3ghn7EihGihl5V6Wuc4JHzt733eUDyUQVKzwjE
	H/P7cYnhzl/vgiufcFFEvyOqK3bJXQXIkyK9Gh6sxZ1ywv7Fufp0OWRbIe6pJveXLKgp3ybI7p3
	KI286AVrRnu37u6kSZaN2hJerGIJDcQHdTX1KaDUDEk=
X-Google-Smtp-Source: AGHT+IHsp6QUFpMLzg6RFZfT24l93gao05k4Ok3I8RY1SmxsMToyPGVIKqWah9c5Rc1/JLuYkzCUNA==
X-Received: by 2002:a05:620a:26a3:b0:7c5:5585:6c83 with SMTP id af79cd13be357-7c5558573cdmr1464793185a.54.1741714188560;
        Tue, 11 Mar 2025 10:29:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f715b718sm74299356d6.91.2025.03.11.10.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:29:47 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:29:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: drain obj stock on cpu hotplug teardown
Message-ID: <20250311172947.GC1211411@cmpxchg.org>
References: <20250310230934.2913113-1-shakeel.butt@linux.dev>
 <20250311153032.GB1211411@cmpxchg.org>
 <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>

On Tue, Mar 11, 2025 at 08:57:54AM -0700, Shakeel Butt wrote:
> On Tue, Mar 11, 2025 at 11:30:32AM -0400, Johannes Weiner wrote:
> > On Mon, Mar 10, 2025 at 04:09:34PM -0700, Shakeel Butt wrote:
> > > Currently on cpu hotplug teardown, only memcg stock is drained but we
> > > need to drain the obj stock as well otherwise we will miss the stats
> > > accumulated on the target cpu as well as the nr_bytes cached. The stats
> > > include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
> > > addition we are leaking reference to struct obj_cgroup object.
> > > 
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: <stable@vger.kernel.org>
> > 
> > Wow, that's old. Good catch.
> > 
> > > ---
> > >  mm/memcontrol.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 4de6acb9b8ec..59dcaf6a3519 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1921,9 +1921,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
> > >  static int memcg_hotplug_cpu_dead(unsigned int cpu)
> > >  {
> > >  	struct memcg_stock_pcp *stock;
> > > +	struct obj_cgroup *old;
> > > +	unsigned long flags;
> > >  
> > >  	stock = &per_cpu(memcg_stock, cpu);
> > > +
> > > +	/* drain_obj_stock requires stock_lock */
> > > +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > +	old = drain_obj_stock(stock);
> > > +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> > > +
> > >  	drain_stock(stock);
> > > +	obj_cgroup_put(old);
> > 
> > It might be better to call drain_local_stock() directly instead. That
> > would prevent a bug of this type to reoccur in the future.
> 
> The issue is drain_local_stock() works on the local cpu stock while here
> we are working on a remote cpu cpu which is dead (memcg_hotplug_cpu_dead
> is in PREPARE section of hotplug teardown which runs after the cpu is
> dead).
> 
> We can safely call drain_stock() on remote cpu stock here but
> drain_obj_stock() is a bit tricky as it can __refill_stock() to local cpu
> stock and can call __mod_objcg_mlstate to flush stats. Both of these
> requires irq disable for NON-RT kernels and thus I added the local_lock
> here.
> 
> Anyways I wanted a simple fix for the backports and in parallel I am
> working on cleaning up all the stock functions as I plan to add multi
> memcg support.

True, it can be refactored separately.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

