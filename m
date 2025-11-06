Return-Path: <stable+bounces-192650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49BC3D8B0
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 23:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AE63B937F
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F2F30AAD8;
	Thu,  6 Nov 2025 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQe0U0Av"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0B30AAD0
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762466927; cv=none; b=C1iNV7W1IEAhvZVE74nYZfMjgVD6dn3y5LOp1mZvANUTfB5V0KBzkY+a8y4Hr0AhgL7jZyj2ridLTX+xlzQeVZ0SsdP5jkCiausfrScLZOVSQIGGxhlkwEdVMJ6dKBJC0tYz0JRe71jtUvS+vB7KkhsYl0FizNvV2ees8iHWEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762466927; c=relaxed/simple;
	bh=h9q7tUoiO4KH3BtEiymr4GhzARhR41W3qFR50RhtBwk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VCpausGQaF9ZnLMwawgtmJEf7OjAeZOWagSks3i+nA+O81LDRgydhvX72qvRaXszEk4zM3Ykfc5RyQDIR4ZOjyUSj11UUKCtvNZhGaPn5wvTr/ZbEMUR5Chzih2DgWhdWew8p7pzkHk1JTm+avDN9vovWTiAwC1hH8dmJUCS42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQe0U0Av; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762466926; x=1794002926;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=h9q7tUoiO4KH3BtEiymr4GhzARhR41W3qFR50RhtBwk=;
  b=HQe0U0Avx0WoysAjbiEzaolrmoPXOxNJn3Zcd8LMVizt6s/Jv3zjNp48
   U8g/F1t2mjFxWkS91934SnK9KHBdgsymjABgEb4KDYgeNxGFr6/TFUrtm
   L0oBOUwyF5F5RXNo5MAjpp6TdWyFcGp0QMrYPvk8JXtSxgQMbTz4ETaot
   nDDsyuNQWC2ahSo8uEiB/VcjWejDVGmDApBuv0m9osq/xt2vLeXdW8ssw
   kERN8fcOoBq7LLRqjM86fx0wFFAhrUlwzU35iIBfm+QYcfD7xxjW4apf5
   9sNM+e3AIRfPXPAYZwSGUJf5y3fNt8PtFuCgyTxutY5dNsA7nBTL9uZkU
   g==;
X-CSE-ConnectionGUID: lMfNDeGOSdG0AIhL+ad6Ug==
X-CSE-MsgGUID: mJfPk9SjQiWUmlJLdTb20g==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="76066525"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="76066525"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 14:08:46 -0800
X-CSE-ConnectionGUID: /OM+rSEzSbibsAUWLmz42Q==
X-CSE-MsgGUID: fzW2ZLJdRnKpQlrcxFXE9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="192147060"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Nov 2025 14:08:44 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH89q-000UOG-0C;
	Thu, 06 Nov 2025 22:08:42 +0000
Date: Fri, 7 Nov 2025 06:08:33 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in
 cgroup.procs and cgroup.threads
Message-ID: <aQ0cYUIgN0oEMNOa@4b976af397a4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2016aece61b4da7ad86c6eca2dbcfd16@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in cgroup.procs and cgroup.threads
Link: https://lore.kernel.org/stable/2016aece61b4da7ad86c6eca2dbcfd16%40kernel.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




