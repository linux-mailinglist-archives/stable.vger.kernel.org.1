Return-Path: <stable+bounces-116621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22183A38DCD
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 22:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A377A1F29
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D222E3E8;
	Mon, 17 Feb 2025 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFFv0XFC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FE226545
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739826150; cv=none; b=imPzwgBHbitqj0pR9edDJ4Ereo5+8+58VPYR38w3AUG9awTHCfI+IiDkCBO6MUmJ5pLqqA7pjc4ixs7UbCo4Ukwteu3WFKs46yfkw/wUsl2i7cjOkPqODc1yr3xzFIkA0eazVVyToUKz0xFUFeqaXXI58CQpNHx8YioKeRXXcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739826150; c=relaxed/simple;
	bh=19zlvIxFozcIGE2zzrNwFMYPUHZ6Rpp/w+EDlYLvIVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iNEPKM1PG7httnU5twKs4Q3l99yKET6QuOH1KBJnZosxqaRvW8B7TtqQUlRJJAygI3sU03lSAKWlCczeKgECmsMEgT4sJJovnw+PnQyfV9LLVG7KlDMSgGgiTrDlEk83AWQ4p0QhoEKgCKM1q+fP1xP5MNA16asjiPxQjHJewf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFFv0XFC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739826149; x=1771362149;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=19zlvIxFozcIGE2zzrNwFMYPUHZ6Rpp/w+EDlYLvIVw=;
  b=HFFv0XFC+j6yfNepZ06OxwWVAwxESdyag2YhurFUuGPhppoDruHzr2g0
   xiion9rigAUO8QYivTNlXfmYQkTuhFSoGOyneMyr7f4vA1sxA6pcQlqbb
   ErWzvWsjES0YuT7rjtUdxoWpFyBO/2ux2siQ3Lu7vWffhzSA9XxB/bgtV
   qlx7Y2DIsov0X0uBJnBz5s1VCyL/4CVw7njQPNa5vKWpR6tsWWemZgu81
   vGU5pviTpfTNFG4D2m0DEs1PPAInBlNtelKSgue1ZTqiwGZBg/z+L57Cx
   SDBb9hhHFiw7LNDNaYPBbkd2K0VlLhFYo6MOxMpmPXR13SHf/EnfEkDa2
   w==;
X-CSE-ConnectionGUID: OHuhncYMTRCr69i1iKMnvQ==
X-CSE-MsgGUID: SgZwUGpgSpugTVHyfdtvcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44442235"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="44442235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 13:02:28 -0800
X-CSE-ConnectionGUID: c892KkS9RZulVmm7o5iGXg==
X-CSE-MsgGUID: EqhJuRVaTtyCkgoz9qb6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="114191756"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Feb 2025 13:02:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk8G1-001Dax-1d;
	Mon, 17 Feb 2025 21:02:25 +0000
Date: Tue, 18 Feb 2025 05:01:25 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] media: verisilicon: Fix AV1 decoder clock frequency
Message-ID: <Z7OjpShZOo9mDa14@a5d4ccc8ade5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-b4-hantro-av1-clock-rate-v1-1-65b91132c551@collabora.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] media: verisilicon: Fix AV1 decoder clock frequency
Link: https://lore.kernel.org/stable/20250217-b4-hantro-av1-clock-rate-v1-1-65b91132c551%40collabora.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




