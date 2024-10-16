Return-Path: <stable+bounces-86528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28489A10F5
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1002B1C22F24
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 17:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644FA20F5CB;
	Wed, 16 Oct 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKTQw51g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0118BC23
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101159; cv=none; b=juL0b4kjTHmd+sro8kJl4CIw4jZOcE3D/wf9V8tWT0w5Il6Aq8Pz/t/h6rWZX6HhkM530BZPaSYqmmblrC7UECMWSd75cjPm5CpHJWS0GbkeH48zF0CfWSiOe0n9Ymdu5Pptf7Q/L4I9LnkET7ICH4XkLN3ufAA4E8RvAmfq5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101159; c=relaxed/simple;
	bh=cx3dlGOsbTaRziFjF70+NYCBGmFjTmdLmiHoqwFlvvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=emsPM6Ch29HIn+5ZA/N05ai39iD+XKavr4v8FERhSiGJOZ61iVfg9QSF6IXLqVa4qShbUO3eH1kATbrTESIRIgJGf94HNpKeDVafYk1rFM5KK7hdP+JsK5rc64Cxzlk92BNPr3GPv+izimxhp3gzUdJ2hNYhxeOlag1EW8cGcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKTQw51g; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729101157; x=1760637157;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=cx3dlGOsbTaRziFjF70+NYCBGmFjTmdLmiHoqwFlvvk=;
  b=lKTQw51gVq8Mx97uEeseqCkIiiNLImmB4b+z7uyI8/enyzsQximD3foI
   edJHjmQ3TX+HmCEywlpGMGhmHuqoFVw4GIKGnny/OCZdM6FogOkKf/jwn
   hMxxhSoHjw9E4O9mQDA7uMH0LtnyKYez8ISCBO6j5UlwZPfINWzJWGqH/
   XeLb+PTvu4z81XCG4eSGw6xrW4E4PFk/SS70R2G8rUaROABY8pHTAsqSs
   9mQgibSVIAfuIv/8jVFxiwVowJBZSOSLtNAm7fqVujv5OE/ifJ3NjdXYk
   UUcbGa338MT5/alrUw6lg1jnUuDUWw0pvLc+B4JKG0b6SxSLzFnJzli7B
   Q==;
X-CSE-ConnectionGUID: NHhQz02mQ/G31dPXSNkY8A==
X-CSE-MsgGUID: FYkjZL7eQHWr1eRNcb14jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="39931852"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="39931852"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 10:52:37 -0700
X-CSE-ConnectionGUID: VT/0b0gYQjK3N3OD7j+MYg==
X-CSE-MsgGUID: aBHsxdE5RkyG7bzH/YC46A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78740612"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 Oct 2024 10:52:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t18CH-000LD9-0W;
	Wed, 16 Oct 2024 17:52:33 +0000
Date: Thu, 17 Oct 2024 01:51:47 +0800
From: kernel test robot <lkp@intel.com>
To: Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
Message-ID: <Zw_9MxsDnRFFSpdf@594376e94b8d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] riscv/entry: get correct syscall number from syscall_get_nr()
Link: https://lore.kernel.org/stable/20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




