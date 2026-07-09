Return-Path: <stable+bounces-272935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fmtJON6mT2oQlwIAu9opvQ
	(envelope-from <stable+bounces-272935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:49:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 486FB731C2D
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:49:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nqQtquNf;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272935-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272935-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D2903087A4D
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F83002DF;
	Thu,  9 Jul 2026 13:40:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50822E5B29;
	Thu,  9 Jul 2026 13:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604431; cv=none; b=lNuVnuxxA8Hu1+60p6FlxGvfwA2b1s06Gt/cc/z+whfOnNV9YcWn9Zi7ifuOfqzSB927qAr0Ja6P7L1ZuL0Z06KfLoeN8FJq7X7P7GtcgscOXcmSa2AlHySmbbB9FeiuiUzZGPjyOAtCmnR9eZ9PKldFPcJNf7SPK+hZ7JABdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604431; c=relaxed/simple;
	bh=jpefKvU0o97D+6rCm0jc5GzsU6oTwcJQuPrlRAo/6Mo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bg12xODBXsQxUPoP0eWDbQmQJazVdSKhO67XcRxkoBYw7wFUlBX4aBF5DvzRFfPKe5Kq1PCx1l0nLs/T7ODdmr/8YVzpK8n+mxZYICyoZhWNNBempCts4goyUoP3kvXTbJwOEFOZPTGTNRiSgPKcAX+fSUBkV/sWytKgA/gc4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqQtquNf; arc=none smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783604431; x=1815140431;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jpefKvU0o97D+6rCm0jc5GzsU6oTwcJQuPrlRAo/6Mo=;
  b=nqQtquNflnHdvAARjnTOk5wIW/rPYPHhYTz1y+TNT2s9do/QvMVp6HsG
   66LSlfAzaVENGhI30gXoy3XRPKsvWmQFeq2PyaKolcc5sjezsNE+PYffX
   poAKnKoRrGHg1a/XF1yFOHfvuSTc4DhgqOdFHeufY7Rsp6+0UYpGIzHIz
   LVNgDz1XX2FTGppakeWIseLqH2Q+ZyuWF5jWCDY3Nh4hRnSl3aGDrz5OT
   R6o2WbQY/8Nrnbu1ysyVgKGzmWk/5BZwGZAlrWJNIodyI4E/gKrOGmB6G
   SjBAZ7Y5OVJp3uUAWL2vpJC/BvCabcvUYgV2KMAqYUGBrQJvzC2rbN/nm
   Q==;
X-CSE-ConnectionGUID: IId8Z0fvQtideNiT/KcZgw==
X-CSE-MsgGUID: Y5leJyPXRk2xWpXjaNB8MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88199819"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88199819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:31 -0700
X-CSE-ConnectionGUID: m3gMdyMjQV+Npm09YUIV3g==
X-CSE-MsgGUID: UtZc74/3R8C/6cQiIwKdaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258195457"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, hansg@kernel.org, 
 mgross@linux.intel.com, sumesh.k.naduvalath@intel.com, 
 Ma Ke <make_ruc2021@163.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 akpm@linux-foundation.org, stable@vger.kernel.org
In-Reply-To: <20260624014910.1226446-1-make_ruc2021@163.com>
References: <20260624014910.1226446-1-make_ruc2021@163.com>
Subject: Re: [PATCH v3] platform/x86: ishtp_eclite: Fix ACPI device
 reference leak in probe error path
Message-Id: <178360442228.12613.11058614783929144446.b4-ty@b4>
Date: Thu, 09 Jul 2026 16:40:22 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:srinivas.pandruvada@linux.intel.com,m:hansg@kernel.org,m:mgross@linux.intel.com,m:sumesh.k.naduvalath@intel.com,m:make_ruc2021@163.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272935-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,intel.com,163.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,linux.intel.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 486FB731C2D

On Wed, 24 Jun 2026 09:49:09 +0800, Ma Ke wrote:

> ecl_ishtp_cl_probe() acquires a reference to an ACPI device via
> acpi_find_eclite_device() but fails to release it in the error path
> when acpi_opregion_init() fails. This results in a reference count
> leak, preventing proper cleanup of the ACPI device.
> 
> Calling path: acpi_find_eclite_device() ->
> acpi_dev_get_first_match_dev() -> acpi_dev_get_next_match_dev() ->
> bus_find_device() -> get_device().
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86: ishtp_eclite: Fix ACPI device reference leak in probe error path
      commit: e65e4242cd8babee019e575d85dd21261a68e4e2

--
 i.


