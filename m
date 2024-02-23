Return-Path: <stable+bounces-23473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BA7861290
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 14:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8472B1C2144D
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1947E779;
	Fri, 23 Feb 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkzqXI7M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54727AE78
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694417; cv=none; b=FiDzZ2WxibfCRWY6+cEMSlwba7meGFrASyj8ZLoHAbecWjS6RmI/VIx6vS/LlhpspdGPEyFoJHDGVPTaRXizt/XMwWLZGVNg9HrnFOC4FSr8cHVU/S3GVdi0DBu3C4VstniPbCKR0wrYva1+tc+/ww128UM9hTHXq3SyjSvQ2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694417; c=relaxed/simple;
	bh=c+VltOfcK4EHBDAn/QZv5Ksf8pEDaKZQUWD9cpq9xCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BqpqCoaq7S68IR8MbGRePpZ1JneO9O7XuXrqeZ9biBUPJmvRX4czpS71MB2kn8q7YqfMi4EU1k4H9hBHnbVCbwpY+ifpMROMlaiJYaXCJO3ySIbQxUCYNwbTdqISe/oCd+cG56+z2VrUPlsGXZHu0yxamod6SIGiYtuuNG5LqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkzqXI7M; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708694415; x=1740230415;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=c+VltOfcK4EHBDAn/QZv5Ksf8pEDaKZQUWD9cpq9xCQ=;
  b=QkzqXI7MVdP8knukcpTfSb4ejoxxTNdSK7QwpWe+TmwdtZI9keXiwxb1
   wV89zrm3hhsFEEFZw5Wcs0gyfEw7oWyJuOJdkN77w2vxCjYiWmDMRcLwm
   4y+v+hGcGKRx4Wo2wWlaQ0gy7CsGHd0NVwY4ffpMyd2V1H8M9eRzq0GOX
   Yj0pOsj9kMb2YHElyOrCVJ10dOTgtzyuFhsRy/HNf1w6lyXqLa5vqRfxd
   r+NHT8vwbYRdjDduZ2B8Rs3vmHcxrzYd+Uc/ayQ+Z8Mn7qog098D9yyuj
   L9SdquRSUJdC9vnhKwro6f5dAvqstR7NjuMrawRf8I+HA9dGHirOqXNES
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6794060"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6794060"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 05:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5882634"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 23 Feb 2024 05:20:14 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdVTC-0007Xk-07;
	Fri, 23 Feb 2024 13:20:08 +0000
Date: Fri, 23 Feb 2024 21:19:10 +0800
From: kernel test robot <lkp@intel.com>
To: Valentin Obst <kernel@valentinobst.de>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] x86/tools: fix line number reported for malformed
 lines
Message-ID: <ZdibTssCvfNnFk1k@fdb2c0c3c270>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-x86-insn-decoder-line-fix-v2-1-cde49c69f402@valentinobst.de>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] x86/tools: fix line number reported for malformed lines
Link: https://lore.kernel.org/stable/20240223-x86-insn-decoder-line-fix-v2-1-cde49c69f402%40valentinobst.de

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




