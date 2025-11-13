Return-Path: <stable+bounces-194707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091FC590A6
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5EC6508CD3
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B617E35B132;
	Thu, 13 Nov 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzGAEvDw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1835B12C
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050898; cv=none; b=G9KikomImnKxXv8TFWYimjFiYG7JJ25JdL2Dw/Acc8QBD7XCkWTHZmeATxUoadH433qkWgnlZBd+uhfKEdzXfTmrxokJyvg5tzlQrOTp0Ogvdv9sUKBFzxlWJ+wSWgwG9RSY9YId8K/1LTE38LXol/AE0ClpYscYOxgmCUmuRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050898; c=relaxed/simple;
	bh=XSrcaNhguz8zSGMbWozn5kQN8atSs74h/cO9FuTZM2w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IajQi6ItKlsFSHffpwm7t0x8LGvuw7Di2WvMZ3LredFnlSf/celxSRIgG6H8d6RjxWkAAK2dy6kfFTuea6mI2QorCpux/vmFLS2dNyfZCj8TRDlGj42feZiRbHEwsHqPtIISMZiRDVk9gs91/skJ4MIH+QdxE/CH3lvQfNZoW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzGAEvDw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763050896; x=1794586896;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=XSrcaNhguz8zSGMbWozn5kQN8atSs74h/cO9FuTZM2w=;
  b=nzGAEvDwP7emAW/ffOE0c8hqVNJGAnyrE2DrlWKp/WjFfyNMNkRPjsMo
   qZ1nveQne5NXV0Shz4vTpQQKsZbnpZPhUtxY8usBsbu29nO8cuuBux4eO
   Zc0/Hu+cAQpfhH5OinSP8o0Y48BBmBPQTWqKytOv1iHJint23aOGSrMa1
   2fA7sI5uB6oga+ALoSMPdUYy1AmS3sxtUj41FCIoJ42YtE7yb1Unzp4Sj
   jP/0vUKlDih/2aBfIVMh8G4hIcJHe8MXUZ5RzGNhYIr0s1HM97ViWFMjj
   ec5uoc4SKi9qAzu7ClaAyMjZU3R7LXbtJKXIw5IOtvrGXYSY284tSYvYy
   w==;
X-CSE-ConnectionGUID: jjIP5hNSQbae1oTL+QbreA==
X-CSE-MsgGUID: STg+Xx7STSyGK6rW1Yvj2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="68765922"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="68765922"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:21:36 -0800
X-CSE-ConnectionGUID: 3RnC93V4RMe7kPiPIminsw==
X-CSE-MsgGUID: CvMLncZiRomQ5FFhj++Xrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189553016"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Nov 2025 08:21:35 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJa4i-0005YJ-2o;
	Thu, 13 Nov 2025 16:21:32 +0000
Date: Fri, 14 Nov 2025 00:20:37 +0800
From: kernel test robot <lkp@intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH printk v2 1/2] printk: Allow printk_trigger_flush() to
 flush all types
Message-ID: <aRYFVT9p8QIII8jL@c83b8aa73612>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113160351.113031-2-john.ogness@linutronix.de>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH printk v2 1/2] printk: Allow printk_trigger_flush() to flush all types
Link: https://lore.kernel.org/stable/20251113160351.113031-2-john.ogness%40linutronix.de

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




