Return-Path: <stable+bounces-41440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DEA8B2503
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 17:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C02B1C218D9
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861E14AD26;
	Thu, 25 Apr 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2cBIM5X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814A14A4D7
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058645; cv=none; b=ORUpeFmfKYmIhWUhavh+Dd9TgIZfrWXko6BKoEkF5RPmrP141qlpRVQPkKcQUi3EzvoE+DCxuluEaOTp+WINab8EiD35YsS/UpQ71vR+DblWCWR0cHJmYYzSpO5+TS5tvlGlbTVXscJigsV7MZg/t2ATfqKKJKVIzNF3PustiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058645; c=relaxed/simple;
	bh=3USVTQKNGhwi2BB2DbJzaK+Rht5aQfWXYTGNGIZG2C4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OqyVf7ut/BXpyHmN3EoUeNld810duPtGFynBz3FUNGOhI1/JKiJ5GqLDtRzHgQpLeBaOxJnRg6rRyM6cSanWkiMwIOcg/63Xh/Xtwx7qQ5VWdxLBzATrTu63UHKI8aPk1rgSZqBZoZ5afdgsXjUUP6LP/QujfwvOq6VLW4q1/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2cBIM5X; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714058644; x=1745594644;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3USVTQKNGhwi2BB2DbJzaK+Rht5aQfWXYTGNGIZG2C4=;
  b=C2cBIM5XfesPcumBWYyb2WOXY3Jq+4PULGRX3JDG1aPijWAyosmfGbK+
   Q6ZwsYJgXjJvUgMzHOc9ilU7KTKWhe7m0PkOxUc26vZcVtMe1vcv8TfWM
   UCHs/RoJzqK08xNpuuWb2YZGNvsfD+J6BLEcvCs6tEGvUpp6VkVqIdz/v
   l3knqID0MpTp9KJ8jL6/4xeJlQpH3n6ldepMtn44yaAKdb2i6T1zgqeDZ
   kVrefOje+cotNl2iUaEElQfQwvWEFlcpc+iacjUuJvFxwM2+SnRO4g6gD
   k9A/ynS+lN5i7iA0HLb57/f9lZJo58eR4KZbZZAzVHqFAkZROPUYeRQT9
   w==;
X-CSE-ConnectionGUID: 5IdNlYZ9SeCDSeS1S1Fhgw==
X-CSE-MsgGUID: 3rUB+rkxTy6aW0jXXqYuJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="21173506"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="21173506"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 08:24:04 -0700
X-CSE-ConnectionGUID: L3Stjn4uRT2GEimMGcB2xQ==
X-CSE-MsgGUID: 9nfFT6OYTDCz/O/hbQsRXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25135174"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Apr 2024 08:24:02 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s00x6-0002V6-17;
	Thu, 25 Apr 2024 15:24:00 +0000
Date: Thu, 25 Apr 2024 23:23:01 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Wulff <Chris.Wulff@biamp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] usb: gadget: u_audio: Clear uac pointer when freed.
Message-ID: <Zip1VWPF7v_DkRLX@c8dd4cee2bb9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR17MB54194226DA08BFC9EBD8C163E1172@CO1PR17MB5419.namprd17.prod.outlook.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] usb: gadget: u_audio: Clear uac pointer when freed.
Link: https://lore.kernel.org/stable/CO1PR17MB54194226DA08BFC9EBD8C163E1172%40CO1PR17MB5419.namprd17.prod.outlook.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




