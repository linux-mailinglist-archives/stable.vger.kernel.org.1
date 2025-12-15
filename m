Return-Path: <stable+bounces-201023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E42CBD65C
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 11:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E65CA30122F6
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E8A3168E4;
	Mon, 15 Dec 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htT1UH1i"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184892C11F5
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795457; cv=none; b=s4M8EBlA1L1JvhlZ0tMow6jGg46pTEMQpdqGSse078+Rj5124dj8tlyVU1kwoX6Tfg1QtoFOi5IxIPSPpe/stIphgxACmpUTlyp4nFBQx/kKW/zW8PqkV7CqwS76Rmbf6Hy/YQLDF+5+s9YPwXkZfQ54IGQ/PYfDddEkTCfwxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795457; c=relaxed/simple;
	bh=5VCpsFBhYZjRqLdOUTJeSj9xiu7RwW4lXKpkshqDwUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=irGZdn/eia4PRrsgeQnkKTim9hbvP3yO5OJQxAgxGSXr3VKtZBPSVKEkCmzzINIP49215tEc0VXreaISS1HdWov17RDwzePAmgaGqXmTSGwCbcKIbZGsEdcbLt+9f2tJTxCU2NPjVGt5iExQsFLyO7VmolBPDmGAN2TNj31dxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htT1UH1i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765795456; x=1797331456;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=5VCpsFBhYZjRqLdOUTJeSj9xiu7RwW4lXKpkshqDwUA=;
  b=htT1UH1iDKi2hi9av77w3RE/b5CBsznUAxYt9fkgNEcdzcQL7SomxomV
   8EhT/AR+sD4DKqgul81BV7sMwwa/Ag16+K1WlPC/8CpNfzd9amQRlebCu
   hTnr/mXO6AdcAB48Tiszy5CGjF1O+b3f+lnY3UnPphj4GGawzJmAbqjw9
   MQw+N2vKz2lygS1vfabVchEOdOQuWwz1aPLgdjIZQ6ezRlGsanroWy28K
   aiCq9r9C0n3ufer0vJ7smXdwggGYSeikZ0/ZVLfowiDPzkS4oIZ1oh0wg
   btVcrcavjuzlDtQ2lS+O1yKxzkWoufLXzYgIOOrC8teUEo7NTA4INIdlI
   w==;
X-CSE-ConnectionGUID: +QDyGQOLStCgqH/spJXTZQ==
X-CSE-MsgGUID: PY/lQP70Qmisaijy7nEwbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="67763137"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67763137"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 02:44:15 -0800
X-CSE-ConnectionGUID: sTOBZH1mS3yCEIJUSwq9kA==
X-CSE-MsgGUID: YxI+CpwoTCap0rBxsoGAjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197580835"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 15 Dec 2025 02:44:13 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vV631-000000000CD-0Jnl;
	Mon, 15 Dec 2025 10:43:51 +0000
Date: Mon, 15 Dec 2025 18:42:46 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] virtio: console: fix lost wakeup when device is written
 and polled
Message-ID: <aT_mJshz2YRNsHsH@73f44f95d416>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] virtio: console: fix lost wakeup when device is written and polled
Link: https://lore.kernel.org/stable/20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7%40isovalent.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




