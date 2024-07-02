Return-Path: <stable+bounces-56311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED8E91EDC4
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 06:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D241F23B3D
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C12030B;
	Tue,  2 Jul 2024 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3+AyBJW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF596FCB
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893848; cv=none; b=SFxxPjMt1kU2zFR1CpeJrm7JgB+flnzpxKgBtTs2NHlg9jl3RszR/edU21S3Ub3sEVog95F4I5jbHUtNZsp+cyWC4+208FmUEqdEi5vi7is5XWaPpmm2Z6UleVQBO9qJCgy70l0v7Tj91mQPJgig2QnUKCxw6tpMJ2zM9JdELGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893848; c=relaxed/simple;
	bh=4RBsP+gLp7CEDt736ft2qwpPcaY/in2ja5pZhYfph1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LQnNwBEanGwqWR++Kid3/mLy+81+Nt9TjJp6cdYXWpwJz7+O0oQuA21KydzsB3jVgAitoDrjs9XoqjspNBKELxPhGVpZW1luUrwZmsbT/9ZJvN501PXMUXWU3gVHizo0bHImydbJP/w+9O0I/2Ww5197WE/xu2limzfa2FzKxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3+AyBJW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719893847; x=1751429847;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4RBsP+gLp7CEDt736ft2qwpPcaY/in2ja5pZhYfph1U=;
  b=O3+AyBJWsxTmlAgZu6/E13FON4aFuOmeTr4iMCjfArKYj4bEAajvuEux
   mZqE85pU+0LpLui6XAwEFuD9bSNUAjFuYHkUIg6yiIWuGmJNAj6DQcLQ9
   fPCa6RMwGIiWIogRz7PZcO0CSztogbu1bDX0dCWtcQP/RcTXqMfOyUrjU
   lXG4VK5Y9GzDaqoC6lg6CHVt3G1W14/z5lR/aZ37jpOZU0FBigeeL6SQb
   5NyP6W8n7y5rpQ/wbN34ACRnawVhQbqVr/8qhjFgU5Cxej8tL29Nv3ZO9
   lShH1zYej/Eq+9wj4yJuZdESry5WQBiqe4o8iQ3SHgA7zC5ToR6bj+2aa
   g==;
X-CSE-ConnectionGUID: uCX86P/BTCWplfGi67G1Bg==
X-CSE-MsgGUID: HxFC/W/QT+uTqfBK+ipXuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17186718"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="17186718"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:17:26 -0700
X-CSE-ConnectionGUID: VayP5luzQQar7sU/J4MTrg==
X-CSE-MsgGUID: UdNM6wJFT5W//+uYn1WPog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50207570"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2024 21:17:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOUxG-000Nhc-0U;
	Tue, 02 Jul 2024 04:17:22 +0000
Date: Tue, 2 Jul 2024 12:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/4] igc: Fix
 qbv_config_change_errors logics
Message-ID: <ZoN_NLFz3jyc2j29@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702040926.3327530-2-faizal.abdul.rahim@linux.intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [Intel-wired-lan] [PATCH iwl-net v1 1/4] igc: Fix qbv_config_change_errors logics
Link: https://lore.kernel.org/stable/20240702040926.3327530-2-faizal.abdul.rahim%40linux.intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




