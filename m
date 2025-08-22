Return-Path: <stable+bounces-172320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE0FB31044
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7066BAA18E4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFDE2E6114;
	Fri, 22 Aug 2025 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+cobEO5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98432C3277
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847497; cv=none; b=KPXRetkBXAxIdJ2giNg+u6Sz8gJyzKJIJwO/dKyPpLVeBHSEKd6ZSZH8oq/MX6ytD9rBc6A6NNb2SDIwe0k/drKaasvcn/pdHWxVX7kQS0hCBeev9rEmq8ikNxzZ4TZWLdaT/B1IaJ3z9Uf73jmDg9X0MeFU/x00Z+tc8MG7dSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847497; c=relaxed/simple;
	bh=amTHXuJSqqHamPmnJxe3dRoDxRqdbkgOusrtnlpvT+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A9lZz19o2JgXzD9C1at1ZEvcutzeMcIXSpNmAjoxl0zW03GN8gCmhibxMfHPA4+CP6LloVZIzKIHThpF1rGDh0nZ2CBPqpsZeIpfEg6HlmdsseTjl7VTalePDqseooDQs70PRtdLksVJ/6EgdNH/RSB5C3HJ4tKooft60tqOL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+cobEO5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755847495; x=1787383495;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=amTHXuJSqqHamPmnJxe3dRoDxRqdbkgOusrtnlpvT+w=;
  b=N+cobEO5wSovGGpwuzmaNA4dZnLkVjaCfcZPJ5wxXdDNCkacn8c+dUDb
   CNjcC8Bb+weVtuPOs4VT0sTeKAKsFLTL+buYlbOMboWtJDVm7IBvHff+s
   P0wv+I1jjdYGkrmvAElYlLM2hLaVcZNqUGJ64HTflaWHkmKZ0cQUgs9CX
   UbdPSvYar47a/50CaSHYQphRfucjy7zfGHb8E0KRABTMbtNA5BDExrqar
   GOFMGgOFpeEPI+MMQC6/uU68f4v24FJrpaztNe4G2Xnd2+5CjNT/h+cDH
   dtlpR2Yqo571qJx0DwSJ4qn4PhYCLnF34cEGWnQuB5izINYMa/RM64/O9
   g==;
X-CSE-ConnectionGUID: DSVCFWGaTV27l+Ezetgcrw==
X-CSE-MsgGUID: zbOMULfnQgCpojvtIJaomg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69522446"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69522446"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 00:24:55 -0700
X-CSE-ConnectionGUID: 6zrcyzGWRXqvNX3ntD1dAw==
X-CSE-MsgGUID: G0plkk4KT16ywi1KlaAveQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173057343"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 22 Aug 2025 00:24:54 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upM8p-000L0h-17;
	Fri, 22 Aug 2025 07:24:51 +0000
Date: Fri, 22 Aug 2025 15:24:33 +0800
From: kernel test robot <lkp@intel.com>
To: Gu Bowen <gubowen5@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
Message-ID: <aKgbMXMaOj0j22ND@85d67d3e4d56>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822073541.1886469-1-gubowen5@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5] mm: Fix possible deadlock in kmemleak
Link: https://lore.kernel.org/stable/20250822073541.1886469-1-gubowen5%40huawei.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




