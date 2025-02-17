Return-Path: <stable+bounces-116555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7171A3803B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3624188AF52
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E891917D7;
	Mon, 17 Feb 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyRdW4qI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29956199E8B
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788224; cv=none; b=Ou0K2ZdoR7uEkTr3M4hJral0GUxhx0X/wjuClWiTkikkO6CKX3Ooh6x8qvnkFQFN3F3ByB0RXUarV/JY4CPUHBV+QuQX7KURIrQRVuCz4De9YWnk+9Lq9P/RA0L9cTdvA17qd7JNZVNq/g/MIP6BIFxqQG1OndztBGeRQriSSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788224; c=relaxed/simple;
	bh=rqy0o7Oys/LLE9YRPDp46bhFWyAGqnDUjKuvPTU+GHs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tfY2hQwec8vuc5wD9JMPp3ef8kGkMXRqbeo1NIhmzFPsz4BcxF0E+XiA0j/qXol/1UKf+NFRMZaWmTk3HdwJluzec8cwmRSPkut6S/uirc0cAiiNzYwQl639HxAoNEZjLJxNvBp1SDcu0TPbmU+n7rHX7Ub4A2QuPrq3YIfdnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyRdW4qI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739788223; x=1771324223;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=rqy0o7Oys/LLE9YRPDp46bhFWyAGqnDUjKuvPTU+GHs=;
  b=iyRdW4qIXS/U1Pda85Vzk6jdEUW6ZpJ9qprxtSwAoS4JCUWEAJ2u9v+S
   n8cu2ZYSp395NgnhPyUKuwErTRtEY+AaNT0Qsg21KwfETWg9T5Gd+czxr
   U0DY7YoEQU4Wy3RyAUjHXUPP1kRB3NKRSrQFBefVcJGdsNJGh6JjmUwNI
   UjqRobVUkj0sF4GszN06OsbVHbFgGu89JpWsFlRC/7MVWiVTaiEE5WemA
   zYL5fSp0Cd5W/nr7pq0h5CfFTI6FFRp9Tp6tn7uPog80YWZhqgCOQ0EZp
   PjUsImKyHkDU+kzAbbkajBtGc4RJMAcOZCdUUo1mtKv59yGjDvYy3fOqG
   w==;
X-CSE-ConnectionGUID: eqP+lY0YSJ23JxYpM40Qhw==
X-CSE-MsgGUID: CIpdCSWRTOeePzKK+B3Fag==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51891613"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51891613"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 02:30:22 -0800
X-CSE-ConnectionGUID: HZVQroiFQHW4PN/acQroKw==
X-CSE-MsgGUID: l3ieAs+nQre5GF7FPuaDZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="119094457"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 02:30:21 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjyOI-001Cz5-2R;
	Mon, 17 Feb 2025 10:30:18 +0000
Date: Mon, 17 Feb 2025 18:29:45 +0800
From: kernel test robot <lkp@intel.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 RESEND] dt-bindings: iommu: mediatek: Fix interrupt
 count constraint for new SoCs
Message-ID: <Z7MPmZ9URNWhZNEB@0e6ae266f58d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217102652.1858304-1-macpaul.lin@mediatek.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v6 RESEND] dt-bindings: iommu: mediatek: Fix interrupt count constraint for new SoCs
Link: https://lore.kernel.org/stable/20250217102652.1858304-1-macpaul.lin%40mediatek.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




