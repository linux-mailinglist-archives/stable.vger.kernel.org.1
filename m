Return-Path: <stable+bounces-75755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89DD9743CB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 21:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9001C25749
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3861A76CB;
	Tue, 10 Sep 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaeqoCZq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F41A38F4;
	Tue, 10 Sep 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998358; cv=none; b=h+fThrHRu0xYOgR7aVBcHXQDjLsYHZW1SR2QvtmIrbE6h4aPkKD0ZYOqsblYceWuCiTU8wMXSl69QMkcmX7GlCHbOc8kumLZ7KLjNga0t3fp5c72j3r+E2q4LYmj2jefJFslprzZ4v8t2Fgj/aa+7A8fAiYdRAGMFHj3LQSmcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998358; c=relaxed/simple;
	bh=e4U0T65qhqvNn3O/S5aK5OkJiPqkvEGFHzPbP+6pPmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y504O+jKcs7FlUE7z9Jcte5/QvfjOPD/qpCNLJXkg3deKXr31Imw9Q2ZA9tqgnCLpu+y+yHyfMSESfYpqpxBTrLNVilvX/Zxe0WmryridNksjnbTktsedxWQDZkLl9Ktv8CE28S8YikIBuepyGc+QF/GelwD1Eqwb1LSAVrTv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaeqoCZq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725998357; x=1757534357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e4U0T65qhqvNn3O/S5aK5OkJiPqkvEGFHzPbP+6pPmw=;
  b=gaeqoCZqRgcegZOHvEYcbraN3DpP+rgf8Hn7uL25mM+GF70OS4SOoJ/B
   VmoATY1ZxtlOg7YKeT9PeXJH6YXoc8vCg6ZjOvWxLKtajlmGxGCFfNOFr
   A5xEIcokfcBETBgllAMbwqld4gqlsoQKFeRw88KDF2oH5aSAeVjhS6AYK
   6E9KmHSuPEf1zdd34rhcICLdrld384mo1Hgf9hKcEjSPnX6Tpqm1ZLBqe
   ZG6N4Bv4udF+XPMTaOVs+3X077/T4UPwZ6ZvNGf7g+3psldxvUql0VTnk
   zGp5EXZhjo7fOJwxbAT23r+nHzvB4NGEHOC+V0PJ1BRG1OF9g2jHABwbW
   w==;
X-CSE-ConnectionGUID: BsmMwsCiSbqkM4njYTFcuQ==
X-CSE-MsgGUID: Z/eMPRLFRd6XXbv6JQU3pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28659763"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="28659763"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 12:59:16 -0700
X-CSE-ConnectionGUID: YI5KDJafS0iyIY+1tVg51w==
X-CSE-MsgGUID: eModdzSlR4yLgRVLbXAgLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="66985748"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 10 Sep 2024 12:59:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8CD95326; Tue, 10 Sep 2024 22:59:10 +0300 (EEST)
Date: Tue, 10 Sep 2024 22:59:10 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/6] x86/tdx: Fix "in-kernel MMIO" check
Message-ID: <gwxxb4o64g5e3ulihhv6aar3m3btkza4vt7gjplx4lvylegd65@vm3sjh243oek>
References: <cover.1724837158.git.legion@kernel.org>
 <cover.1725622408.git.legion@kernel.org>
 <398de747c81e06be4d3f3602ee11a7e2881f31ed.1725622408.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398de747c81e06be4d3f3602ee11a7e2881f31ed.1725622408.git.legion@kernel.org>

On Fri, Sep 06, 2024 at 01:49:59PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> TDX only supports kernel-initiated MMIO operations. The handle_mmio()
> function checks if the #VE exception occurred in the kernel and rejects
> the operation if it did not.
> 
> However, userspace can deceive the kernel into performing MMIO on its
> behalf. For example, if userspace can point a syscall to an MMIO address,
> syscall does get_user() or put_user() on it, triggering MMIO #VE. The
> kernel will treat the #VE as in-kernel MMIO.
> 
> Ensure that the target MMIO address is within the kernel before decoding
> instruction.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

