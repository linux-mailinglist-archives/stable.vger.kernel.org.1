Return-Path: <stable+bounces-172781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B75CB3363E
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEB417FF5C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B060C27990D;
	Mon, 25 Aug 2025 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHQNI6AA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6828F4
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102348; cv=none; b=mI59kubIXK0BnIMmLN1dtHWnuxTGo0+gJ7V+aJZaV3SNU7FwJDKTOVNOrWop0BiWuCUwx4H+he3kyPcPZGrRusDYTv1TXF1mOfw/SYfE3+E9J7bVA+UkNaQFGgf+hT179Clid3LyUMLtJE8fSFYAtw+zPcFIGZox3hU7pyQbGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102348; c=relaxed/simple;
	bh=tZ1NtCt8Bu9ttZzlF2SQucPW+m9v/iXOzIo1q8QDAn4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FyskiTnBBki6pLjx5iRU+O5vCMXmy141/FQ4FQfILYry/Lbi4HsfF1JyUXw4bm76uA2EOSeUwWEzyrEY7uHyMYOvXLcV25e8yzyMgJfIwNy1KA4VpUXcn4S7RzO3xwKlKbqlC+9dI/gsok264MqLhPLh92eLSBMOq+MLW1p2aOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHQNI6AA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756102346; x=1787638346;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=tZ1NtCt8Bu9ttZzlF2SQucPW+m9v/iXOzIo1q8QDAn4=;
  b=jHQNI6AAobO0ppproCMVHoWAHERify7YmlU9hKHX9a+6tMcEdjMydnoN
   mKRVGAGJn1tt+QNIIgn6D9uqQ2aNir7a6JAQL+pDLWvTBZt0Nyo2BQtas
   u8rtjsKrzogccu95RFFizOaSkczI3ZN8NpdCL8SoB70EQXsdyj/LagvuS
   WomvuLwoyf79wANX7BZoIPUGUz1kQxlH0iHBBL42SYPagVfODF614oqR2
   Tno1toDYwCfEin1Rje9HPra1c8EN11jmDr+aet6ICmxv5TIuKtzPNTg4k
   TiBfbmA+KJb1ZTgd4iXPPPfY7CxfycZll73dsof/Pj1ixiYO57JNMBhWZ
   Q==;
X-CSE-ConnectionGUID: XKrM48/ZTxWb5uTu/eH33A==
X-CSE-MsgGUID: tem94qH8THWpP0usGww7jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="58234441"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58234441"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 23:12:25 -0700
X-CSE-ConnectionGUID: oO0wo6DySKy+kQEIya2kTw==
X-CSE-MsgGUID: +2yjTfYURAuAQBr/kA2Y6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168418068"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Aug 2025 23:12:24 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqQRK-000NPJ-0N;
	Mon, 25 Aug 2025 06:12:22 +0000
Date: Mon, 25 Aug 2025 14:11:37 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net 2/2] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aKv-mcCm0jTDBG64@13ae35437deb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825060918.4799-2-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net 2/2] selftests: net: add test for destination in broadcast packets
Link: https://lore.kernel.org/stable/20250825060918.4799-2-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




