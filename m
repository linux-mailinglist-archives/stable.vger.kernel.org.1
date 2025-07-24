Return-Path: <stable+bounces-164606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F151B10AB1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08603169DC9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE32D5C6E;
	Thu, 24 Jul 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYI2xX2L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC82D3ED7
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361546; cv=none; b=TieBA1Dl4xF5X/6dD6DYYtq4+9rmuWOSj0O0WaGEaD2h8YPufXjlrCi4YdhDpo99Z6h1WfwxdTER7UwbTVbGW+4K0sigOhyQRZnLjg20DTWcJsMlZAeCAEMosK6pxOLmGYeA2evyjrdgKz24E/Zv5VhPOYbb92dXVq0fh7EQ3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361546; c=relaxed/simple;
	bh=M4TWp7K+Ol0BcCvSQCZkI2VlvJcQV50Lby6E0Kc0HA4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tRmpd+I5v0b5GwwbqPV++bJnVooHSz/cjP0SCaOkFArT4Ri8WrSjU2tj8RIWBODCYOJ+KnsI+ZAKVSLe5i5h8QMhnRmp/Zywc4+bvE+2+4lv5Vy5L+AOlJRKGKv1ny+m2bH5LP9cuDXdI8aTalNlJyOw4sJeawepoRpaRYE0Fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYI2xX2L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753361545; x=1784897545;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=M4TWp7K+Ol0BcCvSQCZkI2VlvJcQV50Lby6E0Kc0HA4=;
  b=ZYI2xX2LCyrfKOuxgjayZ2dszA648mmcjCxKSdA47cDO3eyrBB3ZIVKp
   2TiHUpqPfnpUPZvE88bfBNWO6L5KqOni9kaxK39kJfEphvyHyb9mtw5PC
   sZTFsdAXTEz9sMUSBjADMTxOARMX2FU3VBaZ6KHzZGFig0K8/EqLuaZgv
   XTGJdYXV+cNJt7M55AysqamLCBUb3yB2LzwH8C5Pl4qzwvafnUqqFQ4HF
   yz2lGsw5vTVQxgkBphr9uua+plYBS8rEBqdZ46X37qhrnbGC4eiVcVnyT
   9A2x5vFguXRG9HGkWVWheaomD5ZQYjfIuv8jomS6xWcSTySDeMdpcLpf5
   Q==;
X-CSE-ConnectionGUID: ThqT5cA3TWq2YLEuz4nMGQ==
X-CSE-MsgGUID: NwRgbKYUT8KlnGTq6JQc0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73254220"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="73254220"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:52:24 -0700
X-CSE-ConnectionGUID: a9M29K29Qye8Yazuf8dxLg==
X-CSE-MsgGUID: FasRdBspR7yU6/OmRlSX+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="159460782"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 24 Jul 2025 05:52:24 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uevQr-000KRj-0h;
	Thu, 24 Jul 2025 12:52:21 +0000
Date: Thu, 24 Jul 2025 20:52:20 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next] net: ipv4: allow directed broadcast routes to
 use dst hint
Message-ID: <aIIshP1U2XxL-uU_@17a2457f42e1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724124942.6895-1-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net-next] net: ipv4: allow directed broadcast routes to use dst hint
Link: https://lore.kernel.org/stable/20250724124942.6895-1-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




