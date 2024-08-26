Return-Path: <stable+bounces-70277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D956995F9E3
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978C3280D89
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD891991D5;
	Mon, 26 Aug 2024 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3zV4pjP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B979945;
	Mon, 26 Aug 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701460; cv=none; b=Q45CNj5yIplZ5ETy1vje2Vq1NWBEDrs8+EytsvO3j6WyXuP0IZrS4tefeBh++O1XrhyNMyr2trqBzBaLkszmsZAIFJ4k6ZP6hV1I76UDTKJ4vQaPP9+FYVan0XIuSFedR5HcT8eaS+DkHlq4wc8BKxmTyASqxB4Go4nQoFJX+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701460; c=relaxed/simple;
	bh=2eUyGbCsKmgFJ6viLd9Ww9XjzPKJxE7/qmedy+QVTBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACxlopIXjCLr6Fu9ZWF3v86i3N8zWrXGfo+A4re1YZXy0FLgLYVKUVS6QisRzgVghq1DDzgm/HbMzdmniujkF3n2zseB3OuOyhrYCtFxj5elxecNzVj6JLzV6rL9pAF5ff5sq8lJ2psVMAoO+WM3m/pjjpRp+EJchxH0sPRg0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3zV4pjP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724701459; x=1756237459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2eUyGbCsKmgFJ6viLd9Ww9XjzPKJxE7/qmedy+QVTBE=;
  b=E3zV4pjPyRLuyQJxpTXx0p9McEFSIdu378/J0SuizGaC7EJeNUYMVA6Q
   qjwZ7e7rQkZchuYgvlAkboKraje+cO7b+lmbbZjbWsNr3cegmW0ZNTabi
   6mXv1l9cxGDnDE522fXYIa4WaLHyegA8Cw1YkdqvZFTnpESk81fvVKdJh
   SNgkMBpkr1OnekpM/sju9jWZ/YPe/D+8YinRzEUVdxoyyq7wcHP0K8zLM
   IESdcr4a4zsm9N7wxdXLotOTFzuW0rGQHjhSrMXJ/uVS5IU0KOaJMwwdH
   pTgHWk5w8ZYce9x/w9dkJvbwMNBWDWeVeYLDmpzN4zgAbbo0TXHLsodQs
   Q==;
X-CSE-ConnectionGUID: psPvii0SRU6edWeXomcFZw==
X-CSE-MsgGUID: isMw7JwYRaScpaYAu9BGng==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33714050"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="33714050"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 12:44:18 -0700
X-CSE-ConnectionGUID: gG41QWJiQg2RZLKhhQaUAA==
X-CSE-MsgGUID: LMQiLHIjSqinWvyCMB9jLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62580560"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 12:44:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 461CB444; Mon, 26 Aug 2024 22:44:14 +0300 (EEST)
Date: Mon, 26 Aug 2024 22:44:14 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Fix data leak in mmio_read()
Message-ID: <zz4zxwnmvtcaadlu743s7wcmc4weblvzyy5cpoy7qberd3ckoj@ovsehcctbewb>
References: <20240826125304.1566719-1-kirill.shutemov@linux.intel.com>
 <7401a060-884a-4e7f-9d87-10f5c5ac754d@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7401a060-884a-4e7f-9d87-10f5c5ac754d@intel.com>

On Mon, Aug 26, 2024 at 09:41:49AM -0700, Dave Hansen wrote:
> On 8/26/24 05:53, Kirill A. Shutemov wrote:
> > The mmio_read() function makes a TDVMCALL to retrieve MMIO data for an
> > address from the VMM.
> > 
> > Sean noticed that mmio_read() unintentionally exposes the value of an
> > initialized variable on the stack to the VMM.
> > 
> > Do not send the original value of *val to the VMM.
> 
> The key to this is that 'val' is only used for the _return_ value, right?

Correct.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

