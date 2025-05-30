Return-Path: <stable+bounces-148330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D9AC967E
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 22:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E43505BCF
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 20:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CAF2798EA;
	Fri, 30 May 2025 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+UOADGn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18701B808
	for <stable@vger.kernel.org>; Fri, 30 May 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748636337; cv=none; b=ZnNRqX6cGt0gU1LNTjBjggSesjaD5KQpsJP0z2Ps45odJRxmAp1FK75crFhVV9geW3X54UIvueEIzeG0M0uirppD6K7YctYBKWCJ1HA6WOm8cxX/xAVtFnBZUDs7UVYr870ZHIyhfwN8B+5IX+6Dfs8Au8LnbhltkHAsMbysuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748636337; c=relaxed/simple;
	bh=TsgzG3Siem+ZVZDw0dpx4KwtjEDzRLPVNTomrJNMVxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jHQ6ygPWMrXTH2jawvroiSMV+f24LJoqDR+GDp4b6UNtgWSa5CXy6hshwNtX0vBfjVAjvP6k32pa08eqAJk758zHgeekkT1edlWsiv8uwJMCvtMr3WuouV/dtCP44vqSkcJt6YW+vD7MpR/+GCzYMS7BXbf0AZGu6YuwuEb1S6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+UOADGn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748636336; x=1780172336;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=TsgzG3Siem+ZVZDw0dpx4KwtjEDzRLPVNTomrJNMVxM=;
  b=A+UOADGnmEUGooztxYWnmjBRtgpmTE+GtTQ03RejVwYG+JkkySH9shTc
   8wqp8UuDyVJd7ktkRDnOgkUmBNZrq7MwcW7XexsYSyr9K+5UBR0eWk2CB
   mx1ANINv5ea36xYcK/UJ1aNC89ODB/ACfb3gGzU4x9I9WvNbO1B78QVWY
   VFLcR9i7tseO4/4pmQUv8hWM7roea4tLMbLujh3DkQQ8SyOc3Pw678hpr
   53//NJ2FZouDOK/r6PHmRtgdcot8yzKJeLH7gijpAroUOyGZUECxzspRD
   ezyL1Gg8Js29prZ7XxJCn2m39bBHp913RhmTeNKYUdA/NK2KuvbEtRkEu
   w==;
X-CSE-ConnectionGUID: rZjGqezeR2iCn11iG7AR9w==
X-CSE-MsgGUID: 576XXVcMR1KA8cwqsX9+aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50789603"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="50789603"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 13:18:56 -0700
X-CSE-ConnectionGUID: uxk+OHYnQA2jvHA7IeTLpw==
X-CSE-MsgGUID: F/kbG2q6SZ6xu/N6tM6EKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="167149943"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 May 2025 13:18:54 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uL6Bo-000XwC-05;
	Fri, 30 May 2025 20:18:52 +0000
Date: Sat, 31 May 2025 04:18:29 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap
 cache
Message-ID: <aDoSlYVIa8rtJupb@679c1d4e5b58>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530201710.81365-1-ryncsn@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache
Link: https://lore.kernel.org/stable/20250530201710.81365-1-ryncsn%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




