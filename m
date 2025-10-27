Return-Path: <stable+bounces-191340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9ACC120CA
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 00:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9316F4EAC68
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7F31B825;
	Mon, 27 Oct 2025 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+R8bL/L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7B2609D4
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607727; cv=none; b=AcoS1f+LVjgrTJiFrmpXHQD9AUYv5BQ5jmPbiLYjsE6gZmsP3KJt7kgOAnJvx96xPIKrIxJmw3RpXCWHR0O1LE6/fpCiQctkToiIWDmXGfpg5AeZPQT4tft3VNYFfEj3mRzMQ7vUW4egKQZ7Y+3oNt2FidPGLac8ovEPRXDEaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607727; c=relaxed/simple;
	bh=OtuSsErLL0CzwBJFr41jS0iUIamZOAPW5rtpImvk3Us=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=swGg7ibbUa2VFxJpJ3YiyKe8I9rCt0eXJ5DzD1JoIugpMb0JFmNjEUTS0Vv0wOuCSMMhnqMiVUcaekEUt/NcjyJBAW6hbFmzupfsvnXS47EyMHb2mF+ylH1ph0cjEnOgPo8TDIRV46ieeT1t9Zseb3//MN4Q6zgdayO09XuFFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+R8bL/L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761607726; x=1793143726;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=OtuSsErLL0CzwBJFr41jS0iUIamZOAPW5rtpImvk3Us=;
  b=Z+R8bL/LVNOlCmsK0Mb1DL2AqsLS9F/AqfYpxTKhGBw/nzIIFAqzhsVn
   ENkyo2/dXYvqpiIDwaktvJgsAU+U44A46eqUuTPVq07t7aYQn6GixwvyE
   9b8o6z+dZl3PwBevqrGXKsTXsj6sJc/WMZAiHXkxdjPtIi1gzFFL2QzfD
   6s+Va2psoH8S2Leo8S28mRfNWrfVpfZfn4yWdYKpBHfZSESbgzE+Q27oO
   C6S1cQ30lTWdy5Xe0AnM4Gg9RU0i/M5icO+FQJHs4zjaTn5ZbTn8LJddc
   RMFBJwbfW8eNoqAvkytvljaF+4F9ndN4rUKCIWBE8Df6YJl0lhKPqnQbQ
   g==;
X-CSE-ConnectionGUID: bXpxVLA9Sm+vhOPf86V27Q==
X-CSE-MsgGUID: NS9DUW+zQPKdbNA323lrCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73987141"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="73987141"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:28:46 -0700
X-CSE-ConnectionGUID: QO3+Eri6SMSfld9y+KuABA==
X-CSE-MsgGUID: XSbQ8PeHT1a+zZTP157A0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="185271075"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 27 Oct 2025 16:28:45 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDWdm-000IZR-31;
	Mon, 27 Oct 2025 23:28:42 +0000
Date: Tue, 28 Oct 2025 07:28:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Vasilevsky via B4 Relay <devnull+dave.vasilevsky.ca@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] powerpc: Fix mprotect on book3s32
Message-ID: <aQAAB56SHIng8CGt@fb33b90f3739>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] powerpc: Fix mprotect on book3s32
Link: https://lore.kernel.org/stable/20251027-vasi-mprotect-g3-v1-1-3c5187085f9a%40vasilevsky.ca

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




