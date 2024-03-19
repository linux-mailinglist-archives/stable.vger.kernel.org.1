Return-Path: <stable+bounces-28437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E31880303
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 18:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E161C221FB
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B3134CB;
	Tue, 19 Mar 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/SdhBvv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFC2575F
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867887; cv=none; b=MzAMhV2uZCYk2Gq4pVKVBIM0bjCl4Tr+mrqzG5YFTQm1WliK5+2l+NFTZ9ztvF9NT0s9ejIUOdQXv75BbeYKMSdfs14HZHqE7A9htPRkhZ7ChWvsPuIVOvN5h4UAlHOcViLakc8jf8/sMrlCa9C47ydY9ne2Xw/NbdjGROwaW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867887; c=relaxed/simple;
	bh=MIVV16Mpf5PZ3yXzekFqltSKB173xKKfq3kPCXlwxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rC47W8zDmMd3D4X2TSqRVshJpVus433fS/lUym4BQBlPlE/zADF+8UIBa9tXOgfHNUGogsvtM8VcFSXC/mgV62CWw18Ts9rSJrJefruqX8vhd8Nkqul3VoLA2+4C3KkyhqkAIhNO6L8QXp8kI9WpZwprHCsGlya8+v2wZUYz1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/SdhBvv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710867886; x=1742403886;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=MIVV16Mpf5PZ3yXzekFqltSKB173xKKfq3kPCXlwxlI=;
  b=O/SdhBvvQElH41PiJ7l9/a3Ld636WCDP2kE5WCX+F9Wlp2zkoIdDAG1B
   qbijVL1mdyBFx+VbisJJj5paW3YpUgqEuHjeBqudJk6D5xy0h2Dpjahm1
   NobrKHQiIUgb8pFaZ/QcjjTjy/F3lhsKdu3wVrW7ED37F21GXIgowl5me
   uQS0LeOSnYzWmqLPmJIxSTB9apu5nNcwGea4uAMHDdsaCHc5JKp8yq97q
   u87EgzsbaY3T94te2CzRPKCnhk0UlvTuknXl4Fdcx8stSjYc97aGG/Psa
   zfaF54yZf+GverI1SehWoCHrE4yk2qE9zfCYz39uvzWxM7y97LmJB0X4H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="9574239"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="9574239"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 10:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="13903055"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Mar 2024 10:04:45 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmctG-000Hy3-0n;
	Tue, 19 Mar 2024 17:04:42 +0000
Date: Wed, 20 Mar 2024 01:04:34 +0800
From: kernel test robot <lkp@intel.com>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4.19 5.4 5.15] btrfs: defrag: fix memory leak in
 btrfs_ioctl_defrag
Message-ID: <ZfnFojtwvgWFjPOm@28e5c5ca316a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319170055.17942-1-mheyne@amazon.de>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 4.19 5.4 5.15] btrfs: defrag: fix memory leak in btrfs_ioctl_defrag
Link: https://lore.kernel.org/stable/20240319170055.17942-1-mheyne%40amazon.de

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




