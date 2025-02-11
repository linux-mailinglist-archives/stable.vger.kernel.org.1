Return-Path: <stable+bounces-114910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA324A30BEC
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 13:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937BB3A1979
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257586FB9;
	Tue, 11 Feb 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+l6vk3/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A61B85FD
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277548; cv=none; b=JKJSHJ+mtD7dOB0R+dKqKhuy8AuP/guOesogVFjvmzHfwkI8lhNCnVZFwp8gWoPy1hY33tX2qnxPaM+633z5c32wrV5knvL08n0VEvusIVmE3vYG/FhSxqL9lNBhtBIgXXzvkpl0OaWybp3OGBT4/4yISFrZWWEzgJs4Tgrg09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277548; c=relaxed/simple;
	bh=I3J6efnR0PjvI0I/FjS01Lo8ztCyGXHUdF+cwbVzSxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=obI9u6Fppf1tz3nN3uYYUqSWarkqHnfmI4yVWRSrZmPk0SKGDk+SjJufD4f6eqYFLaKU1sqP6jrJ0MFmX4Me6oyjr1miRiTPR+Qxr7qBPWKuKCm3seoLKjVmEzQU7BSqPkpH57sUDQnCG6HL5vZZMNBklK0UtmEmlZG+ozdbTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+l6vk3/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739277548; x=1770813548;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=I3J6efnR0PjvI0I/FjS01Lo8ztCyGXHUdF+cwbVzSxE=;
  b=F+l6vk3/XZKyqKaUwapGUrkzVLy3fFAeQhnUuLYg8wdfn5db7UaDDz6c
   S7xTWtuaHHsE4Cno4q/EIs7pjkC6N9EfCgXp+IqGv8DsxLdk0mxXkmRTW
   8yiWvDpbsFkYfraI7t8GxaH8WR7R2N+edKD9WE2nuRh8I432nHlGq3a2z
   /CECOrMwQg1WEI0TMKMCJuYl2sZxDevpIKDIcsz/PEFvRcX9dIRGsU8ny
   pd784q/nAv9w+JVvkOTJzP+ay2f5aesfIFpZE+t6DY9ZHjpuPEPqtkh5W
   oV1cH7i9Kq177zo0PsIkhf7Se5eMLy5/ESPmOTc3XQos+kTxT+Pz2M1ab
   w==;
X-CSE-ConnectionGUID: aDHO9HKdReOKPhJJQKlSnQ==
X-CSE-MsgGUID: F9wbvQe2RPmwzStXFV73/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43654459"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="43654459"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:39:07 -0800
X-CSE-ConnectionGUID: iBSdd4hTSWG2I/WPqMSRag==
X-CSE-MsgGUID: dhOJaEZjSGWT/2NbF+iHKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="112455841"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Feb 2025 04:39:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thpXb-0014A7-2r;
	Tue, 11 Feb 2025 12:39:03 +0000
Date: Tue, 11 Feb 2025 20:38:54 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] usb: xhci: Handle quirky SuperSpeed isoc error reporting
 by Etron HCs
Message-ID: <Z6tE3r7f-r-vYGo6@a4552a453fea>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211133614.5d64301f@foxbook>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] usb: xhci: Handle quirky SuperSpeed isoc error reporting by Etron HCs
Link: https://lore.kernel.org/stable/20250211133614.5d64301f%40foxbook

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




