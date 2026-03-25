Return-Path: <stable+bounces-230358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBsPAGIKxGk+vgQAu9opvQ
	(envelope-from <stable+bounces-230358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:16:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 426FA328D03
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F45F31C280C
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F53E3D93;
	Wed, 25 Mar 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iy2G1rGF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12012857C7
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453455; cv=none; b=sPuNov/mIOKWPlcCkmbKub+hxstrC4koj5b+pllKOvSeOV56FFq1twPC7H3Rla0zWkI5oXu47agMixntOCoht37aHyqsZSy5gX8SyAvArCps/rYbnOQbL3yLte9Os2ibDSW+VKyr+tV6d4nWfdUU/KGMDs87ZEUW+IB3+pW3HfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453455; c=relaxed/simple;
	bh=vqGE1NYdTRu444bhmKZ3SpM+wtj27zgztsHbOtDKvEI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RPnyLRelBzgAbgCl6pg7CKFyDJMC3GP16XNlghXDQYn3E4F9K3jQ4nsYJypdfDEgNaquSprrKz7LfjynvqnzzV8kH1bpBbFo4EkPAnXYvQ+F7R/xamxFe6eYXkW5MOXRWgQfDuPpXXBauyYn6s+lHhtQRs9/BU5xT1y8Foa834Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iy2G1rGF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774453454; x=1805989454;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=vqGE1NYdTRu444bhmKZ3SpM+wtj27zgztsHbOtDKvEI=;
  b=Iy2G1rGFl/R/xHaKBbZuFaqqiEqpoa5dmAFfIPYgLHZ/WDmcsP5En97n
   lrxXAm7jE9J0PWPRl01u9es8uldqG9N6PT9YOUrzYEgnzuDOeSfziHZFY
   HJGwEfSVHAa5WJbuj3769lbGSXpZ6V1fQKbEwbtE4/D8M9PwgA/auR5Iq
   jB8NJvbS6d1o6988VjhofOVci4Nojel0YTQvD2hl6p/jxBDNwdveYqJbQ
   /xd/wirWFb2wUNkr6DdxazBMUYlUOhSxL7H5q/Emd/inzixiZkdLmUpRQ
   p44nyplVQzWjzIPlOZwLvCmEE7G94tVCVi5H65sBAo/GhzqWB3EIvvyrh
   A==;
X-CSE-ConnectionGUID: T9SulYS6QQq58LgWPed8Sg==
X-CSE-MsgGUID: lC4RzCUjRsC4pMO2YliEOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86574055"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86574055"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:44:13 -0700
X-CSE-ConnectionGUID: uwjOXqQOT4m9kzwZETLcXA==
X-CSE-MsgGUID: ShcFUYL2SbK8pilXRrHVpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="221400008"
Received: from administrator-system-product-name.igk.intel.com ([10.91.214.181])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:44:12 -0700
Date: Wed, 25 Mar 2026 16:44:10 +0100 (CET)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 2/6] drm/i915/dp: Use crtc_state->enhanced_framing properly
 on ivb/hsw CPU eDP
In-Reply-To: <20260325135849.12603-3-ville.syrjala@linux.intel.com>
Message-ID: <984a8f43-7e5a-2d8c-3efb-7439cb4552ec@intel.com>
References: <20260325135849.12603-1-ville.syrjala@linux.intel.com> <20260325135849.12603-3-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-916698106-1774451826=:294612"
Content-ID: <6eadb5af-8903-146f-2175-4180ae7e8864@intel.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230358-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.grzelak@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 426FA328D03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-916698106-1774451826=:294612
Content-Type: text/plain; CHARSET=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <f46daaee-d612-1290-8390-746dc68ba834@intel.com>

On Wed, 25 Mar 2026, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>
> Looks like I missed the drm_dp_enhanced_frame_cap() in the ivb/hsw CPU
> eDP code when I introduced crtc_state->enhanced_framing. Fix it up so
> that the state we program to the hardware is guaranteed to match what
> we computed earlier.
>
> Cc: stable@vger.kernel.org
> Fixes: 3072a24c778a ("drm/i915: Introduce crtc_state->enhanced_framing")
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Reviewed-by: Micha³ Grzelak <michal.grzelak@intel.com>

BR,
Micha³
--8323329-916698106-1774451826=:294612--

