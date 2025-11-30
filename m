Return-Path: <stable+bounces-197678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B7C95121
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 16:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9724E023D
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0E27934B;
	Sun, 30 Nov 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGdM5pUb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6EA36D4EB
	for <stable@vger.kernel.org>; Sun, 30 Nov 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515702; cv=none; b=qvxCbMDQrydqCGYE4MeTKjjKWlFaQMrLd6aEbcvW0DzKXb6ZbqN+Nf4SKNCxUHWua+T08WucM8sMT9RauYJUiMii1oUKGWLCnuT7hdtlVj0dO7L8FQNZOjvLmCSaSQkUA28GXHnGZyKvaTuB8wnEYoCvdl5aawqjilWxn7/XygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515702; c=relaxed/simple;
	bh=xs7djllhX3HB01eo/QrRaa5TNNqDHxbNUmtgL1UzCJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vGvhYTjqUg+H4IH6Pl3RwHT6IcA8yDM8mA0vyhpMlaK/y8jHkr6XAhnmGu6yd4NUN6pO3F2Pl9sY2cwRe0hNKYxoS6V0oH2ZxiHRt/5DbgFt3HigH48APCs9FicjyOy6QEKhfqBan9KwDXtkvsc9V7xRUECdN8chRGHqUm0ugxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGdM5pUb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764515700; x=1796051700;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=xs7djllhX3HB01eo/QrRaa5TNNqDHxbNUmtgL1UzCJc=;
  b=oGdM5pUb4++EIUdzEv0ZL/LoRYc1jvJ4U6LqXO84IZ6EqFAbj/YyGV0k
   sl8GEn7SKrHMZzAXdT5dDgmk0BYADf4mGoyQAB2Oa50HZstscbtBFLBOF
   5KJLBexjydpWXD3ab6IGajpmCJIT/IN90FQA0eAfTvtAK0qqdlEfcnrOw
   FUupaq6insrDopvrm09Dc9pGgkZooMqoHJZ0U8dlnUoBt1jI7w+9/wLfQ
   bqQ2S6TAoPBWSuWe2s16ioL49gcl+9t8ssIvImrO1l4Ai1l94OTjvl1vm
   AhrtEXkUGQgCxKExmuly8axSNtKviYG+IDqDA34ETopts7ieiXgM+Ohql
   g==;
X-CSE-ConnectionGUID: uMr+uO/aSgavxUnRBhYrmA==
X-CSE-MsgGUID: S44+2hzzQ0qNduPKN7O+HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="70324881"
X-IronPort-AV: E=Sophos;i="6.20,238,1758610800"; 
   d="scan'208";a="70324881"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 07:14:59 -0800
X-CSE-ConnectionGUID: nJOVCqjXQ92f2KTFEQwY9A==
X-CSE-MsgGUID: JnFP2muQSNyH7zbz1WFC7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,238,1758610800"; 
   d="scan'208";a="224560864"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Nov 2025 07:14:59 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vPj8a-0000000081Z-0Rug;
	Sun, 30 Nov 2025 15:14:56 +0000
Date: Sun, 30 Nov 2025 23:14:04 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 6/7] PCI: endpoint: pci-epf-vntb: Switch
 vpci_scan_bus() to use pci_scan_root_bus()
Message-ID: <aSxfPMInBUE2pbEQ@73cdb724bd1e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130151100.2591822-7-den@valinux.co.jp>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 6/7] PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use pci_scan_root_bus()
Link: https://lore.kernel.org/stable/20251130151100.2591822-7-den%40valinux.co.jp

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




