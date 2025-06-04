Return-Path: <stable+bounces-151467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B7ACE5B6
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 22:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DF83A9700
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46D1940A1;
	Wed,  4 Jun 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3xIbnmN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1F3C463
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749068433; cv=none; b=Kfp8I6PjuFc7afUM1ankouAOIq6YuzZjPmx/0HUahiqbEPDRL/b2PIxMMx3x8jlGgd1ZdaWBTzSwmDjeunGLmRuKz3KvI3jzQROeUkz5ElRDdAPTNSTbugr+XO6eI67x/ZwZE5d8XFf9dykY0UXIGBoh1HomlpHw9Dfyk0gEwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749068433; c=relaxed/simple;
	bh=3h4Wo9IfcLVwLZx+6/628c/4ZC/VAYqy7o8Uurk1hiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rflik8IMz3YV5dSq5KhYqipi4xpSF2J/gEbC1lG0BTIccOOJdFrQMUgNyJlWMBloLY/OzcoIokrUYgqmKLfAKhpFQ6AiT0WhGfZsSDxKvwSWQuCzNoYSPUh0tm82YiGqyM/81qc9InG5FDzYNDcvldut2Spsro56e3JkLWbABCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3xIbnmN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749068432; x=1780604432;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3h4Wo9IfcLVwLZx+6/628c/4ZC/VAYqy7o8Uurk1hiI=;
  b=m3xIbnmNlg/4CIoOuH0hekmiEBRnpEvL3OVepK//ZOuxSL5GI2FRckiE
   gEFtVnegwc4uMGuoKz6Fx79CfYrKf43mBnmzE6/T5XhnmwxoyGrTleiz9
   rkrSwiqZVpQyA2m3lBi2uXBr1N2HQxwTcRhZY3DlqSNqJCISHOw1xgvYr
   BlHlOCEQS7hKYN4xrh0TdIzMr42ySLVx75Zh4bnV6OPO5vZ90wjkBN/7i
   c7XLXpat5XKrqg7msbx7XshS/s6BPpyiZGdGNeZAUAgjiBJ4y+OCTUCSj
   N9DVpY2nU5BBsg2+D9So6Czt+2S8nNxMDRsq6PEo6p3WIIjppVey3WHMq
   g==;
X-CSE-ConnectionGUID: rpHHek7yQt+TErh7aumS2w==
X-CSE-MsgGUID: urGdnjyRT7uER5mY/hgiTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="73703218"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="73703218"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 13:20:31 -0700
X-CSE-ConnectionGUID: QpaRov1hSKm7bHYxC+Xxuw==
X-CSE-MsgGUID: 0FTgKk8KRNaBUQCku91N2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="145331702"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Jun 2025 13:20:30 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMub6-0003RV-0W;
	Wed, 04 Jun 2025 20:20:28 +0000
Date: Thu, 5 Jun 2025 04:20:27 +0800
From: kernel test robot <lkp@intel.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] gve: Fix stuck TX queue for DQ queue format
Message-ID: <aECqi11CoMBbVAVx@acd742588394>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604201938.1409219-1-hramamurthy@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] gve: Fix stuck TX queue for DQ queue format
Link: https://lore.kernel.org/stable/20250604201938.1409219-1-hramamurthy%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




