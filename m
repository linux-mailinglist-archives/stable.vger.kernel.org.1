Return-Path: <stable+bounces-119941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBA4A49A0C
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50C3188B353
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3FA26B2C2;
	Fri, 28 Feb 2025 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIngbUPB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5C26B0BF
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747399; cv=none; b=BeKoKR92rRf4S1C55w8RMlV27D7SAhYogIeA1l3X4TiqMhC2d4ciICiLPf4IQKmuBAkujaIX+2RqiFM17+3CXCduzDpGuq44QQ9Axh+ljeBG62XpstB8PrvQFR88+uEZlWks+D06e2OhFBsm4XglI+DC3AxVgZvpHA5b7hdrla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747399; c=relaxed/simple;
	bh=TDHNVTNhSPgS5mQri/O2pvx75mWlsb0T+4O/wT+pjUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=un+w9s0ZgtxHxGyFodbfxbyQquZkXaByHBZUj39Hr1n5tGEGQoQe1ScnqhAJvZBGO/WpTI41V+tJqYJzsYPi6HvZf9fmQ3wX+mwNwf23jbM2YMVu67n3oEIa7fSUotHU8eb4WiYnxhnRPUYt4VURnc3DAe0pyTtc3FAH3+K+Ank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIngbUPB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740747397; x=1772283397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TDHNVTNhSPgS5mQri/O2pvx75mWlsb0T+4O/wT+pjUM=;
  b=jIngbUPBtgmn8vnjPgsWYurIBgLOcykir7RF1OCml4pq1bRFQsi2xeYV
   eFi6H5FkB5W6nrno+O1PTz8sUNhn1b6wjEk5Ri10gSb8zb6LRRIWB2zsn
   bDeoScvH9mtSoCxColdvnpEANHAu4o+hBdTKyF2ELCW7y8QDI+Rffy9Pr
   MfcGrfPkxGtlhzB7ZdyL4CIaDapTbt3O/UMt7v6qHF9ymcVIwQYtyULxv
   CwUdfALBxYZc3IJdfXjUZmXNmtcb3sUU2pWHYuqyECW4nnQhRRiTq5pfV
   /74/0ICzgxGsrfJQ9xwJ+XxycFIwO+iBLIJh3BPWxoOh3chPuLY94+l2p
   g==;
X-CSE-ConnectionGUID: IjAO4QRESau8PtWJfuhuSw==
X-CSE-MsgGUID: s7Vh8JXeQBuaRS+r1yDrYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="29268138"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="29268138"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:56:37 -0800
X-CSE-ConnectionGUID: QzIRgdDMSI6kOUBTHIF8Bg==
X-CSE-MsgGUID: HkVAYp+/STW6WxqxuAiW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="148133477"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.73]) ([10.245.244.73])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:56:36 -0800
Message-ID: <2385e181-1f3e-4eb1-b00d-33d09e67603f@intel.com>
Date: Fri, 28 Feb 2025 12:56:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/xe/hmm: Style- and include fixes
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Oak Zeng <oak.zeng@intel.com>, stable@vger.kernel.org
References: <20250228104418.44313-1-thomas.hellstrom@linux.intel.com>
 <20250228104418.44313-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250228104418.44313-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 10:44, Thomas Hellström wrote:
> Add proper #ifndef around the xe_hmm.h header, proper spacing
> and since the documentation mostly follows kerneldoc format,
> make it kerneldoc. Also prepare for upcoming -stable fixes.
> 
> Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
> Cc: Oak Zeng <oak.zeng@intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>


