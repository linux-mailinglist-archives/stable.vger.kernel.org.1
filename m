Return-Path: <stable+bounces-170064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F7B2A227
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BCF16EFEF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85212264B3;
	Mon, 18 Aug 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="La1XjXG0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA91C8606
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521008; cv=none; b=ulfwSiNTZKSehAnGkJ24kgIaBTOg98cKTpnTe7oZJzUqUwy00Qn5lLI2PoDhOH9ldSsFLbWagKWY22kZFNly/Whog5ixrOVOyYriuviAN0Mkn8LPil5j+AltV3PC9j/kAvlFjvQeuQiD4ufulTkH4IG56p5m4z+SRDpDVmAdDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521008; c=relaxed/simple;
	bh=gG3oGq/hJVfxFUTpg6jg7GO9O7GLdA0OnBQMXthbYVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kgsNQsqoD4voQDMVunCUwZdyQHwDdsdfbEdRE1O2lUQEVsprrmVRs3BejFfV4nX5Krew6mCUIY3A36Z2wbAeJ8Q3lkoMuXBB8fydoGPmR0hPNbWK/hSQ2dPJtWECy3OzSEnxAKzY+Z5rYO5Ls6YaeDyPgsQQVNEsTGQPI994w7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=La1XjXG0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755521008; x=1787057008;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=gG3oGq/hJVfxFUTpg6jg7GO9O7GLdA0OnBQMXthbYVM=;
  b=La1XjXG0xIZUeDQR1j74m5bOa1YD+tRUM1561t3TI2f+C13/+hK95xru
   1Rxej8k0FJdUjluvBofeZXk7ud9FniAVnGsEekIwuW99oWMGoDzQB9G1x
   WNMKVontTehnlRGbSpxu36WGHrbAJZvD2qOHXC4JnSiSFMz3CSIv5G3Qd
   d3flpUwDCLveEZOz6WBRIWqKlPGHdpKvyJoWlicd9p2BMBnpsXB3oHdg7
   nLjxaUnZ67hKEDyT4K/22rjSDAiAvgDb0b4QN6/K4RC2RRO0d0QrhNsyt
   0vUvVdUExXMMAbbmmdYw3HJNIMtwsUT6ZHplU1H8wmwZZu2mbXGwGbSMW
   g==;
X-CSE-ConnectionGUID: 5ALAzMFDTNOyBOmHDRGjPA==
X-CSE-MsgGUID: oRI0euxaSTOGoUK5QWxeFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57598365"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57598365"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 05:43:27 -0700
X-CSE-ConnectionGUID: pC+0/5geTbqx5UTMICCXow==
X-CSE-MsgGUID: twCjzM6eRgiFfqaKun1MwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171806153"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 18 Aug 2025 05:43:26 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unzCt-000EE3-2H;
	Mon, 18 Aug 2025 12:43:23 +0000
Date: Mon, 18 Aug 2025 20:42:27 +0800
From: kernel test robot <lkp@intel.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] media: cx18: Fix invalid access to file *
Message-ID: <aKMfs970ReRSZGy9@769e0d9fd271>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-cx18-v4l2-fh-v1-1-6fe153760bce@ideasonboard.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/2] media: cx18: Fix invalid access to file *
Link: https://lore.kernel.org/stable/20250818-cx18-v4l2-fh-v1-1-6fe153760bce%40ideasonboard.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




