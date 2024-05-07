Return-Path: <stable+bounces-43164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED58BDC29
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 09:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931211F21BF1
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D277113BAF1;
	Tue,  7 May 2024 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNKiet2y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371013BAE9
	for <stable@vger.kernel.org>; Tue,  7 May 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065908; cv=none; b=CLF01OmW9QrKHhDBorcXtyqscrkhw02LBHTiBF2Mn0GIvJ7PV34mN2EXsSEvZksXaLaDl09X0ytkY9fZhKfnmiOqzds9Xv8dANiw31b3U59N8kJBR6tbSF0KNxP6EEtrphAyfZ1/uxWEtUmWiGawMctoIpnPjufGmRr7cj6OhB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065908; c=relaxed/simple;
	bh=jOjJgk+C6qM8SRiOLIXC5KSmW3EnYW1nZhDW3oBevEc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p44wi8iVKYKGzILYiHCHBfMnxAiEjnZXYgcgo9K/VyWqlf+84onQeYNC7pVrprV7eL/F5umGCsCjGagjFKdYhy90/eyPW3RmwQMWhHrx499i19iF7nQbKwC/Pr9KbqdKPpsMqo34PLuPccEMjtlGGhYg5CeRSTER0aFm8GBCivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNKiet2y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715065908; x=1746601908;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=jOjJgk+C6qM8SRiOLIXC5KSmW3EnYW1nZhDW3oBevEc=;
  b=ZNKiet2yLAxsXOYz6mM/juHIcxCc9k2rH6rNa4JZyNjXr6EEGGbFLBo3
   /n2Rlhq4VW8AhvntSrnj5zSBHIyHJpm2tsQv1udmlvnQpar2Vdb9fz2rj
   kXYUgjWQWXc1rrE8RZJ1P1RQDE+nLbSPgysBI0MWH5mPB2UmdrSud4WkD
   uD8MEPruHFdDW60iLnl1WtX5k9udp/gL8CG9Pa2IerIdkiyax4ZRA2tZ4
   h4n4ZwzcWZq/SpAiGCnxgPVKLJHlOLVR/GtwFkJKt3CXjIa0Sbqaj6pGW
   cVUs2pAewb3qB13yYuWHRwRNK6ZE2vtDQmQd1H9HnzjNgoORi2XxUjUAv
   Q==;
X-CSE-ConnectionGUID: ryuAfdCQQOSmLR7caubINg==
X-CSE-MsgGUID: IEeHitwuS7uUJwVUy5xxUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10996635"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10996635"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 00:11:47 -0700
X-CSE-ConnectionGUID: eRlJ8V5dSM2IB5x6Agmy+w==
X-CSE-MsgGUID: mvT36/vKRaGPQX9ZHETYFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28819545"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2024 00:11:45 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4EzH-0001VH-1G;
	Tue, 07 May 2024 07:11:43 +0000
Date: Tue, 7 May 2024 15:10:45 +0800
From: kernel test robot <lkp@intel.com>
To: xu.xin16@zte.com.cn
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH linux-next] jff2:fix potential illegal address access in
 jffs2_free_inode
Message-ID: <ZjnT9SJYoZAHt_rv@974e639ab07c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507150046826ZGsq8VfvyxBzczJHMtBxQ@zte.com.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH linux-next] jff2:fix potential illegal address access in jffs2_free_inode
Link: https://lore.kernel.org/stable/20240507150046826ZGsq8VfvyxBzczJHMtBxQ%40zte.com.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




