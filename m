Return-Path: <stable+bounces-76805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DA497D454
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF54285839
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200013D601;
	Fri, 20 Sep 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzoHok0n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDCC13D520
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828724; cv=none; b=fvmL97KMJA70W8Fxv8zrwaMZjBErwyUu9n4a4Jf31QW/zYqYY/vslYR3r39D4MXcNOnBSN1Hai6lirvK8S0MCb6Eqgg1HFsqkVHfiexgwiYF5meTKsyz5s7JCu53xDlctMVg1/X7C0E7WHjxabMQiTwNzYeY+BCF6KC9zCmKOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828724; c=relaxed/simple;
	bh=5de8fI+AS3M3u4rHjgWpD8xOMOPH3rzjVq27Mkau6Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OCJF3UVelsXHk5idGhTYm66H2w/aVx7IgaGuKbU2dSz228FoA0yI1VDN5IJvApoui/N745qekBztRu3T5j7fG9LWuWCBxaht9MkhKQCVw+01+z29CJU9oQo0NeIFA7BY3FL2ywUbV9P0qdwpjG1gOBm1BciI/HvvNlr4+/refG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzoHok0n; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726828723; x=1758364723;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=5de8fI+AS3M3u4rHjgWpD8xOMOPH3rzjVq27Mkau6Zo=;
  b=SzoHok0na++gwbsC+ZduLl9gmzl4CMyYo5Asji4h1o8JOpmwOgeDQ+zh
   KsRKY7rQZpoL+hnfCsE2z3rZbeoVBvJMm3w9Z+4rIWNbQspkatgmUne/Z
   J3BSOrnm0xl1fFJnlfOvR95UQfnzJOZZRpWauBoPXnTmsIK+w4HROPl0Y
   3mdEIr58Ibh7HugDildVeZ8zv1itjUad7XXTR4ERuCnk0PJaxeiLC3uti
   zwW4TuH8HhK1GOVEVYfu9FMG2evSuDeh5tOmbAi8RPiV0bm4SvYxctgku
   uiPeMa4XLKyUVXVjCsI+nMZAYh4gJKo8h2uz5BNyWprHH83wpd7dyHj2w
   g==;
X-CSE-ConnectionGUID: B1TDG+kTQ6ezUQgBu8mJAg==
X-CSE-MsgGUID: n5SKx9u2Q2u0l67HffztvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="26015378"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="26015378"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 03:38:42 -0700
X-CSE-ConnectionGUID: xFhSJyCnRoOHICgTyaf2Dw==
X-CSE-MsgGUID: mexhLB0ZTDq32Awc94R7aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="74632015"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Sep 2024 03:38:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srb26-000EHp-2j;
	Fri, 20 Sep 2024 10:38:38 +0000
Date: Fri, 20 Sep 2024 18:37:40 +0800
From: kernel test robot <lkp@intel.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10] bpf: Fix mismatch memory accounting for devmap maps
Message-ID: <Zu1QdPBf_QnYCxbS@3bb1e60d1c37>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920103950.3931497-1-pulehui@huaweicloud.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10] bpf: Fix mismatch memory accounting for devmap maps
Link: https://lore.kernel.org/stable/20240920103950.3931497-1-pulehui%40huaweicloud.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




