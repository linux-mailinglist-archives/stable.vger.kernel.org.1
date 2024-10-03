Return-Path: <stable+bounces-80614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929098E7C7
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 02:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29F71F2461C
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 00:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3826A8C1F;
	Thu,  3 Oct 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWOU9aCi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7EDF51;
	Thu,  3 Oct 2024 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915735; cv=none; b=KzDXbYqnsdA0kls4ye+WHhPG68huDdfXKGLxmAECZLgSddd6k6uGuCuY3fYLqmtJ0XacWR2P/GgXsj7bweVrDXRW02uxKs0kL1aSVHkIqkP24WHqEEVvRwtcYGL8VrzyEe9xpQjznon9X7WEsdQsF2kBa4ZNSzL31ZLPCDvNNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915735; c=relaxed/simple;
	bh=9Z63A4UwMPg7h2BjcWTLocAQBrgxW8vXstQE/Guqqi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqjDddlYFTuy7Ufyr0wAWOBc1flZ+IgoksZwABQ2bHYjwAjBRhS0fPj9cXvj+JtMx4ATjZKyJ8BBIy3PHas51ndyELoizqjIiVHkXClhEVkxrfygzg85FlvNcdcgFsxyDstAaBEimGsTWbBaDM9QLkJbhxL6mCBGmUHYBXcGzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWOU9aCi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727915733; x=1759451733;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=9Z63A4UwMPg7h2BjcWTLocAQBrgxW8vXstQE/Guqqi8=;
  b=JWOU9aCi48vlB6EtbQS51QWbLB+NOsXV49EltCou+DpwIMj9+8OVktTv
   DU6hqs7H3HdaQkalO8UheyCmxCQn+ckhEmXG2O6iXQrtEpbotbZ7jPx/b
   fCiY19nfgHu2BkgQsOBuU2qWJ6DlbcSymT9/8B40mw7Hr4AgZZ5vJFYr2
   TnL76SExADIDtOrvZ6urboky+TI1OcgboCDhZhUhssknoxcKNQVm/+gGX
   6Q2PBLR5wSJVb/Jq+DjKVe8uNJHUHc2n3mrFB2AhUjrcNiPq4qhdD6YyA
   UZ7QDsg5/KlzFGCiXiqpW/cW7xfdqtDtqesNKJGP6L8zMKuzu/8XwwTEN
   g==;
X-CSE-ConnectionGUID: fpaMjLVARoeeg/UjyH3mAQ==
X-CSE-MsgGUID: BrPkpwc6TmKbRbWNR4bLAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37694043"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="37694043"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:35:23 -0700
X-CSE-ConnectionGUID: z1ZzhR+/RTubqKTYjKGlDg==
X-CSE-MsgGUID: qKKNOiHpRLOzWaZqqA8d4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="73859316"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:35:13 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  chrisl@kernel.org,  david@redhat.com,
  hannes@cmpxchg.org,  hughd@google.com,  kaleshsingh@google.com,
  kasong@tencent.com,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  liyangouwen1@oppo.com,  mhocko@suse.com,  minchan@kernel.org,
  sj@kernel.org,  stable@vger.kernel.org,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  yosryahmed@google.com,
  yuzhao@google.com
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
In-Reply-To: <20241002015754.969-1-21cnbao@gmail.com> (Barry Song's message of
	"Wed, 2 Oct 2024 09:57:54 +0800")
References: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20241002015754.969-1-21cnbao@gmail.com>
Date: Thu, 03 Oct 2024 08:31:40 +0800
Message-ID: <87ikuani1f.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Hi, Barry,
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >> >
>> >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
>> >> >> > introduced an unconditional one-tick sleep when `swapcache_prepa=
re()`
>> >> >> > fails, which has led to reports of UI stuttering on latency-sens=
itive
>> >> >> > Android devices. To address this, we can use a waitqueue to wake=
 up
>> >> >> > tasks that fail `swapcache_prepare()` sooner, instead of always
>> >> >> > sleeping for a full tick. While tasks may occasionally be woken =
by an
>> >> >> > unrelated `do_swap_page()`, this method is preferable to two sce=
narios:
>> >> >> > rapid re-entry into page faults, which can cause livelocks, and
>> >> >> > multiple millisecond sleeps, which visibly degrade user experien=
ce.
>> >> >>
>> >> >> In general, I think that this works. =C2=A0Why not extend the solu=
tion to
>> >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_asyn=
c()
>> >> >> too? =C2=A0We can call wake_up() when we clear SWAP_HAS_CACHE. =C2=
=A0To avoid
>> >> >
>> >> > Hi Ying,
>> >> > Thanks for your comments.
>> >> > I feel extending the solution to __read_swap_cache_async() should b=
e done
>> >> > in a separate patch. On phones, I've never encountered any issues r=
eported
>> >> > on that path, so it might be better suited for an optimization rath=
er than a
>> >> > hotfix?
>> >>
>> >> Yes. =C2=A0It's fine to do that in another patch as optimization.
>> >
>> > Ok. I'll prepare a separate patch for optimizing that path.
>>
>> Thanks!
>>
>> >>
>> >> >> overhead to call wake_up() when there's no task waiting, we can us=
e an
>> >> >> atomic to count waiting tasks.
>> >> >
>> >> > I'm not sure it's worth adding the complexity, as wake_up() on an e=
mpty
>> >> > waitqueue should have a very low cost on its own?
>> >>
>> >> wake_up() needs to call spin_lock_irqsave() unconditionally on a glob=
al
>> >> shared lock. =C2=A0On systems with many CPUs (such servers), this may=
 cause
>> >> severe lock contention. =C2=A0Even the cache ping-pong may hurt perfo=
rmance
>> >> much.
>> >
>> > I understand that cache synchronization was a significant issue before
>> > qspinlock, but it seems to be less of a concern after its implementati=
on.
>>
>> Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
>> discussed in the following thread.
>>
>> https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programming.=
kicks-ass.net/
>>
>> > However, using a global atomic variable would still trigger cache broa=
dcasts,
>> > correct?
>>
>> We can only change the atomic variable to non-zero when
>> swapcache_prepare() returns non-zero, and call wake_up() when the atomic
>> variable is non-zero. =C2=A0Because swapcache_prepare() returns 0 most t=
imes,
>> the atomic variable is 0 most times. =C2=A0If we don't change the value =
of
>> atomic variable, cache ping-pong will not be triggered.
>
> yes. this can be implemented by adding another atomic variable.

Just realized that we don't need another atomic variable for this, just
use waitqueue_active() before wake_up() should be enough.

>>
>> Hi, Kairui,
>>
>> Do you have some test cases to test parallel zram swap-in? =C2=A0If so, =
that
>> can be used to verify whether cache ping-pong is an issue and whether it
>> can be fixed via a global atomic variable.
>>
>
> Yes, Kairui please run a test on your machine with lots of cores before
> and after adding a global atomic variable as suggested by Ying. I am
> sorry I don't have a server machine.
>
> if it turns out you find cache ping-pong can be an issue, another
> approach would be a waitqueue hash:

Yes.  waitqueue hash may help reduce lock contention.  And, we can have
both waitqueue_active() and waitqueue hash if necessary.  As the first
step, waitqueue_active() appears simpler.

> diff --git a/mm/memory.c b/mm/memory.c
> index 2366578015ad..aae0e532d8b6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4192,6 +4192,23 @@ static struct folio *alloc_swap_folio(struct vm_fa=
ult *vmf)
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>=20=20
> +/*
> + * Alleviating the 'thundering herd' phenomenon using a waitqueue hash
> + * when multiple do_swap_page() operations occur simultaneously.
> + */
> +#define SWAPCACHE_WAIT_TABLE_BITS 5
> +#define SWAPCACHE_WAIT_TABLE_SIZE (1 << SWAPCACHE_WAIT_TABLE_BITS)
> +static wait_queue_head_t swapcache_wqs[SWAPCACHE_WAIT_TABLE_SIZE];
> +
> +static int __init swapcache_wqs_init(void)
> +{
> +	for (int i =3D 0; i < SWAPCACHE_WAIT_TABLE_SIZE; i++)
> +		init_waitqueue_head(&swapcache_wqs[i]);
> +
> +        return 0;
> +}
> +late_initcall(swapcache_wqs_init);
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4204,6 +4221,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma =3D vmf->vma;
>  	struct folio *swapcache, *folio =3D NULL;
> +	DECLARE_WAITQUEUE(wait, current);
> +	wait_queue_head_t *swapcache_wq;
>  	struct page *page;
>  	struct swap_info_struct *si =3D NULL;
>  	rmap_t rmap_flags =3D RMAP_NONE;
> @@ -4297,12 +4316,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				 * undetectable as pte_same() returns true due
>  				 * to entry reuse.
>  				 */
> +				swapcache_wq =3D &swapcache_wqs[hash_long(vmf->address & PMD_MASK,
> +							SWAPCACHE_WAIT_TABLE_BITS)];
>  				if (swapcache_prepare(entry, nr_pages)) {
>  					/*
>  					 * Relax a bit to prevent rapid
>  					 * repeated page faults.
>  					 */
> +					add_wait_queue(swapcache_wq, &wait);
>  					schedule_timeout_uninterruptible(1);
> +					remove_wait_queue(swapcache_wq, &wait);
>  					goto out_page;
>  				}
>  				need_clear_cache =3D true;
> @@ -4609,8 +4632,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
>  	/* Clear the swap cache pin for direct swapin after PTL unlock */
> -	if (need_clear_cache)
> +	if (need_clear_cache) {
>  		swapcache_clear(si, entry, nr_pages);
> +		wake_up(swapcache_wq);
> +	}
>  	if (si)
>  		put_swap_device(si);
>  	return ret;
> @@ -4625,8 +4650,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		folio_unlock(swapcache);
>  		folio_put(swapcache);
>  	}
> -	if (need_clear_cache)
> +	if (need_clear_cache) {
>  		swapcache_clear(si, entry, nr_pages);
> +		wake_up(swapcache_wq);
> +	}
>  	if (si)
>  		put_swap_device(si);
>  	return ret;

--
Best Regards,
Huang, Ying

