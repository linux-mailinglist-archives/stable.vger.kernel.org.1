Return-Path: <stable+bounces-8444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F04981DECB
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 08:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902571C20A27
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 07:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47A139E;
	Mon, 25 Dec 2023 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivDxYXkp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6E4A31
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703488796; x=1735024796;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=VvP3lVseSwZso8Vfs7xEYANVnkrnNrLbJwwacbxIHVQ=;
  b=ivDxYXkpflCjU/OOGUwMpmYVR1YlABUAOFBnCPtyYWqtga0HETWfKZat
   7YgVIOKUd3EP1FW1hd7TZ4ZfhppazL+4GwbnlzutFGuG69JZOEvZ++Tbt
   UdG6Qqzj41WZtYAfOr1W0SpIMduHpEOLp4kY42rxGOk3AX01J9qzgaeEC
   eDPVE1NkbwbnHebaBIsjx/zyy/qe5xuu+POVhW/3K6cJzT3hZdEvl7AId
   ViLtCE/VS/2ME3XXDIufR28Md34Ckgsr7QCjVDH5gMPhwvhw3S6daAuR7
   D/c7dIx60O8HX2bUE/XaIKPlAlHkUB06g9UL/bocN3hOH2eWVxKpItSNR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="395161400"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="395161400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 23:19:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="868314059"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="868314059"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Dec 2023 23:19:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHfFg-000D7U-1w;
	Mon, 25 Dec 2023 07:19:52 +0000
Date: Mon, 25 Dec 2023 15:15:32 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Zhang <mrman@mrman314.tech>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Message-ID: <ZYksFJtDVQHy_Az_@89a6bd94b8e8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05aa1755970796d5a250660e42ee85ad@mrman314.tech>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
Link: https://lore.kernel.org/stable/05aa1755970796d5a250660e42ee85ad%40mrman314.tech

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




