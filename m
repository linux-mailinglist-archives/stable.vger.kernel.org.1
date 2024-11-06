Return-Path: <stable+bounces-91677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F229BF1D1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A86285582
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFCA20408F;
	Wed,  6 Nov 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bM0FxsSr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067D2038AF
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907323; cv=none; b=liSWkseyr9RElIyyv8JDnmz3yjBKH8NrwYsCV15oUbj/voEAANsKOcCuxenzPmIR7vZbkg+aUKjyfUw9YO31I3iw6yKE9PUL7eqjI8pLuX/DvmM7nemp3lNMMZBxJNc646/imV3NnYErHY1/Ojo5nDdBmJ9SKAndgm8ip9UjSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907323; c=relaxed/simple;
	bh=FI7CV0X4k1j7iQ7IahLdRFMBi8yyGlbjrOiYPxWSBi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T7BwPpCMIqIMFanmZjN8RduqSKK3CY47Cy62k+SogyTWjhyMNqOPjNqcXJ/3JkD63NrZRymKnHOeAlkAJeDWRK8kJEnf5W3n1VVEbrbWoSxwMQk87GCk9pPjf15a0BtRAkwGjfe9WZtHtO1L4s3yZAjk9jepBTIUYarGig3H6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bM0FxsSr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730907322; x=1762443322;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=FI7CV0X4k1j7iQ7IahLdRFMBi8yyGlbjrOiYPxWSBi8=;
  b=bM0FxsSrMMsMTz+TYbo2jBAf/09wVGw+nYQHykN0juO5iESpMPO9T4hI
   CmIuE85ZH+psjhNQmxOcEl7rQW4BTFtraXfjB6h3uXcZbfpBVmP0ZgemM
   xv9cFJKGIMxC6OzSQRUosSAKgNc7iH2BoH+Of5bA25c9p5qbUzmKqAcxV
   KblxwyQVD1R8QfHqVfJhSope9SWGJLopijK214y8psYcPhFrH6vsCw8il
   l3VfGCpW3XZ4aMiMY+iNYFCu1hUsvDDqZ+THJEENuudV3J2xLq3/DIUqo
   Fx2rpPngO0FvsFG3Wvhdx/AiyFGIS36CbjiR0Q1w2lWAmZelzPxozCusK
   Q==;
X-CSE-ConnectionGUID: Q8frv/N5Qai/VRclP27NNQ==
X-CSE-MsgGUID: YnDp6gilS+eCCpltPT8T2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34410711"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34410711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:35:21 -0800
X-CSE-ConnectionGUID: 2lEY/G5EQ7Ws6YWFczQ3Kg==
X-CSE-MsgGUID: Oavb0Ff9SveEtXlp3auSTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="88572040"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Nov 2024 07:35:20 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8i3x-000p4E-3A;
	Wed, 06 Nov 2024 15:35:17 +0000
Date: Wed, 6 Nov 2024 23:34:46 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Message-ID: <ZyuMlk8VXQx7IswZ@a6d8444ee0cf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-phy_core_fix-v5-6-9771652eb88c@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 6/6] phy: core: Simplify API of_phy_simple_xlate() implementation
Link: https://lore.kernel.org/stable/20241106-phy_core_fix-v5-6-9771652eb88c%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




