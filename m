Return-Path: <stable+bounces-75731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D742B974112
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2321C255C2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C551A2C32;
	Tue, 10 Sep 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHrTNmu9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753461FE1
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990661; cv=none; b=kbq1V/NgLvgP/gKAeddct9xePwvrabbcbMU9C83royxm4sAl2JdYDicq/r9HaRAlIjKiGBBr1FwVPtP59mpYI25dAqxVnQ17cYjYZAnaUhzy9+mX4ro5ZOrdQNi8j1CX5pI3Uc0mTvu5WplN3boXGy6z3Z3GVda/akns9lyBXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990661; c=relaxed/simple;
	bh=/O17IV/yfGZqoOUamwcF10jhVtVEfBfb7u+sYzKZlrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j4C0E24Ea0EvaRtiq6ZllgPXYlyr5pcxRQ3ohR3N1g1d8eA7ZG2GaiVAeUod4e5RC732PL3wMYD7lOTymniJHgtdyezC+Qw5JSafo1yhGEgsBQuoD6V5c/+hbq6Gg/KZKJSAAETKZYnct2z0Qir9IRubQCEDJgiQHNQqZ2ZgKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHrTNmu9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725990659; x=1757526659;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/O17IV/yfGZqoOUamwcF10jhVtVEfBfb7u+sYzKZlrw=;
  b=OHrTNmu9ehk65ch+YbQPZrpvp6/t5QRZjLQvNqM+61j0ZjacZJgk3tts
   HXGmFfCVajWgL4ZdpDMODG4aplfCD+WBjF7IgYvQp2YtdS/u0BIfh46i6
   WeyoTh8JqAimmrw+b3EjPR4NKG6khc1lFlIrV8ZwHpD74Wwr55HZfyylT
   ZJekvQQEEcF/4Cv5xB0O+OWJ4+906P97nfRFY1xcX+H9I0DazUexkv/xj
   eq1cn28msgQhb0tLjmJsgv8JfTDEwwfxrxhwhpIFoIkNkBKlVIYEzn3yL
   Hi+1JqfS+85FgenIJozNX1IXZxlkH7wwG14KKniSFObebsmrU2uHRB3hB
   g==;
X-CSE-ConnectionGUID: rpNL6hbORkGWwpoLho4EAA==
X-CSE-MsgGUID: ukh8KdFATS+IlV+xCPN5Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35353080"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="35353080"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 10:50:59 -0700
X-CSE-ConnectionGUID: EPAnZmxWScmdBxR7lYo1WA==
X-CSE-MsgGUID: oYaRLOTHSxGlbPLG+E0wTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71900431"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Sep 2024 10:50:59 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so50x-0002SI-38;
	Tue, 10 Sep 2024 17:50:55 +0000
Date: Wed, 11 Sep 2024 01:50:48 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [NOT A REGRESSION] firmware: framebuffer-coreboot: duplicate
 device name "simple-framebuffer.0"
Message-ID: <ZuCG-DggNThuF4pj@b20ea791c01f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuCGkjoxKxpnhEh6@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [NOT A REGRESSION] firmware: framebuffer-coreboot: duplicate device name "simple-framebuffer.0"
Link: https://lore.kernel.org/stable/ZuCGkjoxKxpnhEh6%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




