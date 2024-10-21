Return-Path: <stable+bounces-87595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517B9A6FF7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24821284839
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C9E199223;
	Mon, 21 Oct 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VU9YB7Vu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964A433AD
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529119; cv=none; b=h+VAlOEZaLrZuTxZaXVGunlETrpUgj0e+rLhYa8UL0r43s9umNxTClWhznnVzH30WB78Pg2c/Ag0gtJTjFON6BFmp+tb/pgnCHWVPA9i086X03X9X3wfxxc9BfkjkDUNuaz8N4KBGhJWwAjz8G+EjYMccfkUCmnJn5CUPhuiHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529119; c=relaxed/simple;
	bh=9S5XWeDimO7T8Z8cx7YkEdx1zBb59Jbi24biI3eiu6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X68vVknTPW0GFecAcsLQ3xXhSMgqEqfw+yFCWo4aI5DpCjDdtHtgNkEk3+tv6zJzGqE93jqmjjsuC9yoGKxrEDNHW3frunzmrRoAcYHmDgXbwBIexCKogM/x/sr15naUt2Qb+2lCrndrjJT4438h96PbIZrW438ym1Yf/YmxWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VU9YB7Vu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729529118; x=1761065118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9S5XWeDimO7T8Z8cx7YkEdx1zBb59Jbi24biI3eiu6U=;
  b=VU9YB7VuBthdMXHqnAwC0RU47fUaABbvRsCFBNnMbEjXoRq8/CO83fLs
   yfy4atN1yI14fTLmIlyJYRvgmoDijgG7VqqGMnq0/09W17TIRTxB02SVh
   hX8IjAFwnxB0AbdjZST7EGsSFX9XsUJVAP6sdF2wiyRbYG/U75aEFQFnY
   imJY8Xy8SEQdLUWB3Bo1xaKyZCOHFe4NDqHpRCXpfi2MNFc+AattujaNP
   qGhM/pr5Sd2yKDrSvScDSaxxp7tL+DC65IqXLY7c+r11ES5H+LVqS7w0/
   d1XjQt3Cl3xLihafsPGenhxBTKff5V3Awx0b6b5Z+X1hJDQW7pTh5ZNXD
   A==;
X-CSE-ConnectionGUID: 9CoacWK9SKywRKDGiA+6kg==
X-CSE-MsgGUID: Sd6Iz+LbS3GNBWIZ8mTz3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29186538"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29186538"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 09:45:17 -0700
X-CSE-ConnectionGUID: 7K0B0aKcRKGHohFlsYWy1w==
X-CSE-MsgGUID: mowclFgpT4uxwqF6Dnz5ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84401460"
Received: from cphoward-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.124])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 09:45:17 -0700
Date: Mon, 21 Oct 2024 09:45:07 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: andrew.cooper3@citrix.com, brgerst@gmail.com,
	dave.hansen@linux.intel.com, mingo@kernel.org, rtgill82@gmail.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/bugs: Use code segment selector for
 VERW operand" failed to apply to 6.1-stable tree
Message-ID: <20241021164507.vp6zd5tzyrmzhwc3@desk>
References: <2024102128-omega-phosphate-db6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024102128-omega-phosphate-db6c@gregkh>

Hi Greg,

On Mon, Oct 21, 2024 at 10:13:29AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I will send the backport for this and the older kernels where the patch
fails to apply.

Thanks,
Pawan

