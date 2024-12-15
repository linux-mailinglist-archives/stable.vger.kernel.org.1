Return-Path: <stable+bounces-104232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB279F2283
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF99E188551F
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C1B1CABF;
	Sun, 15 Dec 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBkUp9xs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60E156CF
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734249079; cv=none; b=Kx41v32doDfmf1ev7/SQdtFfT0fIGgT07z08pcE84vSSXOuUkKENSacps74FOfn4eWWmQ+kjxveWaVFTM+Kgqg9v/J027ez3f+9enXe7aL44vVdephVR9CQ9saC8tJJYkHU+DYyM8ixu2GJ1NoCYPhr6Bi7zHco8LhxVaBbVM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734249079; c=relaxed/simple;
	bh=ReZjY6a+a2rC1dp26yVLZsjvzFLgmbXwuZB0irGrM0w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CpHUdGC9HijjOr03iVmXwUFgfJGdBpqICWKzUzc0Nzoc7KRyL4+620F753yDiX7i+8fTr+hPBtZq1ZTIq828WTOP7UlgQEpjeTe8FzPefpS1XZhivxNgFc0V/HED4TnPZaFVXWo2CUF7GOluI35mfse29D9FOuOe+dmi04RU8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBkUp9xs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734249076; x=1765785076;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ReZjY6a+a2rC1dp26yVLZsjvzFLgmbXwuZB0irGrM0w=;
  b=lBkUp9xsjhJuaxcpwc3Q5JK2VKipSHRiYZhTloRm2EPu/NG7mJKGY1gR
   YjUeMPVHCA0D9hb5xNRatmiLpIMM/tr/g/lN1iyKxNDFa8bmQ4YjWCGOb
   56Gai/VzdFONGz9ccT07K5vjcVtRI7keEHrKpXLwnEKNafwBWJqnhuK3f
   OHlhZ/kKaOauK6X58PU9pmoxjRqiuejdoqhM3kzwJw7VIkif8QHjTzPVq
   hI2f4lbU5NaKA2O6nJjG2oiD9JxQlP332HmXC9Tmh+Mjc437XJg/UamDb
   2VlL/h0w0zzCFKG0ovaeRFbrDVjIOGgspb5jCx7WuyxTROH+Eih5XC272
   w==;
X-CSE-ConnectionGUID: 5gVO3xE/SFmIjaS9lMfTmw==
X-CSE-MsgGUID: dmDy/QUHQniMpvWnqGIbTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34563549"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="34563549"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 23:51:16 -0800
X-CSE-ConnectionGUID: VrIWcagjS3m8hJ+P4vWbpA==
X-CSE-MsgGUID: Ls52XSLBRsO9j/BAUubp5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="97473785"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Dec 2024 23:51:15 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMjPF-000DVi-0Z;
	Sun, 15 Dec 2024 07:51:13 +0000
Date: Sun, 15 Dec 2024 15:50:59 +0800
From: kernel test robot <lkp@intel.com>
To: yangge1116@126.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V3] mm, compaction: don't use ALLOC_CMA in long term GUP
 flow
Message-ID: <Z16KY1ZP0Og0eeTs@39f568f0a533>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1734248992-17701-1-git-send-email-yangge1116@126.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH V3] mm, compaction: don't use ALLOC_CMA in long term GUP flow
Link: https://lore.kernel.org/stable/1734248992-17701-1-git-send-email-yangge1116%40126.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




