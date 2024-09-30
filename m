Return-Path: <stable+bounces-78230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D70989C72
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B01282ED1
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49C314A09A;
	Mon, 30 Sep 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M194nXVn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03C17A58F
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684223; cv=none; b=Eosl1EiAzDo5CqtoFW8pKFNN4CSrwNSn2B5DUJuBQth5cK427zJ3Sr3SIrYEVpWu6l30fPeKYgLPD7w5x+4+MD9H3aNWoQI3RibUIsmBlf3bEJOo0RpZ3JlToMY7poXNP0ThuWMsC/+tFtSWLXzfsH7dw24F13bvKnagGyrBmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684223; c=relaxed/simple;
	bh=4zroMonaGVz0DLu0QRApyBldFyQbMUUuMAh9tvCb/Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KcGtR6tZ5qZ5pDz1PrixrT/Ah3n6e5vt0hiub9YN18C73rJJW4amYUrWRubeYV/MCRbNRU27T+nLprGt886bMvsr0d2h7Bh8Lw4TBNjxIUgiOh+hbShi+w2FKD9GtNCbkhtRJPmIxSDb4iwxsLI79wmA2IkCSjAHblk7qhP8jtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M194nXVn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684222; x=1759220222;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4zroMonaGVz0DLu0QRApyBldFyQbMUUuMAh9tvCb/Y8=;
  b=M194nXVnX9vt+jRv93V9zVAnhZHRB/e58R2xXgeby5dDgYrNoF/RokKN
   7IS4JmYOp7m49S14etbZfwvCxV1JH8pXpHm2HH7pt03dou24MmS+yxjrU
   zkPK70gG3HDejmovokW20wQpl0rvWJPk1ppIjTzdgnhbvrfJpu3rFfzv+
   U342SQt2XWqet7USiaZIYaEprXDBAaCLpA73Vl3JINqD7jFyVvvBuGiB/
   F6p7/e0ijOrBTKDlu73bZeJ7Ny3VYc9GVV2Xdq7NbKpJaUXrFQoAKANpe
   IzdtQOSxhQ7oqjrN/jq3ptsazO6TiTldaR0i6r/uMT8Dt+2ifVdsFSd29
   A==;
X-CSE-ConnectionGUID: JTkGvdxARb6aO/iIjzsUuA==
X-CSE-MsgGUID: wUR0o0kBQwyyCpu19HuG5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26225798"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26225798"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:17:02 -0700
X-CSE-ConnectionGUID: W3IsoolJRt64DScUMbitOw==
X-CSE-MsgGUID: ptVagjEaR++cZlMah4SI1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73353897"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Sep 2024 01:17:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svBaU-000PDN-1X;
	Mon, 30 Sep 2024 08:16:58 +0000
Date: Mon, 30 Sep 2024 16:16:10 +0800
From: kernel test robot <lkp@intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for
 VMBus
Message-ID: <ZvpeSkeAgjdPXayr@5b378fdd06de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727683917-31485-2-git-send-email-ernis@linux.microsoft.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Link: https://lore.kernel.org/stable/1727683917-31485-2-git-send-email-ernis%40linux.microsoft.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




