Return-Path: <stable+bounces-88231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575DE9B1DB2
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 13:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADBF1F216AF
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152D762D2;
	Sun, 27 Oct 2024 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AD7YurTN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA11210FB
	for <stable@vger.kernel.org>; Sun, 27 Oct 2024 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730032569; cv=none; b=sBku2rCxqmYyjhnWYlj3n/0sUF1nyMyKs2zCwKi0BRhz1m1m7loAATvoljgg5sXOHqulcIUiO51dZZe9XDr9PT0Nmt3c2J4SsslA0xf8hf+6RjRH24TTeT9SOnUaARo4++MG14W5MeyQARcuLx3jGCeM4h0RZfUJSelXGAgPbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730032569; c=relaxed/simple;
	bh=UCk/NWQxyHZwAnXjfMxpEmATvGT+JlmuYIwC6blKuCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J0O2GRjlHPN0Raj/bnr7tEzA5hzwor8HzCdHY/420Bi116zPR35IAKW1IkrK7n8BjxW1vRZSfUiykz4HgHTTD1zSX24BouPLjO3eF7otqvia6V8IXRpX8aVIIhlD6mqOPCi9yo6p1AYzHBYuhcsUDFqavBfGTOefjPFeYJ206M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AD7YurTN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730032567; x=1761568567;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=UCk/NWQxyHZwAnXjfMxpEmATvGT+JlmuYIwC6blKuCk=;
  b=AD7YurTN4jpo/w3X61i5CBylVuVG9xxFa0TrJas7jBVUMBCp0h9zus6x
   9Sui0KJYNYj8KBhcBDYGii2Nje2e3Lj70F23nOplpF/raY+ZxT61m+Eyb
   u22mlb1geh1dQoZJeCT65DFQGZV0/WYAFR5V3uhCbNtZ1AWJfrpT6USec
   TFWxNWBJS/oEQptMC1c4gHAGNI7GQQC4IYp/PHEfBgDiXdf8DeiRqESxX
   lqw9+E/hkRHzoqmDLmcMfCzKy9VTrbre2E3yqUs+z0KZNnq01iF37kQCI
   DxYsomAkZlb4M8zZGZM6gB3ZDxnSx31vDLzXhMwVJ6VeH9vAtpObAIJ9z
   A==;
X-CSE-ConnectionGUID: PLzfkpi8QhaNEIE6X3mdQg==
X-CSE-MsgGUID: FbeNiwkDTFGxAeEf84Vr3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="41016265"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="41016265"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 05:36:07 -0700
X-CSE-ConnectionGUID: Y31+veZZQaGvZP+f5uSNvg==
X-CSE-MsgGUID: O5nlxAN2SvGq0J0cTNfclA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="86479854"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Oct 2024 05:36:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t52V1-000agm-0n;
	Sun, 27 Oct 2024 12:36:03 +0000
Date: Sun, 27 Oct 2024 20:35:24 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH hotfix 6.12 v2] mm/mlock: set the correct prev on failure
Message-ID: <Zx4zjCYaH6NcqACS@bf9bdfd6a989>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027123321.19511-1-richard.weiyang@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH hotfix 6.12 v2] mm/mlock: set the correct prev on failure
Link: https://lore.kernel.org/stable/20241027123321.19511-1-richard.weiyang%40gmail.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




