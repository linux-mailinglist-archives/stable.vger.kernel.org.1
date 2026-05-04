Return-Path: <stable+bounces-243854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMTEERy5+Gn1zAIAu9opvQ
	(envelope-from <stable+bounces-243854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:19:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0284C0927
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34D853008253
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780FF3E0226;
	Mon,  4 May 2026 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfTnUnTg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0253DEFFF;
	Mon,  4 May 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907991; cv=none; b=qHLjd2okO1RaqguFTkqiYQiBwMWFCvFwjIMLMpOy8BYcriwLDTo3ajTtCAhNDEq1I2AmylnuYH9s5FNn/qtOKkE+fgMnmMxdw91ibfZIZmxdKJ3JbiA40AJ3ueoaaRkopkdV2RcTMs2fGBUfvVYsXptI4uSxi+TupbNGdiC6D8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907991; c=relaxed/simple;
	bh=WG+XGX1LKFO8gDnjpvg3aRGIaiaGPdZCSu/I8N1JFYc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmDN72VZ6HlftTFa6Y8Aq0XeQ1E/xl6lvYT6M6pf39Ifv87ABpdK38sqwP5M+TmurLa+J4vNLgAxb/ainnZLGXNi0KAJVmQ4UwY6RDUsqJMNWnVVvP06YeW4Lc/W71A0r4uapz3TROMqLtc+EjxkNkfl2KjXqLWE03pDmH5wzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfTnUnTg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777907989; x=1809443989;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WG+XGX1LKFO8gDnjpvg3aRGIaiaGPdZCSu/I8N1JFYc=;
  b=bfTnUnTgUMN4Vvg5Z6daigqPA5i98o//y+AGkfBFeBbiC2IN88MEZrlD
   8lIexOtl/P0w1ifF5RicHiv/GHwb/j7bu+kv8csUL5gGlZjwYnclRzXPh
   /wNJ5S1o6S9MIQBJXYScm22spEBenrhYUsaNNhXrAtqlZbK4Ogdr+hXqA
   TMUEcZHZWo0JdTQ7jGpMlN4F8ftYHjHLqcIs/fa5uqixZkvMH6DJuxw11
   GFp/lE08A0Fx4O4Vc2IOqUm9/sjEOebVkBaNbdob+OMBYlRnhGBvtExwI
   kKnYFeHltttMLDUWgMVPkKeV3RM1EcjZnsrwfoZj+cYXQvvsWEW+UF6Y4
   g==;
X-CSE-ConnectionGUID: Ih222ncgQFmlbDrp1nAMVA==
X-CSE-MsgGUID: Rm80mw0+SzaIXAEMQxemsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82616897"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82616897"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:19:48 -0700
X-CSE-ConnectionGUID: gLwZablRQHyBsU8n6pso0A==
X-CSE-MsgGUID: OtqIoPyqQ7OXKxsCvujbWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="240530954"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.197]) ([10.245.245.197])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:19:44 -0700
Message-ID: <017d25edabb2e4f60da7421278bffa20f51b0142.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm/pool: back up at native page order
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 04 May 2026 17:19:42 +0200
In-Reply-To: <afitheEYRoy7VoPu@gsse-cloud1.jf.intel.com>
References: <20260504042619.2896273-1-matthew.brost@intel.com>
	 <58ea6837e2aa808bf9f3ba304395058a2d08b8d0.camel@linux.intel.com>
	 <afitheEYRoy7VoPu@gsse-cloud1.jf.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: CD0284C0927
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-243854-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, 2026-05-04 at 07:30 -0700, Matthew Brost wrote:
> On Mon, May 04, 2026 at 10:35:23AM +0200, Thomas Hellstr=C3=B6m wrote:
> > Hi, Matt,
> >=20
> > On Sun, 2026-05-03 at 21:26 -0700, Matthew Brost wrote:
> > > ttm_pool_split_for_swap() splits high-order pool pages into
> > > order-0
> > > pages during backup so each 4K page can be released to the system
> > > as
> > > soon as it has been written to shmem. While this minimizes the
> > > allocator's working set during reclaim, it actively fragments
> > > memory:
> > > every TTM-backed compound page that the shrinker touches is
> > > shattered
> > > into order-0 pages, even when the rest of the system would prefer
> > > that
> > > the high-order block stay intact. Under sustained kswapd pressure
> > > this
> > > is enough to drive other parts of MM into recovery loops from
> > > which
> > > they cannot easily escape, because the memory TTM just freed is
> > > no
> > > longer contiguous.
> > >=20
> > > Stop splitting on the backup path and back up each compound
> > > atomically
> > > at its native order in ttm_pool_backup():
> > >=20
> > > =C2=A0 - For each non-handle slot, read the order from the head page
> > > and
> > > =C2=A0=C2=A0=C2=A0 back up all 1<<order subpages to consecutive shmem=
 indices,
> > > =C2=A0=C2=A0=C2=A0 writing the resulting handles into tt->pages[] as =
we go.
> > > =C2=A0 - On any per-subpage backup failure, drop the handles we just
> > > wrote
> > > =C2=A0=C2=A0=C2=A0 for this compound and restore the original page po=
inters, so
> > > the
> > > =C2=A0=C2=A0=C2=A0 compound is left fully intact and may be retried l=
ater.
> > > shrunken
> > > =C2=A0=C2=A0=C2=A0 is only incremented once the whole compound succee=
ds.
> > > =C2=A0 - On success, the compound is freed once at its native order.
> > > No
> > > =C2=A0=C2=A0=C2=A0 split_page(), no per-4K refcount juggling, no frag=
mentation
> > > =C2=A0=C2=A0=C2=A0 introduced from this path.
> > > =C2=A0 - Slots that already hold a backup handle from a previous
> > > partial
> > > =C2=A0=C2=A0=C2=A0 attempt are skipped. A compound that would extend =
past a
> > > =C2=A0=C2=A0=C2=A0 fault-injection-truncated num_pages is skipped rat=
her than
> > > split.
> > >=20
> > > The restore-side leftover-page branch in
> > > ttm_pool_restore_commit() is
> > > left as-is for now: that path can still split a previously-
> > > retained
> > > compound, but in practice it is unreachable under realistic
> > > workloads
> > > (per profiling we have not been able to trigger it), so it is not
> > > worth complicating the restore state machine to avoid the split
> > > there.
> > > If it ever becomes a problem in practice it can be addressed
> > > independently.
> > >=20
> > > ttm_pool_split_for_swap() itself is retained for the restore
> > > path's
> > > sole remaining caller. The DMA-mapped pre-backup unmap loop, the
> > > purge path, ttm_pool_free_*, and ttm_pool_unmap_and_free()
> > > already
> > > operate at native order and are unchanged.
> >=20
> > This split is intentional in that without it, we'd need to first
> > allocate 1 << order pages from the kernel's *reserves* in order to
> > later free 2 << order pages, making the shrinker much more likely
> > to
> > fail in true OOM situations. (I believe this was one of the reasons
> > the
> > initial shrinker attempts from AMD didn't work as expected).
> >=20
>=20
> So where exactly is allocation done=E2=80=94shmem_read_folio_gfp or
> shmem_writeout? I did notice and called out, in the commit message,
> that
> those interfaces are a bit confusing with respect to whether they
> actually work with higher-order allocations.

The interesting one is in shmem_read_folio_gfp(). This used to be 4K-
page only (but i915 had some tricks to make this allocate 2M folios).
My understanding (to be verified) is that this recently was changed to
allow 2M by default, and also to allow 2M folio writeout. Writeout
moves the folio from the page-cache to the swap-cache and then starts a
fs writeout operation. Pages are put back on the LRU and are freed when
writeout completes.

As I understand it, shmem_read_folio_gfp() will also potentially
allocate memory for the shmem object radix tree.

>=20
> Also, FWIW, this patch by itself seems to greatly help with
> fragmentation, and I haven=E2=80=99t seen the OOM killer kick in. I=E2=80=
=99ve done
> things like running WebGL in a bunch of Chrome tabs, then running
> bonnie++ (which basically uses all memory), or running IGTs, which
> also
> use all available memory. Based on that, I=E2=80=99m leaning toward this
> patch
> alone working as designed.

Good to know. Perhaps it would feel safer if we completely restrict the
xe TTM order to 2M and below (if we haven't already).

>=20
> >=20
> > I believe the solution here is in the ttm_backup layer, We should
> > introduce a ttm_backup_backup_folio function and either insert the
> > page
>=20
> I think something like ttm_backup_backup_folio() makes sense, again I
> called out in commit message.
>=20
> > directly into the shmem object (zero-copy) or even directly into
> > the
> > swap cache. Then we should completely restrict xe page allocations
> > to
> > only allow THP and PAGE_SIZE (Possibly 64K pages, but they'd either
> > need a split or perhaps they are small enough to be backed-up using
>=20
> Yes, I did raise something like with Christian too [1]. IMO the
> driver
> should be able dictate to TTM the orders it likely to allocate at.
>=20
> [1]
> https://patchwork.freedesktop.org/patch/716362/?series=3D164338&rev=3D1
>=20
> > one-go copy, similar to this patch, but in the backup layer). FWIW
> > at
> > the time the shrinker was put together, AFAIU SHMEM split large
> > pages
> > on swapping anyway, but since that appears to have changed, we need
> > to
> > catch up.
> >=20
> > Inserting directly into the swap-cache WIP is here, rebased on a
> > recent
> > kernel (This is an old idea that has actually been out on RFC
> > once).
> > This needs a core mm bugfix (also in the branch), but I'm not sure
> > the
> > swap cache is the right place to do this, at least not if we don't
> > immediately schedule a write to disc, it looks like current users
> > don't
> > want to keep pages in swap-cache for very long (related to that
> > bug)
> > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/thp_swapping2
> >=20
> > Inserting directly into shmem (A fairly recent idea that is mostly
> > untested)
> > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/insert_shmem?r=
ef_type=3Dheads
> > Since SHMEM schedules writeout immediately when pages are moved to
> > the
> > swap-cache, it's not as susceptible to the above bug, since swap-
> > cache
> > entries are not typically held for folios for which we haven't
> > scheduled writeout.
> >=20
>=20
> Let me take a look at these branches today.
>=20
> > We should try to solicit feedback from mm people on these two
> > approaches.
>=20
> +1, but I think we should stop here if this patch, as=E2=80=91is, is OK t=
o go
> in=E2=80=94ideally as a fix=E2=80=94since, based on my testing, it seems =
to help
> quite a
> bit and current upstream shrinker is badly broken.

Well I think the problem with testing shrinking behavior is that we
haven't had good test-cases, so we don't really know if this change
would break something that currently works. In the shmem documentation
there's even some wording about concerns that the shmem radix tree
allocations could accumulate and drain the kernel reserves.=C2=A0

According to Google AI, the kernel reserves are around 2MiB times the
number of zones, controlled by vm.min_free_kbytes.

But I think if we would push this or something similar but then we
should=20

*) Move the ttm_backup interface to be folio-based.
*) Restrict order to 2M
*) Craft a test-case that triggers a shmem_read_folio_gfp() error in
the backup path and verify that they do behave gracefully.

And then as follow-ups:

a) Investigate direct shmem insertion.
b) Address any remaining flaws from partially backed-up bos.
c) Cgroups integration, following up on airlied's work ensuring that
the evictee is charged for the shmem memory.


Thanks,
Thomas



> Matt
>=20
> >=20
> > /Thomas
> >=20
> > >=20
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: stable@vger.kernel.org
> > > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper
> > > to
> > > shrink pages")
> > > Suggested-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com=
>
> > > Assisted-by: Claude:claude-opus-4.6
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > >=20
> > > ---
> > >=20
> > > A follow-up should attempt writeback to shmem at folio order as
> > > well,
> > > but the API for doing so is unclear and may be incomplete.
> > >=20
> > > This patch is related to the pending series [1] and significantly
> > > reduces the likelihood of Xe entering a kswapd loop under
> > > fragmentation.
> > > The kswapd =E2=86=92 shrinker =E2=86=92 Xe shrinker =E2=86=92 TTM bac=
kup path is still
> > > exercised; however, with this change the backup path no longer
> > > worsens
> > > fragmentation, which previously amplified reclaim pressure and
> > > reinforced the kswapd loop.
> > >=20
> > > Nonetheless, the pathological case that [1] aims to address still
> > > exists
> > > and requires a proper solution. Even with this patch, a kswapd
> > > loop
> > > due
> > > to severe fragmentation can still be triggered, although it is
> > > now
> > > substantially harder to reproduce.
> > >=20
> > > [1] https://patchwork.freedesktop.org/series/165330/
> > > ---
> > > =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 71 +++++++++++++++++++++++++++=
-
> > > ----
> > > --
> > > =C2=A01 file changed, 57 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > > b/drivers/gpu/drm/ttm/ttm_pool.c
> > > index 278bbe7a11ad..5ead0aba4bb7 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > @@ -1036,12 +1036,11 @@ long ttm_pool_backup(struct ttm_pool
> > > *pool,
> > > struct ttm_tt *tt,
> > > =C2=A0{
> > > =C2=A0	struct file *backup =3D tt->backup;
> > > =C2=A0	struct page *page;
> > > -	unsigned long handle;
> > > =C2=A0	gfp_t alloc_gfp;
> > > =C2=A0	gfp_t gfp;
> > > =C2=A0	int ret =3D 0;
> > > =C2=A0	pgoff_t shrunken =3D 0;
> > > -	pgoff_t i, num_pages;
> > > +	pgoff_t i, num_pages, npages;
> > > =C2=A0
> > > =C2=A0	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > > =C2=A0		return -EINVAL;
> > > @@ -1097,28 +1096,72 @@ long ttm_pool_backup(struct ttm_pool
> > > *pool,
> > > struct ttm_tt *tt,
> > > =C2=A0	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > should_fail(&backup_fault_inject, 1))
> > > =C2=A0		num_pages =3D DIV_ROUND_UP(num_pages, 2);
> > > =C2=A0
> > > -	for (i =3D 0; i < num_pages; ++i) {
> > > -		s64 shandle;
> > > +	for (i =3D 0; i < num_pages; i +=3D npages) {
> > > +		unsigned int order;
> > > +		pgoff_t j;
> > > =C2=A0
> > > +		npages =3D 1;
> > > =C2=A0		page =3D tt->pages[i];
> > > =C2=A0		if (unlikely(!page))
> > > =C2=A0			continue;
> > > =C2=A0
> > > -		ttm_pool_split_for_swap(pool, page);
> > > +		/* Already-handled entry from a previous
> > > attempt. */
> > > +		if
> > > (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > > +			continue;
> > > =C2=A0
> > > -		shandle =3D ttm_backup_backup_page(backup, page,
> > > flags->writeback, i,
> > > -						 gfp,
> > > alloc_gfp);
> > > -		if (shandle < 0) {
> > > -			/* We allow partially shrunken tts */
> > > -			ret =3D shandle;
> > > +		order =3D ttm_pool_page_order(pool, page);
> > > +		npages =3D 1UL << order;
> > > +
> > > +		/*
> > > +		 * Back up the compound atomically at its native
> > > order. If
> > > +		 * fault injection truncated num_pages mid-
> > > compound,
> > > skip
> > > +		 * the partial tail rather than splitting.
> > > +		 */
> > > +		if (unlikely(i + npages > num_pages))
> > > =C2=A0			break;
> > > +
> > > +		for (j =3D 0; j < npages; ++j) {
> > > +			unsigned long handle;
> > > +			s64 shandle;
> > > +
> > > +			if (IS_ENABLED(CONFIG_FAULT_INJECTION)
> > > &&
> > > +			=C2=A0=C2=A0=C2=A0 should_fail(&backup_fault_inject,
> > > 1))
> > > +				shandle =3D -1;
> > > +			else
> > > +				shandle =3D
> > > ttm_backup_backup_page(backup, page + j,
> > > +							=09
> > > flags->writeback,
> > > +							=09
> > > i +
> > > j, gfp,
> > > +							=09
> > > alloc_gfp);
> > > +
> > > +			if (unlikely(shandle < 0)) {
> > > +				pgoff_t k;
> > > +
> > > +				ret =3D shandle;
> > > +				/*
> > > +				 * Roll back: drop the handles
> > > we
> > > just wrote
> > > +				 * and restore the original page
> > > pointers so
> > > +				 * the compound remains intact
> > > and
> > > may be
> > > +				 * retried later.
> > > +				 */
> > > +				for (k =3D 0; k < j; ++k) {
> > > +					handle =3D
> > > ttm_backup_page_ptr_to_handle(tt->pages[i + k]);
> > > +					ttm_backup_drop(backup,
> > > handle);
> > > +					tt->pages[i + k] =3D page
> > > + k;
> > > +				}
> > > +
> > > +				goto out;
> > > +			}
> > > +			handle =3D shandle;
> > > +			tt->pages[i + j] =3D
> > > ttm_backup_handle_to_page_ptr(shandle);
> > > =C2=A0		}
> > > -		handle =3D shandle;
> > > -		tt->pages[i] =3D
> > > ttm_backup_handle_to_page_ptr(handle);
> > > -		__free_pages_gpu_account(page, 0, false);
> > > -		shrunken++;
> > > +
> > > +		/* Compound fully backed up; free at native
> > > order.
> > > */
> > > +		page->private =3D 0;
> > > +		__free_pages_gpu_account(page, order, false);
> > > +		shrunken +=3D npages;
> > > =C2=A0	}
> > > =C2=A0
> > > +out:
> > > =C2=A0	return shrunken ? shrunken : ret;
> > > =C2=A0}
> > > =C2=A0

