Return-Path: <stable+bounces-104322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727C9F2C86
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3989164E5B
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DB1C2323;
	Mon, 16 Dec 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPlt+zUt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93462E628
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339690; cv=none; b=czykb9aZOi5YSWkDXjoWKKDte+SXS9R+++f+b2cJxiarnzGQdKybja9w2/sMOV5qdnwIJ8TcmTVbc8YyAfQ6bZ//DR+5Uiv9gK0rxLlxCxptMQmL+PcGFNCpjmGSb2uWwUtGpZ4IqHXQ34BlI0Y68tW7oR5F3FbaivBAH0EgeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339690; c=relaxed/simple;
	bh=r/KozuYMeTjHbcO8LwWrshAe4Zp5Zn+4O4INxZnk/Xg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwyM+aIFRKzWyx3W/ntVKv6xOKUrALC3CDzNIdCL9G97O512wPhupMw+08x2V6IxJVK9//ZFv5BdTxsFcy2EZi3geFvViC0OPS5SnvGXocA3aNNVYLo/rPNWWQjWQ/gWm5Y8rEO5ZUg4uA+Uic88UH6XslX5OInomSR1rA80Td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPlt+zUt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734339689; x=1765875689;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=r/KozuYMeTjHbcO8LwWrshAe4Zp5Zn+4O4INxZnk/Xg=;
  b=mPlt+zUtiSzKLonEyvMHKktZfDGzm1TIPfFf1j9VWjeWQFW9WT7ez5Qw
   OG74MA/mXvGeClioS1v5k0AdywquS2+VSsc3HSBmCaZSXfQLZRpObqY6i
   GMs49/dPKBbzxtmg97GkEdLygyzhp/e6Ug8m8g3msDUXVCoB0Z9qW0Fs/
   CShKqWxyhrvUJtpnmkUMBPLJK9o7N4D0WQMuIS1818aWDb9l9Hm6DgJe6
   /Vg3dgSTM6NQjsK64mzbV/Gh9CreSTGWd6LsdqDiVmNlD/odYRIwQSYru
   moeH+z6Gl6yeFoh4vCp51ZGseD5NbxjNm4TqGk+mBULC+Ol3zRRERbp55
   w==;
X-CSE-ConnectionGUID: 0cIhS+BiRbmrx5IBOH0Gig==
X-CSE-MsgGUID: kM8ldLB+S+OpK0jwdjy+dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34942743"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34942743"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 01:01:26 -0800
X-CSE-ConnectionGUID: WpAwzNajTpyWNqhzwDmVCg==
X-CSE-MsgGUID: 6W4ckSrpRCeRz/aYcPelwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102119524"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO [10.245.246.246]) ([10.245.246.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 01:01:23 -0800
Message-ID: <24eeb9dcbb1845bdb420df12384f54d60234a411.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/2] drm/xe: Use non-interruptible wait when moving
 BO to system
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Lucas De Marchi
	 <lucas.demarchi@intel.com>, stable@vger.kernel.org, Matthew Auld
	 <matthew.auld@intel.com>
Date: Mon, 16 Dec 2024 10:01:21 +0100
In-Reply-To: <20241213122415.3880017-1-nirmoy.das@intel.com>
References: <20241213122415.3880017-1-nirmoy.das@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

HI, Nirmoy,

On Fri, 2024-12-13 at 13:24 +0100, Nirmoy Das wrote:
> Ensure a non-interruptible wait is used when moving a bo to
> XE_PL_SYSTEM. This prevents dma_mappings from being removed
> prematurely
> while a GPU job is still in progress, even if the CPU receives a
> signal during the operation.
>=20
> Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system
> buffer objects to TT")
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Suggested-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>

For both patches
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>




> ---
> =C2=A0drivers/gpu/drm/xe/xe_bo.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 283cd0294570..06931df876ab 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -733,7 +733,7 @@ static int xe_bo_move(struct ttm_buffer_object
> *ttm_bo, bool evict,
> =C2=A0	=C2=A0=C2=A0=C2=A0 new_mem->mem_type =3D=3D XE_PL_SYSTEM) {
> =C2=A0		long timeout =3D dma_resv_wait_timeout(ttm_bo-
> >base.resv,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0
> DMA_RESV_USAGE_BOOKKEEP,
> -						=C2=A0=C2=A0=C2=A0=C2=A0 true,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 false,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0
> MAX_SCHEDULE_TIMEOUT);
> =C2=A0		if (timeout < 0) {
> =C2=A0			ret =3D timeout;


