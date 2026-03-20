Return-Path: <stable+bounces-227505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNHEIuEVvWnG6QIAu9opvQ
	(envelope-from <stable+bounces-227505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:39:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6BE2D824E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8ACD1300A675
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FE438735F;
	Fri, 20 Mar 2026 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCeqWgiX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8D3803E4
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999572; cv=none; b=tq4UcgNSPq3bgWz2f+IWvu/iAonT+Q7WvPX/T+WVCmpwjf7Qdfd7vicrSElBBD05BlfWznUNKaTtpPASNan0jUzNSCX9gCVmLMBdVBXgB+g8v17MAQrqWJZ+etgUsBQwccLw020ENH/jFHzmVtdJdnTZz3P8oBwH3DIFygm4V0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999572; c=relaxed/simple;
	bh=0sstqU3fJ4IUi2S+H3VRr6xcvwvgQHXGoAH2vmDu0Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hg+hSTQqAJp01tRWQ4gnEr4kbdU9Wphso5ecuHY3sHZ8A4+ALILWO8ptNuZqKTZuCW2VPmlCphacHT9fV04TAFMsxRUseadcUVO71DjK8WDXFRGzatrfIHR+8VOGV3uZOQMq6NpHzpyVq5Ktw3FjLGLrrv/ZiorVEKf0RdFGCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCeqWgiX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773999570; x=1805535570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0sstqU3fJ4IUi2S+H3VRr6xcvwvgQHXGoAH2vmDu0Mo=;
  b=VCeqWgiXAf6HMSJ8fW4tU0lJSvmyymM2LmfSDYsHEZok0y3o43soPBqo
   xK6CEfpXwdaovqcl4QfCDZ3Cxk+MV7XADhGJNHHJM4mxlDW/Lf1F5ukZq
   D6pRu5ocdBhwaQ1/5BHlMEp6x3Ox6t0k4wEqZJbuMeaQNKBAW7ZmZ7lh8
   lnc4PNOBqRVjl0ZpUVQu1+AjW73beVFrHXqUjlynCfIuJjePkX+VZW1GK
   YI8uvZBggrICT0iDDNtj7B+NL4y6SY7Qps+VUKmdI/I5mXO8m07bNn03Y
   cAsKtCm+EQCgaqTfG98seGFddN5SEwjF7DxnJEKWGP7Xpi5Kg8a4IhAYW
   g==;
X-CSE-ConnectionGUID: pgweN31eRF2nFryoPFVMLg==
X-CSE-MsgGUID: OtSLvaLeTfup1nqzpV8jWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85783856"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85783856"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 02:39:29 -0700
X-CSE-ConnectionGUID: nAObGmK6TkKxwuNer5WDUw==
X-CSE-MsgGUID: NUMW7+4sR5W0nYldGQ80Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228175937"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.189]) ([172.28.180.189])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 02:39:26 -0700
Message-ID: <bc89f69f-b8a4-4651-9b50-ed3835fb0d5d@linux.intel.com>
Date: Fri, 20 Mar 2026 10:39:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 3/3] ice: reintroduce retry mechanism for indirect
 AQ
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 Michal Schmidt <mschmidt@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Rinitha S <sx.rinitha@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <2026031701-reapprove-dollar-1839@gregkh>
 <20260318000947.379271-1-sashal@kernel.org>
 <20260318000947.379271-3-sashal@kernel.org>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260318000947.379271-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227505-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 3B6BE2D824E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-18 1:09 AM, Sasha Levin wrote:
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

Tested-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Regression tested on real hardware (E810-C for SFP) on top of
kernel version: 6.1.167-rc1. No errors/warnings in dmesg, ethtool -m 
works correctly.

Done after applying all the patches in this series, recompiling and 
reloading the ice module.

Thanks
~Dawid :)

