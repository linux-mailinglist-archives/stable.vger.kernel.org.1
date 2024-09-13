Return-Path: <stable+bounces-76033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A79778A4
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 08:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F59A1F25E2C
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 06:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9FF224CF;
	Fri, 13 Sep 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RaH+0U6S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E50185B5E
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207719; cv=none; b=FimmbLLxLQ80hJTg6DTeBlRbllikpbU1l1nJJdgZYX2lY1qeotQEtUJKGrlaGZSLfTq03HGQGQU/KezAiGjjIuAavL5YmXV0aZ/Cdws7ikWVRwthmcrD9mT2dWWJcQurX85akTDiMd6k1opFdK1dXE5rfE87sXFM1Y1/zm9NcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207719; c=relaxed/simple;
	bh=n+Lgy/aNTwtVO501kH/Mto/sOBwIiMM5iijaWCy1vGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LRCutTtsa0eAp1Cs2PwEEZcwP9NkqmP/50ZgFTIfnXMUTtuDGfbqXXvYg+OOGrzpKX3jjzxqIdgWGsi3JSPQ4YulEcEbYV/JhjNe/5YdfBEWrr0s4eTn9qsVN8VfBEXS5ypNM6LHhpv5kH7mrG2czTijn9oTzPnA7ivpMP6sO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RaH+0U6S; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726207718; x=1757743718;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=n+Lgy/aNTwtVO501kH/Mto/sOBwIiMM5iijaWCy1vGE=;
  b=RaH+0U6SCXW/fcmjH+ir4gqbin4cFS/0xfwRm33owYjyaUhd4I+QVe8V
   vmb6RKZ1tq9NBYVnC7h27s4PhAb7VyYfYezm586hsc3RA9c6eveYx+QoR
   R9s1fhMPjqc0B5kYGLdF2GSdTUxRkMpVJzCu5nvKQ+wUqIQ81N2Ob8B7u
   zzsU6esh+96bU99FYOu4PuJXzRMVYlc3rpXPN2+JuB+5Q9bO3CFHUYBsE
   bnWz6DvXFBrxgTKycY6ZyuBTa2YhMfjXc2Rx9AlexOjasEXjdyOvulTXJ
   tfwrMbyF7ZFwaY4mR5sh0K/tXqfkZlF/QP+4GExkkIP5HezZOZBjuA95A
   Q==;
X-CSE-ConnectionGUID: tfprc1FwRqyHoSlrlQrmTQ==
X-CSE-MsgGUID: MXMXzr+cS12WnM0DrIZwCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24917900"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24917900"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 23:08:38 -0700
X-CSE-ConnectionGUID: 9PnM+g65Q9qXp0FPn6eRuw==
X-CSE-MsgGUID: +t6fXX9OSgGghXsKfCUtaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72757935"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Sep 2024 23:08:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sozTt-00064a-34;
	Fri, 13 Sep 2024 06:08:33 +0000
Date: Fri, 13 Sep 2024 14:07:50 +0800
From: kernel test robot <lkp@intel.com>
To: Wade Wang <wade.wang@hp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] HID: plantronics: Additional PID for double volume key
 presses quirk
Message-ID: <ZuPWtlKQoDwjDNrJ@3cded50e80a1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913055831.1322457-1-wade.wang@hp.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] HID: plantronics: Additional PID for double volume key presses quirk
Link: https://lore.kernel.org/stable/20240913055831.1322457-1-wade.wang%40hp.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




