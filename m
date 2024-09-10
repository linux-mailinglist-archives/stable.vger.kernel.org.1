Return-Path: <stable+bounces-74102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91025972646
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 02:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DA81C21264
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E1C40BE3;
	Tue, 10 Sep 2024 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rw78MjlH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE5482FA
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928936; cv=none; b=k3ZsDhwA2fLkK3liAizbynMm+kbXY0mLyx6BI6pJ9wyYrhNZLmGP25+NITPNZBm70PEMLhOe1kPYqvBttDRWDNjf84SNnlxzwtodPKxuN5XBuQbeKetJZIYqJb3ebX7DZ6V9wmUjRPbqZ+tZCjDW5RXbJuqHJMzTp+i7WmczAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928936; c=relaxed/simple;
	bh=yn3Dn2Qqze0AiXwShqRP6iLLdkyfmKHeBhhgbOZoqwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VP2pS6XNOpuXpedsAaJNqGdhM0y9iE1RgyfhO5OuftheMvRmvT1sLo/qzcjeFUNFji2bs+IqrTPmyWm+fXouon89Mf/r1UIj5pAqr5umapSQWJnnE6cUly0xpB/0/cBWPVhKpU2wzwLI8EDexmDf5UCi45mMHS5a/9LgsxVZueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rw78MjlH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725928935; x=1757464935;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yn3Dn2Qqze0AiXwShqRP6iLLdkyfmKHeBhhgbOZoqwA=;
  b=Rw78MjlHgX98hEveoDkBH8INGuDnt3b7Y8ptRLPQ0lEFpuzPzaPZ3Ckr
   KqJvUmZ4syCIHf5dIARKl/2mGcbxTmw89rB2QbnMsc+Jt2TY37x8podtX
   0FkhSRJLj4nWlGfzBESnTTcDtFspJOIxeUrAoxISwkHNzfYfOrO4IivRC
   rJ8pYkjOUype+6kmJWpYyaz8gjwKeNaMPn7xd1UjP/iwBXAoU09LfXubh
   23gCxngsH5QHfnwV5+ibrpuneazEM8UiQTIbPVO53STxbhFLWoLXi3prG
   1XMXguHibTcb2Alq0Gq0IxQxQ3DTnHvokN+ULqkW/IoE9TDKNif+bn0nc
   A==;
X-CSE-ConnectionGUID: OxeizD/pQT+TXzvApPOCRA==
X-CSE-MsgGUID: NCRc+imDSrO3iEFc5v0BAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="27578827"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="27578827"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 17:42:15 -0700
X-CSE-ConnectionGUID: 4l6Q3jlhQMivfP5Es+mj+Q==
X-CSE-MsgGUID: DMU2tLutTZScZAn22ttM+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71635636"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Sep 2024 17:42:14 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snoxP-000FPQ-1n;
	Tue, 10 Sep 2024 00:42:11 +0000
Date: Tue, 10 Sep 2024 08:41:35 +0800
From: kernel test robot <lkp@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in
 virtio_net_hdr
Message-ID: <Zt-Vv1ygku-tScAI@b20ea791c01f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] net: tighten bad gso csum offset check in virtio_net_hdr
Link: https://lore.kernel.org/stable/20240910004033.530313-1-willemdebruijn.kernel%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




