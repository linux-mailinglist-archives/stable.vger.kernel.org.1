Return-Path: <stable+bounces-230357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA/YAQoLxGk+vgQAu9opvQ
	(envelope-from <stable+bounces-230357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:19:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E2328D7C
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E25F30B82ED
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209B3CCFBA;
	Wed, 25 Mar 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2Ly43je"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80782DCBF4
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453209; cv=none; b=KnjBMtKFHRrSUiMjWfW9OCy3/SY7kPGv2GXXMHLHJCdpWgoL3Hk2efBj/PLMHIfLFaDi5wOIXz5M3rqD0acfpUAOlvK79LKeV8fL5aKoCn31NurRCRxByQx//6XCKMxDHPVZjbJCx32/nyShlSD9GlfZ6YCi/n5F+PYW3EOhX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453209; c=relaxed/simple;
	bh=KpWRqnfn2KKx9CCG0GyuvAV6EokwwGAW4V17iSMngq0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SEkDOJgsu90euQuInbYLtnlu+muRog5y6RngXNe4CadHU4LWcHKlZsSfpowCCp+09RCz5hzlysXUh+DdfkJ1BKNeMVIs3T8N56DSDsLYpOjyk1jxnRkfV0Z7uFdQPEaly2vTYlZwWSqJaWkUUd+2RmCTHTjRzaP5WhnR8FLpUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2Ly43je; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774453207; x=1805989207;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=KpWRqnfn2KKx9CCG0GyuvAV6EokwwGAW4V17iSMngq0=;
  b=j2Ly43jeqaj8I0h7clKDFjTKHbqGymqMF2898XsusXDtpxAUoHuOLB4E
   4uFHupup4VZ9wubkqu1B3ydIEKBw4EzSWs2Jgyl9ryWvvG0AARVUvLFF+
   Bsr+sK3OlBWjzGwKX6P401qSksVoO3jdQSJ/70cfVLH1LLCK0rLURvnvz
   Z3V6YGco3O4m38Kr13M6uBQ0vxTFNkvlMfrB9ykv8uczhKykSdxoV/JyY
   WO0WBlurvsoRAPqnhqK5lRLXHUq+1Ht0TA/kMalwVXi9wwGlprTL4arTo
   4xKX/utDgJ5h9dDZ213kz4CV0sV5fekGt+u7G4zP9AZ3kUO8UJcwq295e
   g==;
X-CSE-ConnectionGUID: Bp7gCoUoTJaZjtL6fePRlg==
X-CSE-MsgGUID: xzd+hVsxRdGvCjHdhyv+tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75381498"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75381498"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:40:07 -0700
X-CSE-ConnectionGUID: ze0fWeg7TUSYluyZtWDJjQ==
X-CSE-MsgGUID: a2wsMCdFS7SElKPQHnVZ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="262634792"
Received: from administrator-system-product-name.igk.intel.com ([10.91.214.181])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:40:05 -0700
Date: Wed, 25 Mar 2026 16:40:02 +0100 (CET)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    stable@vger.kernel.org, Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: Re: [PATCH 1/6] drm/i915/cdclk: Do the full CDCLK dance for
 min_voltage_level changes
In-Reply-To: <20260325135849.12603-2-ville.syrjala@linux.intel.com>
Message-ID: <4790e7bb-c9b3-001b-9f1d-c9990721e2c0@intel.com>
References: <20260325135849.12603-1-ville.syrjala@linux.intel.com> <20260325135849.12603-2-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1013487388-1774451849=:294612"
Content-ID: <2951095b-2979-b733-5139-967941db4e64@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230357-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.grzelak@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,gitlab.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 742E2328D7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1013487388-1774451849=:294612
Content-Type: text/plain; CHARSET=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <e61e61d2-5f39-3c08-b676-e546fa696723@intel.com>

On Wed, 25 Mar 2026, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>
> Apparently I forgot about the pipe min_voltage_level when I
> decoupled the CDCLK calculations from modesets. Even if the
> CDCLK frequency doesn't need changing we may still need to
> bump the voltage level to accommodate an increase in the
> port clock frequency.
>
> Currently, even if there is a full modeset, we won't notice the
> need to go through the full CDCLK calculations/programming,
> unless the set of enabled/active pipes changes, or the
> pipe/dbuf min CDCLK changes.
>
> Duplicate the same logic we use the pipe's min CDCLK frequency
> to also deal with its min voltage level.
>
> Note that the 'allow_voltage_level_decrease' stuff isn't
> really useful here since the min voltage level can only
> change during a full modeset. But I think sticking to the
> same approach in the three similar parts (pipe min cdclk,
> pipe min voltage level, dbuf min cdclk) is a good idea.
>
> Cc: stable@vger.kernel.org
> Tested-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15826
> Fixes: ba91b9eecb47 ("drm/i915/cdclk: Decouple cdclk from state->modeset")
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Reviewed-by: Micha³ Grzelak <michal.grzelak@intel.com>

BR,
Micha³
--8323329-1013487388-1774451849=:294612--

