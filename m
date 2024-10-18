Return-Path: <stable+bounces-86729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 773439A3388
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 05:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FE91F2152A
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CE15098F;
	Fri, 18 Oct 2024 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMlmluCZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124D20E31D
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223527; cv=none; b=KGmPEaq7eO2Fx/vJzt8BHYzy+bMfAe9Nc7ivuVDyurO3olNFITcLTEk66Ct420x1nypAehMBqzqMqXhs11i0ktWvNnBpWmgIuGuoXesym/3+2gD8DYatUVYghn89xL0WYrwsfL0Z73OQdN3VcxwXBRJ+ZaUtBpmriJcHVQnf5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223527; c=relaxed/simple;
	bh=GwaWOOboQlho3iQSLbSyHOn/x2HDxOr4BC20PaYIEqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o6jPMErvmP+e2xugWq8zAkdCNJvBZak0wN7NNSytmS5BpwwsIf3KrvGU3d/XRCrp52xdA6c990SOgBY0deP9pM8PvguW7oFrEY9M3cWksvNS5TxGwJNCqoZN+o9KDBFCIyKeb1DJzNFNe7LuBg+/YRG7zux2N8SZdYp6FvtPZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMlmluCZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729223525; x=1760759525;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=GwaWOOboQlho3iQSLbSyHOn/x2HDxOr4BC20PaYIEqk=;
  b=AMlmluCZdX2d+/MOpN05R0LXJup9unHpbLfNXNRT6WBeq2KNukhJkDDN
   cyKn49CLRKpyZD7VizXrNL7ibLyNw6VTwCKJtA2/6oNr21rD9EuFJIEW4
   8ZCx9rMLA3qTocgljWkQVwIx7m/coJk8Ti+SCZ/CnsM+3bV/fv0Ms2E0N
   Acfsat7Tq0tQGuSCk0X9TfPzai2Be6b9LRiQbOfyrXQ+9JXhxF1Nl66Oe
   f4FKeWDBqKgww4uLTA7s58jWQhEtBXPqGsQEvJkm5+FIBV6FuqYUg5R0k
   fsUvjy/yDzu58xaou7yzRTYUsur5w4S+4ShZKgQgR+YJGFhviLDucAtU6
   w==;
X-CSE-ConnectionGUID: DD900FrCToyMxVRfvMaBdA==
X-CSE-MsgGUID: TSUP11h7SBuJBomCIz/c5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32540698"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="32540698"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:52:05 -0700
X-CSE-ConnectionGUID: twWNI8GTQcW+HYkX88klXQ==
X-CSE-MsgGUID: 0PUHcgb6TKynbUGPXk7LFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="83390268"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Oct 2024 20:52:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1e1w-000NEl-39;
	Fri, 18 Oct 2024 03:52:00 +0000
Date: Fri, 18 Oct 2024 11:51:26 +0800
From: kernel test robot <lkp@intel.com>
To: Tommy Huang <tommy_huang@aspeedtech.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] i2c: aspeed: Consider i2c reset for muti-master case
Message-ID: <ZxHbPvTBX-E2AV-1@594376e94b8d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018034919.974025-1-tommy_huang@aspeedtech.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] i2c: aspeed: Consider i2c reset for muti-master case
Link: https://lore.kernel.org/stable/20241018034919.974025-1-tommy_huang%40aspeedtech.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




