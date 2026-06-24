Return-Path: <stable+bounces-268145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UDmvLam+O2p+cAgAu9opvQ
	(envelope-from <stable+bounces-268145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:25:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE16BDA18
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:25:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="BYrm/AIU";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268145-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268145-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A09F63026765
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841C2DAFCB;
	Wed, 24 Jun 2026 11:25:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AC1DF736
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 11:25:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300326; cv=none; b=me+Nj559AvWFdXz3xgRI1Lg8qOz2dUXhs9N3Nn8ls8HZxlYDC5PwcHpjbGh2ogqvU3PjCWneI4tAOvdpCAoVLdSsLQ4XiKKbtjy0l9UugbM7P8C/Ue1gmYmHffpw4aiEo+IcluogHdtpzeGLe38Iktvs3StH0/cWpiOPcD2VfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300326; c=relaxed/simple;
	bh=m0LGuB5FkxF5rC95tT6VWj2lo/0s5OKsb2zVG5v554c=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=aYgSnTaEk6Oats88jp8cKAs1ALF6j7NNxnKINMsy7qvlmm87SHicW+k4pq5xO8wWm8AvMdyYsJwEoqa3vswUGzGmxMRpVxmp1fOye7BjR47OLa9IIiuDgFapAjUMbFZE1lcq446FFBfLh8u8GdLU5FOXgNn2gFtxiTSiyrnD10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYrm/AIU; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782300325; x=1813836325;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=m0LGuB5FkxF5rC95tT6VWj2lo/0s5OKsb2zVG5v554c=;
  b=BYrm/AIU47Ek5ZcO1OgEmX1ypyEmK2YPLV+02p0kI2UPhR7Fdw1PMWMZ
   4qLLkjZDtOAU2iIHTC2HmIKTufity5WKTwUiizfEIUo8AKLbIsABjMlAd
   yJMFD9jkoqzgpoRFe5U1NiihoBu4yGTpiL3fIBjO5+ey4K3KsmA0xHMDK
   CZnfmdmjAV+kGK7a0Rp0R3r0K3/v4ybOeAwyuqtybclFOgsJlDr3tnLTZ
   l6YNRjHPzbpGsYn94wtJGxMO987csrOC1aC8ModrLcxtB2v2ywcN+p/4X
   JrbofQ2kYRX6RZXKTXGqNv9TCGnqpYWDS6a2sq0rqVMx3nEv9TqLpKU7P
   w==;
X-CSE-ConnectionGUID: AdSJ+xAtRBaTB4b3bLNwXw==
X-CSE-MsgGUID: LFYYMwDNTLCF311FYkI5Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83179435"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="83179435"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:25:24 -0700
X-CSE-ConnectionGUID: fkOWmZXwQsmh7ccCZI1tXw==
X-CSE-MsgGUID: TqyTHdScRTOqgz9Z+GuXmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="279978009"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:25:22 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
References: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH] drm/i915: Return NULL on error in active_instance
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Martin Hodo <martin.hodo@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Date: Wed, 24 Jun 2026 14:25:19 +0300
Message-ID: <178230031953.112641.4817434529385736057@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.hodo@intel.com,m:maarten.lankhorst@linux.intel.com,m:thomas.hellstrom@linux.intel.com,m:simona.vetter@ffwll.ch,m:stable@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268145-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,jlahtine-mobl:mid,vger.kernel.org:from_smtp,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBCE16BDA18

Pushed to drm-intel-gt-next, thanks for the reviews.

Regards, Joonas

