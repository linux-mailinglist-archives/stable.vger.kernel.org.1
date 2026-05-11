Return-Path: <stable+bounces-245171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOViCG+iAWpKgwEAu9opvQ
	(envelope-from <stable+bounces-245171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:33:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B741350AF7A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22E06300A335
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E13BE620;
	Mon, 11 May 2026 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKuflpx4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568D3BD647
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492012; cv=none; b=M2bUrKQcjsovGvKFMUUMhqRH9oWRzc/a764JidN+eRb/2+6YQWpGGpywWnx1OZjUCh0/9VpNR04TT/GRqXxeZmsLjXwAyT0aONrPw4fw5utWTEjvBkE3nDNPUp48PQnNPHIXRQ0Wwa0x2/diF4v765e80iyL/CxltkYPsdhzwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492012; c=relaxed/simple;
	bh=Nxn/SJxFgpyHXhNu+xmkiMum9B7+qkLommG6kbe2hTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a6ryqIQ6qlafbomIIKCshrqopRy5C2YJ6/sdo87RCea/+EypJXGdKErQ4y0A6ZIMbjN0RqNEFRlyhn/eSksAE9zvYuVGrL70mYNXbJVc1PULXALauePjCVh0e61fL4z07K6xfFRwHbenEMfZfgdB1Zxst+CLyefn09D9YlTdjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKuflpx4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778492010; x=1810028010;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Nxn/SJxFgpyHXhNu+xmkiMum9B7+qkLommG6kbe2hTk=;
  b=oKuflpx4ss9kvxOozisGS+qdHjKihtTeMAQQ98MfjttgzHB1OX3GsTSE
   fNdh6o9Hzt92jXx9G76vFmru+oi8XcjXu99jrjn1elnFqtUmdxAiVwuZ0
   /DkRQgC1iDUoQrBV8Q5xqjgSe7tVHGgsUbzVxU888OckM6MmNiJcQT8m2
   tkewwO/TAHCo9ZDztERBEBLT3kp5MEbpj1ZXcD0s1Oe2LuyVIW5dp4YRk
   pf1BL0eDLyViUU/3Rn4dk5iDWfObN9Y2heVj3+oq6mU/rGxVIdrVh0T59
   F++6KXh0HNKove9oKHwSK/6fvgPVLl78Cl0NgcxNZpBXO540IOcFodhl2
   w==;
X-CSE-ConnectionGUID: vNwEQLgdTri5i5uoKWp25A==
X-CSE-MsgGUID: FgoYPLqKTCCNA5oLassOcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90751105"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="90751105"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:33:29 -0700
X-CSE-ConnectionGUID: zwhdx/fdQZSUhe4FLlBejw==
X-CSE-MsgGUID: SYQIv4xNSNWmwSjhhkCBJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="241376626"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.253])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:33:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Aaron Esau <aaron1esau@gmail.com>, intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, mika.kahola@intel.com, stable@vger.kernel.org, Aaron
 Esau <aaron1esau@gmail.com>, Marco Nenciarini <mnencia@kcore.it>, Imre
 Deak <imre.deak@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 0/3] drm/i915/cx0: fix PLL enable failure handling on
 Meteor Lake
In-Reply-To: <20260509162407.510539-1-aaron1esau@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260509162407.510539-1-aaron1esau@gmail.com>
Date: Mon, 11 May 2026 12:33:21 +0300
Message-ID: <cdf591ba648d7b3d6a4ae5fead14f5faa92e52ca@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: B741350AF7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,intel.com,linux.intel.com,ursulin.net,vger.kernel.org,gmail.com,kcore.it];
	TAGGED_FROM(0.00)[bounces-245171-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, 09 May 2026, Aaron Esau <aaron1esau@gmail.com> wrote:
> On Meteor Lake with a hybrid Intel/NVIDIA GPU setup, s2idle resume can
> leave the CX0 PHY MSGBUS unresponsive. When this happens, the PLL
> enable sequence silently fails: register writes via MSGBUS are dropped,
> the PLL never locks, but the driver marks it as enabled and proceeds to
> drive the pipe.
>
> The root cause of the MSGBUS becoming unresponsive appears to be the
> NVIDIA dGPU not participating in S0ix (addressed via the
> NVreg_EnableS0ixPowerManagement module parameter). However, the i915
> driver should handle PLL enable failures gracefully regardless of the
> trigger.

The way I read this is: There's an issue with an out-of-tree proprietary
driver, you can only reproduce the issue with said proprietary driver,
and the upstream driver should jump through hoops to workaround the
issue in the proprietary driver, in ways that we won't be able to test
in our CI. And the expectation to work around this upstream is because
you can't really do anything about the proprietary driver.

Is that about right?

Apart from adding a bunch of generic error handling code superficially
unrelated to the proprietary driver.

The reason the CRTC enable path generally doesn't have error propagation
is that 1) the allowed errors on atomic commit are *very* limited, 2)
nonblocking commits are even more limited, and 3) even on failures the
display pipe must be running.

You simply can't bail out in the middle of hsw_crtc_enable() like
suggested in patch 2.

See [1] for more. Also see parts about tainted kernels in [2].


BR,
Jani.


[1] https://docs.kernel.org/gpu/drm-kms.html#c.drm_mode_config_funcs
[2] https://docs.kernel.org/admin-guide/reporting-issues.html


>
> This series:
>   1. Fixes intel_cx0_pll_is_enabled() to check the hardware ACK bit,
>      not just the driver-set REQUEST bit, so a PLL that failed to lock
>      is correctly reported as disabled.
>   2. Adds error propagation through the DPLL enable path: changes the
>      .enable callback to return int, threads errors through
>      _intel_enable_shared_dpll() and intel_dpll_enable(), and checks
>      the result in hsw_crtc_enable() and ilk_pch_enable().
>   3. Makes the CX0 PLL enable path return -ETIMEDOUT when the PHY
>      fails to come out of reset or the PLL fails to lock.
>
> Found on a Lenovo ThinkPad with Intel Ultra 7 155H and NVIDIA RTX 2000
> Ada. Kernel traces before each crash:
>
>   i915: Failed to bring PHY A to idle.
>   i915: PHY A Read 0c70 failed after 3 retries.
>   i915: Timeout waiting for DDI BUF A to get active
>   i915: [CRTC:149:pipe A] flip_done timed out
>
> Aaron Esau (3):
>   drm/i915/cx0: check PLL ACK bit in intel_cx0_pll_is_enabled()
>   drm/i915/dpll: add error propagation to DPLL enable path
>   drm/i915/cx0: return errors from CX0 PLL enable on failure
>
>  drivers/gpu/drm/i915/display/intel_cx0_phy.c  | 54 ++++++++----
>  drivers/gpu/drm/i915/display/intel_cx0_phy.h  |  6 +-
>  drivers/gpu/drm/i915/display/intel_display.c  | 10 ++-
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 87 ++++++++++++++-----
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.h |  2 +-
>  .../gpu/drm/i915/display/intel_pch_display.c  |  7 +-
>  6 files changed, 117 insertions(+), 49 deletions(-)

-- 
Jani Nikula, Intel

