Return-Path: <stable+bounces-176920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2353CB3F1ED
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 03:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA88B20121D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 01:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC522DF3DA;
	Tue,  2 Sep 2025 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVjQv6kR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E47254B09
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756776923; cv=none; b=qaUDxMKiRxFoOqahnUISdyhzrwTfbhaveWjRDHFV7beYbbzJqdyDgbNkhnkH8kqrB4x/RQJJWtCeeATQYWd6GcKgPA3lRD0Ey/xxDSeNtSNPrvBObhwhA16Xka+stqFsP5PQjB72T2mOaAu9m7uPyOx4gDPdZZfnXn0eMTjQXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756776923; c=relaxed/simple;
	bh=Puhny1wjCMl88TJxS0H8KukwLRBVKRmMMtWzDxfhg/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SYEQfisxVdXYnWzBJH6qd1px43yaAFgntJsfl/8vJfvE22hir5xU2slq9PZIo9bEU8VnD5kRlzA6r+9bSzvA55w0ud6uNtKKpHz6TolOPFTLGl1lG00K8ZS83NM3jcelGXMFGt2OE2Mirng18/NTFXGga9GNyjfFdIjDNDjCBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVjQv6kR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756776921; x=1788312921;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Puhny1wjCMl88TJxS0H8KukwLRBVKRmMMtWzDxfhg/k=;
  b=AVjQv6kR5S6jbsdGCi4FlvaLZ3oXftw0XCKjIZfWnoU7TG4uOIN7bhYT
   65GezQ1PZ8Aj4EwGJY9NayMk6W+nP0yI/Eg6zY7hRr2RCaMsBnpB1hW5R
   viyzYIA/Dnjn9ZuuLh5NKRXg+JLTuzO9vw2gFdM6Adlr7vbEneiunPRl1
   BNrntxJEwTDyXEKlfx/653jRoIrObotALRg+1AYvA/MfAafj7PHy+TCTf
   ssvZuTCKt5lkxhsMTFHwLJUA5b57O/Mi+Nz8xCqCJnYrISoJnzOCDnIsr
   4DKCiXJHXnDPzpyHV7FtW8UdPosNLoUfcE07Y5n85hm6n+oa5XEISOZMh
   A==;
X-CSE-ConnectionGUID: rPO3g1DoTvC6WCuGtzuQMw==
X-CSE-MsgGUID: 3q7EI3zRQtWbclE69uMvxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="61666937"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="61666937"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 18:35:20 -0700
X-CSE-ConnectionGUID: bUwWodIuR4SDG09PgzrsEA==
X-CSE-MsgGUID: 0Fwl6N04TFGU935YaxKvew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170414163"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 01 Sep 2025 18:35:19 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utFug-0001JH-1s;
	Tue, 02 Sep 2025 01:34:32 +0000
Date: Tue, 2 Sep 2025 09:33:29 +0800
From: kernel test robot <lkp@intel.com>
To: Abin Joseph <abin.joseph@amd.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v2] net: xilinx: axienet: Add error handling for RX
 metadata pointer retrieval
Message-ID: <aLZJaXYEG1xK_pou@c51ed5950d49>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902013205.2849707-1-abin.joseph@amd.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v2] net: xilinx: axienet: Add error handling for RX metadata pointer retrieval
Link: https://lore.kernel.org/stable/20250902013205.2849707-1-abin.joseph%40amd.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




