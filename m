Return-Path: <stable+bounces-98286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C64309E38E1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 12:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3969EB255F3
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D01B21AB;
	Wed,  4 Dec 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMqUUXG7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2F19D09F
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311790; cv=none; b=SblOk7dWSAmH8hLhN2qtQ+ZtyMgIQGrgH0tXtTiIDefFCNQQBmBONDT049Lr8+30vgSw49QwTcQw5/syMZ0cnvxdcNEPg9r0+cU57I+Kosn7ZVOIyBEW7SZvRf0V24Xuz7ut/vgfTgzanAE6p99hOtaYtGqgP0Ga8TLBmLEXnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311790; c=relaxed/simple;
	bh=K9G3ow5eSG09Qm9mcHn2m/eM+zl0slGLHgi9J56zwRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZJWbjJPgDGdoKmh6vt9aMb6YzlnoDlD7v7QJCU6FGmFV/ltRY7KmqN4wNxp78EiS55t915ZcXDG4GcP+lxcbh4ulD3mycn/owdjhTqR2ug6TgEam7RRx8k0JbkH3xt7xIX46gqKS6IVD2zLFDlj/HWav4Qe2Ayd+7F9hMtO26hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMqUUXG7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733311788; x=1764847788;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=K9G3ow5eSG09Qm9mcHn2m/eM+zl0slGLHgi9J56zwRk=;
  b=BMqUUXG7mZT9z4FZUvaU2Xgiaxv2ljWWBO/dkPJFyxIsD/0/z8s68f6n
   BJK4+gw/06dTvzwq9U/DrloegTdeROpzWVgOnjVYjTqVRCc+HwTEBzTnt
   cAiNLQHj1KYqUhCT4R4uPk/LUvC7Mz1RPsHzJVeZ+QR1oVyBFttMNTveR
   JaFPQfdLi3V68Oq+S+XORnPM5lJ+IdU3R8TIDcYUloS34Adq3I2hiVv4G
   CkEKdzvUfRUuWLNpvnWI+2PQw+OgxMgwxWRT1jAitroerCFcmtiHY9VHb
   Xeltutt1Q4M/kReX9es69u14n0T2LH8Mz9+dsFjb44jckZd8bE/7HJFoo
   A==;
X-CSE-ConnectionGUID: 3zemD4CeQJK8ebeyyzjMKQ==
X-CSE-MsgGUID: gI0mVq8aSS62zjHoq0Uftg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37510154"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="37510154"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:29:48 -0800
X-CSE-ConnectionGUID: s2ZEqdPiRxC9jFVrSYL78A==
X-CSE-MsgGUID: 2NfcIHAHREuypBw7LPKxlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93822999"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 04 Dec 2024 03:29:48 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tInZg-0002x7-2T;
	Wed, 04 Dec 2024 11:29:44 +0000
Date: Wed, 4 Dec 2024 19:29:42 +0800
From: kernel test robot <lkp@intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating
 userspace page tables
Message-ID: <Z1A9JkG3JspS5tFO@fa4ec8514079>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412c90a4df7aef077141d9f68d19cbe5602d6c6d.camel@infradead.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables
Link: https://lore.kernel.org/stable/412c90a4df7aef077141d9f68d19cbe5602d6c6d.camel%40infradead.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




