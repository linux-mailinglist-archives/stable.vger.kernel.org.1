Return-Path: <stable+bounces-152766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05FDADC85B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE37A1308
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74667295DA5;
	Tue, 17 Jun 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0AMUn4+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E4289E2D
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156400; cv=none; b=RITOjfLk32Es64i/nAaZl7oRbLUKvnkS2jFHLEJdCPTlz2LUgItbmc1gGUkQWxIppG4NJUMQ1QhdpF9ZiL/dktwjObcMC2or3UfDu/MBqDnxMyN8yzR7OUjUzVTvp3rrcjqhxGlcU9vpW8WZposG0pb9Uidh1k8/3QFauCwnZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156400; c=relaxed/simple;
	bh=Zn2TacU6UVNqCNeV3B0EXyrHPDXKd5MOwZRVE1Gwh9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eyGy/ylqrm4kSHjKcxaLdC1uJhFaYQLdv5bSdtoH6DOgIkeoLvo20luF0dnEkRY9dOjGsa5+bmJlgTDdMFrSP7E9TbH4/bePOg7QtPwDXd21gbnNO5pyFrNtQ7KmjNsFl7F5oQe/XYAbse/yN1ajtF1/FARFkJoeqt3gBVps5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0AMUn4+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750156399; x=1781692399;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Zn2TacU6UVNqCNeV3B0EXyrHPDXKd5MOwZRVE1Gwh9Q=;
  b=N0AMUn4+0KjhPscuL+3a6yOQsWRq9FIumwKeb7hBO4+qXOtY97tcJ/eK
   HD7SNvxr4gj1qWhE2XIbw40HQWZNvJugFv5wnGjoViTxTOBs/3wPCzCbl
   395zXkqVwiq9jbxMRhDM6PSz9QsX8ftCVnXJ+Cip8y6imRPcHcarLqft2
   NMnFSrLC31HGXYfcHmKvtbfWYDMY3d8x97yo87odCfnsXpGC/4fn7L2dh
   yvSddIReuwiJWOcAIKhrJmJ5RHrSwDgtJUHk9XK1fXWRC7/YTg6tS6Nad
   ZR6UhKRjY4xkGAZsu61fAgFnsYDU3X6o/7hY/osifmGdeTl3MPjeVmoxR
   A==;
X-CSE-ConnectionGUID: Kmu9dW+gQxucjN6Nm594/Q==
X-CSE-MsgGUID: vypM9bohQE2ionnmaTyaWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63681485"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="63681485"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 03:33:18 -0700
X-CSE-ConnectionGUID: HhE8r42OTjq16hAMe9DPfA==
X-CSE-MsgGUID: NHu4dK6qToyDh3rQ6/RooA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="153703458"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.111])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 03:33:16 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Vas Novikov <vasya.novikov@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Ankit Nautiyal
 <ankit.k.nautiyal@intel.com>, Suraj Kandpal <suraj.kandpal@intel.com>,
 Khaled Almahallawy <khaled.almahallawy@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
Subject: Re: [REGRESSION][BISECTED] intel iGPU with HDMI PLL stopped working
 at 1080p@120Hz 1efd5384
In-Reply-To: <8d7c7958-9558-4c8a-a81a-e9310f2d8852@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <8d7c7958-9558-4c8a-a81a-e9310f2d8852@gmail.com>
Date: Tue, 17 Jun 2025 13:33:11 +0300
Message-ID: <afa8a7b2ced71e77655fb54f49b702c71506017d@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 17 Jun 2025, Vas Novikov <vasya.novikov@gmail.com> wrote:
> If any other information or anything is needed, please write.

Does [1] help?

If not, please file a bug as described at [2], in particular attach
dmesg with debugs enabled all the way from boot to reproducing the
problem.

Thanks,
Jani.


[1] https://lore.kernel.org/r/20250613061246.1118579-1-ankit.k.nautiyal@intel.com
[2] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


-- 
Jani Nikula, Intel

