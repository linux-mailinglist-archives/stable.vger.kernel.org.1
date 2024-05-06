Return-Path: <stable+bounces-43132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD818BD37E
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 19:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F5E28114B
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B24156F43;
	Mon,  6 May 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnKMmrDd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBB2F2C
	for <stable@vger.kernel.org>; Mon,  6 May 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014818; cv=none; b=A3zvkZzO3SvX1ZheqG6bgtYzSKuSGeGoRSSuFimhXmFIC0UcjfDiPHfZKJI+0j6aSQB/qQxNiIAJkBi3nEAAkWw0igcjYk7Qf9NlY1n5Xtz4w37y5iq2pUx9EtIPSbD2gBpgzWtiA5V4pW/VMjn7ooq1iomAW/Zb4+v5koqRAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014818; c=relaxed/simple;
	bh=rJcd5caZZhKGE6xxpCyv8yduuhfoNv6L1PORou0rdEc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EeTIZ9FYo1Sea87I+lHOOvM4HM3OcGMDbMoH38KwS9YpPeeY52fg3lz0m4SZWAYNclARj+DpCEtsx6RW/DjWP/b8OIivrXdOvR9l4texV+uDk3sjDSJ7+fW/cIAnqgSs4oADDvCweD270ORSbqAkQWHCpy/owveXO59mFVOCRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnKMmrDd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715014816; x=1746550816;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=rJcd5caZZhKGE6xxpCyv8yduuhfoNv6L1PORou0rdEc=;
  b=CnKMmrDdcRZNiSZkm1E/sBMottOQuBlztkNSCOkVQ7h1OwapdsjIERsG
   cwej2iBtkTRayOREHhs3ymPBq00xGPjZagXdf9SiELx4ao1wad4nD69Qu
   6e7AJVBT0vF+iAmtXDb6MIXtwF6NMdKJBnO6MxGsZum7llO1Y6khEq53v
   7NfKgodRtRXte2bfR96abynjEoQtCZbwxuY4dsTnxYHHhmgfXq88wtH6m
   NacwcZLu7cnyy3MRuy5KG0t7De0oKf4qFRUkVhtTRGfYlU5+HdiH5eL3A
   TTNVe6opW9/k4n5ROOSmAj8FbPcYOdStzmJjW9tOND37pt+gvHjRey++8
   w==;
X-CSE-ConnectionGUID: U9p3vChBTsun68X17fgEyw==
X-CSE-MsgGUID: aK/2X9hNQc+OiXJHr6Of7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10933870"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10933870"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:00:13 -0700
X-CSE-ConnectionGUID: r+q5Y2VGQlOdGM6RrPnS5A==
X-CSE-MsgGUID: +VuqpKQeQ9mchrFJkxho+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="59082991"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 10:00:12 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s41hB-0000os-1K;
	Mon, 06 May 2024 17:00:09 +0000
Date: Tue, 7 May 2024 01:00:03 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 03/10] selftests/harness: Fix fixture teardown
Message-ID: <ZjkMk3aG4A-swvNi@974e639ab07c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506165518.474504-4-mic@digikod.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v6 03/10] selftests/harness: Fix fixture teardown
Link: https://lore.kernel.org/stable/20240506165518.474504-4-mic%40digikod.net

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




