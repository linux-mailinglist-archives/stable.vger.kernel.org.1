Return-Path: <stable+bounces-194924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A4C6214F
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 03:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C60564E68D3
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 02:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E661E3DE5;
	Mon, 17 Nov 2025 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yua3qNpw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF72156677
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763345863; cv=none; b=lRPoBJip97tpKxGd7BkjTXyzmUvxhWHDrOLy7NG2niRPF5JDIUm1onEDugrBZGHoUAz0l9hB+47n17V92BvDU9B4ggFBNconIDcg14q8fJKbM4N+GkHtz3BtZtIPLP7IEszutvfLid1GpSshq2QIlc7WIgtpFRbosmawQoa9PB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763345863; c=relaxed/simple;
	bh=kJ7rArdQZhc3YqIOZm65TkKxb2rNJCi6cN+oqBOmiS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TFnfc+RqvSUdowoH8knJJdFGIHNT5h2gbXwa/6j+fZTBOsJs+4EuEmxNVtT1ihPE2NjGuiRLr6Brr/2zVgbCJ3hCH0aVseakiHHhSh0yLCaM5n58YFFDXn8Yx9x/9I24N2T2xZVjH6j6qV+LQyzSffWHTN0eNvCDxRbAsf+/Stg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yua3qNpw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763345861; x=1794881861;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=kJ7rArdQZhc3YqIOZm65TkKxb2rNJCi6cN+oqBOmiS8=;
  b=Yua3qNpwfKbdJtzotiP67qDAruUSxSi3i4tjs1DSje00xNPYNG+7zA4H
   XN6/rWxUBCOxZ6n7LtXgK+SDLEoxPQe5U9fb+tuwsriNTxyy1MHMat9PH
   Axn0yu/GcfKB1XrBIOxntgiSs47I+Z8MmF9NcOE1OlwlxSLl1Eeu0cAPs
   FhQe+oreCxlRHKUNtjehYmhMWxOVNlsq/tEUfrN/qebyYToALOf8XshZg
   oq8mwN0rAfMP3Usrs8S3D/fNFYxSySViInsJ/rzbqjDLuCgsX2NGuoL8u
   9MxZdqHGMbOIP4OsLPNSHp2Esu53FbTzIzdRvTEywyETwsN/ENYZ0o1E6
   A==;
X-CSE-ConnectionGUID: UfYw372SShuhYwlQM+IIAg==
X-CSE-MsgGUID: VG9R1VINS2+A+4lszhFfiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="75660947"
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="75660947"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 18:17:40 -0800
X-CSE-ConnectionGUID: XQ4FJphvTbiz1PszRElAAQ==
X-CSE-MsgGUID: X6qgFbeUR/G7iHgH4VLixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="195264636"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Nov 2025 18:17:38 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKooC-00004t-29;
	Mon, 17 Nov 2025 02:17:36 +0000
Date: Mon, 17 Nov 2025 10:16:58 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <aRqFmo4DCWLcgeyp@3f7c4ed3526d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117021429.711611-2-shuai.zhang@oss.qualcomm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 1/1] Bluetooth: btqca: Add WCN6855 firmware priority selection feature
Link: https://lore.kernel.org/stable/20251117021429.711611-2-shuai.zhang%40oss.qualcomm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




