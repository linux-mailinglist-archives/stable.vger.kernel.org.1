Return-Path: <stable+bounces-71486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4B964474
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF871F26097
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F0196455;
	Thu, 29 Aug 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaPRySIx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7AE18E360;
	Thu, 29 Aug 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934628; cv=none; b=Uy4wuaexOdazc1D5myGDMj6PCitlUqMD7uy3vf4Vmt1FBWDPbsxTHEzV3fgO5gPVsIjBIKTKF1rLVewkjbyO5QTgoxsMLsyjtGGgamIHc0syXyK3Hu8JQQugdwaGGd0KQoU102VAZsH8xXhth+8S60+5lqK8sNouBZSJx668UDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934628; c=relaxed/simple;
	bh=u3qcRvtBLlVgfxJ6HUJVJJbVviRspfWgoYS2Mn9zdg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1So9fXTQsXg2tgdl9tXtdyUjFzm46+WnHmXdwoD7cCo1NCt8ep4wMsO54cl5tjCV87PibwNHiUpegv4AfH4QAZXFmj1lWDydjvtKOVWJa6mjN8Mvtmvbwcq/f2cr/qgZMy4cWoLR51bKPgG9OwkNqp35JThb1Gj4SG18UvUq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaPRySIx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724934627; x=1756470627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u3qcRvtBLlVgfxJ6HUJVJJbVviRspfWgoYS2Mn9zdg4=;
  b=gaPRySIx2GU6xqreKXdDmm3UC/+haATlpX95xHxVfXobV4YXC9m6dVtT
   OpU4RWyGTwsYQLOZNtVDV7N5+99NzsoN8ltfoevNDBoM6UMJBgnivJMDv
   zzVl1ItQ8HkYm5dGoBYOUMscdvqiL4YMRKvPHuGNHQ9rl5agcjybS03CM
   ntqRvg8TWU4rBjfEH6b46g9IrRp4dtzZWmxn+RYQerbX9OTgDOxkAByU+
   yfAdWYf3YViP3BXgOF7JtCXmMzZtov3IZjX5I+uXzQWdO0x3KUwnSHtO+
   A8qRZD7Xf+xRR+TRa88B389HdvNTnWOaIRjR5HA+WcKb8Jo56/wIE9Rga
   g==;
X-CSE-ConnectionGUID: UExMX1h+RGmXV09ZIouPog==
X-CSE-MsgGUID: dm2WBJDfQ+CoBwwAkYHh+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27281204"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="27281204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:30:27 -0700
X-CSE-ConnectionGUID: Ksu6FyZYSxijbfdxtrifdw==
X-CSE-MsgGUID: 14sX5qBeSCyBml+sOUFRUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63619919"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 29 Aug 2024 05:30:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 17CD4170; Thu, 29 Aug 2024 15:30:21 +0300 (EEST)
Date: Thu, 29 Aug 2024 15:30:21 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 4/6] x86/tdx: Add a restriction on access to MMIO
 address
Message-ID: <cpbbbdeqkgvtoeqviygn6vcagxl55wjb3nyhqd5fzk2re6luan@rmfr2sbw7tfi>
References: <cover.1724248680.git.legion@kernel.org>
 <cover.1724837158.git.legion@kernel.org>
 <b9b120f5615776d3f557c96e244e57c97ac7d9d4.1724837158.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b120f5615776d3f557c96e244e57c97ac7d9d4.1724837158.git.legion@kernel.org>

On Wed, Aug 28, 2024 at 12:44:34PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> For security reasons, access from kernel space to MMIO addresses in
> userspace should be restricted. All MMIO operations from kernel space
> are considered trusted and are not validated.
> 
> For instance, if in response to a syscall, kernel does put_user() and
> the target address is MMIO mapping in userspace, current #VE handler
> threat this access as kernel MMIO which is wrong and have security
> implications.

What about this:

------------------------------------8<-----------------------------------

Subject: x86/tdx: Fix "in-kernel MMIO" check

TDX only supports kernel-initiated MMIO operations. The handle_mmio()
function checks if the #VE exception occurred in the kernel and rejects
the operation if it did not.

However, userspace can deceive the kernel into performing MMIO on its
behalf. For example, if userspace can point a syscall to an MMIO address,
syscall does get_user() or put_user() on it, triggering MMIO #VE. The
kernel will treat the #VE as in-kernel MMIO.

Ensure that the target MMIO address is within the kernel before decoding
instruction.

------------------------------------8<-----------------------------------

And please make this patch the first in the patchset. It has to be
backported to stable trees and should have zero dependencies on the rest
of the patchset.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

