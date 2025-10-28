Return-Path: <stable+bounces-191456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACE0C14860
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47107352860
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F1329C75;
	Tue, 28 Oct 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awQfm//n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466832A3FB
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653273; cv=none; b=WADx4DDal8/SzNbnVyoWr398ERhPHbH6jYh36YMCcNqj3vlvFRYKijnpsLzhSXx2Y0asmhP4Rrfi+QzSwD4O9Gt0GNhXa1E29oQAbjQEPvf0bdCpPThsfWneb9/1svwFzj0Ilfj5sxQC2TOFa0dkRAHEvQ3n3+dC26iZYvGtAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653273; c=relaxed/simple;
	bh=PehspMcLAoFMZQxu5wPiKU3Ol7Zzwh8uNmoG+rjBQio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vBnECwNIXB6185FP4T4+QEFo1kWdU7vFiV76W/i8QuPgc9fUfle4kLoQjetsHt0P6ZI8jSbD0BeGtyRXpqynRp1LjzjSMJiqdwoI0627UY/Z5kerFapoBGAnuzX37TmqUaGJEAQCq+0YnfOJNwO6eWfuu6ldw3mtOY5gU9l4O14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awQfm//n; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761653269; x=1793189269;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=PehspMcLAoFMZQxu5wPiKU3Ol7Zzwh8uNmoG+rjBQio=;
  b=awQfm//ndPExwspDe0ucuvqTyZWhkiysVE++04+67+XxzT92+JcQy+gK
   Gl54/wXtcet8GToEPF21UwyhaP4orVpkhe7y1iUMYiUels8D+4pKxqYDy
   R83/JPdMlNUbu5n9STW9vZEZ5/SziUki7CQIGlDWm//O+xCIgSX6dNnPS
   IV7RFp7ziFdLxi3lFzFTV+tdALAHDm2lD74xiSqJrj5ouHEE9DtIGXfce
   ehoJ8E9/VaEOELcLgpYAQKeMg9dzDAtGmH2uTWU/83Ta7luo/rYBCt2Ej
   9epQQTNKMNWwDwhdP3uINbAr2adyzj/XxTHvNoAomOX7sinhwLBTqFQ1i
   g==;
X-CSE-ConnectionGUID: UHKow3LkQuSB5Ew8h4kL2w==
X-CSE-MsgGUID: kLuZYIyVRxqgZM9mFA+bOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63787820"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63787820"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 05:07:48 -0700
X-CSE-ConnectionGUID: Ly3QFMFwQ52sg4PUZ2+pXw==
X-CSE-MsgGUID: 4kbVJ9PVSLOw5axH/7iSig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184507000"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 28 Oct 2025 05:07:47 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDiUE-000J6r-22;
	Tue, 28 Oct 2025 12:07:40 +0000
Date: Tue, 28 Oct 2025 20:07:11 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] Bluetooth: btusb: add default nvm file
Message-ID: <aQCx72Qf1CgVC6kP@fb33b90f3739>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028120550.2225434-1-quic_shuaz@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1] Bluetooth: btusb: add default nvm file
Link: https://lore.kernel.org/stable/20251028120550.2225434-1-quic_shuaz%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




