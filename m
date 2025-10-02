Return-Path: <stable+bounces-183063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B039BBB41CA
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5560419E18D8
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9133115B2;
	Thu,  2 Oct 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUeGjlzV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3A2D5928;
	Thu,  2 Oct 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413525; cv=none; b=mnd7E9kUpE2wqEjtcszjMLRB54KtYQWg38/XV4RYnhtmqiVnlnN8Omzk9ofpK1xC+h8/CxCH3vcYeMiHEIrQMiVg1SiH2wpfzKNlm/zXNHIZqxyRRevhiYjT2mIKsCz0D4xTulXHnDDEuFtl2KIHd0qMxl6RZb8nMu4VUwDKotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413525; c=relaxed/simple;
	bh=LBJwX+/J/S/AXxLN4fxHEkcz15w6NN0vaaw6XqdorgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fl50ewrSBqBXe6LSAvJ6OLetIqnoR4CpnUTzmrCYPqNq+Vo2SSa5YcOoKwwjiTiJfnVRaXn1SKWcNLqalbR+PnvxEZi5zMelbdx+lsezLBFYaD22e6D/PDzjgSpiQ2gqwqNxLMAYqM2vZZ8xX5eWyLx0DPJFKMnZJQ7xP7c331U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUeGjlzV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759413524; x=1790949524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LBJwX+/J/S/AXxLN4fxHEkcz15w6NN0vaaw6XqdorgE=;
  b=LUeGjlzVsa5HjidyUP4D4IpP5ZCIkFtxz/cVppKKapaVs4TU4jCqmNZz
   vOlk4zv98M+70xhmL/kct65KrKrp4tUN0U27w8QAllkrY60aROB+8IlUY
   As3LnINuz6EIvHP5ujaAtTqFZn9xGH6Ad+6LaL7gqeNZIHO2snOYvU7cB
   henK1NoAkOtMFHUbVVmViQ4qJynAWAPQ5q0izyRSj7DQL57s0pBSX35dJ
   44iMgnndr14N17jL6W0RFszFsYgJuji5jfyzGfLqpNgTFyzKFCtZ/egK6
   nknVcSs2HY1GNnjk44Xmxz8jSh5akfjjaa2+4Awg2HnbgYbTDG7RcW1II
   w==;
X-CSE-ConnectionGUID: o01rnVgeTNmcoChhy/Yt5A==
X-CSE-MsgGUID: Vk6H6r0lRYScaZ25MOXdHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="87145321"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="87145321"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:58:43 -0700
X-CSE-ConnectionGUID: gGre2mGvREymIBKtLfsjPg==
X-CSE-MsgGUID: 1oAVmHk0TyqGDRokSVGUEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="209747567"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.246.8]) ([10.245.246.8])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:58:41 -0700
Message-ID: <4c4920a6-4c9f-4b38-b180-bd4be58916dc@linux.intel.com>
Date: Thu, 2 Oct 2025 16:59:36 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] ASoC: SOF: ipc4/Intel: Fix the host buffer
 constraint
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 stable@vger.kernel.org
References: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
 <03e9d232-a0b3-4ed0-9832-d07068003553@sirena.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <03e9d232-a0b3-4ed0-9832-d07068003553@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/10/2025 16:08, Mark Brown wrote:
> On Thu, Oct 02, 2025 at 03:53:19PM +0300, Peter Ujfalusi wrote:
> 
>> Changes since v1:
>> - SHAs for Fixes tag corrected (sorry)
> 
> Still some issues:
> 
> Commit: 7cea6ea9f99c ("ASoC: SOF: Intel: hda-pcm: Place the constraint on period time instead of buffer time")
> 	Fixes tag: Fixes: 842bb8b62cc6 ("ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place constraint")

this is the SHA for the previous tag...
My middle-click copy is acting up today, sorry again.

> 	Has these problem(s):
> 		- Subject does not match target commit subject
> 		  Just use
> 			git log -1 --format='Fixes: %h ("%s")'

-- 
Péter


