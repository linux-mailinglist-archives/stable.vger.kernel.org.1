Return-Path: <stable+bounces-144191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CCDAB59F0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8637188D4AD
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2781F03C0;
	Tue, 13 May 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXBcTx9d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401E1A38E1
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154011; cv=none; b=WkOnNtGD3OpGGBV3SzQazVDR1WanFXnV3UJJD6RTAJXap+orHlh2EqMEdGsmXT8isFV4n5qZRd1cvTyCdEDjaILiCxzyM7tjpazjBTjXkOFUXG1zB/2/DiR+HGzlFKauHbNxnnVJWo1CHJ/NcopVQF9whJokZwPEndghBNATCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154011; c=relaxed/simple;
	bh=ra/sPV97ll5xRK8+eHliL67sN2MRW7Bl2HmavZG9nKg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bpChV/zI9KTp3xRsiSjefvUafPoCAz5NMYgbEwXo+WdoeKN4TwHugTH3T5YO1WgSrloyFTq9p7gW4dYQOfEvyjK2f5TLlnlEK/xxILgiiTxT5b+nfdseSf/2uhG2N/E00PVfdBQs152XG63v3jv39oQbyEPxt6PPgd1xb71IplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXBcTx9d; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747154010; x=1778690010;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=ra/sPV97ll5xRK8+eHliL67sN2MRW7Bl2HmavZG9nKg=;
  b=MXBcTx9dNIQGRCh46R5NgE4PhPsZ7wlHlEyWUfsfNaIm03qh3ZZpcF9m
   MNTprpvojG709EW9PFn9PCi9OHsQSC5AYh3vx/+1rsFgjp04R8Pdh2nAI
   bUT+Sa6UiB1z7eQ8BLN8AqiYUNeHT575mAOSUZ9y3gyUh5e7X8aEz7JgX
   IN0zn+ctLZ6mCDsIW9Qk+kWRm5nRSE0+wWd8kvz0bU+OhgLiOHMDlF6nn
   SauU3IEHGh0PiQN9/Xd0Zul5w/cWL5uQ/QqX+jfNUlOzn/Jc9l/xMixLh
   Ds7hxLpQV7Z3uQxa/eDnMNdpmsvF9Evy3Ks/mExxMpY6R4nfyqBVmFVq+
   w==;
X-CSE-ConnectionGUID: hD1ittxCQiujSa1u4+ZE1A==
X-CSE-MsgGUID: ofNEEOZOSl+Wrg2zVlifvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48889378"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="48889378"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:33:30 -0700
X-CSE-ConnectionGUID: UVHJWMa4QxC/Rc+WKk+RMA==
X-CSE-MsgGUID: af6fa1kxTFy8Wo1LS9r5JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="142714477"
Received: from llaguna-mobl1.ger.corp.intel.com (HELO [10.245.116.107]) ([10.245.116.107])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:33:28 -0700
Message-ID: <d995a12d-f30b-4627-b5f2-a50d5e3a408d@linux.intel.com>
Date: Tue, 13 May 2025 18:33:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: Request for backporting accel/ivpu MMU IRQ patches to 6.14
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please cherry-pick following 6 patches to 6.14:
bc3e5f48b7ee021371dc37297678f7089be6ce28 accel/ivpu: Use workqueue for IRQ handling
0240fa18d247c99a1967f2fed025296a89a1c5f5 accel/ivpu: Dump only first MMU fault from single context
4480912f3f8b8a1fbb5ae12c5c547fd094ec4197 accel/ivpu: Move parts of MMU event IRQ handling to thread handler
353b8f48390d36b39276ff6af61464ec64cd4d5c accel/ivpu: Fix missing MMU events from reserved SSID
2f5bbea1807a064a1e4c1b385c8cea4f37bb4b17 accel/ivpu: Fix missing MMU events if file_priv is unbound
683e9fa1c885a0cffbc10b459a7eee9df92af1c1 accel/ivpu: Flush pending jobs of device's workqueues

These are fixing an issue where host can be overloaded with MMU faults from NPU causing other IRQs to be missed and host to be slowed down significantly.
They should apply without conflicts.

Thanks,
Jacek

