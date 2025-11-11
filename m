Return-Path: <stable+bounces-194493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EABC4E6CA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB086188C878
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387E32D9ECB;
	Tue, 11 Nov 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlvqcNZi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174452C324C
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870606; cv=none; b=PcPB6kbfmq4QD3VfWA2kIYFbX9ox1DOX4Adfi7GRf0Ed1kI79zcTH2A6bB15mL3DPRC025c6XMSsmGz72juVEHYpm/8MFII+yfg3joMHCK6ZXTM+s4dnrJTypr/hq0j5siy/juMulRkCXhgd0q0CpWXl7sSPUCSOuaP659rRcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870606; c=relaxed/simple;
	bh=ldd0MBfQA5ahB9OKyLXq2WHwZXflcX6TWBNO30ToaAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LUJGoN4ANSIFEBl40HZVj3bzU5h89tsVM1YhHPoBzTfpg51U+YCvC8rBgK6GxsNtil5TaxauRg4ihEE4HWe9e5ajECkxa6qyEf5i3b19eb7Mn1bGPShKf0CupINfD07lQW3+8QJ8uMqCF3UoA5wZR2lnbxgx+I2oo8pVB0T5IdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlvqcNZi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762870603; x=1794406603;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ldd0MBfQA5ahB9OKyLXq2WHwZXflcX6TWBNO30ToaAk=;
  b=BlvqcNZi5TJn/5p+Zlba+2UtlBZnzZ08GDYBcpNSL9FMV7+T0tnuqcln
   ATW/+joWO9zHBJF7VuHu34eCq8XQ6w0PFnkvtv4eSBwJsf3wC9ppg3PAW
   t+4bG3Owr4Spz9a/YCYCoXo50EsRFZ/tpgRijrgumLLy/EcemCG9tfPit
   bDxbdnlaaVmmi+A91T2cN9HZOKxDEH3yMPwcBjNI1XbRZG+/ihREnXUYI
   eteEf67NmR3Wk1WXedGpzdzLyVuTWHBmgbCfn9IRC0NAyC8FSuIk+0rAL
   NjWSuMnICJwF0zr6wLsBVvUyrW3a65uiHPHM3mYC4fnaxFh/YiDGLcSp+
   w==;
X-CSE-ConnectionGUID: knvmux36S32e6W9MFmQw+g==
X-CSE-MsgGUID: ABM2aUlgSQSoNXZSXbPhxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64136063"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64136063"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 06:16:42 -0800
X-CSE-ConnectionGUID: SMjDAfDfS9CBHQoMWpu3zQ==
X-CSE-MsgGUID: qlZqNdVER5qcM2a5ju8sIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188811155"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Nov 2025 06:16:41 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIpAl-0003E7-1s;
	Tue, 11 Nov 2025 14:16:39 +0000
Date: Tue, 11 Nov 2025 22:15:48 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] usb: mtu3: fix possible NULL pointer dereference in
 ep0_rx_state()
Message-ID: <aRNFFHSnzHjRJqp5@6d04f8574eac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111140956.3285945-1-Pavel.Zhigulin@kaspersky.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] usb: mtu3: fix possible NULL pointer dereference in ep0_rx_state()
Link: https://lore.kernel.org/stable/20251111140956.3285945-1-Pavel.Zhigulin%40kaspersky.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




