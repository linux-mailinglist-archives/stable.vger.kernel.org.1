Return-Path: <stable+bounces-45623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 792DD8CCC63
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 08:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3939B219FF
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF69C13C685;
	Thu, 23 May 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjAg75hx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE82D05E
	for <stable@vger.kernel.org>; Thu, 23 May 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446536; cv=none; b=INCwxGyxz6gu475+HGjkJ0Fkb6hlia82G4QCu4YRuOSIuZBRfmM5pqV6D9P5XAL4CteO6a+dikJ5fhWP20PYNEPhuMWWIL/hmys6Xiif+3EJvr7f5k+8XEM54BfGL/vlHXtFBeo9IHRTx5eDL84kv/klPDUNvfUucVtS15BOazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446536; c=relaxed/simple;
	bh=9+zrY0QdkeR0ldxHcH1HgV5+LEUfsMmojn9R9V5LA0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=me/KbGJi7pjqz4It0qP9+5P/KWY2+cNj4xWfqHulP/UJHOGeo08gjtpmPJXY+iQmw4dP7fJVV2rHhycNz/WEmSP0KPQT3pOaC5Jxtb+PTCmQUFBuGZSKJxbXEEVC1jSfT32yKy6dABHHtyNSt9zxW/J5FcbC9la9mb/mAwD5QPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjAg75hx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716446535; x=1747982535;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=9+zrY0QdkeR0ldxHcH1HgV5+LEUfsMmojn9R9V5LA0Q=;
  b=mjAg75hx5j+H/JR/uJYuqMHKPXWFFgviLEWiH9+4tJVFJgT3U+h+TwW0
   ZVfsTdMOt2UpvBjC78eHAubnB9BLCPD3azOBTiC3Md3Z/TQzJnVWF6gf+
   QQ7H3bhCIelMHcX6LeBWRxS1CE36znyHhYEWkNzqDljXuN+SIIB6w+8W3
   Sl/2+N816TFFrMRqOZi8W6morItXyTim6a9UnyhgbLFCV9CByiwEEx5rk
   KMPQ4Q0MB7dk+4fmYqYIc4WYWVG7Mt7ppbpwv8z2BR0MLHgZe0OmV/yBy
   sG5HzXSHrJcHSq3+kUqU/GiurILHStnGTcZTgk4cYse3Ys9edRok45LlQ
   Q==;
X-CSE-ConnectionGUID: n1tP7GNbTJaREgenSROGkw==
X-CSE-MsgGUID: rJiJ2jb/RvieGeB+9nA8Aw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12618069"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12618069"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:42:14 -0700
X-CSE-ConnectionGUID: DOsMT3JBRkWKbZIpIfNlLQ==
X-CSE-MsgGUID: a+SMiao2QX6VB1wKWf1eKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38338808"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 May 2024 23:42:13 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA298-0002YD-0N;
	Thu, 23 May 2024 06:41:52 +0000
Date: Thu, 23 May 2024 14:40:59 +0800
From: kernel test robot <lkp@intel.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
Message-ID: <Zk7k-yCuFM1ud3Ya@4a1dde18ea58>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523063905.3173-1-donettom@linux.ibm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] selftest: mm: Test if hugepage does not get leaked during __bio_release_pages()
Link: https://lore.kernel.org/stable/20240523063905.3173-1-donettom%40linux.ibm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




