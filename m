Return-Path: <stable+bounces-245172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NJgFUWmAWpDhQEAu9opvQ
	(envelope-from <stable+bounces-245172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:49:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44950B4EB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AA3430FC174
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA163C0626;
	Mon, 11 May 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyUgCP5H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249542A9D;
	Mon, 11 May 2026 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492245; cv=none; b=h2qOC1oInfvFpdglyKx6i50XEzJfhisKFkofcTzgSoC0Uxwv+qvu2Z8bq3vdWnrBD/kwawmvpKAqvGH9PD0L14zMbpv4oj6A9vRv8enbXHTEdsTU6EGr/aNSVSHJX6+xDAQXPdifRIurSWH2Vp5lJ9K2Bmx+dmBX1EJAsNZvgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492245; c=relaxed/simple;
	bh=uE+17b78z0Qiyo76rhPMbN96lTgTv0XUaXKXaGYQnSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZs/vSZOvRQR6ilkIcKfJcKQd1QuQZdaT4t2f2fi1mWXd2UlLSxPWiu5McdfSiWY2eK+hWG5YKj/iT0tiTru7xCtvS5/+KlOugSZNKfBIwy1zMfyquIpyBataGENSLsX9b3fos11iD/sJSbQA19yJwgowSvfuLTjVQOnZkr885Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyUgCP5H; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778492243; x=1810028243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uE+17b78z0Qiyo76rhPMbN96lTgTv0XUaXKXaGYQnSE=;
  b=HyUgCP5HukqRmWu5aX2B/Rj0frSd6U9TJe9/o1nUwf9OSaoJu20cT2sQ
   uSBn9m05ZBcO4OZYHiJ3LS+9JyuKCIHAJ3VfRUNkZwd1aKin/o18YG3xM
   Oh3GX/DNhmvicqCMsG2trvoLNsOPiNxS0kNjfUxMqhY76patEAJ1VSJXk
   b8jUDzV1Nqh8MIP+esrX303LpUiiLXcA+O5r1c94GI6ENjpOIIE5yIyqE
   YaBznalYlBVFakTFO0w95IVkOa0wdemKz0A2wEetYc44+Oi2eHLB3s7Yr
   zisSMPm1Ayt+XoDGj9fNg1Ghlja1/2U6RjcZslalb8H0vZhJ9W58f7+OJ
   w==;
X-CSE-ConnectionGUID: ucTvoYfESs6Rs4BupzlHLQ==
X-CSE-MsgGUID: MBqA4jRbSeC8NaJ0T+qXPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79396405"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79396405"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:37:23 -0700
X-CSE-ConnectionGUID: w+/odRwTQuOYXFLIjomajg==
X-CSE-MsgGUID: 9gZVm6/ARIqIgp0Nv32+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="236428556"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 11 May 2026 02:37:20 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4EA9B95; Mon, 11 May 2026 11:37:19 +0200 (CEST)
Date: Mon, 11 May 2026 11:37:19 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-usb@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/4] thunderbolt: harden XDomain property parser
Message-ID: <20260511093719.GR6785@black.igk.intel.com>
References: <20260415123221.225149-1-michael.bommarito@gmail.com>
 <cover.1777817011.git.michael.bommarito@gmail.com>
 <cover.v4.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.v4.git.michael.bommarito@gmail.com>
X-Rspamd-Queue-Id: CF44950B4EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linux.intel.com,intel.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-245172-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Michael,

On Sun, May 10, 2026 at 07:16:55PM -0400, Michael Bommarito wrote:
> Style cleanups only on top of v3.  Andy's three nits on 1/4, 2/4,
> 3/4 are applied; Mika's request to drop the duplicated on-wire
> entry struct in 4/4 is applied.  No behavioural change to any
> patch; the bug analysis and the gating in patches 1-3 are
> unchanged.
> 
> Three independent memory-safety defects in drivers/thunderbolt/property.c
> are reachable when an untrusted Thunderbolt/USB4 XDomain peer responds
> to a PROPERTIES_REQUEST during host-to-host discovery.  The peer
> supplies up to TB_XDP_PROPERTIES_MAX_LENGTH (500) dwords of attacker-
> controlled property block which the local host passes to
> tb_property_parse_dir() as part of the control-plane exchange that
> runs before any tunnels are set up.
> 
> Patches 1-3 are one bug per patch: u32 overflow in
> tb_property_entry_valid(), short-dir_len OOB+underflow in
> __tb_property_parse_dir(), and unbounded recursion in the same.
> Patch 4 is three KUnit regression cases exercising all three.
> 
> All three defects are OOB-read or DoS at worst.  No controlled OOB
> write is reachable through the parser; parse_dwdata()'s destination
> is a freshly kcalloc'd buffer sized by entry->length.
> 
> Operators who do not need XDomain host-to-host discovery can disable
> the path entirely with thunderbolt.xdomain=0 on the kernel command
> line.
> 
> Reproduced on v7.0-rc7 + CONFIG_KASAN=y + CONFIG_USB4_KUNIT_TEST=y
> via the KUnit suite in patch 4.  Pre-fix on a v7.0-rc7 + patch 4
> kernel: u32_wrap fails with a KASAN use-after-free trace in
> __tb_property_parse_dir() (the parser reads ~16 GiB past the
> block); recursion fails with KASAN + an Oops on RIP=0 as the
> parser exhausts its guard page.  dir_len_underflow returns NULL
> on pre-fix because the downstream content_len = dir_len - 4
> underflow makes the entry walk bail at tb_property_entry_valid();
> the UUID kmemdup over-read is silent here because KASAN-Generic's
> slab redzones do not flag a 4-byte over-read into the
> kmalloc-chunk tail.  Treat dir_len_underflow as the post-fix
> invariant pin; u32_wrap and recursion are the active pre-fix
> detectors.

Applied 1-3 to thunderbolt.git/fixes and the last one to
thunderbolt.git/next. Thanks a lot!

