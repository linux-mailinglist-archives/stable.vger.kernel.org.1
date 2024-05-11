Return-Path: <stable+bounces-43577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D848C32E1
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13ADE2820C5
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB31BC3F;
	Sat, 11 May 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmRu4fiy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EA1BC44
	for <stable@vger.kernel.org>; Sat, 11 May 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447841; cv=none; b=pain1SFsxSTKYpfFb6hX7qCuH2qeUqxx3q8UWSngwoK0enRC/byaNnEEWA2B0YKMRWb1jVHMwF6N6O3zL+LD1JjJcIgqLR3dGsXLM22LYHWnvrWlCS+Wg88ZQvhQZ8WVRWO7yTd4tjC7bssWrZHtkE9jSnK++f8RACSvRXiB14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447841; c=relaxed/simple;
	bh=dlK3Vn7cwWFT6IKPUmgebw8I+1P3ezGKvtLYuQCc0dM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zdw5xJfPym6KPz7VOfensYXwE5nf1exo8JpZ5DPCxmMHkO/YASqfCbP+qDq6qBohvNRb9AMKtnqCgffZI9I5HH/7iihQGpJDSMr92zCdxaug1AOjXzOa7Dt7gMHgtoMG93ZJdDzmXAwmtaN6FG5WLaC2Po5iFee9vPVNd77UhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmRu4fiy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715447840; x=1746983840;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=dlK3Vn7cwWFT6IKPUmgebw8I+1P3ezGKvtLYuQCc0dM=;
  b=mmRu4fiynvvU6WN3geKLVBraSvv4U7raaBGwY0DzkWDHdswR+C7FdNmY
   B+0QZK9g5F+oiu+x2O99GAYKcD7hnzOf32A/7PcA9kW7lXr/nWD7Hcorl
   NTVfQVt1zVJZwqV2W+nNavqt+4nUa0KP18XhQk7rP6TCkApMQYKgSgXJz
   KpkgQnnHqAII2dJ5zYF8FvvGA5covY5FfVQ3ZGs37hEsUV/NGTwKh6FAq
   lYabNl2OgyQGbh9K2zB7jvEZSkZXgSS1UjURAGlNT28F91od6e3sYkYut
   DumtOph3zJyWuWUSI0T6uQ7v4KZCtRzYklXiJnULAOqPrEaUI5L3TvZuj
   w==;
X-CSE-ConnectionGUID: OfSTqLrqRDW4b6q2N7ZBbQ==
X-CSE-MsgGUID: g/Mp2JFCTq+4I8V6yN1XkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="22578659"
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="22578659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 10:17:19 -0700
X-CSE-ConnectionGUID: IZ2GS8NXTxOTiAQ1hGB91w==
X-CSE-MsgGUID: FIgFfqJPTEOQSbpPK5SoYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="34805413"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 May 2024 10:17:18 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5qLT-0007fv-2B;
	Sat, 11 May 2024 17:17:15 +0000
Date: Sun, 12 May 2024 01:16:58 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 07/10] selftests/pidfd: Fix wrong expectation
Message-ID: <Zj-oCo7mQoUVP__W@974e639ab07c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511171445.904356-8-mic@digikod.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v7 07/10] selftests/pidfd: Fix wrong expectation
Link: https://lore.kernel.org/stable/20240511171445.904356-8-mic%40digikod.net

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




