Return-Path: <stable+bounces-231182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ4uEn5kymn27gUAu9opvQ
	(envelope-from <stable+bounces-231182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:54:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2506735AA71
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA2F6300BE3A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7373C3C19;
	Mon, 30 Mar 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8+4iDnQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B6175A96;
	Mon, 30 Mar 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871404; cv=none; b=pLUg5lWBYUKsseHEnIc2KS1M51kaPjMJRukgoJmvqzlWby/yViGNFJxdCUkF1qk41wf9LxWkXO5guXZKdqeYSgcE24azjqqVIWBkFS8IFSsCe9ymsaaSYtpSjUjdDMa7DMYKSv+FMm2zvKE4BBOOyAsZgzhxiCAZz9oLuh4+Mvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871404; c=relaxed/simple;
	bh=qwx+uovzcKZxcm0VDafKuZvZ8t4WfOt6isHpv35/KVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjB4x4+vuX03mHseuYshpv/+YCstl2odxvIq5eHXt/vqCGAiIcYlVCcz+yIO5Tk/9JDIMTmaQXpJIQ57dT780qUDMh1A1Z/b+ifeKD9ICxUhc3S3iGNXLlRuIf/K6CG6AAxUdQAFfpR88pndolXU3iYl4WPb+NevH9Iui81lWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8+4iDnQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774871404; x=1806407404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qwx+uovzcKZxcm0VDafKuZvZ8t4WfOt6isHpv35/KVI=;
  b=V8+4iDnQhYOG6kKj0+avros5ncNdSknST8zQZjrNmDcwuIC36OOB2NsA
   f+RQ3M9/n46ZHdKmhqFMNKbk4BBY/BytCD6iznPbbhkbvFQ0cY9R3+ktb
   AdRGK/QUc7/LHqVFecF1lXYkVeM50jzfh3DMk91LWezUn2aKCWEnECipa
   s6PKhd1im5nopvT9SNOs8xUWRzyXQHmOISZofLOWQfmopkTE8zxe6L0E2
   k5kaO+eL4952GVa/LN55+ZmF7GrRijNXXqYtcmw5ci/uubD3zQKKM6FJX
   oPcS/44PDGOmXOS0w8FDOpp42Szv8nmT/DNUK4IQsQVEuJIOAiJNliCvV
   Q==;
X-CSE-ConnectionGUID: u7nJZmkORxW52b03QClBaQ==
X-CSE-MsgGUID: V5RcPSCGQK2O6zqf/oz+AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75831031"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75831031"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 04:50:03 -0700
X-CSE-ConnectionGUID: EZZjznjATcalu0S1+1ct0Q==
X-CSE-MsgGUID: TMFDWUL5TYum9XMMwcBV5A==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.70]) ([10.245.245.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 04:49:59 -0700
Message-ID: <3672d018-d7c2-4bdf-a130-60ed76a9e543@linux.intel.com>
Date: Mon, 30 Mar 2026 14:50:15 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Don't allow pointer operations on unconfigured
 streams
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Paul Olaru <paul.olaru@oss.nxp.com>,
 Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
 <3cd96fe7-4575-40f9-a1f2-610fb1fac5c1@linux.intel.com>
 <aca1sW6ca1QJBN9V@sirena.co.uk>
 <e3c69a0a-5ed1-45f7-9180-9268bd671df0@linux.intel.com>
 <bf12ef77-0d28-4454-a910-59bf915b5048@sirena.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <bf12ef77-0d28-4454-a910-59bf915b5048@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,nxp.com,linux.dev,perex.cz,suse.com,oss.nxp.com,alsa-project.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-231182-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 2506735AA71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 30/03/2026 14:05, Mark Brown wrote:
> On Mon, Mar 30, 2026 at 10:01:59AM +0300, Péter Ujfalusi wrote:
> 
>> Should this be fixed in core level to avoid repeating the same check in
>> every driver?
> 
> I did wonder about that but wasn't sure if there might be some viable
> use case, especially for things proxying through to a DSP or something.

I see, but proxying or not, if there were no configuration set (the
state is OPEN) then asking for avail or tstamp do not have any validity.

> We don't generally guard calls based on the state the stream is in,

compress does this quite much, just avail and tstamp is exempt for some
reason.

> and not every implementation is going to try to do the division.

yeah, the SOF IPC4 compress which is under review for example is not
doing this.

-- 
Péter


