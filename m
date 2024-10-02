Return-Path: <stable+bounces-78827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9998D527
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A51C21CD1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45431D0412;
	Wed,  2 Oct 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8dqggLY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268716F84F
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875644; cv=none; b=hGzivv41o7BlXpQ4wxR78YqrRMsTgaKlRBKeh8NQPWWSDBweXS6mnmtpJkNBPW8v4d6BpDV2zrjeeYe9yzZYZ55HTvXXzkpkKpAatsiD7n+xkEDcOSo2Nqwv5BSmV9ioIYvISyk+1qv0fkThwh+GMsTenKJq3xlNjm9DJiT0IuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875644; c=relaxed/simple;
	bh=Mn9B6l9bRzL90ieh4PbtqaQCYwsvd+KT32io3NF9Z5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aWl0TcipjkA48MABYsEU2tBJMA7HJLsJQoup3KqDWkwMSnrDmUkdVxSATixQgzlQfdx/js+yDi0Yl4D8h1Sw06O7QU84hjg4BOtfauOQ81UbyaMtlmROMVzZRiLjVYjGNxPfdeD4oloAVv1BpVmLI5Sz8g0Qjs0GR2UKUWdGyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8dqggLY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727875641; x=1759411641;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Mn9B6l9bRzL90ieh4PbtqaQCYwsvd+KT32io3NF9Z5Q=;
  b=i8dqggLYc4lBQAm7EraTIYFT10HR5v2RwvpOd1gP9TfPcZxoEW/v/e+l
   USTrR2DykFWotuGn0a6qfL1wvxc9RM9st+GLi39Vn6eGBizgfinKhd77j
   074a3gn1rVj1F7rdAzwdMJxzVUFkoCPfkp8rWYvCkUlb4wHjMz4GzF+D0
   P10hsRy/AOWrBcVvIh7ioOZoH7dYdstzaCcoYKGiTJYCCkAD26xlzQ5Ax
   vpIIzkzkSew4+U3+d2U/S8VoO5fDQVWXA8aJy8yda/THLAoVGUoD6HKTP
   qIJ60h7XJVrIs4xvSayFjxtknkuHu46T1rApDasOG8PwiuqNtbSw2V29a
   A==;
X-CSE-ConnectionGUID: euzeEFF8SQCCPODMN/7x+w==
X-CSE-MsgGUID: ydmnuHCaTNW347uXuT7F4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26928014"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="26928014"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 06:27:20 -0700
X-CSE-ConnectionGUID: 8DwRQJJ1QFSFwOBiLkjDqg==
X-CSE-MsgGUID: 7yBEJjhhSeqx69Dng9JdvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78535734"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 Oct 2024 06:27:19 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svzNt-000S7g-2l;
	Wed, 02 Oct 2024 13:27:17 +0000
Date: Wed, 2 Oct 2024 21:26:26 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] USB: chaoskey: fail open after removal
Message-ID: <Zv1KAqAP8o4L3buz@5b378fdd06de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002132201.552578-1-oneukum@suse.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] USB: chaoskey: fail open after removal
Link: https://lore.kernel.org/stable/20241002132201.552578-1-oneukum%40suse.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




