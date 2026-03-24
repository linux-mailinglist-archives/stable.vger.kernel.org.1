Return-Path: <stable+bounces-230110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEP6MttpwmlScwQAu9opvQ
	(envelope-from <stable+bounces-230110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:39:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0593068D1
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFDB23034B38
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428DC35AC16;
	Tue, 24 Mar 2026 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMJa+if1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DF3ACF18
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348760; cv=none; b=FRK7ClrcG2xU0/SdoDaSOvbueSTReQLfXgn5hdBoIw2Izg7+/uc/CVFdXb+yuWoNNGq+URbK4gBTJqZ0z6Ng5ZlubVlR72iC8AHwTM/VX92ki+Pj3CniNHfUyIH5Hm8a1KPqf00RvznqcFuSYkemHGc6dYeanInGlKBwimRbYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348760; c=relaxed/simple;
	bh=MrpHzRQwsA0FTen4mArLVyDHGZDKD5kjPbvGmciIpHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gx8ad+qcfMaJq3l8xL9vzhSTA+IrR6k1Oy1jr/0p9lLFa6rS2QPfrDOK8sEJSTqjXwXCD09BfFpYNf/lo2/GyuOoMYDv4XGhXbHlzUxitbbEzyYD/vk4+zjpAWca02A8YxZy+vNdS7la8tq0339EIZ0qDlecLO/x9d9nUGlZmk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMJa+if1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774348758; x=1805884758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MrpHzRQwsA0FTen4mArLVyDHGZDKD5kjPbvGmciIpHI=;
  b=jMJa+if1LbQ8+E8Hxy45uNK8emHg0d1vCgW5YboOzgHuESTwafGXW0KD
   FhcqZct3DVbat3MxEdM+/XUegt/7jdiWMFt3aKKKfpuMm4i7Dz7onvJOR
   nxHSDnfRXyIbZ3ScZd0qS2StAkMnDVdYB0LNSBwQs/u0gtL/qAmeB3F03
   Bv/6NlfceeW9njiGAMoDXDTYCnN7wdTPjwtZ6666dLK/mt0prMTegLJEm
   saLy5qT5WdjjXURi2rXGcVBYHUyFZ5KUvRlV+gpNqjTpBRmoWwik6nHr2
   mZvr9kO1fo7W0CFP6CgDPgjIifNmOVvuOEka4FVTgo8RffCMLHwLZr8cB
   w==;
X-CSE-ConnectionGUID: oJoEFb/oStK7t57TfxT3hw==
X-CSE-MsgGUID: MEZPZS/jTKGhSDi5sXclbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86434707"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86434707"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:39:16 -0700
X-CSE-ConnectionGUID: jflHM+oTQe6vxTaFNj4LbA==
X-CSE-MsgGUID: apybqnzVRIWajyRaQr/WtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247390848"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.189]) ([172.28.180.189])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:39:14 -0700
Message-ID: <9b17ea40-c074-4047-895f-eb9f040a67ac@linux.intel.com>
Date: Tue, 24 Mar 2026 11:39:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 2/2] ice: reintroduce retry mechanism for indirect
 AQ
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 Michal Schmidt <mschmidt@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Rinitha S <sx.rinitha@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <2026031702-configure-decorator-0097@gregkh>
 <20260318004646.408222-1-sashal@kernel.org>
 <20260318004646.408222-2-sashal@kernel.org>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260318004646.408222-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230110-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,mpg.de:email]
X-Rspamd-Queue-Id: 7D0593068D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-18 1:46 AM, Sasha Levin wrote:
> From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> 
> [ Upstream commit 326256c0a72d4877cec1d4df85357da106233128 ]
> 
> Add retry mechanism for indirect Admin Queue (AQ) commands. To do so we
> need to keep the command buffer.
> 
> This technically reverts commit 43a630e37e25
> ("ice: remove unused buffer copy code in ice_sq_send_cmd_retry()"),
> but combines it with a fix in the logic by using a kmemdup() call,
> making it more robust and less likely to break in the future due to
> programmer error.
> 
> Cc: Michal Schmidt <mschmidt@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 3056df93f7a8 ("ice: Re-send some AQ commands, as result of EBUSY AQ error")
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> [ kzalloc() => kmemdup() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

I didn't have the time to test this, but the code itself looks sane :)

Thanks
Dawid

