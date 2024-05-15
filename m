Return-Path: <stable+bounces-45134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFDA8C621C
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8470C1C20CFB
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DA3D966;
	Wed, 15 May 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PihpBZVk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7D40847
	for <stable@vger.kernel.org>; Wed, 15 May 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759434; cv=none; b=rDe+7FKa5isGtzkSkZrJfi9leciObcjnrP+wpNtm9Ji1C0ImLOQKMKCabhzTEH124g9lI6lEkzFbIjJAoAL+cjYnUexCVlaW2ggwyc9OfOr8pEf0SUQ6nQh7VWAXHeNsM4jhsqaIDCARwvIOFmB5qyGdc8B9FEyW+7TSF2/Lxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759434; c=relaxed/simple;
	bh=yTs+lRB87zhkS41QCrtu6/FB+nA6/kFPQM2ac81uZbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G/b5ATrrKvcQKA/8W9o6e/CectD0Gxpn6CSoJFlw2Y6FXQPV4nEPS2j9I+zb+w6yQjhpVWajIYhmVZ3iqWTCi9sj6LMl74bReBhA9P2g1oeR0So536k72T4lXymVKrbrWU8o2a+Zu4ffOyGrEIFyiE8aFTS+QTHkTnxDQQ65iTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PihpBZVk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715759434; x=1747295434;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yTs+lRB87zhkS41QCrtu6/FB+nA6/kFPQM2ac81uZbQ=;
  b=PihpBZVkgsLWXZ2nw6WYkfNheZlDitpb/yKb2r3PrmAb4oU8JYx0ZBJd
   WXNrAVYVuSIhLQ+A0G50vW8IbE2TGlBg2mVWTG8VzJp3vPWxBpXFb/otT
   Jj4lNH5AqIlCTDq+VSyy9DsohDkZUmKY6EN4prDZ32rHiRbcvMYjTXyDU
   xmBiOWKsUSJ+65D/v2oTjvFwpWC0W9t9FZ9h9vki0C3HdUJh/5GmMT1wH
   C37d7IpxPLoDyTh72bsRr+yw4mNBsV/hpp8ZLMvw0A0S+yY+UEg1z7luH
   2EJst3W111674zXSvuz4SEfTMLJdHmOGfSWhmu5AFvjK1xCtHnSyPr6zj
   Q==;
X-CSE-ConnectionGUID: X2+S4EisSVCjY7hINdSETA==
X-CSE-MsgGUID: dsvLxqoRTpSD6/bLy3g1Iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="14736649"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="14736649"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:50:33 -0700
X-CSE-ConnectionGUID: t86D13iNQXOuZxYiMkKN7g==
X-CSE-MsgGUID: 6iTYhYF+RuCWXPMXHvSoww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35518898"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 May 2024 00:50:33 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s79PB-000Cb5-27;
	Wed, 15 May 2024 07:50:29 +0000
Date: Wed, 15 May 2024 15:50:03 +0800
From: kernel test robot <lkp@intel.com>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.15 1/2] netlink: annotate lockless accesses to
 nlk->max_recvmsg_len
Message-ID: <ZkRpK37ncAajhx3p@974e639ab07c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515073644.32503-2-yenchia.chen@mediatek.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.15 1/2] netlink: annotate lockless accesses to nlk->max_recvmsg_len
Link: https://lore.kernel.org/stable/20240515073644.32503-2-yenchia.chen%40mediatek.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




