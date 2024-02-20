Return-Path: <stable+bounces-20798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C402985BA16
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 12:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6CD28282F
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597D4664CB;
	Tue, 20 Feb 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZG+SQLNr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD635664B0
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427572; cv=none; b=Mq4p2kPPVR4aDe35aixydNYMc7JUeh/Cm8FzGXoOu7d774N51YBd2H8UtWYohK3AShTy90cA0NbckMeF3KKXif+e2ERKUxzQ+KKKdNIV1cv19JphL623JrAQOP3Ror+ri7boeQCJW+4FHvREegLffsXOWMmMGHL1VLu8FbZEAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427572; c=relaxed/simple;
	bh=WsXsmpjsK4Tr+jbYY25ctW5IOach35TTfKZWzsyg7LY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iYrdPL7t+rGUSThB4/GuZPL0Z3hRQolakMZpzY5NbV8xU609l71p8vkxUf003BVL6gu0Uav6Vfic8R8jSMU0givh35U1VU3cnSVc+fk460LU+I7ElV25zKzA3ansZBeBlHFvyl7PO3wuMZaVAsOH53C6PHTN//ExMW/DK+VUI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZG+SQLNr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708427570; x=1739963570;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=WsXsmpjsK4Tr+jbYY25ctW5IOach35TTfKZWzsyg7LY=;
  b=ZG+SQLNrF1hv+6jDDB75TuXLQdKVKY/HsPjYUBJa6OP+40frNYiCf4R1
   kLAYX5E0EbQoaN6phCJIfTiBajgMCzRFLW+zFRU49FNHI0MAoSm3Ay7Ra
   kWZeXxZhu4MavtFO+sm2TdYpVOR1LFFVhloZDZWd85oZFevz91GcsAyoe
   a7C4M0rv7N9rpB/wXr4T+xlAq6A8fXKtzWnlM4uhqPaiMIWYSRMluLtrV
   746qCr3u4oOfu8FkXIyqETWqtxlLAl8y0EiJvYXphbfj9PMpd2X1QQ09x
   V8skb5PYp/cVG02LJdC66hZp+PNa82OpjOB4c6q7BWY41iV5wWM5O8WA+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2649353"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2649353"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 03:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9366342"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 20 Feb 2024 03:12:48 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcO3J-0004SC-27;
	Tue, 20 Feb 2024 11:12:45 +0000
Date: Tue, 20 Feb 2024 19:11:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] accel/ivpu: Don't enable any tiles by default on VPU40xx
Message-ID: <ZdSI8jt-_-ddpCAY@7f826eaa0bf8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220110830.1439719-1-jacek.lawrynowicz@linux.intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] accel/ivpu: Don't enable any tiles by default on VPU40xx
Link: https://lore.kernel.org/stable/20240220110830.1439719-1-jacek.lawrynowicz%40linux.intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




