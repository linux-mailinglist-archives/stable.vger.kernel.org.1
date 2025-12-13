Return-Path: <stable+bounces-200950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A0CBA7D3
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 10:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D71213003139
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4532EA14E;
	Sat, 13 Dec 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1SMTNDb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F035977
	for <stable@vger.kernel.org>; Sat, 13 Dec 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765619550; cv=none; b=fB3Puldv9D+Oxm+UDwxBhkYctzWScjsS7YOu5XU+AOHOBzEOWG3e7HUBoMXdHfKrXP/JkLcRuDUB/YOCbR6HKQhr4IuQ1vjMYhoazUpJSjnRZgStuNDROVtn/QMC2p4CKAVubsOyVZtv3VMm1CumBrCqz3MX+0nJFDfzNTM+GNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765619550; c=relaxed/simple;
	bh=ynqRBUAULXgIMfjECn/ojh+RpXKsaoXJPQx5zKt46tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n4cDEQIQ5id7xgXjgU+Q7NW47jdCY8iMQiUD73Fu+8+NDKrWicgWC8Ar4XFX7nl2qlNKfc0M0psVLwgqW7WbVr12sDRvn0EjC7Ry7BPus5AYpzc3qdFIERMxgKNaJls9N9ioKb+TsGweGeYeIpUImx1xNf1RdnAM7hHvafo3YcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1SMTNDb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765619548; x=1797155548;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ynqRBUAULXgIMfjECn/ojh+RpXKsaoXJPQx5zKt46tQ=;
  b=k1SMTNDbaYMJLTzsXt02XENpW0MsPDx3981cIpfg/OTZcBekLtHS+x+f
   DdH+3MNlOaSuAi9Foqc0S6GRsQ128TEhm4/1Cc6EY8cCqqR1unEUZoo97
   MkfWA9JsEHJWBlXDUXe4CWMZsWCe441DYVM+xGvactN8fwAjaVuzexKZc
   HZx/UssLT1nasMlpY8jARipP2r40n0tAPyHc8TOl8oiaF5YVBi5cdyzV0
   mqrB3ma5c5FOsH3Ddu+8HZqo7wWPcUr514NIlEMTmTPmrJt1Pzsc8w6z2
   oz/6M/6NYY7wuoq0M44dTmugqtcs9HDLHZF+iHgg2NzLgddOWj6fWQNOW
   g==;
X-CSE-ConnectionGUID: rN0o8UkaSraQZjkUbIj1aA==
X-CSE-MsgGUID: bQE+XAjCSA+bJ+IIwbIcdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="85200135"
X-IronPort-AV: E=Sophos;i="6.21,146,1763452800"; 
   d="scan'208";a="85200135"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 01:52:28 -0800
X-CSE-ConnectionGUID: 9xWtv78VReuHKZOp1GX2PQ==
X-CSE-MsgGUID: yrZ8Z78ISUCez6Aol1u6iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,146,1763452800"; 
   d="scan'208";a="197557145"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Dec 2025 01:52:27 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUMIb-000000007Sb-1O02;
	Sat, 13 Dec 2025 09:52:25 +0000
Date: Sat, 13 Dec 2025 17:51:25 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.12] LoongArch: Add machine_kexec_mask_interrupts()
 implementation
Message-ID: <aT03HXCwUdbEftn7@73f44f95d416>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213094950.1068951-1-chenhuacai@loongson.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.12] LoongArch: Add machine_kexec_mask_interrupts() implementation
Link: https://lore.kernel.org/stable/20251213094950.1068951-1-chenhuacai%40loongson.cn

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




