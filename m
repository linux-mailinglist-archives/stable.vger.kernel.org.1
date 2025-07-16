Return-Path: <stable+bounces-163198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C0B07EFF
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 22:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267E84E0E82
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101229B20C;
	Wed, 16 Jul 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kb5wqMZh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBDC2D1
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698125; cv=none; b=mhPk0/RDEtv0mbh4hutH6aLBNGy+gZ2HqTUX7pZOstC8UdnXQrbwN6kBB2vja+mnz0Rwzmqhkr1KA4nDEMliuITjp/gQUjsk5tskuk1T+qKcGpayITP/oZPP0M7nsxlLCan3noZNu1RhWKvIIRz/bM81/KR/UwGHfOMIOBY72f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698125; c=relaxed/simple;
	bh=FYD0hTduT3dkDB00s4vIs6nr5wQbe/med6RXdgs1dNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b9BXLAwq6CRzBGYKn4cpjQu185vX4h/Nqsicu2zfmYr6tp7xGr5A7UsoIlwy4/FJP30in/DG1jf4bIk0XQA0oKGLipeKyfwGCCW9tnrvz0Y+WZ6TitEVaDiV6Pd2hp9v/Z0u1xuQ/yVEbU5IyBrhNgj+iq7GoAT4ZuZBa4PRbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kb5wqMZh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752698125; x=1784234125;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=FYD0hTduT3dkDB00s4vIs6nr5wQbe/med6RXdgs1dNc=;
  b=Kb5wqMZhtf5F6H3PF6bOaofu085RXJnSjBCktHq0gRB+jkXbycr5D7rV
   SzK1knC1RBay8EyMBus3HIS57z6uXQhQB3YgIX29ZBuYl2nY4WbL4jA4c
   cbn0Q4crw7Aiz67b5Xh6jEQFZBE9kia9JINx3pxznXAHgZRsgQrWwlgOn
   aGUL1v7TvOHr8qjcYSMTXbkY600ceVA5H0JwwlGwqUcGgFnLraZg3ljm7
   +pBqP0307RMLTkwUV78ixECzme1PTjt6MOxrdC/BCglsVSi0v1CN4kLWl
   69g/WZdlvUKNsUn87vHynDcGgWsZ/gVZYSzGoMyyW14JjqD/f9Xu3Ofgo
   g==;
X-CSE-ConnectionGUID: FEDadF5gRSu35ccZPlUUDA==
X-CSE-MsgGUID: KZL3p27SRzSyI1Ziqm0krg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="77498223"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="77498223"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 13:35:24 -0700
X-CSE-ConnectionGUID: kTg6g5QkSRyBWbfAnnoL1g==
X-CSE-MsgGUID: inL/hzTQSiKOJr4oNyWfsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="158316919"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jul 2025 13:35:22 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc8qW-000CoV-1G;
	Wed, 16 Jul 2025 20:35:20 +0000
Date: Thu, 17 Jul 2025 04:34:53 +0800
From: kernel test robot <lkp@intel.com>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1] HID: mcp2221: Set driver data before I2C adapter add
Message-ID: <aHgM7XIAzGo8fgwN@32653d2b52f0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716195316.176786-1-sumanth.gavini@yahoo.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1] HID: mcp2221: Set driver data before I2C adapter add
Link: https://lore.kernel.org/stable/20250716195316.176786-1-sumanth.gavini%40yahoo.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




