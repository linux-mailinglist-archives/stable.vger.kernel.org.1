Return-Path: <stable+bounces-59357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8945893175D
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A103283C3D
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2618F2C9;
	Mon, 15 Jul 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBsA7QhG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6CA18EA98
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056220; cv=none; b=axG3i4PP0Il1HextWHAR48wCgqQtKQuRo4RI1Y2nKi6RuSnx1fdtxwCEZw9omI3UV6A5Fdt49ZP3gThBJ/hdEnOOqkJV/q4mxO5GqqCXYgn6IIhKjhpVG21XXwKu8DPjQVvZOmV+VsjS6EWLQbZ8XL8yk2SznQegoPqImkgdOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056220; c=relaxed/simple;
	bh=mYqzoeMsmXn9QAvutNdckuKyTDSepTF0WqJlvOuGi+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YHt9zfORGsoCjpb+g8eh+R8LENsOZscpHYei+xMb0EYv2KGr4jX5avvI+mZRylDl58sUXmikQ6nUZZsHPnphe9qu38xyazlCMM2eAP9A70n3rBJtGFo2Alj3KNoMJW+CIlD/8saRjdEFsjBr6u4lPRyTiRPacYIqczbR0EtZq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBsA7QhG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721056218; x=1752592218;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=mYqzoeMsmXn9QAvutNdckuKyTDSepTF0WqJlvOuGi+E=;
  b=gBsA7QhGWwetpRA9Pv9xHnFOkQ1CGm3ZqrI9L1nehX7t04gg+aNZahbN
   5MIwRBaciAgatBqcbCZX3MGkiqqOywnH4UKyo0wTbDmrh9aOdNIM/WxMA
   DlnENECXWz+bC23Hh6BGeF4EhElP6Q0RWYkthsiljT90sgnEbFn98OTX9
   QL5C8A8jB/58FXKc8Htr0uG01f8FMMAfcptLtNFgteKthhkNiGYupdwSI
   SdutZgvKQIp5XKqc0MH4LpJwj/B13UoMLUi9gqm64pvaTupEpJwBmofDy
   +A5AmiPl8sykoeQ3xU14t3yEC6zqdivqhb+O8uNuR6Q6REJoXjpGUjhME
   g==;
X-CSE-ConnectionGUID: TuDfva7FSrmt2dMttaT98Q==
X-CSE-MsgGUID: +icC9seOTI6DBq96nlBTKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18578841"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="18578841"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 08:10:08 -0700
X-CSE-ConnectionGUID: WTIMiPTjSpuvhB7K7+M6EA==
X-CSE-MsgGUID: M4CpN7piTeOmlgl96nmfpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="80331514"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Jul 2024 08:10:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTNL4-000eLS-0H;
	Mon, 15 Jul 2024 15:10:06 +0000
Date: Mon, 15 Jul 2024 23:09:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] clk: qcom: camcc-sc8280xp: Remove always-on GDSC
 hard-coding
Message-ID: <ZpU7s85rGn6CGCa1@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-v1-1-fadb5d9445c1@linaro.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] clk: qcom: camcc-sc8280xp: Remove always-on GDSC hard-coding
Link: https://lore.kernel.org/stable/20240715-linux-next-24-07-13-sc8280xp-camcc-fixes-v1-1-fadb5d9445c1%40linaro.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




