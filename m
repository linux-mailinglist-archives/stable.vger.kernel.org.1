Return-Path: <stable+bounces-270062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KNrPIjNHRGolrwoAu9opvQ
	(envelope-from <stable+bounces-270062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:46:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F06E8776
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Ym4+Py18;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270062-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270062-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 063603018BCE
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93D277C96;
	Tue, 30 Jun 2026 22:46:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D143B28D;
	Tue, 30 Jun 2026 22:46:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859564; cv=none; b=MDQKH4uK2a+/8vOiDuZozXlwuYp6jHIOgVlMchSAW6h8yBXXo2EP3bfJFC662Yw5SX5P9yiKWCb4xFkdC7dNH7+l13TA3YvJ6lAylBssWCyU3xvD/ZOOox+9JSq2fVXqQQxpaVd6ZN96bbnUunY0roKJoH/t8NS0GXUOnV7Mfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859564; c=relaxed/simple;
	bh=jAFuBAT9xXbB1xeE/uSftQUaSLmCxG/VY/pSUxPNaGM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fl3zIcHgBE+IDYZ7Vg/aa21tmb/lxhD0g2C2MFptB7FC9MwApAHzOpmSXEYGm6IobRqPwi3U+oOI0WVd0lqEVb936amVTNpjCdu1DDmaVcY/M/h9XSrTpRXDRTbxx4lmew6LEbMnQRTc5GsaVMxVrUEEFao7ylzo2idYfyQ7uRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ym4+Py18; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782859563; x=1814395563;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jAFuBAT9xXbB1xeE/uSftQUaSLmCxG/VY/pSUxPNaGM=;
  b=Ym4+Py18p9znkF5H1NzY1p1dFh5LOfSbhwJE0Eg8//Wni6JNFUbI5ZIO
   foqsKCaGnR0gQp7101oJZPKrFEfrgoj08OxkeMA6v9YZUZAYD9m1/zc0K
   bsqP88rclVxCdV06R1iOAx4Dl+vPCkXWlXQgTLiGzJyfGnYVapbrvalQx
   TLUbj13dXNCUV8wchiF0WT7+BCvUbnqDMSIFP0RzNBpBYfed28nmPt9pA
   adwK5ybEqbDNXSCKFvr+tK2fxzx6O5E1YF4CeNx3PNs/oPPz8iqhxG8q1
   JuZOXZLXpk1e7f5qdtib7hsxxqbK400PR9rZBZKu0+54WASDEzrwvXQ/W
   w==;
X-CSE-ConnectionGUID: Dh5wQJGPSjG+dpStU992dQ==
X-CSE-MsgGUID: TvQmS2mSQ7S4yBb/jvbagA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83641605"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83641605"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 15:46:02 -0700
X-CSE-ConnectionGUID: 9P+qy8IPT9qhnGNq1S3EnQ==
X-CSE-MsgGUID: uxI62YlzTAWutGO00C4pqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251966044"
Received: from hrotuna-mobl2.ger.corp.intel.com ([10.245.245.166])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 15:45:59 -0700
Date: Wed, 1 Jul 2026 01:45:45 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
    =?ISO-8859-15?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@intel.com>, 
    =?ISO-8859-15?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
    Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
    Jaroslav Kysela <perex@perex.cz>, 
    Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
    stable@vger.kernel.org, Uma Shankar <uma.shankar@intel.com>
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
In-Reply-To: <b6e4caac-53f1-729f-51d2-aa0ca514ab04@linux.intel.com>
Message-ID: <765b713e-d2a0-6859-2923-53f8e60cb00e@linux.intel.com>
References: <f7d26e4d-8810-430a-b727-52c00d2d6edc@intel.com> <20260612181314.5577-1-alexander.kaplan@sms-medipool.de> <e5a56b3c-1fd7-35ad-f072-e490e2b471a9@linux.intel.com> <178196763509.3248.8656978100050911066@sms-medipool.de>
 <b6e4caac-53f1-729f-51d2-aa0ca514ab04@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270062-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.kaplan@sms-medipool.de,m:kai.vehmanen@linux.intel.com,m:peter.ujfalusi@intel.com,m:peter.ujfalusi@linux.intel.com,m:tiwai@suse.com,m:linux-sound@vger.kernel.org,m:perex@perex.cz,m:pierre-louis.bossart@linux.dev,m:stable@vger.kernel.org,m:uma.shankar@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[kai.vehmanen@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.vehmanen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,linux.intel.com:mid,linux.intel.com:from_mime,gitlab.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A8F06E8776

Hi,

On Wed, 24 Jun 2026, Kai Vehmanen wrote:

> On Sat, 20 Jun 2026, Alexander Kaplan wrote:
> 
[...]
> > So the wedge happens earlier in the sequence, as you suspected, not at
> > the re-arm.
> > The trigger looks like the multichannel DMA start itself once the KAE
> > block has been active in the running power cycle, below the codec verb
> > level.
> 
> thanks for the quick test. I'm working with our display folks to test
> this out with some Synaptic DP-alt HDMI converter. This same test
> worked ok with one converter (Lenovo USB-C to HDMI Adapter GX90K37871),
[...]
> I filed a bug to Xe/display to track this effort:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412

some progress with this. I attached a work-in-progress patch that fixes 
the issue with at least one setup using Club3D CAC-2505 DP-alt HDMI 
converter to the bug at:
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412#note_3543741

Needs more work still, but if this approach works, I'll send a proper 
patch later to the list.

Br, Kai

