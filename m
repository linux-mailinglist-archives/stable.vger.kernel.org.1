Return-Path: <stable+bounces-18929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F284B410
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 12:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A881C23156
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D846E130AF9;
	Tue,  6 Feb 2024 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zgx8cob5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E40130AFA
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219845; cv=none; b=qrsm0r7ytS1E4XToYb9Xp5F+T6OcvtSejej0TuqHDxwH4vw9NDVzQBqm0mHQJZ7KAa4KiZd0Vbe9K9O4+rpTOzrMn14Bh61wNuaB0QUmcyW+4vWv6Jmk89+tahSCLgQUSPh+iUYEy+dM1ev8+AVCFS4YOKRmyybikfHy66hoT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219845; c=relaxed/simple;
	bh=ifMf3q5KFj3fEb143LGBQ/RQHb9VNjmpSvKzU0efqXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IpeBefJ+2TTRoFwIIHh8P6cToPU5rzMLm22G95+/ieOIrnlyv3Wbi59m53JyNr0rEw3KpJvFMzxPxuN/hxl4FXqUApmJB8+ShHvCnHc7dIxvZQLFiNBwznrDLB74nJWDeJxrnTgdlHMQPpvKJXln1vnNBw9TbkexC3T/42dMnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zgx8cob5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707219843; x=1738755843;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ifMf3q5KFj3fEb143LGBQ/RQHb9VNjmpSvKzU0efqXg=;
  b=Zgx8cob5wNrX3jnj7syp0VMZf5+1x95Dqb4i9VRID9XfnOQ0SIdnL5Gp
   8CApnsPXNF9af73f5XnQs0virC9j5AcMygksPQfw9fr7aZKeV1zAcC4os
   aq7wMtSt4sU2ghl1+OEgqQ6A5IrCchribrwb+SmkjNvhtEWzWCraUrhnK
   N9yYerCWBcEkhRWniP8Xzzc/iPfBeJFZwSjAAV2/VH6LfrS2bBOGQdXe4
   7ohG0KvvPlj4WE4PeXv39AbxHUIbuk7k6JP6gqR5XjQDeZnVwr6Ds6AMN
   VW9mtUZFxh5KggzeAyHFN2xCy8gaYtePRqlPiNBlyZoKD9ecgZyCCRaK+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4515357"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="4515357"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:44:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5760999"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Feb 2024 03:44:02 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXJrq-0001KO-34;
	Tue, 06 Feb 2024 11:43:58 +0000
Date: Tue, 6 Feb 2024 19:43:34 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [v6.7][PATCH v2 04/23] eventfs: Have eventfs_iterate() stop
 immediately if ei->is_freed is set
Message-ID: <ZcIbZhvrZE8c8xlp@ddcdc6924185>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206113358.729003384@rostedt.homelinux.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [v6.7][PATCH v2 04/23] eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is set
Link: https://lore.kernel.org/stable/20240206113358.729003384%40rostedt.homelinux.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




