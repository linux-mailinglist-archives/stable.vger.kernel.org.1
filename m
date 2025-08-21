Return-Path: <stable+bounces-171963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8393B2F432
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 11:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE31C1C8031F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123CF2EF66E;
	Thu, 21 Aug 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uu6gVcmx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F71F3BAE
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769172; cv=none; b=tF36Ib0irwE0uZPr6XAShWt/gJj6mHZh+yTOG9jqR41vbo4qEfO1f0iasq2ZtKEZBBph/Udol1K7pnbhstNx5wv3T/OHHBfS1yDtHyyJy1FFDTxNw8XwoE4Cj0Bz4BJc93A47b/CGwlP2RqS62YBITnHt+c30jGXRaFFensjJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769172; c=relaxed/simple;
	bh=1ElbXRTpxTNqlvMv/v/uJylRQyQ6xnlrO9Zr2BEUfTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jn9P5QfsYcXwB4akZtdUB4eT/tieQ3TTMjKDyBfTuIOnnNHpCGh/xWdsFMhqns2zTJReSxxoqbU2SCsDYHrluXkvSR45mPzhGS0J3JruCxtCifqxmnWZSb0I29NkAHjFqp+CnGa696oNzBzLEXKAs9wVijxfRORLeUF3RUJgP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uu6gVcmx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755769171; x=1787305171;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=1ElbXRTpxTNqlvMv/v/uJylRQyQ6xnlrO9Zr2BEUfTI=;
  b=Uu6gVcmx1u5ya+eUI9193dCkM++I6Qvsslivs+jumltnRLw8bDU2FrxI
   iEJs+zfZkdU+0eJovUeJkqlRjJiauHn8Vav/5nlVK7jIHamNfihDoVpDq
   sE4dBvDKp+pJ7h08aTxlGObSPy6GANts3CiGjTP8KUFwt7utIQ3731gRP
   m/xARWW1gpxYvXN11zDy1T/KnpX3gGNoIgsmp3zXNB6hCjcrPZul8InIx
   XLCIGOXE1mKjupzKTC2p/8CLHhYVU+Mq9ux7PZqPkPFF3X8gySsPwf/mQ
   g4Fiqki139k5mitUblqsspObBACqkiB6nj4d8YJoTLGvHSs0KeOpS0ia8
   A==;
X-CSE-ConnectionGUID: Xw9xYeaXTZiiM55pp3HfiA==
X-CSE-MsgGUID: zhcbl4BwRRWH/HoKHEkuEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57255260"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57255260"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:39:31 -0700
X-CSE-ConnectionGUID: xn5tSe9sQ+mn38AH5tvE+A==
X-CSE-MsgGUID: ZwXDFX/qQbifzgUAHbP66Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172592309"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 21 Aug 2025 02:39:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up1lX-000K9j-00;
	Thu, 21 Aug 2025 09:39:27 +0000
Date: Thu, 21 Aug 2025 17:38:44 +0800
From: kernel test robot <lkp@intel.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm: fix KASAN build error due to p*d_populate_kernel()
Message-ID: <aKbpJDVnjOC41cTM@85d67d3e4d56>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821093542.37844-1-harry.yoo@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm: fix KASAN build error due to p*d_populate_kernel()
Link: https://lore.kernel.org/stable/20250821093542.37844-1-harry.yoo%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




