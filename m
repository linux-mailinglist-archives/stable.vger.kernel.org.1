Return-Path: <stable+bounces-59390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AECB7931F61
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 05:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DF61C221CF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 03:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272812E55;
	Tue, 16 Jul 2024 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTPYCaV8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875EC8F3
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101107; cv=none; b=jIEBU3tc7kHYsdJuvuVmgSwNzxPI9VQHBp7iHCntf5SKKhQx5y6sFxCxmMAEpkwiz5r3Mn2lSWmmZsIAr0iXFmfxeKiM3UMaz9gMpzz4eNxpKAhm6qJ0uJa8UfUb9/YfYZSBDTRNHdhhOec9P6EH1OcaK7ypDAvbPXTS1Gah9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101107; c=relaxed/simple;
	bh=TCDJX7ITd7SyXxtit5l4fsed4qb3PW5vDhuQ22OHsqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rcZwl6B3edPGSJ9Q1r/OEQn/NQ6+b9svPR/LlTIQLnoMZVzmD00SinXcC17riNBBko+8923hOHqol/7r31u7lr3PFORlcuVkbKXTeRjaY2GqMYSk8RXOgBQe2Onlbg6xTxagc9hKOfQ968/LEgTdGblv5DHqwTibpHOYMD9KRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTPYCaV8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721101105; x=1752637105;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=TCDJX7ITd7SyXxtit5l4fsed4qb3PW5vDhuQ22OHsqc=;
  b=CTPYCaV8AyYSxF4ioF+uhv0HSdXHdyNSfroGPlizleDecK+DXiPXKIon
   KwHIlesqQ9PvNVmp/yrJ8hOj/Fua/Mh/SsCUqvTjrLCI4pUUKzlfEHZZ/
   EfXrnI0w06ssYo6QpNt7EMkrajfeFGg3j2TkRWcHhjZmste94yXvqG1mB
   ozwVug4Ryeh9ew2SMKRMXVowEAbTH4MieutLarI9j1M2l9m5Ymt+SFvUA
   wKbTsmuSkqkYfzpk52VGa0/fS5N6xMyn3tC8F651eU4hrA9+ljSvLiW0K
   qbNWTNiyEuV6r5+zN5KyroDRVyvhmzEJ899JENyZlI0HJHHgUw0dqXfVW
   w==;
X-CSE-ConnectionGUID: NNAJDtspTcKmu7ZCmduR4g==
X-CSE-MsgGUID: T7jXFNz8RAGTWbz3nVn7LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29105251"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29105251"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 20:38:25 -0700
X-CSE-ConnectionGUID: srQc5QfDT+esoHBAruG9pw==
X-CSE-MsgGUID: iHH3IMqWQSaRKnVXL4u2iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54120327"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2024 20:38:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTZ1C-000esA-0T;
	Tue, 16 Jul 2024 03:38:22 +0000
Date: Tue, 16 Jul 2024 11:38:08 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible
 string
Message-ID: <ZpXrIH81uKmbynDT@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721099895-26098-2-git-send-email-hongxing.zhu@nxp.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible string
Link: https://lore.kernel.org/stable/1721099895-26098-2-git-send-email-hongxing.zhu%40nxp.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




