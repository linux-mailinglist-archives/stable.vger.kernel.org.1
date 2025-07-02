Return-Path: <stable+bounces-159194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1293AF0BEC
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5D51C03B20
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 06:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32E01FE44B;
	Wed,  2 Jul 2025 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSI/MBBt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC92AE8E
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751438880; cv=none; b=byhGumSMtDhqH5yLSM3/W/Yn72V2RHt1MaHQoK3Nwanqec1bhL8epNLUjK+yyovZQCnnfkLWHV3ugzsPs1yL+r0BYtEh4vvHc0AOcJvdFWQwnDSmqY3lt7twmy8eFdsggze30zxHc5hrhCHUC0onWomxNA4qDIhGZySBj38mVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751438880; c=relaxed/simple;
	bh=gdeWcc5ZnTICXIQlEhUIR2i3ELkYAnKqTpq42gov/mI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pQMHX0sy4r3MctO+1gI3g68zzCc62+eb/nTI4IDpP7nJd6Pw1C/bhIv9gDWgySlOebFl/fHp8EVItndI5n3sddzsNqYDvviyQfafeFkqgeTlLnf+bpgk21MaMgIxqrmt9CqqJk9C+OI9QslI2BlxCO0TqBAtyPB4HQ9VV282JVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSI/MBBt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751438878; x=1782974878;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=gdeWcc5ZnTICXIQlEhUIR2i3ELkYAnKqTpq42gov/mI=;
  b=aSI/MBBtYBLQ5P/4LDu6/Qb2wYpQ96A29Uiewx/k9If0qapUjU/hU9v9
   dsbKdyvP1GjKOpxB0LZTWIL1zSJZ+eb/8kRaMb5Hi6Fsi4iJCRlLKCRR/
   7H4FOB9ITcJyvlyYmHpxJcl7Qkp59WfuznI4YrQX/0lPNyF4M51ifELzv
   imWwQCSWWnqYd2ixn8IpXSKFIqoYxcJ/yYZTzr8PyrqJSqWohokhQ/qxh
   Tddpn2ZU7MULi1J7oNKVsZtD33D82rd1QrzbNwUt/RR/lzYblcO8rrW0k
   uRYPKou4/RqxRluVF+HOhD9+jadxBLh0yk9pxahNQK+wWm9bEZJ0IRx+5
   Q==;
X-CSE-ConnectionGUID: En0mqvMeSRup5gpryLBEEA==
X-CSE-MsgGUID: bYgFMWBeSzimZLI2pYJTDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57397241"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="57397241"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 23:47:57 -0700
X-CSE-ConnectionGUID: WMHlYBCsTlWOhGH5CeNg6Q==
X-CSE-MsgGUID: 3s08hZc5RyGRGzi1FWhYdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154148907"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Jul 2025 23:47:56 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWrG6-0000H9-18;
	Wed, 02 Jul 2025 06:47:54 +0000
Date: Wed, 2 Jul 2025 14:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] mtd: rawnand: atmel: Fix dma_mapping_error() address
Message-ID: <aGTWFFVb1vQpB7p6@08871597274f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702064515.18145-2-fourier.thomas@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] mtd: rawnand: atmel: Fix dma_mapping_error() address
Link: https://lore.kernel.org/stable/20250702064515.18145-2-fourier.thomas%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




