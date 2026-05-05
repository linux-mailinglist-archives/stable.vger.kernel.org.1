Return-Path: <stable+bounces-243995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFkJOU+Y+Wmo+AIAu9opvQ
	(envelope-from <stable+bounces-243995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:12:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C54C7992
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB784308D90E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4A3D1CA4;
	Tue,  5 May 2026 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsPnYl1Y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF13D170D;
	Tue,  5 May 2026 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964722; cv=none; b=D2+yJ1g6Lw/12q59dGRjO9fOSc9udjU21dLRRgmF9W89V46/+bg36MElo41Huq3GchlF9erC0wvcFmhHdB9/ldH9XIs+ktawvOZ+r/tsYXUJCm+gOkyNoawPONX+QLfsRF9tasGDM3X43BGrQbXFcozvQZ25HaFgQ793CboJ58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964722; c=relaxed/simple;
	bh=XWHhNPQWCrPpI67QvKbOT1MlLHh2H3XUyJHmsFDJaGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubWb0RiH/3zNhYB0z1cJWi3qz5fBQXNu7TE0dek1c8qeK5bsDZ0unCwjSSYA2LPojRpWfqfwM9+ss4KJSSr88ZUQllEy5SMHeq5eK+cT+Schmh60oJl0ledFEsosxgdPoZlxlgoPzUsfdX6yaSzwyTqqxif6ZHMkTiB2cO2U+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsPnYl1Y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777964720; x=1809500720;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XWHhNPQWCrPpI67QvKbOT1MlLHh2H3XUyJHmsFDJaGM=;
  b=JsPnYl1YBmYR3T+5+442s0f7xroCE94cHdi2Cq9piPpQlk6r7BpfFRm8
   PTJfn7qx1aa+cZaLyGoTSypqP9eBGApxq1Dk5sIekSSoJ5CjDfnffs66A
   RRKh3+Ei91k8cufto8XnZ2/n8X6s8ilxDbVDJt93QBoVjp6FJBy40QVG3
   yzNMT08tOl++oPR2pBt/zNEJSRTCehEWc9RVnu+ZOOXZ1n7oyYny3Xe+P
   a7DKFxhXREByd8jid9jptxPA9SP5R1MZqapZYs748bOZlROvjmHrcCkyl
   MBfyK++r2nupZwBayFgC7AxtQclPakLcyhNYw8mIN10ifCjW28ivHfaYa
   A==;
X-CSE-ConnectionGUID: 0z8gLxaDSiK3KkRg7Dtkeg==
X-CSE-MsgGUID: K/lP69stRue+ExOPXO1D4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89134374"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89134374"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:05:19 -0700
X-CSE-ConnectionGUID: ZX0ETcpVTRyCfdcxFuwt0w==
X-CSE-MsgGUID: vRM4Dj65STyvE4H81db9Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="234720407"
Received: from zzombora-mobl1 (HELO [10.245.244.41]) ([10.245.244.41])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:05:16 -0700
Message-ID: <c2c5fe4cda479c02e18d658c91e55c9ab1cfc8bd.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/2] drm/ttm: Drop tt->restore after successful
 restore
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>,  Matthew Auld <matthew.auld@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 05 May 2026 09:04:45 +0200
In-Reply-To: <20260505033013.3266938-2-matthew.brost@intel.com>
References: <20260505033013.3266938-1-matthew.brost@intel.com>
	 <20260505033013.3266938-2-matthew.brost@intel.com>
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
X-Rspamd-Queue-Id: 966C54C7992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-243995-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 2026-05-04 at 20:30 -0700, Matthew Brost wrote:
> ttm_pool_restore_and_alloc() can successfully complete the restore
> process via ttm_pool_restore_commit(), but tt->restore is not dropped
> afterward. As a result, subsequent backup/restore flows observe what
> appears to be a completed restore, while in reality shmem handles are
> still installed in tt->pages, leading to the stack trace below.
>=20
> Fix this by freeing and dropping tt->restore in
> ttm_pool_restore_and_alloc() upon successful completion of the
> restore.
>=20
> 20545 [=C2=A0 309.784531] RIP:
> 0010:sg_alloc_append_table_from_pages+0x38c/0x490
> 20547 [=C2=A0 309.809570] RSP: 0018:ffffc9000623b838 EFLAGS: 00010206
> 20548 [=C2=A0 309.814827] RAX: 0000000000001000 RBX: ffff88816e42a160 RCX=
:
> 0000000000000000
> 20549 [=C2=A0 309.821986] RDX: 0000000000002000 RSI: 0000000000000003 RDI=
:
> 0000000000001000
> 20550 [=C2=A0 309.829147] RBP: ffff88816e42a168 R08: 0000000000000002 R09=
:
> 000000007ffff000
> 20551 [=C2=A0 309.836310] R10: ffffc9000623b928 R11: 0000000000000000 R12=
:
> 000000007ffff000
> 20552 [=C2=A0 309.843471] R13: ffff88815ba5a100 R14: 0000000000000000 R15=
:
> 0000000000000001
> 20553 [=C2=A0 309.850634] FS:=C2=A0 00007f9ff305e700(0000)
> GS:ffff888276c94000(0000) knlGS:0000000000000000
> 20554 [=C2=A0 309.858749] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> 20555 [=C2=A0 309.864519] CR2: 00007f9fca701000 CR3: 00000001565e2005 CR4=
:
> 0000000008f70ef0
> 20556 [=C2=A0 309.871678] PKRU: 55555558
> 20557 [=C2=A0 309.874403] Call Trace:
> 20558 [=C2=A0 309.876866]=C2=A0 <TASK>
> 20559 [=C2=A0 309.878988]=C2=A0 sg_alloc_table_from_pages_segment+0x60/0x=
100
> 20560 [=C2=A0 309.884415]=C2=A0 ? ttm_resource_manager_usage+0x36/0x60 [t=
tm]
> 20561 [=C2=A0 309.889845]=C2=A0 ? xe_tt_map_sg+0x7d/0xd0 [xe]
> 20562 [=C2=A0 309.894045]=C2=A0 xe_tt_map_sg+0x7d/0xd0 [xe]
> 20563 [=C2=A0 309.898037]=C2=A0 xe_bo_move+0x927/0xaa0 [xe]
> 20564 [=C2=A0 309.902029]=C2=A0 ttm_bo_handle_move_mem+0xba/0x170 [ttm]
> 20565 [=C2=A0 309.907022]=C2=A0 ttm_bo_validate+0xbe/0x190 [ttm]
> 20566 [=C2=A0 309.911405]=C2=A0 xe_bo_validate+0x9a/0x120 [xe]
> 20567 [=C2=A0 309.915663]=C2=A0 xe_gpuvm_validate+0xd9/0x140 [xe]
> 20568 [=C2=A0 309.920206]=C2=A0 drm_gpuvm_validate+0x2f0/0x5b0 [drm_gpuvm=
]
> 20569 [=C2=A0 309.925459]=C2=A0 ? drm_exec_lock_obj+0x63/0x210 [drm_exec]
> 20570 [=C2=A0 309.930627]=C2=A0 xe_vm_validate_rebind+0x46/0xb0 [xe]
> 20571 [=C2=A0 309.935428]=C2=A0 xe_exec_fn+0x20/0x40 [xe]
> 20572 [=C2=A0 309.939249]=C2=A0 drm_gpuvm_exec_lock+0x78/0xc0 [drm_gpuvm]
> 20573 [=C2=A0 309.944410]=C2=A0 xe_validation_exec_lock+0x5a/0xa0 [xe]
> 20574 [=C2=A0 309.949385]=C2=A0 xe_exec_ioctl+0x806/0xc30 [xe]
> 20575 [=C2=A0 309.953639]=C2=A0 ? ttwu_queue_wakelist+0xd9/0xf0
> 20576 [=C2=A0 309.957935]=C2=A0 ? __pfx_xe_exec_fn+0x10/0x10 [xe]
> 20577 [=C2=A0 309.962449]=C2=A0 ? __wake_up_common+0x73/0xa0
> 20578 [=C2=A0 309.966482]=C2=A0 ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
> 20579 [=C2=A0 309.971263]=C2=A0 drm_ioctl_kernel+0xa3/0x100
> 20580 [=C2=A0 309.975209]=C2=A0 drm_ioctl+0x213/0x440
> 20581 [=C2=A0 309.978637]=C2=A0 ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
> 20582 [=C2=A0 309.983415]=C2=A0 xe_drm_ioctl+0x67/0xd0 [xe]
> 20583 [=C2=A0 309.987408]=C2=A0 __x64_sys_ioctl+0x7f/0xd0
>=20
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
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
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>=20
> ---
>=20
> v3:
> =C2=A0- Call ttm_pool_apply_caching after freeing local restore (sashiko)
> =C2=A0- Save alloc in snapshot on restore failure (sashiko)
> v4:
> =C2=A0- Actual 'Save alloc in snapshot on restore failure (sashiko)'
> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 19 +++++++++++++++----
> =C2=A01 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> b/drivers/gpu/drm/ttm/ttm_pool.c
> index 278bbe7a11ad..c7aab60b7f01 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -902,6 +902,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool
> *pool, struct ttm_tt *tt,
> =C2=A0{
> =C2=A0	struct ttm_pool_tt_restore *restore =3D tt->restore;
> =C2=A0	struct ttm_pool_alloc_state alloc;
> +	int ret;
> =C2=A0
> =C2=A0	if (WARN_ON(!ttm_tt_is_backed_up(tt)))
> =C2=A0		return -EINVAL;
> @@ -925,14 +926,24 @@ int ttm_pool_restore_and_alloc(struct ttm_pool
> *pool, struct ttm_tt *tt,
> =C2=A0	} else {
> =C2=A0		alloc =3D restore->snapshot_alloc;
> =C2=A0		if (ttm_pool_restore_valid(restore)) {
> -			int ret =3D ttm_pool_restore_commit(restore,
> tt->backup,
> -							=C2=A0 ctx,
> &alloc);
> +			ret =3D ttm_pool_restore_commit(restore, tt-
> >backup,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx, &alloc);
> =C2=A0
> -			if (ret)
> +			if (ret) {
> +				restore->snapshot_alloc =3D alloc;
> =C2=A0				return ret;
> +			}
> =C2=A0		}
> -		if (!alloc.remaining_pages)
> +		if (!alloc.remaining_pages) {
> +			kfree(tt->restore);
> +			tt->restore =3D NULL;
> +
> +			ret =3D ttm_pool_apply_caching(&alloc);

return ttm_pool_apply_caching(&alloc) ?

Otherwise LGTM.
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> +			if (ret)
> +				return ret;
> +
> =C2=A0			return 0;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);

