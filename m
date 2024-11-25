Return-Path: <stable+bounces-95338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 191989D7A39
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 03:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E885B21820
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B811713;
	Mon, 25 Nov 2024 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imdVD1O9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01A2500D7
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732503197; cv=none; b=puMoJ+7DoxyK+QMKE0uP7OH8buFwgGOEHtlkAtyeLmh54YjNGVeBfvtBXsQlTKKsEa/Gm+rfEZcRXJxJ9nI4AZKl975TD2+wW2QskJzKtJV+YaKMiZ4epo9PGIfi5HzWCJgX1ktnI3B2j3eeEmJVHcCdZi+3V/9+0XBN3ZzKz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732503197; c=relaxed/simple;
	bh=FtSV0rD3j9uk2P65rPhlIjGraejp24YrlVkJCfVezDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rmlWIbyNYC30WCg1xbCUtRwnEcz/b18eZRe7Q4UUWrfgnJG9pOHVFkKlkEmrHFKJ5rsF8rJmmfHLo62RTowuUdfakWOEvawn/QrOE36hKa6tTYFhc9y+67dgbsNGmKwgYF37PCgumNaPJWL62c6SG40ckt+LpK46BW9qGc1wvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imdVD1O9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732503196; x=1764039196;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=FtSV0rD3j9uk2P65rPhlIjGraejp24YrlVkJCfVezDY=;
  b=imdVD1O9x8FQI3dGK1kackDNSxYOneyJTbfrCdLz9T3S+TLIcwIb6BsT
   lAGq1iA0TBUOf299RtHaVCMWUh4RFp8jqUD7aBr2GY8NhaY3RrleVWaPQ
   SolzuhktgZB9QLNP847RXIGq1MywSCjukA7SK1SPY91cpdHL+7P4O5dyU
   Hdbmls8T0m4poSR68/9L33LotAuNqLnqqL+haY4btqh6EwLx+b2If8hRm
   6WXTOMJWEAiD5KQTFzOXEx+inj0kleom50wIKmMJmlqnwhwD2RR0t1lya
   v+6hAVUAZ8SQrEXyz50Z+U36vUPBI54Bxh5Xv1pYuorUWsVewZ85wu0AQ
   A==;
X-CSE-ConnectionGUID: YxG+Ck5eSX+WrDLj9ZDPEA==
X-CSE-MsgGUID: X14aRXqnRo680u0fqAO/Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="36372315"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="36372315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 18:53:16 -0800
X-CSE-ConnectionGUID: RmovcpVwRPGyNeYMbigJwg==
X-CSE-MsgGUID: I2ekOgk3Tn6AKS903mHoSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="128636953"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2024 18:53:15 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFPDs-0005ZV-0F;
	Mon, 25 Nov 2024 02:53:12 +0000
Date: Mon, 25 Nov 2024 10:52:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.12] MAINTAINERS: appoint myself the XFS maintainer for
 6.12 LTS
Message-ID: <Z0PmYtGM0yol6bbG@ca93ea81d97d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123013828.GA620578@frogsfrogsfrogs>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.12] MAINTAINERS: appoint myself the XFS maintainer for 6.12 LTS
Link: https://lore.kernel.org/stable/20241123013828.GA620578%40frogsfrogsfrogs

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




