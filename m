Return-Path: <stable+bounces-230513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPs6ByV4xWnw+QQAu9opvQ
	(envelope-from <stable+bounces-230513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:17:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83469339E6A
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 045FA3033385
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F4939F165;
	Thu, 26 Mar 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW7nMZlb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1639F182
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548977; cv=none; b=pjCY+eozZabunTaj6xK4DUwc+3pR1sAVNBV+LBettDiMNyc+mET5dtt21mlDTCyIk39t1cqth+7LgxAuTLouvxZa0+yf6Ci4ik9L8KoXAkame2iERBJ9oVxVlY61rzCXGAiB1RRBtc4I8mVdq5cQZk0vsPASOlrEkuMBKH4UHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548977; c=relaxed/simple;
	bh=M52i1j8C5ynp2V4Ht1RXbuQF8sNqDLKZ/XbPu6+erVo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl7/UYvaShGnvYGg7Wdo12aYk95djXrtufn/EZs+SYDvP/8bsrB50ytD+3LqT8ixtrGq4iANxoV6Ph3yUu0LjZV9TnkQ+Dd71+OKJA0UqeqLt4eGfP4qDbEYFC/tok0EpYcLhbyo2xJj9NzxMHW7NQ/2rx93fcL39ZuKrVcuULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW7nMZlb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2a5236811so632598e87.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774548974; x=1775153774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSyPhh3HmO6if4yslTgb3vQtjUM5HB1Rw12+bAg9VZI=;
        b=lW7nMZlbPpGBivuOyWmFBkc+q4oon4MqCRdcp5Wh8cQaMq0NEIqosirpn4XI4I3Yzo
         +rNTsLCWkDmT3Vx3uFuMwOPuniDF8zOuJ8sOcWKQm3HF2DULzuJXxXvluQ+7fKsis6t7
         X4x8njCi1JRF7hrE8gS9fDPsfqPtMSWYUFRpsbEaaHGajSXfFblZAAJx2sYEl3CduAOB
         a0N66rdhp7WBZnkoSPHA9INTSmLnyZD2NfQstiEFWmfvmk6/YMCcTK7mxyucgUdOH5ru
         wlHibc7lvEt9APQRM4ZR9wnMwlincQ4Xa1PYX/rmXdPw2mdtBFB1PbeKKmoHL7F0uLu5
         yv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548974; x=1775153774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSyPhh3HmO6if4yslTgb3vQtjUM5HB1Rw12+bAg9VZI=;
        b=FPyI+3gAhsamqZQMmgBTmoaG0f4iy1kBnvlcp77yHGcye2Zr6OzPvwmDsmAVBrb1L6
         7iDfGwIkjYga1KAKAv5a3bwUoZVlSWRc4qX8wCQrYXih6eubCsfV97T0y+mRIA1wIQFy
         Qaoc/OfWz6aY5avIk2ZblMoAYCw8OcD/XHi9+ugPIiMFPNPGNkU2HQ0heSlkPwLELAJE
         3vr4lLe/+Wc81ym9sX2h+NVW8tBfdutTT/NaE03g8GeCk30pg7wSWrKX8e6gyXILT41L
         4i4CoXBDdLdJ64aiFTafxOsuKbXiHgByyG8zn4xqzkqFX+gKYsv5L6fJ6dfuMg7Hlwf+
         1Oxg==
X-Forwarded-Encrypted: i=1; AJvYcCWxycl/34QDmBIVc/nb2ayGtZAuiuZ3GYVXnVY1m7Lw32vIRmxuDl0l0vdUlkXK00MM0EIVuIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypsVbBzXv+7SKJu4E54PvcJfMYODLRKEHR+41tstPea+MJ29Ci
	cotbVoPC5v9UCyJj+L11sFaSDa0DYc7cAlpnNydrFrPdM0et4kC5ngW5
X-Gm-Gg: ATEYQzy+PuYiMPLM3K8lz1W8mierR3hBycEdLbiejZEtU1PMuDioEkLUSBOhBT7ewo1
	spVIZPyfiXnvoptyVsaon+vcUCeB7fD629gParbQqbiDPoBLRAUxSu2Y9O2EAg6lG9y0SOzA3RU
	wp8iKSbXYI2gnzDszrImQJhv+rkrq3NZ83eGVMCD292yZ5U6U2L3QzEdQRMwcJ3cnfcNWVj5fyK
	r6OtjMjMom1QtBRyAKF8/UVZMD1gnW0tKei5wgl+ClRoh7FFRaqSaNU0QOweXUDvIcL/hKLWaKr
	AoFhueglYrmlDcsI5nl5pROyRpITi7ohWuYfWenNCqiX4v0vCeK/rBV13xMGzFKohcXXCA/yvbC
	HzSgckhsxiDPE8Hn91KBkZD55b0N5el83r9fFI+V6JxZjKcbS9Nmo28TwZM2E+iJ0
X-Received: by 2002:a05:6512:31d2:b0:5a2:874e:8a1e with SMTP id 2adb3069b0e04-5a29b98f370mr3614846e87.26.1774548973140;
        Thu, 26 Mar 2026 11:16:13 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a068f8a3sm757853e87.63.2026.03.26.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:16:12 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 26 Mar 2026 19:16:10 +0100
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>
Cc: Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org, kasan-dev@googlegroups.com,
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>, ryan.roberts@arm.com
Subject: Re: [REGRESSION] slab: replace cpu (partial) slabs with sheaves
Message-ID: <acV36oPNFMgL4puz@milan>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <afe9ba0a-1924-42a8-a9c5-34eec709f883@arm.com>
 <ed58493b-0369-4729-bcf7-bc89f72a7913@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed58493b-0369-4729-bcf7-bc89f72a7913@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230513-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arm.com,suse.cz,oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83469339E6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 03:42:02PM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/26/26 13:43, Aishwarya Rambhadran wrote:
> > Hi Vlastimil, Harry,
> 
> Hi!
> 
> > We have observed few kernel performance benchmark regressions,
> > mainly in perf & vmalloc workloads, when comparing v6.19 mainline
> > kernel results against later releases in the v7.0 cycle.
> > Independent bisections on different machines consistently point
> > to commits within the slab percpu sheaves series. However, towards
> > the end of the bisection, the signal becomes less clear, so it's
> > not yet certain which specific commit within the series is the
> > root cause.
> > 
> > The workloads were triggered on AWS Graviton3 (arm64) & AWS Intel
> > Sapphire Rapids (x86_64) systems in which the regressions are
> > reproducible across different kernel release candidates.
> > (R)/(I) mean statistically significant regression/improvement,
> > where "statistically significant" means the 95% confidence
> > intervals do not overlap”.
> > 
> > Below given are the performance benchmark results generated by
> > Fastpath Tool, for different kernel -rc versions relative to the
> > base version v6.19, executed on the mentioned SUTs. The perf/
> > syscall benchmarks (execve/fork) regress consistently by ~6–11% on
> > both arm64 and x86_64 across v7.0-rc1 to rc5, while vmalloc
> > workloads show smaller but stable regressions (~2–10%), particularly
> > in kvfree_rcu paths.
> > 
> > Regressions on AWS Intel Sapphire Rapids (x86_64) :
> 
> The table formatting is broken for me, can you resend it please? Maybe a
> .txt attachment would work better.
> 
> > +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> > | Benchmark       | Result Class            |   6-19-0 (base) |  
> >   7-0-0-rc1 |   7-0-0-rc2 |  7-0-0-rc2-gaf4e9ef3d784 |   7-0-0-rc3 |  
> >   7-0-0-rc4 |   7-0-0-rc5 |
> > +=================+==========================================================+=================+=============+=============+===========================+=============+=============+=============+
> > | micromm/vmalloc | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 
> > (usec) |       262605.17 |      -4.94% |      -7.48% |             (R) 
> > -8.11% |      -4.51% |      -6.23% |      -3.47% |
> > |                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 
> > (usec) |       253198.67 |      -7.56% | (R) -10.57% |            (R) 
> > -10.13% |  (R) -7.07% |      -6.37% |      -6.55% |
> > |                 | pcpu_alloc_test: p:1, h:0, l:500000 (usec)           
> >   |       197904.67 |      -2.07% |      -3.38% |             -2.07% |  
> >      -2.97% |  (R) -4.30% |      -3.39% |
> > |                 | random_size_align_alloc_test: p:1, h:0, l:500000 
> > (usec)  |      1707089.83 |      -2.63% |  (R) -3.69% |               
> > (R) -3.25% |  (R) -2.87% |      -2.22% |  (R) -3.63% |
> > +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> > | perf/syscall    | execve (ops/sec)            |         1202.92 |  (R) 
> > -7.15% |  (R) -7.05% |         (R) -7.03% |  (R) -7.93% |  (R) -6.51% |  
> > (R) -7.36% |
> > |                 | fork (ops/sec)            |          996.00 |  (R) 
> > -9.00% | (R) -10.27% |         (R) -9.92% | (R) -11.19% | (R) -10.69% | 
> > (R) -10.28% |
> > +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> > 
> > Regressions on AWS Graviton3 (arm64) :
> > +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> > | Benchmark       | Result Class            |   6-19-0 (base) |  
> >   7-0-0-rc1 |   7-0-0-rc2 |  7-0-0-rc2-gaf4e9ef3d784 |   7-0-0-rc3 |  
> >   7-0-0-rc4 |   7-0-0-rc5 |
> > +=================+==========================================================+=================+=============+=============+===========================+=============+=============+=============+
> > | micromm/vmalloc | fix_size_alloc_test: p:1, h:0, l:500000 (usec)      
> >       |       320101.50 |  (R) -4.72% |  (R) -3.81% |               (R) 
> > -5.05% |      -3.06% |      -3.16% |  (R) -3.91% |
> > |                 | fix_size_alloc_test: p:4, h:0, l:500000 (usec)      
> >       |       522072.83 |  (R) -2.15% |      -1.25% |               (R) 
> > -2.16% |  (R) -2.13% |      -2.10% |      -1.82% |
> > |                 | fix_size_alloc_test: p:16, h:0, l:500000 (usec)      
> >      |      1041640.33 |      -0.50% |  (R) -2.04% |                 
> > -1.43% |      -0.69% |      -1.78% |  (R) -2.03% |
> > |                 | fix_size_alloc_test: p:256, h:1, l:100000 (usec)    
> >       |      2255794.00 |      -1.51% |  (R) -2.24% |             (R) 
> > -2.33% |      -1.14% |      -0.94% |      -1.60% |
> > |                 | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 
> > (usec) |       343543.83 |  (R) -4.50% |  (R) -3.54% |             (R) 
> > -5.00% |  (R) -4.88% |  (R) -4.01% |  (R) -5.54% |
> > |                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 
> > (usec) |       342290.33 |  (R) -5.15% |  (R) -3.24% |             (R) 
> > -3.76% |  (R) -5.37% |  (R) -3.74% |  (R) -5.51% |
> > |                 | random_size_align_alloc_test: p:1, h:0, l:500000 
> > (usec)  |      1209666.83 |      -2.43% |      -2.09% |                 
> >    -1.19% |  (R) -4.39% |      -1.81% |      -3.15% |
> > +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> > | perf/syscall    | execve (ops/sec)            |         1219.58 |      
> >         |  (R) -8.12% |         (R) -7.37% |  (R) -7.60% |  (R) -7.86% 
> > |  (R) -7.71% |
> > |                 | fork (ops/sec)            |          863.67 |        
> >       |  (R) -7.24% |         (R) -7.07% |  (R) -6.42% |  (R) -6.93% |  
> > (R) -6.55% |
> > +-----------------+----------------------------------------------------------+-----------------+-------------+-------------+---------------------------+-------------+-------------+-------------+
> > 
> > 
> > The details of latest bisections that were carried out for the above
> > listed regressions, are given below :
> > -Graviton3 (arm64)
> >   good: v6.19 (05f7e89ab973)
> >   bad:  v7.0-rc2 (11439c4635ed)
> >   workload: perf/syscall (execve)
> >   bisected to: f1427a1d6415 (“slab: make percpu sheaves compatible with
> >   kmalloc_nolock()/kfree_nolock()”)
> > 
> > -Sapphire Rapids (x86_64)
> >   good: v6.19 (05f7e89ab973)
> >   bad:  v7.0-rc3 (1f318b96cc84)
> >   workload: perf/syscall (fork)
> >   bisected to: f1427a1d6415 (“slab: make percpu sheaves compatible with
> >   kmalloc_nolock()/kfree_nolock()”)
> > 
> > -Graviton3 (arm64)
> >   good: v6.19 (05f7e89ab973)
> >   bad:  v7.0-rc3 (1f318b96cc84)
> >   workload: perf/syscall (execve)
> >   bisected to: f3421f8d154c (“slab: introduce percpu sheaves bootstrap”)
> 
> Yeah none of these are likely to introduce the regression.
> We've seen other reports from e.g. lkp pointing to later commits that remove
> the cpu (partial) slabs. The theory is that on benchmarks that stress vma
> and maple node caches (fork and execve are likely those), the introduction
> of sheaves in 6.18 (for those caches only) resulted in ~doubled percpu
> caching capacity (and likely associated performance increase) - by sheaves
> backed by cpu (partial) slabs,. Removing the latter then looks like a
> regression in isolation in the 7.0 series.
> 
> A regression of vmalloc related to kvfree_rcu might be new. Although if it's
> kvfree_rcu() of vmalloc'd objects, it would be weird. More likely they are
> kvmalloc'd but small enough to be actually kmalloc'd? What are the details
> of that test?
> 
static int
kvfree_rcu_2_arg_vmalloc_test(void)
{
	struct test_kvfree_rcu *p;
	int i;

	for (i = 0; i < test_loop_count; i++) {
		p = vmalloc(1 * PAGE_SIZE);
		if (!p)
			return -1;

		p->array[0] = 'a';
		kvfree_rcu(p, rcu);
	}

	return 0;
}

static bool kfree_rcu_sheaf(void *obj)
{
	struct kmem_cache *s;
	struct slab *slab;

	if (is_vmalloc_addr(obj))
		return false;

	slab = virt_to_slab(obj);
	if (unlikely(!slab))
		return false;

	s = slab->slab_cache;
	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
		return __kfree_rcu_sheaf(s, obj);

	return false;
}

it does not go via sheaf since it is a vmalloc address.

--
Uladzislau Rezki

