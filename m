Return-Path: <stable+bounces-25446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24686BA87
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 23:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB10EB27B83
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECC41361AC;
	Wed, 28 Feb 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8960nGx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506D1361AD
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157978; cv=none; b=V9rvpFJLmsv9ev/RjjcqKZCcEVpLgnqjcsq4bTiiCvVBIAME5SGf5iEv4ui7z4d/9GBYIqJgKIkAVRqmzfeywet18UkA1JJvDWiNU2Bg41R1RUNKl8/7m51OM9x65dXKsx0vUftIXO48kvz3Jy3Zh889/l/rDmmsOdmpeR8tFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157978; c=relaxed/simple;
	bh=O3idBZpZAH4SnpT3VLpCPZjK2kCkOmrtCUyFwkhyXMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G2UlJD8BhFe/4SYDlvTsVt8be7zY3d28P6OYdN5rBiNgK9JDNrkhERmAaEOz0CYEQhvhumrhP6gsv1mmRmjAJ1j4Z6vNXt6cIgEc92R1kVTTz+vtvyWhc13PD1KBjWX7Ub75WBFbBaZ2bGCJ0xcNf25YdviD8zgphorY+tLhYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8960nGx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709157977; x=1740693977;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=O3idBZpZAH4SnpT3VLpCPZjK2kCkOmrtCUyFwkhyXMQ=;
  b=B8960nGxL7BOmamAMT705SbRRuCtr8U5Pf+TTK+S8Eel9UN7wQCd/iA1
   GBCRqSAfvZySJ++Wx/9+mEtkwdPsPSVeqgCQh9v9P5GjiROHGW2h87jNj
   6HKdkRhrBl2GH0urGLF9I43O1GlF7BSancZNuzJaS7SL664mfRXHaVcOa
   GTfs1rkjoivENY3wDSm5WFgbWL2JwiHsrUukrt6DYojA7/DCkqpX2AVRg
   iO5H5RvPBTNxcdwNky7cekf5YS4x6nkkU7uqi/gaePKr6UNgnfWJrZEth
   ymToc8i9XyRZlmJGkQhm9u8G8iBCGm4yvVcR1SP34NdkgIU0pjMQG6l8b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14146567"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14146567"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 14:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12148844"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 28 Feb 2024 14:06:14 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfS44-000CQZ-21;
	Wed, 28 Feb 2024 22:06:12 +0000
Date: Thu, 29 Feb 2024 06:05:42 +0800
From: kernel test robot <lkp@intel.com>
To: Jameson Thies <jthies@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
Message-ID: <Zd-uNoj53eeu64M7@fdb2c0c3c270>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228220251.3613424-1-jthies@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
Link: https://lore.kernel.org/stable/20240228220251.3613424-1-jthies%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




