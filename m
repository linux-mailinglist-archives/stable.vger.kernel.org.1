Return-Path: <stable+bounces-197059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E2EC8C627
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 00:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A203A4E1923
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 23:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124182F12DF;
	Wed, 26 Nov 2025 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOEqaUxX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5DA29BD85
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764200971; cv=none; b=X1Zqa1HpYI4dcBsF0YDY9dg1MHJa+0PNCmXb/YIb8spX5DKdp2nBWUHBww2pk2bUZAkYagjPuh6U9vakK4kS86GzEr5wbsHiRKxyMeevuaXMm4QJnI6VXfzcsfAykh2oMV3z07VRTcrNhWf9hHF3fDoOT5RdJ5lO8bh2rcjleX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764200971; c=relaxed/simple;
	bh=ewKZKmf6WbhbQ6HzwwYNQtKI7r4nfGRlXgfUQqdEexE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bUOnWuQE8n0tq7tu+kU3588IOM6IuENoUVi32oW2fCN3D9LFOgKUjzS66DUYYUdT646fjwtPRIoKD1bGI04eNRKxfURJUOPbZAUNwGIZP24QXfP7Mue6N5eabegDNgFE0XJZNS6OpNE8x7x8zfn9XgaCu5AIsZnCZtlpoD3S0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOEqaUxX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764200970; x=1795736970;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ewKZKmf6WbhbQ6HzwwYNQtKI7r4nfGRlXgfUQqdEexE=;
  b=kOEqaUxXvacPr0C4I6/vmjfFoqR/322fJZh4/Vl7IRZ9ZuSbQwNI11TE
   L8EvqDHrgAfaszoEAoivvW8IIWXlmrxLkTkiI8MIMNgfGHHdCTxJkqLWN
   ppQciqZFJWWvByU4NC/ObEENLKhsGjOFJmDBIrgFoudezLW1pnY4Ct3Ww
   r0Cg7hXwjiedYOTzNlzW7LYEr30Zfq8eBXwjnknpbh0gBRRRFa+hXJzgD
   FJMYzzFifgeP4Wgd+dsHpcMv+2dERIW6cAHHZT7TKpOUaQbZ3Xt46VHDQ
   sp280YyBB1sYstxhn8Ep8aJ6mNFNFJdgdqAqzIRBN/suUMesajiz82/Wn
   Q==;
X-CSE-ConnectionGUID: cn7x+YEwRqCOHbcE4JChcA==
X-CSE-MsgGUID: Igt+jdw4Sqio+RVyTG82VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77720754"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="77720754"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 15:49:30 -0800
X-CSE-ConnectionGUID: ynmtMY2ZQwOm/FuLlsTfqw==
X-CSE-MsgGUID: 9jQioPB3Q6y+E2xjohD0Mg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Nov 2025 15:49:29 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOPGI-000000003TR-2EwS;
	Wed, 26 Nov 2025 23:49:26 +0000
Date: Thu, 27 Nov 2025 07:48:31 +0800
From: kernel test robot <lkp@intel.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] drm/msm: Fix a7xx per pipe register programming
Message-ID: <aSeRz0-wNfLz0nAq@c2e5bee1bcda>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127-gras_nc_mode_fix-v1-1-5c0cf616401f@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] drm/msm: Fix a7xx per pipe register programming
Link: https://lore.kernel.org/stable/20251127-gras_nc_mode_fix-v1-1-5c0cf616401f%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




