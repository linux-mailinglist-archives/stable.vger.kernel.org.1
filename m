Return-Path: <stable+bounces-76032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD579778A3
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 08:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1198E286A10
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 06:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008D18732D;
	Fri, 13 Sep 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqXHhl9A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1713D52F
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207719; cv=none; b=WLku7xo5R1ul+q3dNFH9EpFPW1vHgGr2LcSIwcR3FssnZA4kox3UIKSzwaotfK5+BMWpxmXXbOzo2sS+SqGRIqtO/8iY+l+GkYAGlv7xR84LxljhayCTJZ6qpwYe+DNkNk5C374qUZRH19q5FLYs8SVy6S9GCZ/jAcD/BGViJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207719; c=relaxed/simple;
	bh=Qc2N0QXR4ds/OXCAFEUGKqPVPaQQ/evLsKTUR4J/0Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oa689IL8otfVgInIGfcOk1JmwaU6vWYuScnamAe7P7XjFvF13iCULp2F1fcv88vXXnNmrVhqFjH/FPfdEWHo8LUmkH4Kyc3aSxnQFwr4g6xtL/0+scUF/nCTE30JEvCio+t9HJy0OlLFwK663V+EEX5AN2TmTqOaghAtgo+ynJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqXHhl9A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726207718; x=1757743718;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Qc2N0QXR4ds/OXCAFEUGKqPVPaQQ/evLsKTUR4J/0Uo=;
  b=lqXHhl9AF4mkd1hJA1GUYzxsV/T5zgocuoDcRVXSPFiJgn8kVKbc2UIu
   NuUqp599N6SpToD37CtNvg9EjsHBxRF5SzFwF6ZuJukDBqBqJjHEXJkGu
   MT7bckmrwruwiAsxknnZ5PsZEe0/w3VsosHOYp7j2M6ANoUJepOlP/O6T
   bRrry+EF2HdVA2ElTLsNc5mraVicyqNUyYHu74H/ugpKi8WjVx16TWfc1
   7jsR0FYnwtHaXQOX8ZnK1q/kVNIf2b7sP1gF1YbBOOa92SDoJGhxzPBAI
   qQzzIfexYAnrnS4mwhXsswhfnmRefi2jCv1U5bzJEc/YhSG7+1N8rOYIg
   g==;
X-CSE-ConnectionGUID: q0WyG+bOT1ioysg6ftNXMg==
X-CSE-MsgGUID: z4gK/mqJTTSmn1GcQZYetg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24636596"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24636596"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 23:08:37 -0700
X-CSE-ConnectionGUID: l6aJoIXERCmziobTGlvRzQ==
X-CSE-MsgGUID: dkna3e58R32pUZ3APOq9Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68035189"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Sep 2024 23:08:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sozTt-00064Y-30;
	Fri, 13 Sep 2024 06:08:33 +0000
Date: Fri, 13 Sep 2024 14:07:48 +0800
From: kernel test robot <lkp@intel.com>
To: Wade Wang <wade.wang@hp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] HID: plantronics: Update to map micmute controls
Message-ID: <ZuPWtNwvorjlGpRy@3cded50e80a1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913055851.1322592-1-wade.wang@hp.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] HID: plantronics: Update to map micmute controls
Link: https://lore.kernel.org/stable/20240913055851.1322592-1-wade.wang%40hp.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




