Return-Path: <stable+bounces-144294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4BAB61CE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620063BF312
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 04:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2771DED42;
	Wed, 14 May 2025 04:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlmTWuot"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E41EB36
	for <stable@vger.kernel.org>; Wed, 14 May 2025 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747198566; cv=none; b=a/CAbopDWInXw+GIqdcSf+FcRA0Mlr9zVia+S2b28idIydknvhuc5DIS+QtrLlMQUi0ya3wR574541Z/AqYTPwKoz1AYt27eO5XAMoM+Ls3v3jlP/03nGkpcLrkQyl3v2u5zVVEwuPKE4QYjyGQvXlO9lTNQgbybskdCHNPEiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747198566; c=relaxed/simple;
	bh=wloAIwv4m4m5G9kZ6z4YRDtm8CUkvJY550uB4C1jkOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRXkQu8RPTBjrICoeJcr/nCJFj3Q/OY/I5YFA6Sc40vyEpeW4bRZ7dYw9kmc2bQFrVOGZ71EKre3gZzuFOv3m4TA1bHWBwERSjdxTM1GwV5N4mSDSmtlWuZcJUsnM79OQFKPp1lsFjzEHvtqPZOuTdG2M35X11ka5E1aAhnF7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlmTWuot; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747198565; x=1778734565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wloAIwv4m4m5G9kZ6z4YRDtm8CUkvJY550uB4C1jkOA=;
  b=mlmTWuotX9HZUBrKlfWANTHDYynPdkU01JS4EivU7N8xyKZNsxIzaiqG
   NYnZbwWGXwh2Xwbnc4KcyTzI/TG+XPCk35D43vKRdlf+Z2SV+bL+TJapp
   lR+sERG+3RewFaOhhFBYnQmNqGHWDFWsyWV5LPNaXCLMgy1OHWUwV1BVA
   xlQcqf3f8qV4oiaydbO3lM3Mqs5qUysaa3lD4iyYa7jWMkj1fKKjKL0KY
   1YxdPmMj86ncfeEwLsLhNr9n2VakwuCHX3HVEh5KfGnX+liP0V31R0HpZ
   2PbTtBeHsF013K4T7ar9cvOJaxXxLAqze8gm03t6PwusFX2rCt8ftJ2KG
   A==;
X-CSE-ConnectionGUID: AshL4IB1SnKg/FS9TYSA9g==
X-CSE-MsgGUID: yvaK9Uy6RQWTMSN1Ba92IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="60475450"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="60475450"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:56:05 -0700
X-CSE-ConnectionGUID: fDT6RzxwTl+SZ+b7KuUgkQ==
X-CSE-MsgGUID: SJsllisUTxKtF9FHPsU6lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="138345747"
Received: from kandrew-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.10])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:56:03 -0700
Date: Tue, 13 May 2025 21:55:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, Dave Hansen <dave.hansen@intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250514045557.gonwfisy34jy4rlx@desk>
References: <20250513-its-fixes-6-6-v1-1-2bec01a29b09@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-its-fixes-6-6-v1-1-2bec01a29b09@linux.intel.com>

On Tue, May 13, 2025 at 09:46:11PM -0700, Pawan Gupta wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> commit 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65 upstream.
> 
> Fix several build errors when CONFIG_MODULES=n, including the following:
> 
> ../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
>   195 |         for (int i = 0; i < mod->its_num_pages; i++) {
> 
> Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> Cc: stable@vger.kernel.org

Sorry I forgot to put the kernel version in the subject. The same patch
applies to other kernel versions as well. I don't really need to send them
separately I guess, stable bots will likely pick those.

