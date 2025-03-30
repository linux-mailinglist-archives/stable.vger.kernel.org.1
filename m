Return-Path: <stable+bounces-127012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C1A7583E
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 01:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBFE1682C3
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 00:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AC4431;
	Sun, 30 Mar 2025 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8U4njPO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5379EA
	for <stable@vger.kernel.org>; Sun, 30 Mar 2025 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743295118; cv=none; b=pi1+EKlkETkBBQXPaSEwqNwLeKHISOB+mJvMplIeGQg0HNULi7C/R99Xd++DCEOhBYtD2Kqx6tzXnsdt15ev+ViW9D760k4FnOPXiWlWSIek2E9U4yLLpD2W+LkM5jVskoWzONvi18XD8bteLBaEmHhzOHJ8Zl2x+4qj/6ZMpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743295118; c=relaxed/simple;
	bh=WO5FMS8kbpXGy7RXv6RQa6IJb/8q/1RyuHgH7E6XOkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NIb6kIyYQp7gWiqo4tTT+wusuOM58zcvjQo3jSj4/OVr9cU0szTLS0i8tV4G9bqZFUZ0UlZwiJBfH3jBnI8/rFX5MVHZXknx/JtlulGo4jd3kbW9VN2dLt99cQwa22ImMKthRT28tc+S4uRCPbQZVuj+UlqBX9JmVUg6IvcLb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8U4njPO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743295116; x=1774831116;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=WO5FMS8kbpXGy7RXv6RQa6IJb/8q/1RyuHgH7E6XOkI=;
  b=I8U4njPOzQE7GKLZRMgINQ/7WfxR1r2AipP9Iuw8y5xyzneEKy3+ZDMx
   O4lhi3KH9vgx4NS+amHVnEUlnl9TQVYXhbOdmPaqrww3juFFYMBxMSzkM
   qc6j4WZbYg4WdHI/1KIh29JI1uS/6zD2txHZ6kWa04KR9AeRRHx3Jo1hv
   UFq7qnpMnPjjJht8g1QHEApUyv6jxfejWh066zGGSi8Ei9at1YfhabH2p
   3OEKwyW6ugYRSipxGT9kFjvbeRU8+by8UM1u/jQS8zDATUnaEgpQwciE1
   42g6k+KLIautNqJnmXqVnmVh35ZWaRXPfdXv+h/itBhozazhlGB/86EDD
   A==;
X-CSE-ConnectionGUID: U2uICaYiR5a1nScAg36eag==
X-CSE-MsgGUID: mZ1O0tJ6S7CCfkFvqKFtgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="44534950"
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="44534950"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 17:38:36 -0700
X-CSE-ConnectionGUID: p5e6QtJ4SpaqQppTa0QEog==
X-CSE-MsgGUID: ILQ+Jzw2RPmJ58FDfOFoeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="130613367"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Mar 2025 17:38:35 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tygh7-0008SD-0K;
	Sun, 30 Mar 2025 00:38:33 +0000
Date: Sun, 30 Mar 2025 08:38:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <Z-iSb0ryR-tiUCj0@42be267012b8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330003522.386632-1-ryotkkr98@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/2] serial: sifive: lock port in startup()/shutdown() callbacks
Link: https://lore.kernel.org/stable/20250330003522.386632-1-ryotkkr98%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




