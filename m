Return-Path: <stable+bounces-126754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9292A71B84
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D23E1895DDF
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A9812DD95;
	Wed, 26 Mar 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOW2Bc6Y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430D1E5218
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005279; cv=none; b=gvCSrMDQDOzEgwEQwrR7NTIbNCdDL/N5QGf3tt7QI4pjKBXvwfUKxBWzK3lLk4sfWj12/M675F+qFCm9fx/X3liMxklBbkMY5wG/WgBw+vG3IUYvZcUtybC9ZXWPigbKP44fksGjtBf8MdqgJ4zwH+VPugxV3vnti5HGFQT9Iqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005279; c=relaxed/simple;
	bh=c4BefCRJVe+5wSmWXGo6FIR1nhhMlFnxN2jo3FU9Is4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NuNPJunDTrPLuWNIMr0VSWOLtbTFXUewHP3SY5cBEusc9ZhoP6c2cBPZwK/Xts9gf9Kx8wwN1w2QkMTQAyeurM4IDsimNlCdI06iasZo8/lPDCYOfbhu1U4ooufJr0aDYTiAM0QZpseaqHhDm98GkYlEHI5VNOL+9WQcu53De48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOW2Bc6Y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743005277; x=1774541277;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=c4BefCRJVe+5wSmWXGo6FIR1nhhMlFnxN2jo3FU9Is4=;
  b=NOW2Bc6YS/Zu6rV5hDHhK0oDbuQrlAi2dEDwVUPDqT2x5C5c7K+6ahze
   Vjb/28U2whhdhs8Rk+77lkJ1jKRSZgdwn/9gI0phmxQbyKE2zTN1H3Vdk
   nf1tzPBWLYmmICUw+YL/UQww7XHFBspXaqqotH2VwTG4UtD+CFomPquCF
   5r6eLOMVT5/OP0sW9R9AsnGEetG6Gzkf4qUOQG9JFyTDAWOZFKcpt+wGn
   TbuOmhPmZKQsHQ0iQxWyHvoO4i7N+gV9gpFeA1FzHPB1UKj5Y0lGB3n9p
   lnCKlBofJdbvaggxQ6NgCDQDyt4/NGgZthsYkpuN23pwia1SlbEypzn+y
   A==;
X-CSE-ConnectionGUID: xwMpVtRjSXqyHX2pKB8Ybg==
X-CSE-MsgGUID: FxUg/dwYScqlAMrpZuN+cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61700370"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="61700370"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:07:57 -0700
X-CSE-ConnectionGUID: URfJGoRERGy0zagc+u3ZwA==
X-CSE-MsgGUID: m21RsKMnS7+gMwN9q8F3Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124745213"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 26 Mar 2025 09:07:56 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txTI3-0005st-1q;
	Wed, 26 Mar 2025 16:07:42 +0000
Date: Thu, 27 Mar 2025 00:07:09 +0800
From: kernel test robot <lkp@intel.com>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.13] btrfs: ioctl: error on fixed buffer flag for
 io-uring cmd
Message-ID: <Z-QmLdqVcNd6SW6z@06395982a548>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326160351.612359-1-sidong.yang@furiosa.ai>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.13] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Link: https://lore.kernel.org/stable/20250326160351.612359-1-sidong.yang%40furiosa.ai

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




