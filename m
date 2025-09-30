Return-Path: <stable+bounces-182073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D191BAD1A8
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE9C1C678A
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919D1E5B71;
	Tue, 30 Sep 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pkktzz2L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E372608
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240311; cv=none; b=gYTgr/WlCcfn3s3F52Cnf1Bs3COZtN+lsxsUzB2ug13MMDoxK2A2G+DrW/SC6m48debWfQF4bd+RzelbaboHtYlSRFZ8D79hvUSTtE1qZmJqFnW+xxT0fgzVheTuUe+dI+OGuTuokUd0HnBUg6nvAEdtmMG4g9Pzrreg0i8l9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240311; c=relaxed/simple;
	bh=L/BDNWWpBJlUBc/cBaBGS0yYN6Ehuq7YPDA9YxCgIUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2LqyHcT2mX2Kigx/xlX3i0yqaFcQHygk6A+6f22ZXnze2I/PMVUdsV3GhJL5v234LA52jMhuqfvUKNYGFyn0gJLLBi0LgFu9rNBOik8DVD9IYvkYEgorV7OxAMJQwX8vT6OoPetG+FnbJh1Bm3mP7txcwb2wcI0gutXKqPPyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pkktzz2L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759240309; x=1790776309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L/BDNWWpBJlUBc/cBaBGS0yYN6Ehuq7YPDA9YxCgIUI=;
  b=Pkktzz2LQzzNXlhSvKAhegrnWpZMBWBfUPxY1MRpGXEtEFg2tNS6/btn
   AKSv6huhdXrsUWq7oEMmeU6jUEP2tvISlRj8B93xj2lc0VxrqWfTD7R43
   DKCmNqoujwjLg8bjk4lh/nZURnnES3Fo4D8q/TWW2Qv7qAnhj/TVPpEnh
   2g9i53oUPaO+J4IrIymI6xvop9RrarQvN0rvmU15i0M9Vruc111CoSfMu
   3HraO10ann9S3V8qIrhVKXKLZrTraniMhVh4wpJdnJ7NvG9Kd40v3d/FG
   ijLFRAuHKpgNjrairP/SUKbzJHHX6RNFtaDNPcTHzgX2DYk9AlcwvNcMF
   w==;
X-CSE-ConnectionGUID: 7077SvlLRaCBF6DPzT3FOg==
X-CSE-MsgGUID: TJjvOh1yQ7iYpOtZmPltlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60706067"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="60706067"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 06:51:46 -0700
X-CSE-ConnectionGUID: Zp+/aNVgR+2mCNSAR+rYsg==
X-CSE-MsgGUID: 7pJDAaIfRi6gOyr5xbuXLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="183790672"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.244.133]) ([10.245.244.133])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 06:51:44 -0700
Message-ID: <902780b3-7bc0-431d-bbb7-fe7b7b7fabd7@linux.intel.com>
Date: Tue, 30 Sep 2025 16:51:35 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "usb: xhci: remove option to change a default
 ring's TRB cycle bit"
To: Niklas Neronin <niklas.neronin@linux.intel.com>, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: Wolfgang Walter <linux@stwm.de>
References: <20250930132251.945081-1-niklas.neronin@linux.intel.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250930132251.945081-1-niklas.neronin@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 16:22, Niklas Neronin wrote:
> Revert 9b28ef1e4cc0 [ Upstream commit e1b0fa863907 ], it causes regression
> in 6.12.49 stable, no issues in upstream.
> 
> Commit 9b28ef1e4cc0 ("usb: xhci: remove option to change a default ring's
> TRB cycle bit") introduced a regression in 6.12.49 stable kernel.
> The original commit was never intended for stable kernels, but was added
> as a dependency for commit a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer
> ring after several reconnects").
> 
> Since this commit is more of an optimization, revert it and solve the
> dependecy by modifying one line in xhci_dbc_ring_init(). Specifically,
> commit a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer ring after several
> reconnects") moved function call xhci_initialize_ring_info() into a
> separate function. To resolve the dependency, the arguments for this
> function call are also reverted.
> 
> Closes: https://lore.kernel.org/stable/01b8c8de46251cfaad1329a46b7e3738@stwm.de/
> Tested-by: Wolfgang Walter <linux@stwm.de>
> Cc: stable@vger.kernel.org # v6.12.49
> Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>


