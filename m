Return-Path: <stable+bounces-55047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70E1915258
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D81F2161C
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD85E19CD18;
	Mon, 24 Jun 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdBGc4xA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84419B5BF;
	Mon, 24 Jun 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242941; cv=none; b=T7agJ/dTy5YWXB2ZiaDC2/86W45iqXjOVVNAxe/FuaM7Az4cmkqybSALejmFaIWOgjnJjeobJlJnks7OVnvQeb+dbqL9n9VoBb2fuf/AXPST209MZmzJnpDxoyoV8SWvuZGMgMUh1k+Js4pOWC+amBWDO4DCLcs4cug3wjCAOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242941; c=relaxed/simple;
	bh=Z8b/An1gpBRx3EBNEgucKedKqJ1Ejw6k10nsaOGsUbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGF/TGMOAl+lxh/TVD3HBCPFuQwlLjckyapKAeQQOyli5qzx4Za4/AgqKYkSeLTqer/LCLTpJ8FLqP3T7uWDOBBtCsG5RjblTbIieeAwtbJgHJCSBcDg2bXCe1AvNuaUB4QhTkDslt+lG9ML3Wr0bTuKYwk8b/xOWa8mTPluPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdBGc4xA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719242940; x=1750778940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z8b/An1gpBRx3EBNEgucKedKqJ1Ejw6k10nsaOGsUbQ=;
  b=BdBGc4xAwNH0xlWtoWBvxQSLsmNVJDenX/D29QxanYk+oLmA+O0EzlIM
   K5KrOgC2axC4myXYTjEt5cVrVZ2WQvgJUVscfoqTlhbZPa2UmvP+OJEYV
   CqvYIzLmhqyPFm2a9HrIxvcDvtCe9Qizlzb5kz3WLgGNp0FHYu25J/T2S
   um/1YISWI9tNNCuZGXQNmAq6eQTxeITmOYJAz4AQw4hHfCoqmhb6pxXFl
   WU2J2h5NljtIoRqSSrEm4EgPHSQ+l1w3pNPu2lI8442Dsi1yK1/RY5BdV
   aNaAU8bmVKFZxtb0RnTEnbuwVQcotGLTYxPd3ppoR7BMdpIkcuU0yxCzd
   Q==;
X-CSE-ConnectionGUID: 8Hm3QowJSUiiZtMdOoaxIQ==
X-CSE-MsgGUID: auLgHzrPRgalBIhkHa0Tgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="19121766"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="19121766"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:29:00 -0700
X-CSE-ConnectionGUID: GI/hu555S7+wE0XC4sZLFA==
X-CSE-MsgGUID: 2w5dN8AwQeatpRI/PILLdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47703946"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO [10.245.246.230]) ([10.245.246.230])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:28:57 -0700
Message-ID: <7372501f-0393-4ba5-9e05-71d59dc1449b@linux.intel.com>
Date: Mon, 24 Jun 2024 17:26:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: SOF: ipc4-topology: Use correct queue_id for
 requesting input pin format
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, stable@vger.kernel.org
References: <20240624121519.91703-1-pierre-louis.bossart@linux.intel.com>
 <20240624121519.91703-3-pierre-louis.bossart@linux.intel.com>
 <ec992bf9-667c-48a4-81ed-3a1232123987@sirena.org.uk>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ec992bf9-667c-48a4-81ed-3a1232123987@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/24 14:36, Mark Brown wrote:
> On Mon, Jun 24, 2024 at 02:15:18PM +0200, Pierre-Louis Bossart wrote:
>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
> 
> Please put fixes at the start of serieses, or send them separately -
> it makes things much easier to handle if they're separate.  This ensures
> that the fixes don't end up with spurious dependencies on non-fix
> changes.

Agree, I wasn't sure if this was really linux-stable material, this
patch fixes problems on to-be-released topologies but it doesn't have
any effect on existing user setups. At the same time, it certainly fixes
a conceptual bug. Not sure if the tag is needed for those cases?

