Return-Path: <stable+bounces-146216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD4AC28EF
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 19:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2827AA1FE
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0D298249;
	Fri, 23 May 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdA9OIVq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB4199FB0
	for <stable@vger.kernel.org>; Fri, 23 May 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022020; cv=none; b=P4apkerS0tTIGXv2C09CviL6tDRR1/8y+fMz7FgtLHgWAobFayUl7A5d6Rlrfz+1GqoDJofUwLJd0c+K5YXdY4TLmn5EQ/N1Ni1SxatggXcBgYcjoz0GB+Z7K+AIb33nURFNthK/kWfaz7jhb2MXEt1xZcKUNbFZTTE5b4QZMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022020; c=relaxed/simple;
	bh=3IqCzY3VQXQx5VM/tdGIovzSklefXyPJoGsX7op7NR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sDobUQvL/ql0/HuoNJfZe3CjXkPguTub3FeGf8gHCJYN/qRdsLn8nIi8Cexkz8f3SRDqjKCd/bmkKpKMQuyuXeFM4txuoLMGp63uVqlCY4AQiheANhF7pqtCIJIlNf9ycVFj6OgfX/BG17VjZFxuVRK6S/LLUYZl0UuCNWsF4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdA9OIVq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748022019; x=1779558019;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3IqCzY3VQXQx5VM/tdGIovzSklefXyPJoGsX7op7NR4=;
  b=kdA9OIVq7DrhsB0VY5LygS79kPhfJeqJ+8DMORcNuMVjhAsh/oeexfCX
   BU9hdPE5v7xQzMDQpjiP97uLg8bXAusvEsSud/ifwKH/nQJ1FEtZ7QEei
   oUyv96SCSNs2vPArFBCdbSqLUXslaPhTwsJfuPiyRDBeR7ecjoAHPJY0G
   1Co0kK/s13nycG3roPR5mSV3JbhcGWKKOIEcR28K3EzYreEPcikv/fKSa
   kqtyTcLovKRIEa+ifNopK03s/gdJ5JlQI+qOBcGdqOMaXO6I2wEHVAVKq
   kaQLDRYKPH8WsUHTVdwB0/Tlx3bl99MadsFeAysbTKZ6vt+OZIMO5UQsx
   A==;
X-CSE-ConnectionGUID: 7+3V2q9NTQ21OxiFAw0ZQg==
X-CSE-MsgGUID: wbHcAAVyRKODOhCON4Fo7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49968251"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="49968251"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:40:18 -0700
X-CSE-ConnectionGUID: v+bG2cJtRTS/53useQODMg==
X-CSE-MsgGUID: 7TzarW26RbyxwBcA33jTAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="178353148"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 May 2025 10:40:17 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIWNS-000Qcu-31;
	Fri, 23 May 2025 17:40:14 +0000
Date: Sat, 24 May 2025 01:40:06 +0800
From: kernel test robot <lkp@intel.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/4] arm64: dts: imx8mp-venice-gw71xx: fix TPM SPI
 frequency
Message-ID: <aDCy9iVMaaOK2Lfh@bdd6ecf8f309>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523173723.4167474-1-tharvey@gateworks.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/4] arm64: dts: imx8mp-venice-gw71xx: fix TPM SPI frequency
Link: https://lore.kernel.org/stable/20250523173723.4167474-1-tharvey%40gateworks.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




