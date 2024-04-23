Return-Path: <stable+bounces-40748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9578AF647
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322801F21ABF
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1913E058;
	Tue, 23 Apr 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOmvdZ0P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A613DDDE
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895605; cv=none; b=aHymS8TN+U0y+NeL9/Rbaa/Sf7wabAYl6dD9QeWkHA01SuS9j7Foy+5D+GNjQWkKrgrsw5BZ1PXAq5SAOINryb3RQKFz6EzexZG3uoQ2Nab55ggZ+RH2+Obeia3P/1jeFdYkFumrN4D/dXp+a3WyonlhZPmW/g7YSda68JEa7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895605; c=relaxed/simple;
	bh=Vv/1nIXWIAWmB3EPemO9qutrD/+hBNPC5nMmrE2+LKY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LBYFgI+fhdbEtvzlqgbrRI2msrs+YKOWXmOzPpcgbjN0p2QPwsmnJoL01kwqA+wXwYRpbCNP+/Nrhc88+6a93EtKPEqx048l8pXJHdcUD6wfikxtSFr0j48m1aqCLmgUCAey0XYjK3moqHfwVV/u602y/vvMYwdcP9eFv677oF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOmvdZ0P; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713895602; x=1745431602;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Vv/1nIXWIAWmB3EPemO9qutrD/+hBNPC5nMmrE2+LKY=;
  b=LOmvdZ0PVGkpFKyuPMv+B0Mlsx1I9Vlv+v66M963zKo6fr1Q2PU22UeM
   r+4u+fwt19yKBuxadbveZGkqpx94X6YVQMvQgFbHEMxoFX7A0nJVcNX2v
   v4QzR7itXNlJ+uiGqR3/TQvzDdVUjWNoABIaxdob3iTQr6g/q1OsDDDlO
   ZXxkICMsjtID5ABouV/Z40VD2olHISPUky2MJGtRAC8E1r2pyh/QX71ef
   nleornwth/BhBIrPx1Ncac+GaGo2x6+3VIRGsbXB/k9YYB338yUjGJCAz
   d550AS8PLjAPYK+0AOMx22ySZVmsGp5t3BXo4U4j3vohPqey+hZaRbMWz
   A==;
X-CSE-ConnectionGUID: f2uAUdf9RFmBh7M3+C6BqA==
X-CSE-MsgGUID: 4N3a/FTCQ46/BA1GIQy29g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20646587"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20646587"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:06:42 -0700
X-CSE-ConnectionGUID: MtOxC0ZBQVmnutywDLUKeA==
X-CSE-MsgGUID: pCwkvtGzTX2aTXf79AvhiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29252388"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Apr 2024 11:06:41 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzKXO-0000QG-2Z;
	Tue, 23 Apr 2024 18:06:38 +0000
Date: Wed, 24 Apr 2024 02:06:20 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Wulff <Chris.Wulff@biamp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] usb: gadget: f_fs: Fix a race condition when
 processing setup packets.
Message-ID: <Zif4nDb68utm2px-@c8dd4cee2bb9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR17MB5419BD664264A558B2395E28E1112@CO1PR17MB5419.namprd17.prod.outlook.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] usb: gadget: f_fs: Fix a race condition when processing setup packets.
Link: https://lore.kernel.org/stable/CO1PR17MB5419BD664264A558B2395E28E1112%40CO1PR17MB5419.namprd17.prod.outlook.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




