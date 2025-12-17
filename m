Return-Path: <stable+bounces-202801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CE8CC76F8
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C48513019C71
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 11:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAFD29B766;
	Wed, 17 Dec 2025 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxA2LVYf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B1281370
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765972297; cv=none; b=ZNlL54Y8UlNu4PVqEcus7olK3wmG/7gridVGjoAELxsVlNCsYclfN+PpNMT+jUmPwoyRHfqJpGmXny0mV/MXke9K8s5+Qge9J6hhR+jbxAFS8QZR/C/0ySMgqaNqKH+wobZV7kMfaeQZcnt1tkRyEWvj2g6AwgIZosW9UnQnS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765972297; c=relaxed/simple;
	bh=ZzW9PkeqAFB2xKrDbwheruOlKpnxJtMerSgX9hmzzEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WsOKodWrNabjvHzmpc1ABDqBOHZORS9d74/1p/KTW18tdfiMn6xLNLmONm8VRA8tZw5ahHoEeA9T7SrsMW/2R3si6Z8m4gIRiF4CVX5+71rPbgp9M4vDNV1i3yDaA06VwpnqqrCN9FXu27Gdp/ri1ANyiCQKwhO99Y5FiJz7ops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxA2LVYf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765972296; x=1797508296;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ZzW9PkeqAFB2xKrDbwheruOlKpnxJtMerSgX9hmzzEM=;
  b=LxA2LVYf9Dm9Xv3iP5xogrOv+o+jkrfIJXhzR5++OhdZQPfYTehqBKWY
   Yv0qW54SguOsoAbqdnfPA+zt657rlsnqe3usmPStNv6B21ksqEGhV9yK+
   qkuoFasuhf5YVRPyv9Qb1rBiVr3BdltYpz1Qxfl8i6CRMvpzx+aSoWrda
   Q3JnXYKBbPhHNuhQEfgCAIq0z1DQCqpIzE1hde3z2ghtKvCsJtUL3eoJj
   H4FuMYZW+HrtPSUuST1T4EjVLo+4cF/KIzBrlYeNCt+PdFNps7ClFTTre
   7ZAxgcrCxiH8QUw80QH9fVyTew2blW4mNa9N6xMuCkpQ5neND9J5YQHlw
   w==;
X-CSE-ConnectionGUID: EmuGgYNrQgK5tgFionI8Pw==
X-CSE-MsgGUID: jsQ6xU9rQXSqaZMe3K/Z+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="93381219"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="93381219"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 03:51:35 -0800
X-CSE-ConnectionGUID: xaJ6FjZ2RA6UKRjCIeiDpw==
X-CSE-MsgGUID: VkktQAmmSKCfqhaZQ2avig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="197554341"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Dec 2025 03:51:34 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVq43-000000000Tp-2rcA;
	Wed, 17 Dec 2025 11:51:31 +0000
Date: Wed, 17 Dec 2025 19:50:32 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] net/smc: Initialize smc hashtables before
 registering users
Message-ID: <aUKZCFoH_Qapt3K9@b3b84318f246>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217114819.2725882-1-wintera@linux.ibm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] net/smc: Initialize smc hashtables before registering users
Link: https://lore.kernel.org/stable/20251217114819.2725882-1-wintera%40linux.ibm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




