Return-Path: <stable+bounces-19363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3784EDF4
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 00:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA2D28C74F
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5444F8BE;
	Thu,  8 Feb 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dawJIegt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDF050260
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435676; cv=none; b=iidzSMOcWvOY4nGRiwHGEobTGZ1F1lVJUdruXaEUpkFDsq3onhpbdtyER6V8d+ajCjC2NameURhL5z6zwNoDdWmQUj9qFmu2K9ulsC85YS/weZPGvHHLv9q6n7UMnKfs4cmyrQf4LvxupQvsIsOIV+Hz0Hj2rUgjKSowP4ojyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435676; c=relaxed/simple;
	bh=hKTqmvrOB7w0VCGhi9z36HneQOE6CnwZzk8LP77mrWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UAO/ZCYGhIzVBFg9yeBKr3SEYMw1yGSIYRmUODYL+gf7gfkBL98iLBfyN7LpLLSuh8PYEXaHFuHjsYOzrSd9Is3LhlG7YpZLrT7ME58zfJFwPYzSFxHMuXEc1t14X8oCJkJT+SO5duwgNE8a1Z7yEWJbUeuMECgX/XqF/JuQv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dawJIegt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707435673; x=1738971673;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=hKTqmvrOB7w0VCGhi9z36HneQOE6CnwZzk8LP77mrWw=;
  b=dawJIegtbUjZp+fXjhLTfzGX9PCoGcrNT6VR72+Y71J6HWUYVNWXwjmh
   OjCmPDLyHZ4+o8wJOiM8Ke2xQupy+aYeci0MmYRY7UUukz+TpOdsRbYb1
   GPJ/HKMgPHTNcEz7usW7RFqEQIf2T/8Mjy17xYITB+OtQXGHS7iL6B7z9
   v6TeYkNlsRFTTJMMiOH/voxcw31k+mhW2CndZVSId9gLgQ2GD5HoVJAqk
   ytaQsOH9Wf22EGUGXPh3igRlI4Sps4+JGs75LBMd54fytv6EJLWstUd2+
   FKCO9nGKGQ+3eM7Qo5dNJdmhuu5oR/lzCJEpNU7z99HPAZ62KgJAP95E6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1228192"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1228192"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 15:41:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910537215"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="910537215"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2024 15:41:04 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYE0s-0004D6-03;
	Thu, 08 Feb 2024 23:41:02 +0000
Date: Fri, 9 Feb 2024 07:40:07 +0800
From: kernel test robot <lkp@intel.com>
To: Catherine Hoang <catherine.hoang@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.6 01/21] MAINTAINERS: add Catherine as xfs maintainer
 for 6.6.y
Message-ID: <ZcVmV-vL9CK8gpl7@2fb80f39de5f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208232054.15778-2-catherine.hoang@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.6 01/21] MAINTAINERS: add Catherine as xfs maintainer for 6.6.y
Link: https://lore.kernel.org/stable/20240208232054.15778-2-catherine.hoang%40oracle.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




