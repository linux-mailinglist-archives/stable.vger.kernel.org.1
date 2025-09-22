Return-Path: <stable+bounces-180971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDDB91CA7
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 16:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C7418969A7
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B053F2BE64B;
	Mon, 22 Sep 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E417zpq5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8731F0E26
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552433; cv=none; b=rlYiBzoxiLUnqB7BDdjCkngicpsWIT+HoL+uxLaf/0vsnxIHgSHSDI0Kp2Wzy3LQ59BMpf0V+t+cTXknmjt2Zj5jr8qhajp2wX5he2BGaqiN5ZJUsR8W/k1FzMcY90Y5xQd3PGZHgnBRQmHEIGfWemO13XtcnGVeBM5KePlzxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552433; c=relaxed/simple;
	bh=/jxWS2Cfnrc96B/2JxemOCSklZ1V7YQB/X91PQsXTJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hbUvBYCoZNzICpA58ySCg9d3tjhUo1kE6y2iHCJDSNsMpBg1/ThL1yxQtjUjLWwUC/R7LUpI8eWyqQ2EUkBlF4KWFjyDTKO6ywu3EWjJrlNUcIJbvIZbkdmzabRvIWrpDR8KZIyww60oeXaGmKVu76Lih9CfWWaLrQvLvwBLBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E417zpq5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758552432; x=1790088432;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/jxWS2Cfnrc96B/2JxemOCSklZ1V7YQB/X91PQsXTJI=;
  b=E417zpq50ga9UDELZIe5bAVnoQMPSHApJmXGxGOQDIWeQNICmgOBYFWk
   LvPWd1Voexb70wALQ7bKj7nq+eqJefqLzyj1sB149HKbLjtUKO0l/K2yb
   DtoD+arU8IHM6fJ2hBTqIlIpIrSB2tDRP7s7t3ge26Z0GoGKJFvdH7uD1
   Qa1z33SkfDq3KHivtnYf97dLKZoTJ39nH+dd9AEk1HP6dZ28To5t4ZwXg
   +2anZ89FOYGMc2Om9R14gCrPSHbCP14RXKE4xJNckmJsU/ET37E0IAR5n
   AnAhhMf9cIQ/7o8NBcx5P/3x6vLJAOd9i4ViVlHwPheySQsgDCiKU4N+R
   A==;
X-CSE-ConnectionGUID: bJrdrdtqS8mVuTp/0IYO/Q==
X-CSE-MsgGUID: JIe5n4++RQigJhzYiCPTSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60703223"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="60703223"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 07:47:12 -0700
X-CSE-ConnectionGUID: Mi9Atj/gQTebr4Nmf9um3Q==
X-CSE-MsgGUID: lnVAyYmZSlisZnkqRmXBNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207230116"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 Sep 2025 07:47:07 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0hon-0001mX-09;
	Mon, 22 Sep 2025 14:47:05 +0000
Date: Mon, 22 Sep 2025 22:46:07 +0800
From: kernel test robot <lkp@intel.com>
To: Xinhui Yang <cyan@cyano.uk>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] scsi: dc395x: correctly discard the return value in
 certain reads
Message-ID: <aNFhL8x0LWgCYhiG@8a941366eafc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922143619.824129-1-cyan@cyano.uk>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] scsi: dc395x: correctly discard the return value in certain reads
Link: https://lore.kernel.org/stable/20250922143619.824129-1-cyan%40cyano.uk

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




