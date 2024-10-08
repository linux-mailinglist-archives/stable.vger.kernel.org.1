Return-Path: <stable+bounces-83081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B308D995568
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C71528876B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C691E22E6;
	Tue,  8 Oct 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCYhQzYA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE0C1E22E3
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407584; cv=none; b=IoW0n3hpBrZojwUsebXq92GKjjmHN/OTwJk4aCmOzZKdBGSuQP8IYXSBpR7UrZCPy/zlzJdSKNORa4jPkLPr0wVkL/F++Pj+bWQkSnSIJJnPVMSIEbB5bK0uhTuOcRCPQKTEqdbqHtfz7XLS0TdE9gHrUWQFFwvde3oF0hvZS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407584; c=relaxed/simple;
	bh=wl77ye/jgXY4AdYDS3cKAIDVZ23qHS/0yYqrJTj0rV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QwtZ9Wo+WB+kBSfFjm/S3/l1fJ+QbZtVxxVv0K2Me8Ifg4hLbUy6w9hUFEdPAXC/Ozg2mO0E/mdXlaF/ewh64e4PeYboEzc26DYTc1JfCaHzTndRHaU/XDovPQCSXP+rzg4b0wm2mF3jrEuewxPmUBgyjf43VmXWZGXmJA1E1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCYhQzYA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728407582; x=1759943582;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=wl77ye/jgXY4AdYDS3cKAIDVZ23qHS/0yYqrJTj0rV4=;
  b=ZCYhQzYAE2AozPfwDUkWqLAsTsU5rJNimRhi5vbpReodVfyk1QTUQER9
   Lc22T2QAlCKmKyjZjc9l+uVPowD1ApLzMf5r9EEXqbuI9Sfd5AmUBoW2L
   91++LjqLdaMPz9Qkd+n0wNHmTDB6hcsNX4o2Ck1jEj4ZKIXvszCscDLb6
   ObeO/DfHAHPxH5yJmiKf0XXAseYWYfD5AdHKPaiVpm9JOvgbM54OFsQgT
   OYEfTid9e016IOfEnF+PfS4pBYTsG3348i5BMylHekY56oiNiULAoEa6V
   pBBgmxSclSBf1F3GvuDLvfA2kbAsaFJ6gQTQN4UqjXqookC1dBb2mS8Ox
   A==;
X-CSE-ConnectionGUID: MkVSRVgnSHOOkRt3e9sYoQ==
X-CSE-MsgGUID: luVnynyDSH2J/QcoUq40wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38281961"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38281961"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:13:01 -0700
X-CSE-ConnectionGUID: gSLBUp0bQpWCGRrQJC7FNA==
X-CSE-MsgGUID: vvre69b8RMa07ftxkosGzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106737831"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Oct 2024 10:13:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syDlZ-0008Ay-3C;
	Tue, 08 Oct 2024 17:12:57 +0000
Date: Wed, 9 Oct 2024 01:11:58 +0800
From: kernel test robot <lkp@intel.com>
To: Zach Wade <zachwade.k@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] pstore: Fix uaf when backend is unregistered
Message-ID: <ZwVn3tIrrw7gKdnc@b1422e034610>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf30957-ad04-473a-a72e-8baab648fb56@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] pstore: Fix uaf when backend is unregistered
Link: https://lore.kernel.org/stable/2bf30957-ad04-473a-a72e-8baab648fb56%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




