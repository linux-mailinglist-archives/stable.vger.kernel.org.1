Return-Path: <stable+bounces-76202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1E979E70
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51344B20D66
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43E14A4E9;
	Mon, 16 Sep 2024 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOS/9lF2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FED146586
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478845; cv=none; b=Q14RVrmRgQK8GnGnd8dlzGEMusuk5QsdG+qaqW+Yk5ceUAb846UISPyPSiU52/5VoHn4Jw9ZlngsZilBzGY+HkiIJeGIQJqjzk5vGJQkaNVhtOu2Rgkg/z3MDxpfDhWDMEUgPpgRC6zdgf+CTHlYqdcM9Qj7oMK5GeQ5jA2FReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478845; c=relaxed/simple;
	bh=SCw3QShxbZnnZCIySefmYOjTIE0+gI8LcGkGbDixo64=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U7e15ZOnrnRsNtP5U3KIDLx7dv6sISl2fWPIXdm6TptQeDLZtFjBxQyzT/8zAyAzAgQDatdtda3LK87/CsAxw0TpeY+91rB7fj3Ow9sQ/B+wthecYIMR99OwZ2SBm13+9BBhPb8Qz+fFjsxLciZ/nMkM7z0hKZEw0pUVsB+PU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOS/9lF2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726478843; x=1758014843;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=SCw3QShxbZnnZCIySefmYOjTIE0+gI8LcGkGbDixo64=;
  b=EOS/9lF2xC0HFD8Cp5R0ZdgdPj/+FbmXAYOo6ggztrqGEtBnLQW1pWoV
   1l4QetEPFtzZXpwWMsrJ7ZBuS6Kfab9Q2KSa+35giUnEXPCsXTPm8OaT6
   bq3/kXJ0iLBGZQIHhr6/WTTcMXrikwhpjPubNhEteA8CnyPLUyIkupucj
   9PennqMlL/rHsK1yAbM5r+KJW6TvuZOzIG7J8SMWd8km4oCqGFN+0lWgQ
   8hDKg77BN9qsATBKkyIoGI+nuspzAV/H4/uw2X7GRZAliuhA+DtyA1WAG
   KXBfnVIW1QhdXbGD5UKS12endYdUid2Ag4iQxTfx7T67VMh6JK45A40rW
   g==;
X-CSE-ConnectionGUID: hfBYAkWlSMaKiyc2gkZvDw==
X-CSE-MsgGUID: M/Nzw+zgSz6ypzpOC8dg5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25180148"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="25180148"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 02:27:15 -0700
X-CSE-ConnectionGUID: 6svhQV7IQ9KcM2RStXrbLg==
X-CSE-MsgGUID: 1b0AGPLjSIqTioP/pjmOyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="69315766"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 Sep 2024 02:27:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sq80m-0009cX-06;
	Mon, 16 Sep 2024 09:27:12 +0000
Date: Mon, 16 Sep 2024 17:26:38 +0800
From: kernel test robot <lkp@intel.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.10] LoongArch: KVM: Remove undefined a6 argument
 comment for kvm_hypercall()
Message-ID: <Zuf5zjeeWO9zfUkL@3bb1e60d1c37>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8EFAA3851253EB9A+20240916092546.429464-1-wangyuli@uniontech.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.10] LoongArch: KVM: Remove undefined a6 argument comment for kvm_hypercall()
Link: https://lore.kernel.org/stable/8EFAA3851253EB9A%2B20240916092546.429464-1-wangyuli%40uniontech.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




