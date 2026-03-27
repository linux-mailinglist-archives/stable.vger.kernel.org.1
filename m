Return-Path: <stable+bounces-230643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMY9I6xwxmmkJwUAu9opvQ
	(envelope-from <stable+bounces-230643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:57:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31697343DCC
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2EA4303380F
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13CF386576;
	Fri, 27 Mar 2026 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvyMudzV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC243126DD
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612557; cv=none; b=t0LnjVA4liL9UtxQb904bc6v5RzNdOkbNWWbKLZquKpY3lIR1nqfERR4Xkb4arbQiNdQxNF+LWkrSIPaU2DvNpgcJjl05xlXW3/tgo8d/EbJ4iI3kxPX55spPHnyoIZ6RWlbJaEubUnLfDwaT4k9P2q6flTQyBlQkMa75XYTnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612557; c=relaxed/simple;
	bh=6alnfp2vPlDIbbpKbsDyRVgTxJMerpMg5Y9fPzSrxww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OfoqE+D9Oa+F9naJajiYx8E0BLniKkz2b0H45SRVIKw2lCsuNVpTmCa8obQNIAUrJ6j4EndU0TS5gCi+knO2y9Xj0uE1dniT5yJ0Kmrj7Gsl794PwNssZkMwe/XVa+9ySeB3loTOg9icn1IrCtyic9tbpftgZZFPjp15+I0C/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvyMudzV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774612555; x=1806148555;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=6alnfp2vPlDIbbpKbsDyRVgTxJMerpMg5Y9fPzSrxww=;
  b=ZvyMudzV48qvKwePKvJhl5ARJPqRHunzMGgZI9NQZIqltyuEAQcfoF/7
   FOmPCSRUQ/PsNepVkiUXu7+ubZfDOdElQsDUw1lxEXC0KkbvnUDJ9M3Eg
   kdiQHYBP7XU9Z1xhRtsM3hj+uU/Gp/aZPwOp4hUhYMnxTYmEUcKok92x8
   JyXwOhvm2rC9OOuVCjT3q/DjEAiLpoRs+Quc9kKKb6EaCNGam8zEyd2F6
   JVuJihoXCMHj42gcq1Y1hdl4p8wVqwhsz67TNsipEgSc6fEoGNKRv3b6e
   cXmOu2TR8uJhtan1cdxVuMHXmvwK8lMTA3ZZq+sG3af2xE/sWKGlUeh/t
   Q==;
X-CSE-ConnectionGUID: YN55DHdCSJa5ERBHTQ9iTw==
X-CSE-MsgGUID: Soi3qsLNTOuLDYF0+5ptYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="93265147"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="93265147"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:55:55 -0700
X-CSE-ConnectionGUID: smU4y3vLSjmQmROvntxNYw==
X-CSE-MsgGUID: IZAiiKn7TsquOdvJ2lmvVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="225543135"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.226])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:55:52 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jouni =?utf-8?Q?H=C3=B6gander?= <jouni.hogander@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: Jouni =?utf-8?Q?H=C3=B6gander?= <jouni.hogander@intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/psr: Do not use pipe_src as borders for SU area
In-Reply-To: <20260327114553.195285-1-jouni.hogander@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260327114553.195285-1-jouni.hogander@intel.com>
Date: Fri, 27 Mar 2026 13:55:49 +0200
Message-ID: <c2900e8eea468da57356e5d6472ea09a22553446@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230643-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 31697343DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026, Jouni H=C3=B6gander <jouni.hogander@intel.com> wrote:
> @@ -2866,6 +2867,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic=
_state *state,
>  	struct intel_crtc_state *crtc_state =3D intel_atomic_get_new_crtc_state=
(state, crtc);
>  	struct intel_plane_state *new_plane_state, *old_plane_state;
>  	struct intel_plane *plane;
> +	struct drm_rect display_area =3D { .x1 =3D 0, .y1 =3D 0,
> +		.x2 =3D crtc_state->hw.adjusted_mode.crtc_hdisplay,
> +		.y2 =3D crtc_state->hw.adjusted_mode.crtc_vdisplay};

Nitpick, following the kernel style here actually improves clarity.

	struct drm_rect display_area =3D {
		.x1 =3D 0,
		.y1 =3D 0,
		.x2 =3D crtc_state->hw.adjusted_mode.crtc_hdisplay,
		.y2 =3D crtc_state->hw.adjusted_mode.crtc_vdisplay,
	};

BR,
Jani.


--=20
Jani Nikula, Intel

