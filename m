Return-Path: <stable+bounces-227564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGJ+FGFmvWlF9gIAu9opvQ
	(envelope-from <stable+bounces-227564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:23:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC92DC992
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C0263035F6D
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663433CA49D;
	Fri, 20 Mar 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaT+jdYB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F073CA486
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019977; cv=none; b=MNvJyLBhVBIzqAO12EgUfm6pCOcijc/7FJiPb5o68spx1d6xNtam4kkjYTfj5i9mP7cA3iq1F5RVibMC28O0pKoAvc4yr0OYLsiS5Ry4VOm1CxkD7pIRj3lJJbpiNHi+PqEuzaHzud5ZK0Bt1wXxUBrZUoWMFu1G09iUM8VWAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019977; c=relaxed/simple;
	bh=mGo9Eno6VFGL8BjMHn7tRkWMWYfBqBSsqj6AZDyHUek=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GPuo+NEXrC8hhRAHyyEGFkUbECU/q8sBZsmgImHZlv1ZBHjYasCr4WmYrAc2yT/Z6wgnDOIhFohu0NTGrwGwmEJRT9UvcO/TTCDvvzW7DcnJqY0d4lsvqGOy+sSURnSY9TgMQ466s4UzZ2R9fhTv1tnOLCP8/nYNaWb9iL7pYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaT+jdYB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774019976; x=1805555976;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=mGo9Eno6VFGL8BjMHn7tRkWMWYfBqBSsqj6AZDyHUek=;
  b=OaT+jdYBHdtAq8iFVQHcB/Q+CTp001f46Y4H1EzNWC08VPwNDelJX2kL
   oRq36fgHp34a8G7+LgNLoYFGzeTvXKBVwl80VY3kPh7py/skZ/hxtKZ9D
   IZ6OJEaCBaJNdY0J6xfy/m7TC0yCM7nwFTAvxCgQGgzVPzvlgaDpK8RG/
   QqddrE8bB8FgSCWLAMXS+5p/2x4SBbkVSSXzDm6RB6ULMQLr/AzqvecDe
   z14dKy6jvPF5bvu3bKrkCozac7MIgCewUl7IQWnI/NNbG0Ek9Hmcvs57D
   ud+pwCj++2OyDYnLwEuMK8lwKwfk8J8B/m19vUVkRpLVB7VXFhIimVjjf
   w==;
X-CSE-ConnectionGUID: PfXZDPFXSAqnwzWhO+6/jQ==
X-CSE-MsgGUID: pcfHBCKvTXW+fO/jClXTHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75073024"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75073024"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:19:35 -0700
X-CSE-ConnectionGUID: okmzBj5uRnu3CvjYS+cn1w==
X-CSE-MsgGUID: HuWMuup8SDmGLcHF97AkEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228045713"
Received: from soc-5cg4396x82.clients.intel.com (HELO [172.28.182.131]) ([172.28.182.131])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:19:32 -0700
Message-ID: <20e38ce3-f876-4246-b6f4-13558c256b9e@linux.intel.com>
Date: Fri, 20 Mar 2026 16:19:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
Subject: Re: [PATCH 6.1.y 3/3] ice: reintroduce retry mechanism for indirect
 AQ
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Rinitha S <sx.rinitha@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <2026031701-reapprove-dollar-1839@gregkh>
 <20260318000947.379271-1-sashal@kernel.org>
 <20260318000947.379271-3-sashal@kernel.org>
Content-Language: pl
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260318000947.379271-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227564-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub.staniszewski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid,mpg.de:email]
X-Rspamd-Queue-Id: BAEC92DC992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

W dniu 18.03.2026 o 01:09, Sasha Levin pisze:
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
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Compile-tested, runtime tested (regression only, to see if ethtool -m 
still works and if there are no errors in dmesg).

Tested-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>

