Return-Path: <stable+bounces-132370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B5A875C3
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 04:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9C716F5D2
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F818DF80;
	Mon, 14 Apr 2025 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mskoONHC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784DE188CB1
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744596580; cv=none; b=GKmnyEY2d8wDWYW+Oi8qDSd5OGluLrZkDC5qAx2NhbVxyLrD3WdiqaVCpMhybiuBENornSdMn2pSQK9pS+575zJr1TXC9QsLptaYZWD6/4ZdaONh+0q4V2YG8Kh1cJsDGlS+m64hJzBPUKjxeGdYwvKcD0PF9cJOaxoGCF00jEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744596580; c=relaxed/simple;
	bh=ap71KQGj7IxXMTQ4DUDW9fnPUxaN+WdgLy/qwSwAUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mUBlmgucyDFJ4X655jwfb53XknwvaHMgGeHIfNF0ibqJnNLcVC/wRdeMDHDjxfQMEbzVgcIrH/7HOwAADp9cBzpjlAYnmatPgi4NYPSIm1RURDYKYna9mg1XKlgzMhPy8THXBAKt3xENmZD0PfLYqTnp2X/s8L5UBWQr2Iwx9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mskoONHC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744596579; x=1776132579;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ap71KQGj7IxXMTQ4DUDW9fnPUxaN+WdgLy/qwSwAUxo=;
  b=mskoONHCcl6bp8Gz1yzLoq5INSCvp5yXy0/6McQ+Bng3rPWvRqo+RN1Q
   F4lmUuJyXeoVf7gPUeFPzDAS9GIx4C0j2m8gROi/cs6y5BDaKSRieQCdL
   AK015uXWV9JnXZ+nez9R2xMLacrGEtYV4hRTEgGmG3w8qu6zGfGrc1a4x
   /rD4VSDD+JGf2TA3tQFAj6TztTj40r6Cz6Y1jpTNIeekQ+Cl7/1MkGDD5
   81jZkf3GQs/oPvo48IOkLwl+43RxEW+fpAAufkz4eGkYoVFJlhxrVN3sz
   Ezq5wEMBe5YDK7PhHKjF7qx42Gs9PTXrA+xLLAkB+LnqvXUl1rIP18kT3
   Q==;
X-CSE-ConnectionGUID: CTuSIcMUR1CNB6prqgIOhg==
X-CSE-MsgGUID: bcy/73Z4RaSyncNvYrf+AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46189250"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46189250"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 19:09:38 -0700
X-CSE-ConnectionGUID: hMbIKpMsRuutSFlXI3z+Hg==
X-CSE-MsgGUID: ZyH/F/SZQfO1gjX3E5tMQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="166862838"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Apr 2025 19:09:37 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u49GQ-000DAI-2U;
	Mon, 14 Apr 2025 02:09:34 +0000
Date: Mon, 14 Apr 2025 10:08:59 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] gpiolib: Allow to use setters with return value for
 output-only gpios
Message-ID: <Z_xuO9PZ6_afeii1@6bf5cb62fcc2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-mdb-gpiolib-setters-fix-v2-1-9611280d8822@bootlin.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] gpiolib: Allow to use setters with return value for output-only gpios
Link: https://lore.kernel.org/stable/20250411-mdb-gpiolib-setters-fix-v2-1-9611280d8822%40bootlin.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




