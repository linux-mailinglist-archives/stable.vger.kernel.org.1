Return-Path: <stable+bounces-166686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD0B1C12F
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 09:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E84618A62BB
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA3212B3D;
	Wed,  6 Aug 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGtuU+ZS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C71D63F7
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464794; cv=none; b=LrzS2EQWopBsJtQy8pi927cc3UPynVpBxUxd3xHneE37A37mLdGCvhkY2poLIqNaNpIIIMYAauJdB5zYd7lJZOGKFNCUXoSYXzmtVCWwoep/c9hamqlfu2KeFIA/fS256L8PNL+njsXjRGjV350T7ttAClgGFPobNAGdj+Ku9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464794; c=relaxed/simple;
	bh=yl0KeSdGjWsUk7bZo0u2iui2muNvdg1wGHvspISc1YM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=FLzOIvIWT8On/8KObQtKZsC85Ofoc5GU2J4S0Vssf5EpNKVt7eAmmP9VR0n3bM50EJSBoFdhhyDvo4+lMtTcZd8Q8Flqm8Zni69nhp7gO3xmlQiISSEcfTIO+kPNxeQ8cR2r0nlMQZa7zZex4skQCJiLH60dIbWJR7ettc/Dp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGtuU+ZS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754464794; x=1786000794;
  h=message-id:date:mime-version:from:subject:to:
   content-transfer-encoding;
  bh=yl0KeSdGjWsUk7bZo0u2iui2muNvdg1wGHvspISc1YM=;
  b=YGtuU+ZSp1YkTXq/Ti9sCeCgbBFxldV924cLIH4GdgLhjzx53Z349OEV
   NpHI6OXrgmlgRqWJNL1wUs4G0LGtZTOc+4LvL+QjM2wDv+ECB0FLAO4+m
   XyRABFP3wARyw+BAyrzrcTxpLbDUhgTXGTjyDHAVO++m9pTFm725NCNjz
   hD7e2BAOdwLGHzqY6+ZngIWRgukTjUQ8x+0wIPdFX7/f89swL8kw1AguD
   3WP37Bp0/ETjjdaRlCGTXbyBBCUw1NGZMjTnyDBTnICLiVZfoyxxEpQbN
   +TRMlJjCExODMJ0ZEsNFssJ+1/ZD2e+Yxt7FfbTwV0G850Knevgm0MCn+
   g==;
X-CSE-ConnectionGUID: hnG2zi35RvCSX2RSO6Z7AQ==
X-CSE-MsgGUID: g8RiVZRCTCaupXJiJzfJ6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60586598"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60586598"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 00:19:53 -0700
X-CSE-ConnectionGUID: Ih7jBOz4TlildsnBqgaT8A==
X-CSE-MsgGUID: kCip8K0NQ2quadVFzkK+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195536719"
Received: from geumanao-mobl3.amr.corp.intel.com (HELO [10.245.86.244]) ([10.245.86.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 00:19:52 -0700
Message-ID: <0b14a68b-0175-438d-b0c0-c1c91360a9fa@linux.intel.com>
Date: Wed, 6 Aug 2025 09:19:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: accel/ivpu backport request for 6.12
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please cherry-pick following patch to 6.12:
541a137254c71 accel/ivpu: Fix reset_engine debugfs file logic

It fixes a small regression introduced in:
0c3fa6e8441b1 accel/ivpu: Remove copy engine support

Thanks,
Jacek

