Return-Path: <stable+bounces-226004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF4rErhTuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:14:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E537C2AAA20
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EA7F30DBB23
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54FA3C140C;
	Tue, 17 Mar 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVG15I82"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963E217648
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752856; cv=none; b=uF6XIreSREp16DwVeskdoWhsQ1j91eYlNWa4PxTqYHGMa+ngiSL2Fv528YAdjYixaICUCyRwwDKv3U7nXFCBtDe7uj8hZGtqxqoTdr/6fsTv0G1BiDUxGjV7T69ky//1azYKlCaP296bfZsw94AVkl/qMaG9rYUjyKF4733N/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752856; c=relaxed/simple;
	bh=F0p8gQPBLZEVD9EM+ov7iJ+l8edm5JCED+CAd61J5VY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cX4t8qDiDrgsQG8jdYVt0LgyqSbMNGT6Sc7q/4ZrDgfMXW3R6NRzTT2gV0L66nyCcwG6WdMdPCKzosW5CaQDHMr1efshH91pFCpUoY7fR7o+BEWiXInSkOjr4ut5Vmy2NciglzmTDIUDA4blroOv8HGYGxKX2qxSTq9qQMaC5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVG15I82; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773752855; x=1805288855;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=F0p8gQPBLZEVD9EM+ov7iJ+l8edm5JCED+CAd61J5VY=;
  b=CVG15I82RMwv8pIm3cgAxNlM1n6XVEDLK40T7EZ0+Oe4kH2AXtR32pGc
   0pd9JbOOrscNq4sg7s5MzMVsWnZDqQ+GsoMmU59vGf2fHPYjMBv7RN17B
   o/udm53J2Gc4NI+rlV9dqYpJGx/fz37s0RIHX+qpozw2hVahrFK7hJENX
   o5PpN67eMuZoqr5v3RDnFOmv1vx7cNhgrP4bhq/hU2AEa4rjs6jeNVLN7
   HvubqjSv1zncT0REvRYc4Bcz3V1WrTQpF0aZahObpXoFZIJJKdx/fwMXN
   QL/oAOjxxA6ntcajWz/kd8jgWyHQH8PgytKRoCYyE/llWta8zYY3KN18r
   A==;
X-CSE-ConnectionGUID: iz3LTufjRVCmemKvxfMZhw==
X-CSE-MsgGUID: VJaJS/ifQ2iExZZVMzRiFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="100239770"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="100239770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 06:07:34 -0700
X-CSE-ConnectionGUID: AvYKnYs2SLSTsTIkPNxv/w==
X-CSE-MsgGUID: f3iVZsrJQFiedHUOLmFoDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217963748"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.32])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 06:07:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Order OP vs. timeout correctly in __wait_for()
In-Reply-To: <20260313110740.24620-1-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260313110740.24620-1-ville.syrjala@linux.intel.com>
Date: Tue, 17 Mar 2026 15:07:29 +0200
Message-ID: <c158ed8a644a9c3bf10a14cc083dcd33f84c236b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226004-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: E537C2AAA20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> Put the barrier() before the OP so that anything we read out in
> OP and check in COND will actually be read out after the timeout
> has been evaluated.
>
> Currently the only place where we use OP is __intel_wait_for_register(),
> but the use there is precisely susceptible to this reordering, assuming
> the ktime_*() stuff itself doesn't act as a sufficient barrier:
>
> __intel_wait_for_register(...)
> {
> 	...
> 	ret =3D __wait_for(reg_value =3D intel_uncore_read_notrace(...),
>  			 (reg_value & mask) =3D=3D value, ...);
> 	...
> }
>
> Cc: stable@vger.kernel.org
> Fixes: 1c3c1dc66a96 ("drm/i915: Add compiler barrier to wait_for")
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/i915_wait_util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_wait_util.h b/drivers/gpu/drm/i915=
/i915_wait_util.h
> index 7376898e3bf8..e1ed7921ec70 100644
> --- a/drivers/gpu/drm/i915/i915_wait_util.h
> +++ b/drivers/gpu/drm/i915/i915_wait_util.h
> @@ -25,9 +25,9 @@
>  	might_sleep();							\
>  	for (;;) {							\
>  		const bool expired__ =3D ktime_after(ktime_get_raw(), end__); \
> -		OP;							\
>  		/* Guarantee COND check prior to timeout */		\
>  		barrier();						\
> +		OP;							\
>  		if (COND) {						\
>  			ret__ =3D 0;					\
>  			break;						\

--=20
Jani Nikula, Intel

