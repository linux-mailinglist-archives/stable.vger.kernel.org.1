Return-Path: <stable+bounces-73691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B396E70B
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 02:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CE1286C8C
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FE812E7E;
	Fri,  6 Sep 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMB5I7Hh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604EB1799F
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584371; cv=none; b=tlYm1ySkPymfCqBINcRLmC4K77svx5+mSqBNw70wPG+ZUxmHykmtRYMbyBX3+Z6A2z4YaDd6SO3WdyXZ3npWY6N1uobLylM0SBhkKMXxfjog6f6s8Hx06qqCKX+il8T1sHmRIjPwpIJReGa3VC5uv0fKa28RSsW+ihCrlmpxm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584371; c=relaxed/simple;
	bh=EpqbIJMquSU+0fJf7pI/5fFFwwTNrtLP8Zzy4UeCLD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IFPf88qponMW04MzqvcxKuE/OK9kMmfX4xFFBs8fChvMCzj3mTY7NZnfP2XuKOcYUJ/Tqn2CNoowrNjyxj1B+DMfCHggIQHxRUqzSOYG8f6MFxBWvsnN/8jKJgyc3cE++YBfuX03/B60gDebJyqbXRoURqY5vVUl4dNn8WmaITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMB5I7Hh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725584369; x=1757120369;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=EpqbIJMquSU+0fJf7pI/5fFFwwTNrtLP8Zzy4UeCLD8=;
  b=OMB5I7HhAMDZYH+FehBnM7LgkdKLM7uJ0VHmOeSqnQ29QvLtLMgpVVAn
   pqo6a9nyKTMTA2Ga1cy1rBlvikJFLw5g/2zoAxr1PUw9S2pBq+JjqnXAG
   VxajCAgLn8SaHYqvIDFLCW3aOsIrNMPFX310UXp3gE52J+6E7iJKnd7fF
   xuWq8SFq7Ry3AdPJdiuKhg6DXB4DaIuy3CAGs7iMoLEPYybM4MGL5+t7m
   1BNmEJXOdfwUmDMe3LRjxKjpD7m3LIJqzSSY0VH9udPgpNYg2vYayIcJL
   zn+k0L3SmXTPXLJfEF5C9uc41c5elEiwLXDR2+S6xi6pvmyAad5nP6QdY
   w==;
X-CSE-ConnectionGUID: dua4ZL1KRcmstpbPcMspMA==
X-CSE-MsgGUID: kQ/A7Za3QomLOS78RjEZnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="13399605"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="13399605"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 17:59:29 -0700
X-CSE-ConnectionGUID: r+yeBAAKR7KesFDvhfZJ3g==
X-CSE-MsgGUID: D+RmDDQoSPm8Ucxz/8TsXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="65798450"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 Sep 2024 17:59:27 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smNJt-000ARo-2g;
	Fri, 06 Sep 2024 00:59:25 +0000
Date: Fri, 6 Sep 2024 08:58:43 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksandr Tymoshenko <ovt@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
Message-ID: <ZtpTw89laKyzfJNM@6629791d1ab8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906-nfs-mount-deadlock-fix-v1-1-ea1aef533f9c@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
Link: https://lore.kernel.org/stable/20240906-nfs-mount-deadlock-fix-v1-1-ea1aef533f9c%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




