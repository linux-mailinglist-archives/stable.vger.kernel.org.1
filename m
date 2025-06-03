Return-Path: <stable+bounces-150688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B51ACC491
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5370F188F9ED
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF6227E9B;
	Tue,  3 Jun 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3dZkP9S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143F2C3263
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947334; cv=none; b=f2V3g7JMHZaWcHNrJlukBsMCQQ6LySLKWZ99V2EE1nENBBriXprGJXLeKiHmu68K7m5iD9pmsgttRJpOV3ni9mR0bSGR8J/VRepwhyxib47oOsFApIb+Qv2TwZt5uUvHcR1Rd0YOx6LMad/gnKngpEfE1y7Wu8gM7B7dRYvX1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947334; c=relaxed/simple;
	bh=9f3UWrlbz8iP19nncpSwogZ8NndbfVlsVMfGxCiHk6o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cVqgUMCJQsL5+VCfsMIbu+zn4UWwPEN/OVBpBHrEv/BAWXXiLv/oIB9LsYDU2xNpoOY6Y3Hubw64Oyt4N/I8pGcTmPPOHcir1qs7QdPzqdljcL53bJyDmxDvZhffg/gm1CQmvf99cV29mRDRcrbV1yye+t9NHJMMfAZR6MnAebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3dZkP9S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748947333; x=1780483333;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=9f3UWrlbz8iP19nncpSwogZ8NndbfVlsVMfGxCiHk6o=;
  b=H3dZkP9SPiV6j0VrfDufZWcJB+lnE1uMdCvQRBdVJ3jWKpWtAKgCvQNu
   3bPpXNdTHMBC6AJJ5KeksPPaWn8sme3sPgIPU31w8HbgxhChFJzym9yZa
   fM8gW6CpcqwWALrf0cNReYPUcJnTZuVe4g1MT2syI9ikK5GWKdccuNy0Y
   pUzX8LAktF+Muz+kuaw0CaNFzzJWT+NJ6U/Gx1EM0Ajq26G6t+8jtbvIZ
   9/7OoN9yYel6rAWBGP8flNSMBahslbqHgjaNDUoV0ioZe3Pr4utx+cccz
   l2Y3djkn0QB9k4MWF21HeKpMtf7GltWu+IniHCvMJCcsWOQM0o/ZkX8+J
   A==;
X-CSE-ConnectionGUID: 9Kd+SvVnScOQOFdtse8xbw==
X-CSE-MsgGUID: zy1S+FvtSRymspSQWn4jCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="62371006"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="62371006"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 03:42:12 -0700
X-CSE-ConnectionGUID: wkm+QVYuSp2iejcn5qwhHw==
X-CSE-MsgGUID: yXMDXVHrQPKe3FVOvSFgRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="144704749"
Received: from unknown (HELO [10.217.160.151]) ([10.217.160.151])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 03:42:11 -0700
Message-ID: <fe7c8681-83de-4f3e-8dab-04185f0f9416@linux.intel.com>
Date: Tue, 3 Jun 2025 12:42:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: Request for backporting accel/ivpu PTL patches to 6.12
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please cherry-pick following 9 patches to 6.12:
525a3858aad73 accel/ivpu: Set 500 ns delay between power island TRICKLE and ENABLE
08eb99ce911d3 accel/ivpu: Do not fail on cmdq if failed to allocate preemption buffers
755fb86789165 accel/ivpu: Use whole user and shave ranges for preemption buffers
98110eb5924bd accel/ivpu: Increase MS info buffer size
c140244f0cfb9 accel/ivpu: Add initial Panther Lake support
88bdd1644ca28 accel/ivpu: Update power island delays
ce68f86c44513 accel/ivpu: Do not fail when more than 1 tile is fused
83b6fa5844b53 accel/ivpu: Increase DMA address range
e91191efe75a9 accel/ivpu: Move secondary preemption buffer allocation to DMA range

These add support for new Panther Lake HW.
They should apply without conflicts.

Thanks,
Jacek

