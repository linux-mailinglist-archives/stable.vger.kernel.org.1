Return-Path: <stable+bounces-100246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 464929E9F3D
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FAB1887EB1
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F78153814;
	Mon,  9 Dec 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdxsRQ3Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858C13B59A
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771568; cv=none; b=XuoFwjOa0DG8urogKAxsw+PyestbzxeMZGvBxaurIuYA1h/rqyjI025BOmcDt/PIBe0sWLjbNtANXkJgsoX3BXsxpFYuv7HMfml4WEXl3mDquy5TDhMX79B9hcEG7u0W1rweynpLKIOpcXb8Aok+X9Xw1lGOq5O/kJLLhOnfQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771568; c=relaxed/simple;
	bh=tWDp1sWI+Zcw2X5Z0krY7Stv3V7yPVyYhlszcXNzgaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LmGQPVXXu6MV2laoEiPDwYZHuFb6DEsf8QYD++WO9Y9pAG+k2b5Bb6j3iuBjcVK79/QK9W7qCivKDUju5FHuVuI5JiWNurNm02oGFABbQ685msPWVUdKDo6txrqT1fBDv3nFkqGxxsENHRICGokiMEYIWx/KuSCxgfAMqHb8TcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdxsRQ3Q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733771567; x=1765307567;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=tWDp1sWI+Zcw2X5Z0krY7Stv3V7yPVyYhlszcXNzgaA=;
  b=PdxsRQ3Qo6VXODwVQvJfwPJTGFBOx7lDLenYkP+2JINOtOkadknn3u6j
   1kTglxWgQIZwF/RLF4+pr2dGw8j2tg4wCfW5gA/y8yYfXuY9vTMGouHhJ
   lEB0cnMR/oyb/iNO0EAyQW3J+Y1KAVdieTe5lPZCpCCzNP3vIl3Rw4Htn
   4qSKoX28Glc/CGi0/HCjIm6UtNvW237aTYFxf/5y8QPmNu3mMuliSibyo
   JUQePH3yi0FKyWiQQqOiP3JEvUd9Wv9ds6IReMxwl2sh7V/FcmnQ7oo+8
   ECuHOXg2VmghLEff1J36B3it2NLVsmpl/XcgTb9WosccRPpRNux+98y+l
   w==;
X-CSE-ConnectionGUID: whF0jXRnSNSGUwY52CL0Ww==
X-CSE-MsgGUID: 3ekL2J+cRxiAWjOKZrWRpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34234757"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="34234757"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:12:47 -0800
X-CSE-ConnectionGUID: faMw1IrvSzqfe3sh+6Y8kA==
X-CSE-MsgGUID: AmSu8griSNCfsaxld5jDmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100203121"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Dec 2024 11:12:45 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKjBS-0004j7-25;
	Mon, 09 Dec 2024 19:12:42 +0000
Date: Tue, 10 Dec 2024 03:11:53 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: dsa: microchip: correct KSZ8795 static MAC table
 access
Message-ID: <Z1dA-V5rnnZLiPtd@0945f8898a0b>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a802ae7dfac66efa5175313228f0ba2fc769ef.1733771269.git.joerg@jo-so.de>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] net: dsa: microchip: correct KSZ8795 static MAC table access
Link: https://lore.kernel.org/stable/b4a802ae7dfac66efa5175313228f0ba2fc769ef.1733771269.git.joerg%40jo-so.de

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




