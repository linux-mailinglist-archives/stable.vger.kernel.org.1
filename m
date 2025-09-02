Return-Path: <stable+bounces-177507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F7EB40877
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C235E5055
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE593128A6;
	Tue,  2 Sep 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyQUhdrS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38A30EF7A
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825563; cv=none; b=Chv6jiCJJ3p+9QnqDQTc/CqupCgL/24A8BD2HXD6yEJIFOhtaBUxm9JJyfA1+dPxeKnl/Rt73Xduoh0bDl6ymblDcFHooqs8p7/KRFzoDV9Qpdu6MTFUmIwAcVY4hFfDNyNtagh6jFcsnW9BOP3aIPGsK6GFLQ9JCwhBs8fZUDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825563; c=relaxed/simple;
	bh=f6wVUdChfXUC2dIghTBCKp/nFqlakl6+MJ0LfeFuz5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=O1/PUaVNYOUk+vu7788PW4oCeD5h8Mh3RPy/3oxB7f7Kv1U1N8hSEReBvN0jiSDd3tEDT8fBN05V5FHU4OLnv5fK8sI2xWN2pbRH12okko0d0GtlfBxMVkbbvBNL9aVfVsOX6KusTnwche8twSzBfnabvN4iX89swu9W7b8MnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyQUhdrS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756825562; x=1788361562;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=f6wVUdChfXUC2dIghTBCKp/nFqlakl6+MJ0LfeFuz5Q=;
  b=DyQUhdrSpPuLi2O0Z4VpNlKG1oHYZCK6pGeTDf9+wyMP2sBM8rzZ0dsV
   NuB5TDNjYOwQ8gbAmHnrZm017evWDfPZgxVlDCmJpPCvNEtU76E7qK+Es
   UZNmANBjg3NAzbdWnyFX3jDEoE74jPwmUoQs7ve35HDF7HGo5Ts+5VbWx
   2f2+fd4kjwUMbTuy+6A50GIYLaY99AR47Krq/i7TfTUQam5pY6XZsHFjB
   QYsLBEwWNsOeCrw22bIooEztWf7ckAhUVETUjf6/ZTdq5/fzSlGAMlLWt
   ArxIGEvrEfXRH8HIA2B0K/+fGHeTFFcXZ2f+l00KD7OC9GSfe+ukCiVks
   w==;
X-CSE-ConnectionGUID: Cxu9O5q7SfOLDoD0DITGFw==
X-CSE-MsgGUID: dJeLs3ObRVKz61b8gTfbNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69810442"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="69810442"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:06:02 -0700
X-CSE-ConnectionGUID: 5zkmMphsRDaW0/JKtrCP0w==
X-CSE-MsgGUID: aIKbk75ISI+G600qJcfLQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176610566"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 02 Sep 2025 08:06:01 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utSa0-0002f1-0G;
	Tue, 02 Sep 2025 15:05:54 +0000
Date: Tue, 2 Sep 2025 23:05:44 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v5] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aLcHyJDorSjgy9p8@c25d56e612e5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902150240.4272-1-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v5] selftests: net: add test for destination in broadcast packets
Link: https://lore.kernel.org/stable/20250902150240.4272-1-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




