Return-Path: <stable+bounces-95336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EA9D7A0F
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 03:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5355162A18
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 02:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB5539A;
	Mon, 25 Nov 2024 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NY9UMrq7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5200802
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732501440; cv=none; b=MC1HqmAsMAuHY7il6TTxkxr9F2OAsXIL4v2gpsOW6Of8ZDVZKsJoy4Q8FjcKsPdnd0NwMLGkSiHv8WCpvhP0ad5iKaLucwLYjfSoEGwKrWWoldUKRnoM9H3cDvPa/KK14MHWEltecR5IJp2Nf964Ydn0SaiXQ+T8XuKtrt6HD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732501440; c=relaxed/simple;
	bh=Qy8zaEScgN0ybcpRjWAuBvdZTenTyY4kf5nOcTvi/9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dIWPz6DrkIO371YNBTPWcpV9PimVEGH6nWHfySrbvXW0K/0I/S1XFeYD0lytvsHt7lDSyKPFgRGVWN1NZ5WKEBuh1iyDm0LshjfyLp/0pmbgQRQgIE0oE9RIVIP9RAdh0kHqPvUcrQNj1jNVWqJOUnaqTQcfo9vmRGIknW/QE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NY9UMrq7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732501439; x=1764037439;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Qy8zaEScgN0ybcpRjWAuBvdZTenTyY4kf5nOcTvi/9E=;
  b=NY9UMrq7y0Y9Ky0BcaRszyfKFqS1k8q3stkGBdph3mMTX2ozN/C0XmaJ
   LXIBuKiojiXPpE2PlCZVe8KUMo5EO41144Nab4qYPDCViF+SazsUh7CiA
   NrFNh5xwLHMz7Qh5IfteQOVfOx0YFrQ3M/T5JJlGt+iCvOzPHrh/1zLgT
   TaD9rcIDuuOkIHufgr3cexzVqKygpHdNQdGeY7GfKArx2wlyy41TSaPha
   F4g801KNNi6PRBrrG24sW7xv5pW325y+cdPed11Lq5GOyvPnWw2icqmDa
   pncjONvqsqZaknhRfe5kQk3WcoLSPKG+loiS9+en2euCrPyPJ3uXGkUh4
   A==;
X-CSE-ConnectionGUID: 2rFhnigPSU2q/KOvCLuZQQ==
X-CSE-MsgGUID: 6DtdrSmAQbCcJyZfu9lQ8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="31955132"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="31955132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 18:23:58 -0800
X-CSE-ConnectionGUID: 7Fe/cxQiQwW7aIn6P40fjA==
X-CSE-MsgGUID: n1U+WmxLRc6JS0ahv0QnWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91545503"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Nov 2024 18:23:57 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFOlW-0005Td-2K;
	Mon, 25 Nov 2024 02:23:54 +0000
Date: Mon, 25 Nov 2024 10:23:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.4/5.10/5.15] cifs: Fix buffer overflow when parsing NFS
 reparse points
Message-ID: <Z0PftUzqwoftS1ri@ca93ea81d97d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122152943.76044-1-mngyadam@amazon.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.4/5.10/5.15] cifs: Fix buffer overflow when parsing NFS reparse points
Link: https://lore.kernel.org/stable/20241122152943.76044-1-mngyadam%40amazon.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




