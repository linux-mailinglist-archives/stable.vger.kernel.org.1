Return-Path: <stable+bounces-246772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDfWKgEoBGqDEwIAu9opvQ
	(envelope-from <stable+bounces-246772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:28:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAC852E9EA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 083FC30D441E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E339B943;
	Wed, 13 May 2026 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZENBfBg0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03683D34BF
	for <stable@vger.kernel.org>; Wed, 13 May 2026 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656862; cv=none; b=pKtZSXvdHurDqJH/jMD0e1stxJNO2p9Zv3f4EgxgleJhzMFjpj8SmaW3cIYN4WNtnGIQVQr5qjz3RdEoxyR9U4pXgAt3jmFLDL4m04BlddyZbMoPBDCyP188MTc3iZ3a9/Awz2OIxCkL3BR4vkrSgNIPTe2NZqppjv3RDz0rEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656862; c=relaxed/simple;
	bh=8Pf3UZtBPmTUC54/TMtWx2SebrwAHuEtJ5XI7lvahhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFRqCNA7O7nprL9+lNT2duF3oH6LlK6+3IxkOgBhpK6K+JN8NNsbCYR6Gjrxd6eDrzCPkRlKYVO8na9xWEdaul1iiYWL6wL9ZhTcFkkdIMEaQ8yO5ckjy+Js/GB42JskwHAfI7FMyKK2aURa6SEp4MyDa56tP7rapUH+dMaJZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZENBfBg0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778656861; x=1810192861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Pf3UZtBPmTUC54/TMtWx2SebrwAHuEtJ5XI7lvahhg=;
  b=ZENBfBg0lmvtimfTOVgB4y/8lkysnH5j440qHNQsbaGdlML75/pT6w1n
   SYJsRZnhMWSYUZZFNfn9Dj1KOtxrrJ6R3p8NTcbSR9a1hocDblvwEpj3t
   t+BP8VBxX5ABdo+AZRoEYC+lcNWIG2ZPI6vuswVDJ2JCOjfLZ8bEOgrqz
   MPAgzZ5n8MrvhI9daSxOYqxa9gj6a+7iGkf4I0UZIy37zGoajRDBM2kb1
   3SUx1ELmagzwu1jjaRZ+J64W6X7+D9qY1jrTRvJCp34SH74fUM0tfQ17f
   NF0zEqzNorvUVi/kCRcdeJyIICJ3fEJ5M4d43H0btsW5uxI7i0ctSxaJ7
   g==;
X-CSE-ConnectionGUID: BLQLbEl7RiOz89XtfWBSTA==
X-CSE-MsgGUID: OlrYSU36RnG8Aibcp1PI2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="97002995"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="97002995"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:21:00 -0700
X-CSE-ConnectionGUID: cspXtXtrQXapiE9erISACw==
X-CSE-MsgGUID: I/qqA0Z/Sh+bSpHlKEaJzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="242964678"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 May 2026 00:20:58 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN3tn-000000003eR-13jN;
	Wed, 13 May 2026 07:20:55 +0000
Date: Wed, 13 May 2026 15:20:46 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup
 failure
Message-ID: <202605131522.yUSpVs9Q-lkp@intel.com>
References: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
X-Rspamd-Queue-Id: 0AAC852E9EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-246772-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:mid,intel.com:dkim,gitlab.freedesktop.org:url]
X-Rspamd-Action: no action

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Hellstr-m/drm-ttm-Fix-ttm_bo_shrink-infinite-LRU-walk-on-backup-failure/20260513-095356
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260511162443.24352-1-thomas.hellstrom%40linux.intel.com
patch subject: [PATCH] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260513/202605131522.yUSpVs9Q-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131522.yUSpVs9Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131522.yUSpVs9Q-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/ttm/ttm_bo_util.c: In function 'ttm_bo_shrink':
>> drivers/gpu/drm/ttm/ttm_bo_util.c:1121:17: error: implicit declaration of function 'ttm_resource_del_bulk_move_unevictable'; did you mean 'ttm_resource_del_bulk_move'? [-Wimplicit-function-declaration]
    1121 |                 ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 ttm_resource_del_bulk_move


vim +1121 drivers/gpu/drm/ttm/ttm_bo_util.c

  1067	
  1068	/**
  1069	 * ttm_bo_shrink() - Helper to shrink a ttm buffer object.
  1070	 * @ctx: The struct ttm_operation_ctx used for the shrinking operation.
  1071	 * @bo: The buffer object.
  1072	 * @flags: Flags governing the shrinking behaviour.
  1073	 *
  1074	 * The function uses the ttm_tt_back_up functionality to back up or
  1075	 * purge a struct ttm_tt. If the bo is not in system, it's first
  1076	 * moved there.
  1077	 *
  1078	 * Return: The number of pages shrunken or purged, or
  1079	 * negative error code on failure.
  1080	 */
  1081	long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
  1082			   const struct ttm_bo_shrink_flags flags)
  1083	{
  1084		static const struct ttm_place sys_placement_flags = {
  1085			.fpfn = 0,
  1086			.lpfn = 0,
  1087			.mem_type = TTM_PL_SYSTEM,
  1088			.flags = 0,
  1089		};
  1090		static struct ttm_placement sys_placement = {
  1091			.num_placement = 1,
  1092			.placement = &sys_placement_flags,
  1093		};
  1094		struct ttm_device *bdev = bo->bdev;
  1095		long lret;
  1096	
  1097		dma_resv_assert_held(bo->base.resv);
  1098	
  1099		if (flags.allow_move && bo->resource->mem_type != TTM_PL_SYSTEM) {
  1100			int ret = ttm_bo_validate(bo, &sys_placement, ctx);
  1101	
  1102			/* Consider -ENOMEM and -ENOSPC non-fatal. */
  1103			if (ret) {
  1104				if (ret == -ENOMEM || ret == -ENOSPC)
  1105					ret = -EBUSY;
  1106				return ret;
  1107			}
  1108		}
  1109	
  1110		ttm_bo_unmap_virtual(bo);
  1111		lret = ttm_bo_wait_ctx(bo, ctx);
  1112		if (lret < 0)
  1113			return lret;
  1114	
  1115		lret = ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
  1116				     {.purge = flags.purge,
  1117				      .writeback = flags.writeback});
  1118	
  1119		if (lret > 0) {
  1120			spin_lock(&bdev->lru_lock);
> 1121			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
  1122			ttm_resource_move_to_lru_tail(bo->resource);
  1123			spin_unlock(&bdev->lru_lock);
  1124		}
  1125	
  1126		if (lret < 0 && lret != -EINTR)
  1127			return -EBUSY;
  1128	
  1129		return lret;
  1130	}
  1131	EXPORT_SYMBOL(ttm_bo_shrink);
  1132	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

