Return-Path: <stable+bounces-242878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHqBDGRa+GlStQIAu9opvQ
	(envelope-from <stable+bounces-242878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:35:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E93B4BA4B0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 884C1300F155
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ED0340290;
	Mon,  4 May 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LESgOKuj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793F31F9BA;
	Mon,  4 May 2026 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883743; cv=none; b=e4WnncpGayS72ZqgNy/wWiA/ZjgeqaevLnVNkIdN/xGWfUvBRhrSgu7SpqgD3pGSop3SX3t839UpY2GcmM43yJkDaLcPc9tSr+OzbHl8eMxMBuHxikmbllqwzwGlrhlDzkuvicVHZWkj6oXT1sxHCSXgmsUH4PbGTHP6HqpWE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883743; c=relaxed/simple;
	bh=eGq4ffnRgb7YYIbydz8J2Sf+L+//GRXSDaSI6BWpKkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cY4mRTC2yC3RKvlrJVF5+oAN0WyT5tX/nl73L7anSxDG0P60tBW1f0bX8XmKcjNE8QgsrKw8SS4oNtqOEC2d9h5KZUc8uHw7827il1XfizZKPjZ3TD74Mt0zIrIO4Kv53aw9WDJc0NwZOxquTQfehUSahvQ6DVCvkCvCLJzx584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LESgOKuj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777883742; x=1809419742;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eGq4ffnRgb7YYIbydz8J2Sf+L+//GRXSDaSI6BWpKkY=;
  b=LESgOKujoIZxKvgyfQ5qxygmvXiDANzSbc+xzE3lanxQ20M3G+U/osdd
   X5aFLyPVKDN5gxcJ43mg/0qghz/+r6Stbg1sHXAiphPIpFuzSvbQLaQ3I
   2PaZ7unrNjUF6Tq3NYyhHoNj99A1bNqXkvxUfsXY4lxEanEtDFCEJa/k0
   NvJGFBxfbE4a8XPeNDz/tvy+T4QJnu16HKNGHv3lGNUD54jK3X6KM7+Ac
   aCrRmapvsznQsmHAXPh6C4fiJS9KRPInUj1xQ0yCdvrpgmOXshoTBODuo
   N6guRwNlhkR8bIyujucl+Xd30fQOP9lb8H2VLsA68zjgdadMBkbp++HMt
   A==;
X-CSE-ConnectionGUID: /QATwgEvS0+1ztG2I3IE1A==
X-CSE-MsgGUID: u5cSUSVoSSyxDMjvTe0OOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78636554"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78636554"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:35:41 -0700
X-CSE-ConnectionGUID: VZXPlydPS/24Qz9Ed6guSw==
X-CSE-MsgGUID: 5QBTj83vRTmHIZuqzfLg+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="231101762"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.154]) ([10.245.245.154])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:35:38 -0700
Message-ID: <58ea6837e2aa808bf9f3ba304395058a2d08b8d0.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm/pool: back up at native page order
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>,  Matthew Auld <matthew.auld@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 04 May 2026 10:35:23 +0200
In-Reply-To: <20260504042619.2896273-1-matthew.brost@intel.com>
References: <20260504042619.2896273-1-matthew.brost@intel.com>
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
X-Rspamd-Queue-Id: 9E93B4BA4B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-242878-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi, Matt,

On Sun, 2026-05-03 at 21:26 -0700, Matthew Brost wrote:
> ttm_pool_split_for_swap() splits high-order pool pages into order-0
> pages during backup so each 4K page can be released to the system as
> soon as it has been written to shmem. While this minimizes the
> allocator's working set during reclaim, it actively fragments memory:
> every TTM-backed compound page that the shrinker touches is shattered
> into order-0 pages, even when the rest of the system would prefer
> that
> the high-order block stay intact. Under sustained kswapd pressure
> this
> is enough to drive other parts of MM into recovery loops from which
> they cannot easily escape, because the memory TTM just freed is no
> longer contiguous.
>=20
> Stop splitting on the backup path and back up each compound
> atomically
> at its native order in ttm_pool_backup():
>=20
> =C2=A0 - For each non-handle slot, read the order from the head page and
> =C2=A0=C2=A0=C2=A0 back up all 1<<order subpages to consecutive shmem ind=
ices,
> =C2=A0=C2=A0=C2=A0 writing the resulting handles into tt->pages[] as we g=
o.
> =C2=A0 - On any per-subpage backup failure, drop the handles we just wrot=
e
> =C2=A0=C2=A0=C2=A0 for this compound and restore the original page pointe=
rs, so the
> =C2=A0=C2=A0=C2=A0 compound is left fully intact and may be retried later=
. shrunken
> =C2=A0=C2=A0=C2=A0 is only incremented once the whole compound succeeds.
> =C2=A0 - On success, the compound is freed once at its native order. No
> =C2=A0=C2=A0=C2=A0 split_page(), no per-4K refcount juggling, no fragment=
ation
> =C2=A0=C2=A0=C2=A0 introduced from this path.
> =C2=A0 - Slots that already hold a backup handle from a previous partial
> =C2=A0=C2=A0=C2=A0 attempt are skipped. A compound that would extend past=
 a
> =C2=A0=C2=A0=C2=A0 fault-injection-truncated num_pages is skipped rather =
than split.
>=20
> The restore-side leftover-page branch in ttm_pool_restore_commit() is
> left as-is for now: that path can still split a previously-retained
> compound, but in practice it is unreachable under realistic workloads
> (per profiling we have not been able to trigger it), so it is not
> worth complicating the restore state machine to avoid the split
> there.
> If it ever becomes a problem in practice it can be addressed
> independently.
>=20
> ttm_pool_split_for_swap() itself is retained for the restore path's
> sole remaining caller. The DMA-mapped pre-backup unmap loop, the
> purge path, ttm_pool_free_*, and ttm_pool_unmap_and_free() already
> operate at native order and are unchanged.

This split is intentional in that without it, we'd need to first
allocate 1 << order pages from the kernel's *reserves* in order to
later free 2 << order pages, making the shrinker much more likely to
fail in true OOM situations. (I believe this was one of the reasons the
initial shrinker attempts from AMD didn't work as expected).


I believe the solution here is in the ttm_backup layer, We should
introduce a ttm_backup_backup_folio function and either insert the page
directly into the shmem object (zero-copy) or even directly into the
swap cache. Then we should completely restrict xe page allocations to
only allow THP and PAGE_SIZE (Possibly 64K pages, but they'd either
need a split or perhaps they are small enough to be backed-up using
one-go copy, similar to this patch, but in the backup layer). FWIW at
the time the shrinker was put together, AFAIU SHMEM split large pages
on swapping anyway, but since that appears to have changed, we need to
catch up.

Inserting directly into the swap-cache WIP is here, rebased on a recent
kernel (This is an old idea that has actually been out on RFC once).
This needs a core mm bugfix (also in the branch), but I'm not sure the
swap cache is the right place to do this, at least not if we don't
immediately schedule a write to disc, it looks like current users don't
want to keep pages in swap-cache for very long (related to that bug)
https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/thp_swapping2

Inserting directly into shmem (A fairly recent idea that is mostly
untested)
https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/insert_shmem?ref_t=
ype=3Dheads
Since SHMEM schedules writeout immediately when pages are moved to the
swap-cache, it's not as susceptible to the above bug, since swap-cache
entries are not typically held for folios for which we haven't
scheduled writeout.

We should try to solicit feedback from mm people on these two
approaches.

/Thomas

>=20
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> shrink pages")
> Suggested-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>=20
> ---
>=20
> A follow-up should attempt writeback to shmem at folio order as well,
> but the API for doing so is unclear and may be incomplete.
>=20
> This patch is related to the pending series [1] and significantly
> reduces the likelihood of Xe entering a kswapd loop under
> fragmentation.
> The kswapd =E2=86=92 shrinker =E2=86=92 Xe shrinker =E2=86=92 TTM backup =
path is still
> exercised; however, with this change the backup path no longer
> worsens
> fragmentation, which previously amplified reclaim pressure and
> reinforced the kswapd loop.
>=20
> Nonetheless, the pathological case that [1] aims to address still
> exists
> and requires a proper solution. Even with this patch, a kswapd loop
> due
> to severe fragmentation can still be triggered, although it is now
> substantially harder to reproduce.
>=20
> [1] https://patchwork.freedesktop.org/series/165330/
> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 71 +++++++++++++++++++++++++++----=
-
> --
> =C2=A01 file changed, 57 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> b/drivers/gpu/drm/ttm/ttm_pool.c
> index 278bbe7a11ad..5ead0aba4bb7 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1036,12 +1036,11 @@ long ttm_pool_backup(struct ttm_pool *pool,
> struct ttm_tt *tt,
> =C2=A0{
> =C2=A0	struct file *backup =3D tt->backup;
> =C2=A0	struct page *page;
> -	unsigned long handle;
> =C2=A0	gfp_t alloc_gfp;
> =C2=A0	gfp_t gfp;
> =C2=A0	int ret =3D 0;
> =C2=A0	pgoff_t shrunken =3D 0;
> -	pgoff_t i, num_pages;
> +	pgoff_t i, num_pages, npages;
> =C2=A0
> =C2=A0	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> =C2=A0		return -EINVAL;
> @@ -1097,28 +1096,72 @@ long ttm_pool_backup(struct ttm_pool *pool,
> struct ttm_tt *tt,
> =C2=A0	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> should_fail(&backup_fault_inject, 1))
> =C2=A0		num_pages =3D DIV_ROUND_UP(num_pages, 2);
> =C2=A0
> -	for (i =3D 0; i < num_pages; ++i) {
> -		s64 shandle;
> +	for (i =3D 0; i < num_pages; i +=3D npages) {
> +		unsigned int order;
> +		pgoff_t j;
> =C2=A0
> +		npages =3D 1;
> =C2=A0		page =3D tt->pages[i];
> =C2=A0		if (unlikely(!page))
> =C2=A0			continue;
> =C2=A0
> -		ttm_pool_split_for_swap(pool, page);
> +		/* Already-handled entry from a previous attempt. */
> +		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
> +			continue;
> =C2=A0
> -		shandle =3D ttm_backup_backup_page(backup, page,
> flags->writeback, i,
> -						 gfp, alloc_gfp);
> -		if (shandle < 0) {
> -			/* We allow partially shrunken tts */
> -			ret =3D shandle;
> +		order =3D ttm_pool_page_order(pool, page);
> +		npages =3D 1UL << order;
> +
> +		/*
> +		 * Back up the compound atomically at its native
> order. If
> +		 * fault injection truncated num_pages mid-compound,
> skip
> +		 * the partial tail rather than splitting.
> +		 */
> +		if (unlikely(i + npages > num_pages))
> =C2=A0			break;
> +
> +		for (j =3D 0; j < npages; ++j) {
> +			unsigned long handle;
> +			s64 shandle;
> +
> +			if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> +			=C2=A0=C2=A0=C2=A0 should_fail(&backup_fault_inject, 1))
> +				shandle =3D -1;
> +			else
> +				shandle =3D
> ttm_backup_backup_page(backup, page + j,
> +							=09
> flags->writeback,
> +								 i +
> j, gfp,
> +							=09
> alloc_gfp);
> +
> +			if (unlikely(shandle < 0)) {
> +				pgoff_t k;
> +
> +				ret =3D shandle;
> +				/*
> +				 * Roll back: drop the handles we
> just wrote
> +				 * and restore the original page
> pointers so
> +				 * the compound remains intact and
> may be
> +				 * retried later.
> +				 */
> +				for (k =3D 0; k < j; ++k) {
> +					handle =3D
> ttm_backup_page_ptr_to_handle(tt->pages[i + k]);
> +					ttm_backup_drop(backup,
> handle);
> +					tt->pages[i + k] =3D page + k;
> +				}
> +
> +				goto out;
> +			}
> +			handle =3D shandle;
> +			tt->pages[i + j] =3D
> ttm_backup_handle_to_page_ptr(shandle);
> =C2=A0		}
> -		handle =3D shandle;
> -		tt->pages[i] =3D
> ttm_backup_handle_to_page_ptr(handle);
> -		__free_pages_gpu_account(page, 0, false);
> -		shrunken++;
> +
> +		/* Compound fully backed up; free at native order.
> */
> +		page->private =3D 0;
> +		__free_pages_gpu_account(page, order, false);
> +		shrunken +=3D npages;
> =C2=A0	}
> =C2=A0
> +out:
> =C2=A0	return shrunken ? shrunken : ret;
> =C2=A0}
> =C2=A0

