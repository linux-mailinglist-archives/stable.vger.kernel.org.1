Return-Path: <stable+bounces-60578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA9935209
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 21:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1D71F2227B
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D2144D29;
	Thu, 18 Jul 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwNzJFH3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EE64A98
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329613; cv=none; b=n2muuH5jmte4lSFIrgDa88UbYI5FgiZciJ0kdm3XIznAIz/Eh8WuWYjoph9RoBgWpJN/Jw+F87YjwmxnF1S6M5LdM4F0+euXe0tOi8xMIF6w5ZFzCPjk06ORI8EeLaPtQF5tr8MU2Dh4lzlEVGPhzDsPZLRWu8FhW6+hZhLN5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329613; c=relaxed/simple;
	bh=F9ysAUKDetH8WdoAEmOitnKXgz4nDK3leXRYxMhozvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QXEd/0ypojrfPrq15vA5gBB4YczMtbosVKRz5leRNQf+82P0X8QQs1KWiw5RR8cKH/UgrgZBOpW75JP8UhCd6M9cfd0nsJbtg702fGX9oyeUm9CQSlkg+ae5S9bFB8LATyCgmbX5XMRfqJTPK0GSIo+p6r12XWrnhuUlpADmY+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwNzJFH3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721329612; x=1752865612;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=F9ysAUKDetH8WdoAEmOitnKXgz4nDK3leXRYxMhozvM=;
  b=GwNzJFH34Q2b9HxP5lDykvhG+QKVWgwmmOUhxm2oF8HJkpoXxV0rYiMy
   0FZboDmM1SjnJaccFj8ybgYZikMsAkK/cg3JfMHFmJemPg9FyS2MqYhDE
   m5CzCBiPDtxLa/wmnUliltUWltuz87W8XqegBbOaxGWdLjMJy8yuGNRUM
   L2TxcydZYLsxfBSNW0tenn4BTIpT0M48zUuyoTGb608h/oWTs1++ECK9V
   Y1F6I5omCnQxlur6pnhImPXDeVuzyF8mviN9DEwHASQYNhbgde1TWPW9q
   e1SyRZuBtZLS9JPGKrSJ/F9LJ7qggvRiZfpqD9T+jegh+089ccbMpDnvj
   Q==;
X-CSE-ConnectionGUID: ImFpc5cwT6ePaMAKAxSmqA==
X-CSE-MsgGUID: otdwI76rTVSNneYksFA28w==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19058988"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="19058988"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 12:06:51 -0700
X-CSE-ConnectionGUID: P5TpEC+ERqmX2Q0Fr4dwGA==
X-CSE-MsgGUID: UVEyMVyeTRm5PBN8HWjVOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="51476701"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Jul 2024 12:06:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUWSl-000hWs-2v;
	Thu, 18 Jul 2024 19:06:47 +0000
Date: Fri, 19 Jul 2024 03:06:16 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
Message-ID: <ZplnqP9l0Dy0YVTF@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718190221.2219835-1-pkaligineedi@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] gve: Fix an edge case for TSO skb validity check
Link: https://lore.kernel.org/stable/20240718190221.2219835-1-pkaligineedi%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




