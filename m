Return-Path: <stable+bounces-28581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9558862C3
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 22:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B981C21BE7
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B06136652;
	Thu, 21 Mar 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWXiMYZT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F5136650
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058135; cv=none; b=XztxKy/STPFnQojCIx1l+fi8SiynaEdggfd3hSwwki36J6T3YJsoc+5/6+ct9DbVPxfFumLR9GzD8EqY0Ic5e54kVhBby4mcrStwvYn0kfgXSbr9iLgnqBwS1RMjX8EO7WfeMLmfKYpHIozDHKNjkMky8dcr0MXXtmp6P3zixsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058135; c=relaxed/simple;
	bh=1AtA4ueQfugla61SXLJPUSqYM5jPWhADJV4luNViEkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jt8dTL6KqAn/rR5X1LY5B0v/1lkhLW32V9Tsv2+fGeWlY6mFELMS56W3sxzXpJfaAQwDt3SNlH6ZX839jzRdif3J9P16L7LdIKCLTWjbPZ0882eQzpoU4N2AFeQeOn6US1Xbj2aNpgFxjimCeXl9fmyEr/owtSe+uiYdp/DvSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWXiMYZT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711058134; x=1742594134;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1AtA4ueQfugla61SXLJPUSqYM5jPWhADJV4luNViEkI=;
  b=LWXiMYZTRzQEcO3IfApC5914J4U7utwAih0PT7FOJTXTrxQO+5fPk1Sl
   iWHMA5O13aGS0nwauNvLzXCZGPg8fvpDHzzpsh+7lz/sMAKyW8b4cdYNa
   8xOVW6VVp0tC+d7pJDUN+gFhKvUGwgwxCORvI/bxjLLCJbG2+3V/ucYXb
   FqtncRJl0pT5/mkEnQXDyh6+NF9w8ZdgCpsDDVTTOuaFzwVkyGDGxl80u
   wRa4EZFzceZewrsQVXn/kDvT+SVMHBccBPEVt5PzmWHTLK+OsReKeEapB
   3AHFO2Q15IXCzfeO4JtwSGbItbAEWA86XdIn0uIT0Un69KtVc1rvSTGGx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="31523250"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="31523250"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:55:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="15306622"
Received: from sinampud-mobl.amr.corp.intel.com (HELO [10.249.254.176]) ([10.249.254.176])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:55:30 -0700
Message-ID: <2cb0fc2cb7d1588ed611e632785ca7f9dd1afc41.camel@linux.intel.com>
Subject: Re: [PATCH 1/7] drm/xe: Use ring ops TLB invalidation for rebinds
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Date: Thu, 21 Mar 2024 22:55:27 +0100
In-Reply-To: <ZfyF7kfCE+xcMFa7@DUT025-TGLU.fm.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
	 <20240321113720.120865-3-thomas.hellstrom@linux.intel.com>
	 <ZfyF7kfCE+xcMFa7@DUT025-TGLU.fm.intel.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-21 at 19:09 +0000, Matthew Brost wrote:
>=20
>=20
> Can we simplify this too?
>=20
> 	if (vm && (vm->batch_invalidate_tlb || (vm->tlb_flush_seqno
> !=3D q->tlb_flush_seqno))) {
> 		q->tlb_flush_seqno =3D vm->tlb_flush_seqno;
> 		job->ring_ops_flush_tlb =3D true;
> 	}
>=20
> I think this works as xe_sched_job_is_migration has
> emit_migration_job_gen12 which doesn't look at job-
> >ring_ops_flush_tlb,
> so no need to xe_sched_job_is_migration.
>=20
> Also no need to check xe_vm_in_lr_mode as we wouldn'y increment the
> seqno above if that true.
>=20
> Lastly, harmless to increment q->tlb_flush_seqno in the case of
> batch_invalidate_tlb being true.

I think I can simplify it a bit. Problem is that neither the migration
vm nor lr mode grabs the vm->resv at arm time so we would access the
seqnos unlocked and potentially get caught by clever static analyzers.

I actually had an assert for that at one point. I should probably re-
add it.

/Thomas


