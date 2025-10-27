Return-Path: <stable+bounces-189917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC7C0C02D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377333BE692
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827732BDC2B;
	Mon, 27 Oct 2025 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5yA7uZG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64528682
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548161; cv=none; b=qHgRIfNWfGWwqzQX4rbceyclVg7PgFzYpsVxOgYtqmbAKDDMp3qIL9H+K7RqZpDVRgKQ3bGaP10CvNZLJw/nA5lyNguc+8ywmktSPN/AfkVMI+io048dbvSLwl+lLcNEkF5YxPU+UQmOgyBBfyEt719/nP2+V5wkawzuCKwalEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548161; c=relaxed/simple;
	bh=vb0ZnpvA3usBbxYPASAaUm19xE2GVagWxrzyptkWf+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=loDEeoU5bcpL2uVIhoq19h5/h6GPVCykoO8lBAE6XiJLRpwNesqEz2GCveFGK3PnZPK/I5GdK9q1YYSGAF9WCVb8TJ5f0OiynruP8DEjwiWVviwZE8Od2rwGj9kqWYMph/aCyb0eJsCF4ZlgLryZ7s96y3GSKAtV1izJqE99VKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5yA7uZG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761548160; x=1793084160;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=vb0ZnpvA3usBbxYPASAaUm19xE2GVagWxrzyptkWf+o=;
  b=V5yA7uZGeNj4eUqxlt7SIdF1D8RL5x/sXHVtFyLFgbadlNnE80QouhkP
   hgum5aesAxTp7g5hLCKKZauB6RKuHv65X3CGpD8u7LjEDAVwShp3SgOed
   Z396kAZcqRrs0KeoGG/APIHJneQbC3XSPsfaGAky3Kdfni/vluh9mFpEN
   yotAuzZxCSEnkakaXATf1VVZeQoBSCFxwTxxMLnRnz0Dv6ugDkBi0yX5j
   I0sf5VDzuoUL0GeXg4dtdjiNkFddN/ndtv8Rb7iLm3iMS86futT/u4wE8
   ofCe5hii6g90g/QaYZ/un4sXuCK++3wzJ9yCb3y1+IAsTnKV1CnYffVQe
   w==;
X-CSE-ConnectionGUID: 5cEotl1cS/KIl2SHCwXVHA==
X-CSE-MsgGUID: hkl/jFQzS2yz6w8Asv633w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75066614"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="75066614"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 23:55:59 -0700
X-CSE-ConnectionGUID: KHYiySwtR5iFrCMmyJpHCA==
X-CSE-MsgGUID: f6Ny5IhlTkeSUpGipoGWrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="189337353"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 26 Oct 2025 23:55:58 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDH91-000GZp-2F;
	Mon, 27 Oct 2025 06:55:55 +0000
Date: Mon, 27 Oct 2025 14:55:13 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Troshin <drtrosh@yandex-team.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10] scsi: target: target_core_configfs: Add length
 check to avoid buffer overflow
Message-ID: <aP8XUbllH_jELuC7@cf5b8cc2d60a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027065048.2023-1-drtrosh@yandex-team.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10] scsi: target: target_core_configfs: Add length check to avoid buffer overflow
Link: https://lore.kernel.org/stable/20251027065048.2023-1-drtrosh%40yandex-team.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




