Return-Path: <stable+bounces-172823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB57B33E1F
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D273E172EF8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921262E92C4;
	Mon, 25 Aug 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJ6Dj3XN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20152E973E
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121603; cv=none; b=YBSiNQ6/CQ63e3AbjIJPouArkLw6+hoq6toZBK4YyZVpE0tJHYUsqCdRtbZroCfq6ZIShcVV04ayJR0d9UGm5gO90AR7dfPojYhJRhPg046o8tO1jEh+5cFr9Ah/lVeFBvjDM3xmqaBhLOCTNwU1dXdhijx3tbCTOwb45JMzoJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121603; c=relaxed/simple;
	bh=1Ru3PGx3WNQ5HO2AasM3jczNEuSngROyhcsp9XmIxI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DmbIWybaMex/NYz4nNpvbqx34Q7LJ9RBghhuFyg0C2snrRWjw1pZvy1e4xSTboYSsFBjA1yM3eOsNT/P4YLgQUNP+n9vqUNvh1x0L1GQ+qFdM905VFI+Nen4g+NsicTtJLi3kSaiclwJPKswWzbuHEfpwk4RyExTK99jgi4eWfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJ6Dj3XN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756121602; x=1787657602;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=1Ru3PGx3WNQ5HO2AasM3jczNEuSngROyhcsp9XmIxI4=;
  b=jJ6Dj3XNF03uokt/sP/NhhN/wTabT1UxKcCpXjlww1e7UnaF3HNQV7xl
   xbzhzpb1IptgLo+Q0M0vLJNe4+C2lQ7Vv96m8MmAZj/kksnGYLi3bnCWE
   9sOHm8PuwLiLabgOUDy0jqAEMZjJoDoGeyTRa1nymN9FxOwmPjWxYLzm9
   iErx+F2SYsbD6j5QwfEGqsTnaNGvSmu7YaFbqCyOQ0UPpPrszpVhriWbu
   6ov2NvdpcLZZ81kPN3OxO5xYGXh7pHRDAaOHmyt/qIG38aV2aNfj3bxG4
   zy7TNRKJJtRhKcGXBhPAWVlJDXpTOujA6uHTWxWPNnJvhucpB9F0rKaLX
   g==;
X-CSE-ConnectionGUID: LWTdR/gqRlKJOA4lp6/HrA==
X-CSE-MsgGUID: RiLtPBsOQC2z/xzm6rH8nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="61973677"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61973677"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:33:22 -0700
X-CSE-ConnectionGUID: ZCkCA2QIQAWzOCvZKEv00g==
X-CSE-MsgGUID: Q3LXKvJlRc2PbJrZcQe/xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169665215"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2025 04:33:18 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqVRM-000Nd5-1a;
	Mon, 25 Aug 2025 11:32:53 +0000
Date: Mon, 25 Aug 2025 19:31:58 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <aKxJrkiuSCEqimnf@13ae35437deb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825113005.4015375-1-quic_shuaz@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v9] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw
Link: https://lore.kernel.org/stable/20250825113005.4015375-1-quic_shuaz%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




