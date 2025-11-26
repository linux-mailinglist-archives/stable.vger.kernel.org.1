Return-Path: <stable+bounces-197017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D761C89E2F
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14E51345C40
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A64328B41;
	Wed, 26 Nov 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEPLSR4L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F622E2DD2
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161935; cv=none; b=bHAlpyCHQTo8OP0VRv+pUozeb2nmv7OXpJZbkh/uiuluvr72jSX87RPf1QiGRTybt2dqgY9vhITmP2TLP8OgCHhlQcXM+c07wNe8fev7CgIb0bHcCG8DbcqXMHOsSOduj1i98rrklj6Ifzsrc06HXdsuyMg9urs5hlpV9DMCHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161935; c=relaxed/simple;
	bh=3s/KbLtC2DkKRq+7tKx5zPeRJeZTNmrFx2DGWavhBv4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eBQcnrTuZIfMs3sq5sY7HaUXguRj3mnNzzXOjuf+5GmxC6WARzHFfScPK4qkDVGSd54qm6yXwhb4LpF4Ia+7ZoL14w7pfq7n6HykQKW832QF6eRHGEZFWhnrkhiRH4gZWMrcMC8HD3OmvdoY2czERL4dSJqJKY4Y0pbCUy65SoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEPLSR4L; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764161934; x=1795697934;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3s/KbLtC2DkKRq+7tKx5zPeRJeZTNmrFx2DGWavhBv4=;
  b=dEPLSR4LLsS0gGQBzpEtbgxObaKgculABXLKdoUTzDPNoa3+lUKq2aix
   KQU48tdjzvYrKmzDmpF2eeOx0fzwgHebe1JLB4fojJJy9oR7f4EZS9RlV
   IC1uokh3to0wTu0sGtJn56RmVYh3v/7Mi2xtcPaaGR0ysO8VxORUCnRAh
   Yr1IF9xjmE0K8YoEMctAve0hAnvmAaREvVzzdvyYpG5AbFd58XZ4bNmcF
   QIC8+Guklb3BksDwIRY0IFNeJ/84yi0q+7sbfHHgckAkafnbLzq8aqnY1
   bIHO9nq3dgjwzHWNd82xNu6UlNXYUZhMBT/AQC7ptpz7SGweZPit4zwFv
   g==;
X-CSE-ConnectionGUID: i4pzIzbJQFSAMI1RF0WC4g==
X-CSE-MsgGUID: CSW9IwhkT4y61pZUSpwnIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66238577"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66238577"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 04:58:53 -0800
X-CSE-ConnectionGUID: p3Ymd2OnQHmBWuLC3MgEdQ==
X-CSE-MsgGUID: bRDb6YkYTVik77PvK0uGmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192576383"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Nov 2025 04:58:52 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOF6g-000000002rl-2Kdr;
	Wed, 26 Nov 2025 12:58:50 +0000
Date: Wed, 26 Nov 2025 20:58:01 +0800
From: kernel test robot <lkp@intel.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH REGRESSION v2] drm/panel: simple: restore connector_type
 fallback
Message-ID: <aSb5WUMfQ0h6iQu1@c1f05358b1d3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-lcd_panel_connector_type_fix-v2-1-c15835d1f7cb@microchip.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH REGRESSION v2] drm/panel: simple: restore connector_type fallback
Link: https://lore.kernel.org/stable/20251126-lcd_panel_connector_type_fix-v2-1-c15835d1f7cb%40microchip.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




