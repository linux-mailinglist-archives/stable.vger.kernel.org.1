Return-Path: <stable+bounces-172821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143AB33E09
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E593A3BBF17
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCC2E9EB3;
	Mon, 25 Aug 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+Ugn9t0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729652E974B;
	Mon, 25 Aug 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121437; cv=none; b=YFxn4vN7+6J8ZqIi7agb5LWmj9G0oxr9Dx8hi14Stcykdzkm7/4ENShSCvqhGg1MWA5ZmPVmb7KrG4wt3hJhFnoNPa3r5lNp/3sK7tACdti5Eh6L+72286GvJfM9BRK1CSA1dPnWFDEg2bsAb7Ldj+AcgbMy5ew0qv3Bgqzum9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121437; c=relaxed/simple;
	bh=x87kohJdjsaIQ5rPClNEVIdNcKm6NdmBwtjY2tDmXvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gGjUX4eiv1Dl2mJ70GcK9CdJClCrokcfKE2ZyJb0juC1tGJdDQQJjrP59rktVx7S/MbZsv2GDXl2VRUam8GQTptiwMH789XFET4oRbj94VKXKq2D5pAmWIqcPc/rVn/Dcxanjg03grNoY5NWge5vyPgdIbmVjgjCCR++P2ouuHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+Ugn9t0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756121436; x=1787657436;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=x87kohJdjsaIQ5rPClNEVIdNcKm6NdmBwtjY2tDmXvw=;
  b=O+Ugn9t0wdwkIw1FR+AbbmYfuKjsnsdLz41YtTLGQCbzv0sliYqZBhVM
   qnJgbS7Phgatat/lYwNQERyLobWatguDMYMIR8jzSknBgFre1aSrn8ybE
   kvKDLTOngIT2dPckV75eaLw9/2gWX5f8iH4kdWym2XXVHgHV4jG7d6Ta6
   sHob7iZvGS257obwAdKUQw6jjjdALWPLUMxfwbtrcPFRI69m8VJ/9bVP9
   RbRPQK6CWnI2KaGq1/v9N0DnfltNSp/GrZky9mT4W9vAVjsWtJ4hu28VO
   0/RmG3mRjdsI0ekvt+Q/PRAWv5Wt2bTnfRVyEqdcf2kbhtWJoNlpBONlo
   g==;
X-CSE-ConnectionGUID: +FxdGT0FTsqxeMjlCyvwsw==
X-CSE-MsgGUID: CpfGyiZRRueizSVwOGIANg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58273598"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58273598"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:30:35 -0700
X-CSE-ConnectionGUID: Aivx+ec4TRm+Rqv8x6pr5A==
X-CSE-MsgGUID: eQzjb8SmS4CSq4vS3N1dvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="170101388"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.85])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:30:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: mario.limonciello@amd.com, perry.yuan@amd.com, hansg@kernel.org, 
 Zhen Ni <zhen.ni@easystack.cn>
Cc: platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250822083329.710857-1-zhen.ni@easystack.cn>
References: <20250822083329.710857-1-zhen.ni@easystack.cn>
Subject: Re: [PATCH] platform/x86/amd: hfi: Fix pcct_tbl leak in
 amd_hfi_metadata_parser()
Message-Id: <175612142874.7176.15802059886261111644.b4-ty@linux.intel.com>
Date: Mon, 25 Aug 2025 14:30:28 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 22 Aug 2025 16:33:29 +0800, Zhen Ni wrote:

> Fix a permanent ACPI table memory leak when amd_hfi_metadata_parser()
> fails due to invalid PCCT table length or memory allocation errors.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd: hfi: Fix pcct_tbl leak in amd_hfi_metadata_parser()
      commit: d3a8ca2ebe6e3f2b1fb0e8e74f909d109a1d77c7

--
 i.


