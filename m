Return-Path: <stable+bounces-152493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ADFAD646E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F0A3AC045
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 00:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A4BA34;
	Thu, 12 Jun 2025 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lb3oGvzk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6418C2F2
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687831; cv=none; b=dH7twMN7pqP4W9xp5DcE5WoLSFthvKeMHLkaTC6KkYj30G8NxTOfTyK7F7axb5dq9Fb0/FuBfQYg1S+5ytnHXNQ9s1GHpuDivR1lTGXhxWbRJl8xZqSCsHQFmxZc4Oc6D6nthKyy3RVxuGG8B07nMGUGoZwZPGubZK9XRnCI4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687831; c=relaxed/simple;
	bh=zzyT5Gcb0oGSG/QbZlaf7uMoiLkoSuSWyXN9FeI7puk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jt4BKPDGXXQ1aSlHd7IKXzyAa+gcTaPHuzmcOZjBb7QoypXHbfL/R5IE+Vf3SHmwkSM/UEIzKoQF9+UtQrcGf63maF9NNBfYsJFbRLNrxXON3E6q4Ox5ZrWOvoV5rr5kXehJNL8Kw7DNkj+Q9Ubrl14BzDgDPJHgPLQIAzvyQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lb3oGvzk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749687830; x=1781223830;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=zzyT5Gcb0oGSG/QbZlaf7uMoiLkoSuSWyXN9FeI7puk=;
  b=Lb3oGvzkFXpjeUf7pgDvPNdNDf2syaWJgUp/9xHcYhAy/qKgkibOIMXU
   3FeojnSOk3kyDmFqTix4sItT+AHqijMHPzWgd8kE6ly45sFn8rb8Q5NIW
   4NEAC3ZWIpEU/isV92tkPCrVyxiKWLZKaK5QAmfONoQYeKH+96ux1VY66
   yBACj42EVolvLe+4gx4plCDj4qb0P7z2PDAwwjY7KGSYBXq3hERabptew
   k0CQqEk6Ce1baFoS8ipyFNXF9LR/7aab9IgR8ofBRqM0kBdNwbZaOMUnf
   DaEc8l7ULWCS/+czn+u5i6Tg94n/Jkhpi9VBlyuC918cDnscEA/1jg92m
   w==;
X-CSE-ConnectionGUID: omqPTAAdQVOPWt1wmHmKog==
X-CSE-MsgGUID: oTX0DzELRF2Szg9O4lz80w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51993336"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51993336"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 17:23:49 -0700
X-CSE-ConnectionGUID: db44clUqSCqwkTRgf4kaGg==
X-CSE-MsgGUID: qdJNRhGURxm/Jo4jQU9wdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="170523377"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jun 2025 17:23:48 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPVjN-000AxC-1b;
	Thu, 12 Jun 2025 00:23:45 +0000
Date: Thu, 12 Jun 2025 08:23:37 +0800
From: kernel test robot <lkp@intel.com>
To: Karan Tilak Kumar <kartilak@cisco.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/5] scsi: fnic: Set appropriate logging level for log
 message
Message-ID: <aEoeCY0rgX79K2Cr@fa745dba57a8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612002212.4144-1-kartilak@cisco.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/5] scsi: fnic: Set appropriate logging level for log message
Link: https://lore.kernel.org/stable/20250612002212.4144-1-kartilak%40cisco.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




