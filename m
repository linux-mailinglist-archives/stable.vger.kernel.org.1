Return-Path: <stable+bounces-192725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3468C40015
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 13:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB423A8659
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1C433BC;
	Fri,  7 Nov 2025 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzqHnZ8n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E72BEC5F
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520226; cv=none; b=HfOIisDyNsu/DH8NpGN8bIJXCJPNkHnJY0MpZiTtW8rEbOK89an4+014VLBwteoGuUiIiVtkUEjaOFNKHcNq/dRrSE1h9IZ4DQQVIeBBPf7m2rxWJkg/kGjobhvZE0f2JiAInnNRFwn6VnAydhK60KK5BcJ0ZgX/FfgcifdiDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520226; c=relaxed/simple;
	bh=LHhXMg8kC4q54+/bEwsachcvDgTGnkTi3xQ52vgwnPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EswjVndXNQyy8BsI5FLcGu75z6ABYhcTfQNlFNiGrDY59U/8pWslpnQBuY9w37M1wJCaQLz8p3R4EZONv/gW7W0xGC1pi8puLwrukIpOZerSLgb58J2j7m5zMYI0XWvMiMPgs8zfZixnNVktW/osg/RRGy7cIllu7UAcs6xxDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzqHnZ8n; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762520225; x=1794056225;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=LHhXMg8kC4q54+/bEwsachcvDgTGnkTi3xQ52vgwnPc=;
  b=MzqHnZ8nurKe2NpfkENQ+25R5I17W41gw4hCdBo/lHWtGXkPr7E7m61X
   g/BqdQBrNOjx7c9R1N8WPZ+bRIbVHzHvNssKfJdbt1JSPn9/R8GcLvEP7
   TT/SuhWywnzmf/C54JI/Ls6RJAZqpMmJF0p9O+F4yBgf4TnDDMzeVKAYj
   3QyXRZ8dZlL4wSotn+KTZ32YznP6TszI/8unRMsstItIsAllaHVqXNx/a
   PhU96MONx1rg1ZqTzeRYUIOSV9vLZKSb88TVptKfOb4mvMR7ER7hV7V8t
   UsRPsQZnhCQGDhO/fW4v+CSlJRqNk0/yz6kaCuSmVYHwUWFUW2MVMIuo1
   Q==;
X-CSE-ConnectionGUID: QGTa/DqdQ5STXWFpnKsVvA==
X-CSE-MsgGUID: TZ9eLHq0Q3Sj3ACApiTBgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75780981"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="75780981"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 04:57:05 -0800
X-CSE-ConnectionGUID: /gCPPkd4TkKX5eYbzOADSg==
X-CSE-MsgGUID: KiwiZxqDS621M9HzbCaf2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187686188"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 07 Nov 2025 04:57:03 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHM1D-000V7E-19;
	Fri, 07 Nov 2025 12:56:47 +0000
Date: Fri, 7 Nov 2025 20:56:12 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: add new custom firmwares
Message-ID: <aQ3sbHDGL4DQAE8J@4b976af397a4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107125405.1632663-2-quic_shuaz@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/1] Bluetooth: btusb: add new custom firmwares
Link: https://lore.kernel.org/stable/20251107125405.1632663-2-quic_shuaz%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




