Return-Path: <stable+bounces-144187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D9AB59D0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50311B6329A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A925B1FA;
	Tue, 13 May 2025 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmBm0kjb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE02BE7A7
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153593; cv=none; b=QJOY1cImxJ3Alx0x2HcZYmztAJwLpvSqFTZP8bh/dhcW9O22jCnNknG+npkzJPnXu2+HpvyDkfiNOne9YpU/RIJ5jblg2wp1U8pOcMsX4NSdoM+VzTmUlL5dfv+i5gQtN4BDqZdCXXBEHD0lqPFST1gEnqqjUv6t4wYDFadKjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153593; c=relaxed/simple;
	bh=FYV0t+cqoNLlM39PYdYM8/J+wS3S8wtCFAPnX1MJNW0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZBulOWF+iCJLwC9EJ2Cv9HSrf9SQbjqpOscz9LYW4KN46PnnijPkNxEFyorb4iMNnZRk3A6krqt5kRUaeUncwLry97aHV9NvCFLepdpz0Cuyg4z65UaBXiUV+QuVf3+Po1RcXewZEekwOdLRNoaiFO5HyeNHtf03PNa5xfWdYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmBm0kjb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747153593; x=1778689593;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=FYV0t+cqoNLlM39PYdYM8/J+wS3S8wtCFAPnX1MJNW0=;
  b=FmBm0kjbLHj4fLdBCEp+vBaWZapnxKR8ET20lb2fyVm6lapNHECGas7T
   HXdIhcRZVY6wK5ByJ4vfezQdaHO5Eko04rXK+ZcDMGtugQvjPiK4EbCJh
   tMkFTyzc/P3RQ36CQwzKaK0qS5w6In+a77gY27GzYcy4sTgojDbkpks1G
   Whx1SRElOBOmg8p6cZ3DeNXABRgAoeUCgCIaSrX1SpUI2wEW5NuS8wF08
   uAPQZ6dErS3PcFRX/Oy8P8SNdc+qzkUVKRQWdFMR5Y5hV6cMjJvqmTt1p
   eCX73u4GeAJBQn/51wQ9ZHfn/vOlPu/N076ow2reR4DrJB95wX4lw2913
   A==;
X-CSE-ConnectionGUID: mQ7SpkaKTmqhZ6hYrcEVuw==
X-CSE-MsgGUID: cMjayXhyRRGhp6pctzvN7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48888701"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="48888701"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:26:32 -0700
X-CSE-ConnectionGUID: LwYwICkGSza98o9SKhcAdw==
X-CSE-MsgGUID: ClbCdbfZQdWt9Cfo41MSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="142712978"
Received: from llaguna-mobl1.ger.corp.intel.com (HELO [10.245.116.107]) ([10.245.116.107])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:26:31 -0700
Message-ID: <a0f38bde-d782-4170-9736-f1ad14a13ba6@linux.intel.com>
Date: Tue, 13 May 2025 18:26:28 +0200
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
Subject: Request for backporting accel/ivpu FW log patches to 6.12
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please cherry-pick following 4 patches to 6.12:
3a3fb8110c65d361cd9d750c9e16520f740c93f2 accel/ivpu: Rename ivpu_log_level to fw_log_level
4b4d9e394b6f45ac26ac6144b31604c76b7e3705 accel/ivpu: Reset fw log on cold boot
1fc1251149a76d3b75d7f4c94d9c4e081b7df6b4 accel/ivpu: Refactor functions in ivpu_fw_log.c
4bc988b47019536b3b1f7d9c5b83893c712d94d6 accel/ivpu: Fix fw log printing

These are fixing some firmware log corner cases that allow us to get reliable output in case of a failure.
They should apply without conflicts.

Thanks,
Jacek

