Return-Path: <stable+bounces-269755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u1ilNip2QmoU7wkAu9opvQ
	(envelope-from <stable+bounces-269755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:42:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7F6DB651
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:42:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="XX+zf/ND";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269755-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269755-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5ECD309E59E
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45619405C5C;
	Mon, 29 Jun 2026 13:04:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E728640B;
	Mon, 29 Jun 2026 13:04:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738284; cv=none; b=tKecof8cwCP2kfkUzTlafsgRw2XEgoBaf3yIUYAjPjqFnAIgw7mf7CxXPGdcwQFIyUUF2Ve8FHFG4F2HxI4S5Mdm6P7WXRUXPcjHva+ZMmrtxmyDSuLJunrvgeg9jiJnjEmwu5YtP4RoY9z841O+fQDAHUHhBNVJM+n8s3AvSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738284; c=relaxed/simple;
	bh=roUq0HgZG2spQtmWxczSIxhaz13hGW5+fW0oDsAWTqA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=kDnNsAjMe/9GeiBmdzW3942q2TyfcuWkvjEQAhDxRTxAmcj2h/R1MK11mWVQeLFJDyhFP1Rc7gUly7zFWMnfrqih7w8b7rmc1pZX5BDJseujW5iI3XMbeDX68IaEsf2uFdgfr0MoCk+8ZDUtXASOSXzEQNQwGUhc+zI3nOD6wRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XX+zf/ND; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782738283; x=1814274283;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=roUq0HgZG2spQtmWxczSIxhaz13hGW5+fW0oDsAWTqA=;
  b=XX+zf/NDgkxptXcLW0pDRHDxcQ35Uw9BymjXTMdhG6LaGrVlc7OTW/8c
   0KJauRmXIq6yigq6MrTH3ZpuZGju4SnTzlFFXB/wk4gtwh/TQOGmJL5wY
   C2g0ay9qTBGj4WJuBezsfzz23Se/4jgeRaVkjRRoL7uSefMU2pAE3NHRk
   Z56pJmb9YoqXmdDthRJpClkCp5oSCSN6C6pvKkKjMg8iznr91qIRzCnIJ
   w2fwBTXoOBSmJCvHUSdDI1Qwj6yZAVRhfq6z7hV3x45XQ7q4NpR4eiC2I
   HyKmNyohJ/PRVzvFCQYszzmwfwLfzw6CX4giUeHNMUCrZyISGxypECn8Q
   g==;
X-CSE-ConnectionGUID: JfJWG2jdRAiRlJroOI82cw==
X-CSE-MsgGUID: XcmitjnYSluyPLTHEV1PzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83474565"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83474565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:04:20 -0700
X-CSE-ConnectionGUID: IwiEzdBrSuqY5afV3Yz3UQ==
X-CSE-MsgGUID: fSOm1UQaT2qxvSdmnuWphw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250255687"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:04:17 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260628140327.46842-1-vulab@iscas.ac.cn>
References: <20260628140327.46842-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/i915: fix kref leak in __live_active_setup error path
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: jonathan.cavitt@intel.com, tzimmermann@suse.de, kees@kernel.org, matthew.brost@intel.com, vulab@iscas.ac.cn, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
To: WenTao Liang <vulab@iscas.ac.cn>, airlied@gmail.com, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, simona@ffwll.ch, tursulin@ursulin.net
Date: Mon, 29 Jun 2026 16:04:12 +0300
Message-ID: <178273825261.121848.1051842737561955544@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jonathan.cavitt@intel.com,m:tzimmermann@suse.de,m:kees@kernel.org,m:matthew.brost@intel.com,m:vulab@iscas.ac.cn,m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:airlied@gmail.com,m:jani.nikula@linux.intel.com,m:rodrigo.vivi@intel.com,m:simona@ffwll.ch,m:tursulin@ursulin.net,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iscas.ac.cn,gmail.com,linux.intel.com,intel.com,ffwll.ch,ursulin.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269755-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8C7F6DB651

Quoting WenTao Liang (2026-06-28 17:03:27)
> When heap_fence_create fails, the early error path calls kfree(active)
> directly instead of __live_put(active), bypassing the kref_put path that
> would call i915_active_fini for proper resource teardown. This skips
> cleanup of the i915_active state while the initial kref from kref_init
> remains unbalanced.

Is this AI generated? It hardly makes sense. The object was just allocated
and initialized, unbalanced kref which will be freed is not going to be
issue here at all.

Did you actually look at i915_active_fini?

Real reason to fix this would be to avoid the debug_object tracking to
get out of sync. That should be in the commit message and not some
generic high level description that can be read from the code
change itself.

> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Fixes: 5361db1a33c7 ("drm/i915: Track i915_active using debugobjects")
> Cc: stable@vger.kernel.org

In any case, we wouldn't put Fixes and especially not Cc: stable code
for selftests which need special Kconfig to build and modparams to run.

Regards, Joonas

