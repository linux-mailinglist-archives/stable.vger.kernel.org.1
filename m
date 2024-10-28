Return-Path: <stable+bounces-89074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E249B31C0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 14:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9F01C218E7
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC041DB54B;
	Mon, 28 Oct 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jrr6CxFo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242E185B58
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122385; cv=none; b=E0tFbNGuiVFzGowSW7ZLWAi01l0Qu3Yjcw1QD1L7E4NIg7JegIrmMXS+Z73cQ7V8CbC3g3uecCOH0f0hSvcVy/7UZnMhzFopV3kB8JDChAbestk3CuV4hpatx4/wvPyOr6T2vqPqer1v4wD0EpEVR9uO0lKZVeDJesJhnvALnRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122385; c=relaxed/simple;
	bh=K3JTVNxt4daTB+iZYPMb6lhrl/O9vAeWrW/JfFvSVs0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l9obaOgTN68wcU6ikmYVbsmhTpeF4aOXoam6ekMwrc5BRzAIunR8bzi6+edZ+jZ9IjLOwO/3iISaNpAeSeoDjmeS1M/DYgwi9JdCeoLbypxi80wYOVqlbbabKnR8x3bbnSYz4BNmborC8zk6h5QiCMoOm4Mmf8dSKZxsAg8cysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jrr6CxFo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730122383; x=1761658383;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=K3JTVNxt4daTB+iZYPMb6lhrl/O9vAeWrW/JfFvSVs0=;
  b=Jrr6CxFoeX/Ol5AQnycftJ9YeNBKNXGFnPc6dLiOwoKYKukvtoI4/MKo
   j9FmJhOBrkIX5qXFXatF7nHF60JDmpDahW7bdESgOZy7CYRRKryqSVaaf
   AchRe8aatnOxMb0uhg86nIoRMjP8cPpVfy/Ezbh+5a81tat06Dmrj3IxL
   47mXVyFFcBtClkFzFPF5l9q+GDMJqW9fvhtKcMJNoZDViXpC/ujtqalH2
   4UUE/AdPtKdLW2OWyhBq6fKKSY2TUft8ApdbPK5BQ4821QkzrVA1bAHy6
   Z3LlG8MoJWkoIkmFjpFRZvbsvN0G3SWOLH2iRhPUWonCr1bopMMn6pt/v
   w==;
X-CSE-ConnectionGUID: 1iYBxhkTTlao9jSo1P0NHw==
X-CSE-MsgGUID: mkEAwISvQ92QYxZzxZx76g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29580095"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29580095"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 06:33:03 -0700
X-CSE-ConnectionGUID: iZOndzyDRXObJjHvPpDWBQ==
X-CSE-MsgGUID: 2lRfUCrDS06nimMahXgflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="119081705"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Oct 2024 06:33:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5Prg-000cTv-0b;
	Mon, 28 Oct 2024 13:33:00 +0000
Date: Mon, 28 Oct 2024 21:32:50 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] drm: xlnx: zynqmp_dpsub: fix hotplug detection
Message-ID: <Zx-Sgv9-7QWYiJwN@433b1ac7a1a4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028133138.52973-1-lists@steffen.cc>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] drm: xlnx: zynqmp_dpsub: fix hotplug detection
Link: https://lore.kernel.org/stable/20241028133138.52973-1-lists%40steffen.cc

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




