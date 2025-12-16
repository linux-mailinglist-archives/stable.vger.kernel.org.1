Return-Path: <stable+bounces-202731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6DCC4EFD
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 19:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0AAD30321C5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB733C50A;
	Tue, 16 Dec 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btGQm/Co"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF43335559
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910666; cv=none; b=Sx4U5zkKWhJEX3MClD1bW1V41TmQKZ4kv47b9rrDh4Xiuq4u+gurvUncRI9Gl4UBwuTa3ke+L31kXfko4dtWP/62NnThx5kpHvY5vd0Ge2TAK8r6YGYCiS/iCme+dlhj0WPhbE4L7d2JU6vuwZFzCmTeUO7uM3Dp/ZVQj3ggslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910666; c=relaxed/simple;
	bh=N86iY285Ufrqvw6QGzCZzxCjjsfyw5l5I4LxbHDi1mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B/UArwXS+5wfZKzL9Xlh3UKxb4PUqDePB92ovc7oQWT4NrLBDV5hFUToCtfrkkKqE+0YhMtiupSJceQQL5DWj8cDo3iCUZuQn03ZL4JJa0Z0H6jU7GpWFsNPQkLGfoEzhbjkreo8ZuUvYYUKt1uoMdVmfOTizJOOMHN7PBmDecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btGQm/Co; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765910664; x=1797446664;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=N86iY285Ufrqvw6QGzCZzxCjjsfyw5l5I4LxbHDi1mQ=;
  b=btGQm/CopX/l/A4CtEfVLVC9MpWRsArEdVshvEoZm/8odx6Z7SbyR+/f
   14pxYuGOMXNxu6y8kLBB6we5+XERXVJHc5k/56OJZCGymod2JDm8UhWtE
   kn9Dwlh8pWprWhs5mfOqCcMoMdD/8AF64U06itASpHdBsUXz3QT8DLelR
   OpxjjjyYEgZ+pJFLmdlX++KiCdzVHaOqaIbouG/i2llze5//L/mrtXses
   uQjOEjDBDkNzA1t8wmj2iQ/wGHEoWLRyW0+cu7na+Sd7GVNJC7UY5cCJ+
   tbTkz67OTgbD0Chrg2wiKGyWFUkw/2i2WV2s/USviDvlIJU2CHXFQqQhD
   g==;
X-CSE-ConnectionGUID: CBeF48j4TnqTpdPfepMV2g==
X-CSE-MsgGUID: nm713bwFTjm0EjwEyIIEhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="55412501"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="55412501"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 10:44:22 -0800
X-CSE-ConnectionGUID: D7lRAn+KS/azxJn/tj8yHQ==
X-CSE-MsgGUID: HPmy69loRaqZFSm9pYvcuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="197848696"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 Dec 2025 10:44:21 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVa1o-000000003jo-1DIB;
	Tue, 16 Dec 2025 18:44:11 +0000
Date: Wed, 17 Dec 2025 02:43:39 +0800
From: kernel test robot <lkp@intel.com>
To: Petko Manolov <petko.manolov@konsulko.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb()
 failure
Message-ID: <aUGoWyl1QocktKkz@7df3ebb995de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216184113.197439-1-petko.manolov@konsulko.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb() failure
Link: https://lore.kernel.org/stable/20251216184113.197439-1-petko.manolov%40konsulko.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




