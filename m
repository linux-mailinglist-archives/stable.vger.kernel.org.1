Return-Path: <stable+bounces-50193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEEB904922
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 04:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47221285FA4
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A61DB663;
	Wed, 12 Jun 2024 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPJ3XEt0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5917BA1
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718160036; cv=none; b=iNCKZWpeqhiWQdSCiOr3eDWQZegC5VG5PKtOBnPQh9X7LAqJTmyw6QfI/4DDmSSjpeEtV7uR9VrhrXMbQXphiE6ZinR+qRaVwLt9pm3rBMEWBxG8S544DneB9XCc8mBCyibUrBT7zwDM3f7ZXj8qCXu4ybK6dfhDuBXJ9co88fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718160036; c=relaxed/simple;
	bh=fbhT88WsvUNVbkWpLd+3WV1L5d6ahoTn2hYZBoffvrs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pVy4SrJKCZUIu+fDF2AXJL2kXZalxRZ4OIqVIWnDjTzRg6W7QddrVEmuJRyatlQ922jp9kmfsjuvbZkGsxDQnh1qiIfVTuVDU9zRG4SfM3sWBv+wJ44f+LlKhBixUhy0BpzoHikH8zWK8a5mj/YnoOXeqBDIwAvGRWx6NYw50Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPJ3XEt0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718160034; x=1749696034;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=fbhT88WsvUNVbkWpLd+3WV1L5d6ahoTn2hYZBoffvrs=;
  b=KPJ3XEt0RRsFHxdV5jFsKdMUheOAYP9KrFWRU85Qc/KqEe0pBeWyhPsh
   cN3wMoEVywljyHq+UZgHM0EAJRGa37RpDZMf6WAmET3UPf3nO6gVVM8LE
   /Oi7asl9SimNYRq3NAM+Knd6ek7CBDBWNc9MbXi3m9psLGpFjpsP+jxDD
   xMtcvnZiG01naGLIXZQYePzgWiVYBKpHvvBw6X7SqjniMTpLWcWS50rN6
   1LiyQVHSMhcu9cr/nQ0tzNQF1cPYRtqfReU1UigJkwh5if99u+2k12jln
   0whmJJlvivz/CbpVSsvL0kJyXLUEtk2HnzQHaC+Aq5QgFkhH6n2UpZo2b
   Q==;
X-CSE-ConnectionGUID: +vBi90ewTxeGegx1qTTYmQ==
X-CSE-MsgGUID: yLp7Eox1QeeQS7rxltT0BQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12031820"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="12031820"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 19:40:24 -0700
X-CSE-ConnectionGUID: 9ogOP8iQReeIWXLqUArEPA==
X-CSE-MsgGUID: 36D9pNkGSQGNKxnQ98j6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39497388"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Jun 2024 19:40:23 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHDuP-00018n-15;
	Wed, 12 Jun 2024 02:40:21 +0000
Date: Wed, 12 Jun 2024 10:39:28 +0800
From: kernel test robot <lkp@intel.com>
To: "zhai.he" <zhai.he@nxp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Message-ID: <ZmkKYJuK8Ofb99Rl@242c30a86391>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612023831.810332-1-zhai.he@nxp.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Supports to use the default CMA when the device-specified CMA memory is not enough.
Link: https://lore.kernel.org/stable/20240612023831.810332-1-zhai.he%40nxp.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




