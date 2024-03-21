Return-Path: <stable+bounces-28522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA5688563A
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 10:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA243282370
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A23065B;
	Thu, 21 Mar 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJuyVuK7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C72E41A
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012307; cv=none; b=rnjVv7mZ5flkDFIesjCt4JTMDEL0WIXBRKAlSwronvDvJEC2A9DdqHOzmcSB5KZYi8TX13WYJuJtL2JVcRsQfCz18KNGfhXImsXWWZy/HK8lPqEb7iT9ltSXxlHmzAD4JDj8YAdW7WrwxH1h0HhvrdaHt9I3/rp2Gg+Hxgz9t0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012307; c=relaxed/simple;
	bh=0NIU+TJsUOzjrs8pO6/ItcR0avG8D3Okh7qfg8hVwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kdHmRnRQ849Ol4Nu+RQfj0PA4O2GGHOBEyDR819rz5SJq+6dereKcZDimK5N9MKha3cQG9D5DXF0MZo+ffKZ0XQiEKFzC5QNl7VUmtTpaKyYvRLeGDG4mH4Cb7TQnfR54jjR3K50svvS1e2QOELnHDp17w1VBy0HugNqvyuzsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJuyVuK7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711012304; x=1742548304;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=0NIU+TJsUOzjrs8pO6/ItcR0avG8D3Okh7qfg8hVwnY=;
  b=XJuyVuK71DZnfmOb5huYX6jcGRBeS9cvgX49HbXRMUaOwbYNvBoqa0/b
   +SvuNHrp6Ha/GQyHjvonGSt4mRLc2u3KPE07+aL9c2Bih0IKKbYQzx7bn
   Gz5hGvTMw4SOInhqyvN86jA3nJat7ihy5ilgGu8N0HdPA2+0z4VbFYh8P
   hnnlw4my/EcINUqBZJPotl7Lu1cqoh7YeWXKqIkZVbbw2lZSTvXZuOjDT
   8NLe/59CYszEmoFdMUunyo4optpCMGXnLD6QxRrMYxoVHswox2boFAoGI
   hTdB7iAh1u0BtEFNlIh5ntwBuv03Ulr4ElXyJG+vCO4J7StHr+ttpL9AB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="31424810"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="31424810"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 02:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="14446650"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Mar 2024 02:11:41 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnESZ-000JIR-1K;
	Thu, 21 Mar 2024 09:11:39 +0000
Date: Thu, 21 Mar 2024 17:11:23 +0800
From: kernel test robot <lkp@intel.com>
To: Guo Mengqi <guomengqi3@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] drm/vkms: call drm_atomic_helper_shutdown before
 drm_dev_put()
Message-ID: <Zfv5uwalPfiJQx1M@28e5c5ca316a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321070752.81405-1-guomengqi3@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] drm/vkms: call drm_atomic_helper_shutdown before drm_dev_put()
Link: https://lore.kernel.org/stable/20240321070752.81405-1-guomengqi3%40huawei.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




