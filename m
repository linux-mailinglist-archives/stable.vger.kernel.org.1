Return-Path: <stable+bounces-200094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256BCA5CE1
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 02:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A34B131DF218
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA92192EE;
	Fri,  5 Dec 2025 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNRCpiya"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9821C16A
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764897050; cv=none; b=AjDn+JVU6KnuN+cqIseYou8m993GVf3cbtaYcZM1w7c5gNPyHxkvMb1zSGg1QDRglpAa6a+9vCGZRI+zySc5ub0R+sNKhgLaIU1phc2YUhsqD04UPegUZKATDetc1fHrZNrpY/UpMzDkVHO2i8opZfGaQTbUI8fMp+XdddAFL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764897050; c=relaxed/simple;
	bh=V/pZ0+5j8GI1XB73UqPXU5q8OD7ftU6yoPkvSqd0YPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=StvIVaB/2gPEU6Sprye1znuXaXIhVvLkYFr24prqtjd7lQv+6nDkA7wqN4u7FcAtWwpdrdVNsJdLGolS6UbsxyZQGKQLrCa6y03pEgCQ6ofW4bclTOhe30FxbW+UAzP8pDTomeSmptiH3ce1Abw6sGmcxFbSHRbXKhjAOVOIu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNRCpiya; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764897049; x=1796433049;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=V/pZ0+5j8GI1XB73UqPXU5q8OD7ftU6yoPkvSqd0YPM=;
  b=iNRCpiyaxvnbqmfWDVVD8lO3xj+pDzfSt8Z8vX9QxlwT0lrFK/0J/9SG
   OzDYjRwOfnyuafqq4h/UtJtlzgYUcgpBFeR/18IqcwXpXGz1zqvrgqyxz
   1a/KQelW2h2182A0VEqyOwVZ/3NRfz5BA/PUbRl25KJMCYx+awJuiuVV+
   BT+5CBsMdlZj6WmtayILt8EoN/W0i+6fu+24raE4lmLkqvKiywZJmXEDA
   M5rgARHO92yjsYM1NFnGinURdWagdTLHuN/pEhX2fz7pZ7t6ixVw93/uE
   +J1P7T1/THFvEFPHtqpP0N49+5BLinyBRRsYNe6IdUR65oGad5+nwyvRE
   g==;
X-CSE-ConnectionGUID: pICCu+fhRzen0myLJbkKlA==
X-CSE-MsgGUID: /xuLNQ+7RVi1z2W96LwIKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="54480058"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="54480058"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 17:10:48 -0800
X-CSE-ConnectionGUID: jsbnRCBHRNOaJ5XhO1U9BA==
X-CSE-MsgGUID: Q1xHz3WrSxKuQUniWsylBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="199317573"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Dec 2025 17:10:46 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRKLM-00000000EQn-1XVh;
	Fri, 05 Dec 2025 01:10:44 +0000
Date: Fri, 5 Dec 2025 09:09:46 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [6.19 PATCH] nfs/localio: fix regression due to out-of-order
 __put_cred [was: Re: linux-next: manual merge of the nfs tree with Linus'
 tree]
Message-ID: <aTIw2nOEhZa6YF-w@0bc2809ec63a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTIwhhOF847CcQGl@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [6.19 PATCH] nfs/localio: fix regression due to out-of-order __put_cred [was: Re: linux-next: manual merge of the nfs tree with Linus' tree]
Link: https://lore.kernel.org/stable/aTIwhhOF847CcQGl%40kernel.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




