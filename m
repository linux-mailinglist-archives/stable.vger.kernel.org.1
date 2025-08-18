Return-Path: <stable+bounces-170047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D9B2A097
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F713BAE47
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B226F2A1;
	Mon, 18 Aug 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZy3unE3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB4246BC6
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516676; cv=none; b=GCld+bwAdfYqeaU3NjzqD9r0YH/9U4IXpZGpzojHDpTKOMonUsDushHZvcNGKnkuAdrr9fLPs2DiLmiwxjbrxqwvw3bb0W7wv8FVc+ImKVHQDbbJqE0IOnFPA0RGYotJaGkkYhpSVR+4naKre46IqoHi5EL2eiBKfTNfIZCaaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516676; c=relaxed/simple;
	bh=O+lggR3p+A5qGwr6MCxsE4+Iok9qgYiekHmf2JSP8A4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=glSSL+4MNbMXXOVG16eS4PZysEgxYpmfNTvWCbLF1SXy2ECmatnsRK32pf0WPDNUd9SAPGR946LyNgsHlHE/IpXqgaUy8LLtUEDf1sWn8L1fxsgHlyerrQcl7seJzuEuB715dNwkcWPggXmmdIEotMUr8qzq6sUcCRzUTdGogXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZy3unE3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755516674; x=1787052674;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=O+lggR3p+A5qGwr6MCxsE4+Iok9qgYiekHmf2JSP8A4=;
  b=ZZy3unE3gLtl1/w87PhwpNwDYCFL36DX+uVCzs9jXxS8DDvSSq3LNJ8/
   a9+X8jo7RhJnMKWX5zUEtJnKZ9I3WxBSJes4MVD/foa8CiGV6/Yj0IoS5
   HpyEhZqnZ+WtM0vbyYb7fkEGo5viDb2HuMIZr7JLf9LRoNNnvy90oB29u
   KbHDNg7iEfv9hqgr92D8Teaq+4gonVGI6uTVnU/XlCu3PODmNnXGFWUWb
   ZvUSJD0dw1AbK3MO1DR156spkv9j2B3H9BBZKfNKpanmDl/CvOctTkyun
   lBvpsI5GxE5rUG9ARKKqhTbCW47/iTnIm2uN+feAu8NA/jlOs/z9irm9k
   Q==;
X-CSE-ConnectionGUID: 1gY1FjtITlCXMq4FTj9muw==
X-CSE-MsgGUID: Sz1nPyRiRNKE+x1nbKnPZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="80317384"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="80317384"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 04:31:14 -0700
X-CSE-ConnectionGUID: cUFRx6S4Tv6Bop19ItLeZw==
X-CSE-MsgGUID: UesJ1KI+TF2+pva6I0JKBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166784294"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 18 Aug 2025 04:31:13 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uny50-000EBv-1K;
	Mon, 18 Aug 2025 11:31:10 +0000
Date: Mon, 18 Aug 2025 19:30:15 +0800
From: kernel test robot <lkp@intel.com>
To: wangzijie <wangzijie1@honor.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] proc: fix missing pde_set_flags() for net proc files
Message-ID: <aKMOx_fh0lXoMNF2@769e0d9fd271>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818112428.953835-1-wangzijie1@honor.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] proc: fix missing pde_set_flags() for net proc files
Link: https://lore.kernel.org/stable/20250818112428.953835-1-wangzijie1%40honor.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




