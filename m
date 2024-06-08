Return-Path: <stable+bounces-50035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F79013DB
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 00:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E563F1C20C10
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B4FC19;
	Sat,  8 Jun 2024 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMft1bad"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44723ED9
	for <stable@vger.kernel.org>; Sat,  8 Jun 2024 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717884270; cv=none; b=E2lxtSIjc9qFJ0j37hDb+qrey51MFVz/rIdUvUOqbJU9nfDoO6LbbaTAHLFWwkL7LAmV2YjsVSy5dfLOL6gs49/DTjl71yf8Hy63HsQcRLGllDz81uG1cClmL4/qXI88siQ/XaWQlqp6gYY6CHRCWupfO9Q7H105eXEE0fJMq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717884270; c=relaxed/simple;
	bh=4x/wbLe2PsSNZLwgVL5Tbh+2eG/dnZ09BbiXyQ4ehGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aEaVkzDR9g+QHEym3YKsk4YHwuW4CRizBXT2Y0v0Wh7465ygmR6ai5V4eQN+BY4k9L4Ek3t9EfT62KPgg6UIAY+YrUGwoOfEPzg9XstQLB6f9rOcmTaBVMsgvtOGrOmV+qEgbZ1bzBLmGcWr6/GUhMQ+xjwtqJlE7XqYqRM3Sa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMft1bad; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717884268; x=1749420268;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4x/wbLe2PsSNZLwgVL5Tbh+2eG/dnZ09BbiXyQ4ehGA=;
  b=eMft1badh77LhMcPx3Bn0wVvyoa/RhCTjIhfBi5CCaPBHX2eNz4H+b3h
   j+s5XzCVdxi3jkye8EWJZ8s4g553Cy/pGsoPjivG2neaZazflp1ADHpgg
   mTgEoED8hUowSdd+XcCovQp73wWg1jZD7K1+HAkv/WTgm/rJdgqkdYsh9
   eeaLgDYt52XBZ5HsvxO84LWWrJEbW250McHv+8GK5vYELNKwZw55nM/iI
   vPn+zoFkgTj9J5OK/QjpI6vYuuJ7mLgg1Z/7XoSDauZRSCzeEgqFCzjd/
   m71gMWcw1YPSVt+iYx/G5KS92+kOKDVGoGEnZVKgBVCCryKvpXr0vEhAd
   A==;
X-CSE-ConnectionGUID: X0X3BUYFScGixcWCmAM3rg==
X-CSE-MsgGUID: DdLDjy03QF+sbN6/wIabmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="11979266"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="11979266"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 15:04:28 -0700
X-CSE-ConnectionGUID: +GTs2wsBQ/eGgp9oq6/QCw==
X-CSE-MsgGUID: 09CZe+JxR/mZ76L1YLCOEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="38755030"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Jun 2024 15:04:26 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sG4Ai-0000YD-2g;
	Sat, 08 Jun 2024 22:04:24 +0000
Date: Sun, 9 Jun 2024 06:03:31 +0800
From: kernel test robot <lkp@intel.com>
To: Pauli Virtanen <pav@iki.fi>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Bluetooth: fix connection setup in l2cap_connect
Message-ID: <ZmTVM9A3CDRUGKzZ@242c30a86391>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9169c3e607696a9430f5beb182c914c136edcf.1717883849.git.pav@iki.fi>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Bluetooth: fix connection setup in l2cap_connect
Link: https://lore.kernel.org/stable/de9169c3e607696a9430f5beb182c914c136edcf.1717883849.git.pav%40iki.fi

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




