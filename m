Return-Path: <stable+bounces-192912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604CC4513B
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 07:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37DA188E49C
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 06:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D97227B9F;
	Mon, 10 Nov 2025 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vy0GR/a7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1A19F13F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756028; cv=none; b=q7Vm57RANQbA0x0LgaZmDMRbEvyRM/hvKxpzKAtHw/+VD4TYUKV7b3OVrp+UFO3gUiznr23d8HfXXclKtnvqaWVkhfEGYW6CGDQVW1kXPjGucHcMVnkiFEeXpM+vcODs8SKqjN/DCnZi5yD1JuIGMORySIEgzdn0E1TusIsTzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756028; c=relaxed/simple;
	bh=HWzC7zpraGIpTCNuY/j0kH9Pr9vt8PHVS5TX6e66vZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ERtj3AdWJ8eVkH+CQMY980GCdNTVgAX/Uki5Cyr9nUSbg00tcn0TIWT9gsN8y2ba3SYxGiZMzvgCNs8VyXApGKSSNFfHuts3BozTdy0Bln03lYW5E1aPy9VPirkK5XTrE5q+jWj75St8SpunTFd96gQN7ZT099fbST4zLsx3TeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vy0GR/a7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762756027; x=1794292027;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=HWzC7zpraGIpTCNuY/j0kH9Pr9vt8PHVS5TX6e66vZI=;
  b=Vy0GR/a714y+t+PAYmivZdxZ7fGF2NXnVe+hNKJV+KrePfXWgR9S3BWo
   LzXDl58pHzAmOPadndiZuz35SAG9ks9lOmQvIQ/L2QSLoLfE0O4cqP3HE
   G11vSWMJAgVxGIJjTKAUUko98EH5HUIvAesUQLaK6IvcPcfkInn86WCBg
   LS0P82CVUZnzxOfelMZwU17Q59nqpJq0Rd868DaRAVP1yoLQUnQvzQViG
   reoph70w4IG3OmRe6NoSE8JN7IT3lzm283vYlI/uCIpURYGszkamtJVrX
   1ioC4WP+a2btR39rbWYvY4kWCbPwc0kTMglLQ2dosLuHx1t9wyfxRFAcx
   A==;
X-CSE-ConnectionGUID: 4nwGP1UMSRahkwOQSEkaWA==
X-CSE-MsgGUID: knAVBEcmTtO+vJlU+S9oPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64502853"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64502853"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 22:27:06 -0800
X-CSE-ConnectionGUID: y72OW6nsQSuWgDW+Gf42zA==
X-CSE-MsgGUID: IbuKepxeThqPXJCng2iACg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188236098"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Nov 2025 22:27:04 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vILMk-00005f-11;
	Mon, 10 Nov 2025 06:27:02 +0000
Date: Mon, 10 Nov 2025 14:26:58 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Message-ID: <aRGFsvTZ4y5RmTwu@8d1a9004a541>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Link: https://lore.kernel.org/stable/20251110055709.319587-1-wei.deng%40oss.qualcomm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




