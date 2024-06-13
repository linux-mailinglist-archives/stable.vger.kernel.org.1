Return-Path: <stable+bounces-50517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE643906AF8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34821C218E7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55813C9C0;
	Thu, 13 Jun 2024 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhu8OZoS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21279605C6;
	Thu, 13 Jun 2024 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278087; cv=none; b=E6NOdr8CY3PpQ4ps/HZ52C3Snw+YU0SBU4m1cr7jd/6Xdwc8+1+7IVE0dqDOgxqfMcqsqmZqBLJzE1qlL/O/sIGksV0jHGIVAcAouBc4mzlYVSQbeNMOKAAjLsdVzJZu+xRfVG5mNpT0p/JnfEuq9XFDtLvPCSfGdpWn4KRw1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278087; c=relaxed/simple;
	bh=xXc6y8gMVk1CtBLWX7VAQjfxosu5Yp6VJwUSaAut9Y4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4JfpSAcXeuN8Oiuo7knMPTz1oqnZpHHO/MrLu4tGFYeJdwQsY8RlIQHvqwIXt9mD/+nwY/qD1nU7x5DrmSwDP8eG1zE+d8/tuToQpndasYVWprrA16xMRGo+6pbFVcLvjNIsvyMY0rxe3HNe5qJdW646mMgY6GLfRbqa9qOE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xhu8OZoS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso8597931fa.2;
        Thu, 13 Jun 2024 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278084; x=1718882884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RZdlCyDwmh1iqITvyeSYDfgDTIDdV6MRnysRaws4TrY=;
        b=Xhu8OZoSLdMc48QP8yiXrrMFNnQ3MAoEOgA4Z36yRhf3UeuB3i5Zwx3eo3RMtNw29B
         5w0tYCmomzrCyqHVNE6ZkHJz01wz3rwuA/9qpvFBLPuN2jcl/ppjy7CBKqTi4BoBKRXe
         HI2P+lqn8J/e07S2S0EmhmOulL/jVKvn8bjGjywnEXgluqlwoOfAWfqS7qB2QmCfmfrF
         5x/9rl7T+pWvgbdGC2OxXuHbBQk78kcDOllre1FJdHAYRQ60irHOnI8KmohwdWHTDrXt
         GBgIeIKoa5OeZ69uKEQ+8sJ60vaAcmJO2LGHLnTWAe373MzHm09o5EvdvzwFbq0dgyJg
         4iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278084; x=1718882884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZdlCyDwmh1iqITvyeSYDfgDTIDdV6MRnysRaws4TrY=;
        b=VyuTqRGhAoBHZWvoZVumV9x74HQilWSvO9QABA4w0DRYVrVCT6nku0lN5U2T1nV26D
         5eOmsFgi1mOMbB3egCHz4EjVyEGwjHt47ivGFuRyUN+s304DBAf1lBubwalsTrYN6LO9
         VViqYv9LMIQt0dIP2dSvNnGVOWI1HO3qWI34orUzvoZvmcHLZZRJwjqo9sAaaOCjetJm
         cxIXYhb2IFK9n1wRMpPbBQOseXBWkijtIEPLdRS3eyWLsun4rp2zt4XMX00ewlE6RHge
         3Rz6MJ8UZCdY53/Q4tOzWYNCi8lBaxRBmlvlcgNMR8rgWbn9EBhZanCwaPaAygybuckW
         HpGA==
X-Forwarded-Encrypted: i=1; AJvYcCXNyeoMSbcWTvnGo0CZpE1uwVFxMXszU24ZQJ62610++9u71zrimEUM+1F+gptvW6zuNZF/HMGVqxLmsQcZk7+W6SzaP8IP5sAF4DKueeIKl6oxa2C8vWXZlvWUDdqVGrm5SV0z
X-Gm-Message-State: AOJu0YxyWI2QJXKSDgqyWy2lonUmD2PmkQqBxymMnO3ex6NPHsHDBFsx
	uHoKS1ToJddpQgVaqJaKswPXUaPRbXxaScUrB65eHm5IXPzOumfLgA9FidmL
X-Google-Smtp-Source: AGHT+IFsF5mb6Zhamza0xwk8QqfY5bzuu3KRMD6jmBXNETDu71+QYq1tJv9fBnl1yL8+QcS6Ew6J0w==
X-Received: by 2002:a2e:9dca:0:b0:2eb:ef0f:8699 with SMTP id 38308e7fff4ca-2ebfc8e494bmr28305131fa.26.1718278083942;
        Thu, 13 Jun 2024 04:28:03 -0700 (PDT)
Received: from pc636 (host-90-233-218-141.mobileonline.telia.com. [90.233.218.141])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c785d4sm1812931fa.75.2024.06.13.04.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:28:03 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 13 Jun 2024 13:28:00 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZmrXwABpPPoK0bIp@pc636>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
 <ZmiUgPDjzI32Cqr9@pc636>
 <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
 <ZmmGHhUDk5PqSHPB@pc636>
 <ZmqwvtZQwYLNYf+V@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmqwvtZQwYLNYf+V@MiWiFi-R3L-srv>

On Thu, Jun 13, 2024 at 04:41:34PM +0800, Baoquan He wrote:
> On 06/12/24 at 01:27pm, Uladzislau Rezki wrote:
> > On Wed, Jun 12, 2024 at 10:00:14AM +0800, Zhaoyang Huang wrote:
> > > On Wed, Jun 12, 2024 at 2:16 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > >
> > > > > Sorry to bother you again. Are there any other comments or new patch
> > > > > on this which block some test cases of ANDROID that only accept ACKed
> > > > > one on its tree.
> > > > >
> > > > I have just returned from vacation. Give me some time to review your
> > > > patch. Meanwhile, do you have a reproducer? So i would like to see how
> > > > i can trigger an issue that is in question.
> > > This bug arises from an system wide android test which has been
> > > reported by many vendors. Keep mount/unmount an erofs partition is
> > > supposed to be a simple reproducer. IMO, the logic defect is obvious
> > > enough to be found by code review.
> > >
> > Baoquan, any objection about this v4?
> > 
> > Your proposal about inserting a new vmap-block based on it belongs
> > to, i.e. not per-this-cpu, should fix an issue. The problem is that
> > such way does __not__ pre-load a current CPU what is not good.
> 
> With my understand, when we start handling to insert vb to vbq->xa and
> vbq->free, the vmap_area allocation has been done, it doesn't impact the
> CPU preloading when adding it into which CPU's vbq->free, does it? 
> 
> Not sure if I miss anything about the CPU preloading.
> 
Like explained below in this email-thread:

vb_alloc() inserts a new block _not_ on this CPU. This CPU tries to
allocate one more time and its free_list is empty(because on a prev.
step a block has been inserted into another CPU-block-queue), thus
it allocates a new block one more time and which is inserted most
likely on a next zone/CPU. And so on.

See:

<snip vb_alloc>
...
        rcu_read_lock();
	vbq = raw_cpu_ptr(&vmap_block_queue); <- Here it is correctly accessing this CPU 
	list_for_each_entry_rcu(vb, &vbq->free, free_list) {
		unsigned long pages_off;
...
<snip vb_alloc>

<snip new_vmap_block>
...
       vbq = addr_to_vbq(va->va_start); <- Here we insert based on hashing, i.e. not to this CPU-block-queue
       spin_lock(&vbq->lock);
       list_add_tail_rcu(&vb->free_list, &vbq->free);
       spin_unlock(&vbq->lock);
...
<snip new_vmap_block>

Thanks!

--
Uladzislau Rezki

