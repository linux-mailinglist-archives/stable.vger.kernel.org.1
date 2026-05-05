Return-Path: <stable+bounces-244021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAp1DASz+Wld/AIAu9opvQ
	(envelope-from <stable+bounces-244021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:06:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D874C91F8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92B0301C8B2
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF98E3126C4;
	Tue,  5 May 2026 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ha8zObKs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18B21018A;
	Tue,  5 May 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971770; cv=none; b=ZuKNMYw23m0Py/w2R/Q/tnHwbFRqAd5nEl2erxgCglHb/7wCswNvjLJsJWS2imNyMwK4/dF4l6YAjNFVlf8/ldmGeabLzeHGAEoVbrW1aSgdfXonvAZE7ooX3pmy+HnAg8bLllssTtGTqW/4BalaAIeDBYQb/UIIQSYKvhge5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971770; c=relaxed/simple;
	bh=km3XXeySFy6SVYXHhF4s5Stfz9taVh0BL2AI1OyPFlQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJEdCGOJFQbosirBbtU7ka6h2w2dtWrZlCvJCVyBfHGtoRjo7cYzQvq2UUORAQXmWi0u5iCW7d9RnEXe4dd3jqRVr9PiNreTXDcF0c0aCAmjlpmGSBP5zMKZMgs2wiUZde/8H4GJ9TRBCuUSCOt6kSLnStJs18Tf4GJegQ4tSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ha8zObKs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777971769; x=1809507769;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=km3XXeySFy6SVYXHhF4s5Stfz9taVh0BL2AI1OyPFlQ=;
  b=Ha8zObKsphZxOVsxSjzkAjK1z1T12G0nmTMJd0gA9mUz/QIEOh23G61E
   mEdyIxoUky2L5M4oKKdg3QOOXpNgpbaB3pu0Ii16FQstCFLCEX+bwe7vM
   rC680QqXm1p9ts+9ThRqt8CYkMz1vVbkxpagKwIupPc1+kmhzvjhqTFtd
   hJzV0yOxR9gxUXJnTR/kdiJ62A/XlrEizinai/J/fuJXjdVg3b6yFvDYu
   QRKyqAwU6guSz2JqmmYtBVyeps8xsV1wIBshzMdCluFsp3O6Q1msfQVZ/
   uFOxwbPpRk2GAD7MjuQgy0Y9NQH3theyBc3mgIR6K3fJDDjQtuvlARMJJ
   Q==;
X-CSE-ConnectionGUID: MBFct2wuT6Cc96aAQhAWHA==
X-CSE-MsgGUID: ycsnfnhMQcikZRy4mF7c+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78698031"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78698031"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:02:46 -0700
X-CSE-ConnectionGUID: o4zNNE+DQJinUao9qGH2Tg==
X-CSE-MsgGUID: SqTAs1PJRIqMdPPuss4fAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="237533123"
Received: from zzombora-mobl1 (HELO [10.245.244.41]) ([10.245.244.41])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:02:39 -0700
Message-ID: <12feb16f1f8dd00458e982785d45415d42a3e768.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/2] drm/ttm/pool: back up at native page order
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>,  Matthew Auld <matthew.auld@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 05 May 2026 11:02:35 +0200
In-Reply-To: <20260505033013.3266938-3-matthew.brost@intel.com>
References: <20260505033013.3266938-1-matthew.brost@intel.com>
	 <20260505033013.3266938-3-matthew.brost@intel.com>
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
X-Rspamd-Queue-Id: 82D874C91F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244021-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 2026-05-04 at 20:30 -0700, Matthew Brost wrote:
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
> Stop unconditionally splitting on the backup path and back up each
> compound at its native order in ttm_pool_backup():
>=20
> =C2=A0 - For each non-handle slot, read the order from the head page and
> =C2=A0=C2=A0=C2=A0 back up all 1<<order subpages to consecutive shmem ind=
ices,
> =C2=A0=C2=A0=C2=A0 writing the resulting handles into tt->pages[] as we g=
o.
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
> A per-subpage backup failure cannot be made fully atomic: backing up
> a
> subpage allocates a shmem folio before the source page can be
> released,
> so under true OOM any subpage in a compound (not just the first) may
> fail to be backed up with the rest of the source compound still live
> and contiguous. To make forward progress in that case, fall back to
> splitting the source compound and backing up its remaining subpages
> individually:
>=20
> =C2=A0 - On the first per-subpage failure for a compound (and only if
> =C2=A0=C2=A0=C2=A0 order > 0), call ttm_pool_split_for_swap() to split th=
e source
> =C2=A0=C2=A0=C2=A0 compound, release the subpages whose contents already =
live in
> =C2=A0=C2=A0=C2=A0 shmem (their handles in tt->pages stay valid), and ret=
ry the
> =C2=A0=C2=A0=C2=A0 failing subpage at order 0.
> =C2=A0 - Subsequent successful subpage backups in the now-split compound
> =C2=A0=C2=A0=C2=A0 free their source page individually as soon as the han=
dle is
> =C2=A0=C2=A0=C2=A0 written.
> =C2=A0 - A second failure after splitting terminates the loop with partia=
l
> =C2=A0=C2=A0=C2=A0 progress; the remaining order-0 subpages stay in tt->p=
ages as
> =C2=A0=C2=A0=C2=A0 plain page pointers and are cleaned up by the normal
> =C2=A0=C2=A0=C2=A0 ttm_pool_drop_backed_up() / ttm_pool_free_range() path=
s.
>=20
> This restores the original split-on-OOM fallback behavior while
> keeping the common, non-OOM case fragmentation-free. It also
> preserves the "partial backup is allowed" contract: shrunken is
> incremented per backed-up subpage so the caller still sees forward
> progress when a compound only partially succeeds.
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
> ttm_pool_split_for_swap() itself is retained both for the OOM
> fallback above and for the restore path's remaining caller. The
> DMA-mapped pre-backup unmap loop, the purge path, ttm_pool_free_*,
> and ttm_pool_unmap_and_free() already operate at native order and
> are unchanged.
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
> v2:
> =C2=A0- Split pages and free immediately if backup fails are higher order
> =C2=A0=C2=A0 (Thomas)
> v3:
> =C2=A0- Skip handles in purge path (sashiko)
>=20
> [1] https://patchwork.freedesktop.org/series/165330/
> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 87 ++++++++++++++++++++++++++++---=
-
> --
> =C2=A01 file changed, 72 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> b/drivers/gpu/drm/ttm/ttm_pool.c
> index c7aab60b7f01..f9e631a20979 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1047,12 +1047,11 @@ long ttm_pool_backup(struct ttm_pool *pool,
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
> @@ -1072,7 +1071,8 @@ long ttm_pool_backup(struct ttm_pool *pool,
> struct ttm_tt *tt,
> =C2=A0			unsigned int order;
> =C2=A0
> =C2=A0			page =3D tt->pages[i];
> -			if (unlikely(!page)) {
> +			if (unlikely(!page ||
> +				=C2=A0=C2=A0=C2=A0=C2=A0
> ttm_backup_page_ptr_is_handle(page))) {
> =C2=A0				num_pages =3D 1;
> =C2=A0				continue;
> =C2=A0			}
> @@ -1108,28 +1108,85 @@ long ttm_pool_backup(struct ttm_pool *pool,
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
> +		bool folio_has_been_split =3D false;
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
> +
> +		order =3D ttm_pool_page_order(pool, page);
> +		npages =3D 1UL << order;
> =C2=A0
> -		shandle =3D ttm_backup_backup_page(backup, page,
> flags->writeback, i,
> -						 gfp, alloc_gfp);
> -		if (shandle < 0) {
> -			/* We allow partially shrunken tts */
> -			ret =3D shandle;
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
> +			s64 shandle;

I still think we should move part of this loop to
ttm_backup_backup_folio() at this point, rather than open-coding it
here. It's the design we want to move forward with and would probably
make the pool code cleaner as well. If we think failures would be
common we could have ttm_backup_backup_folio() return the number of
pages that were actually backed up or error Otherwise just return
success or error and on error truncate the shmem pages that were
already copied.

Thanks,
Thomas


> +
> +try_again_after_split:
> +			if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> +			=C2=A0=C2=A0=C2=A0 should_fail(&backup_fault_inject, 1))
> +				shandle =3D -ENOMEM;
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
> +			if (shandle < 0 && !folio_has_been_split &&
> order) {
> +				pgoff_t k;
> +
> +				/*
> +				 * True OOM: could not allocate a
> shmem folio
> +				 * for the next subpage. Fall back
> to splitting
> +				 * the source compound and backing
> up subpages
> +				 * individually. Release the
> already-backed-up
> +				 * subpages whose contents now live
> in shmem;
> +				 * any further failure terminates
> the loop with
> +				 * partial progress (handled by the
> caller).
> +				 */
> +				folio_has_been_split =3D true;
> +				ttm_pool_split_for_swap(pool, page);
> +
> +				for (k =3D 0; k < j; ++k) {
> +					__free_pages_gpu_account(pag
> e + k, 0, false);
> +					shrunken++;
> +				}
> +
> +				goto try_again_after_split;
> +			} else if (shandle < 0) {
> +				ret =3D shandle;
> +				goto out;
> +			} else if (folio_has_been_split) {
> +				__free_pages_gpu_account(page + j,
> 0, false);
> +				shrunken++;
> +			}
> +
> +			tt->pages[i + j] =3D
> ttm_backup_handle_to_page_ptr(shandle);
> +		}
> +
> +		if (!folio_has_been_split) {
> +			/* Compound fully backed up; free at native
> order. */
> +			page->private =3D 0;
> +			__free_pages_gpu_account(page, order,
> false);
> +			shrunken +=3D npages;
> =C2=A0		}
> -		handle =3D shandle;
> -		tt->pages[i] =3D
> ttm_backup_handle_to_page_ptr(handle);
> -		__free_pages_gpu_account(page, 0, false);
> -		shrunken++;
> =C2=A0	}
> =C2=A0
> +out:
> =C2=A0	return shrunken ? shrunken : ret;
> =C2=A0}
> =C2=A0

