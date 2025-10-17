Return-Path: <stable+bounces-186220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B54ACBE5DAF
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 02:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 623FE356D2A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 00:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23333468D;
	Fri, 17 Oct 2025 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cw7956Tp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B91C2BD
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659428; cv=none; b=JPcbjYAABwCXa8pXnxUXvDMDMP90CY091KaLR0a/3fW094FOiWla46sf1KdUD+tGu6jkaIOCUG7LEw7kIJRRRrqdvighVXPysSUUQXpVebMs4yIY2g2ZWkJ3h1Uk2NGs1Wug7097GAumqjSH5fleKCAb971gJFZNzCZQ9nB6VOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659428; c=relaxed/simple;
	bh=XCJfqZwC7cnpR+kw7B7sfOMZds0usZEGxlHWj+TxJfM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Uktgh/O9+W+DQOeDtc64m2quxZIEiPy+PgYz+1S650ZY3QZNGaKDKHaAIBM3o50jsJVo0kHUwNNh7ChYBZkGIMN4YjyFZCld9M9I+CUjOrqpK3wHbRRGUhduMhC6PuR+myBT4HEYxBdqV/Qxo3CT30ri867BX/AOCDv3/KV9JHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cw7956Tp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760659427; x=1792195427;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=XCJfqZwC7cnpR+kw7B7sfOMZds0usZEGxlHWj+TxJfM=;
  b=cw7956TpEwqu9CXoIJLskJXxUc845q7nKphbLhsq/3VSp3+iZRZHvSvz
   U/YwrG2Ppxd9Zz0mE8Y/9ihNCvAg5epz+PiWFVP7RzGMI5bjZjBmSizvj
   KQLjBwRIIt+RUso1+uvWPDmpIgNR1tJas+ligkINY/vGnyvNqm4skYz+I
   FLTODiKv7juHFPTflhbXa1LADhjkN9YLE2Ausr0oSMTKbxh+DphIzt99/
   1cqJMYWzLM+8bQahhb1/JV//nNAcHI5sDX3nOYfsfoDr+6XPk5a7CpKYa
   jqS7eyiCvY1G/Q1HBPPEZMhz4U0Wgwe/SjvZ4QLOnKLtSf5I2XYtUdRys
   A==;
X-CSE-ConnectionGUID: +PBQmy55RjaSQmVy2C4B9A==
X-CSE-MsgGUID: bI3UyGn8Qq+sxm53EoBwVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73468496"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73468496"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 17:03:47 -0700
X-CSE-ConnectionGUID: XF0mIRxfQDC7GPSyakwQtg==
X-CSE-MsgGUID: sNEoQj5LSJeJj4AlDwv/xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183386366"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 16 Oct 2025 17:03:46 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9Xv6-0005L9-2J;
	Fri, 17 Oct 2025 00:02:14 +0000
Date: Fri, 17 Oct 2025 08:02:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jameson Thies <jthies@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set max current to zero when
 disconnected
Message-ID: <aPGHfr0ua5aJeZLQ@0fa591faaba7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017000051.2094101-1-jthies@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
Link: https://lore.kernel.org/stable/20251017000051.2094101-1-jthies%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




