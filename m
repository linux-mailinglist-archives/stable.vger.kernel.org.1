Return-Path: <stable+bounces-268139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3uBDKKwO2qObQgAu9opvQ
	(envelope-from <stable+bounces-268139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:25:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 232076BD54D
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:25:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="T5QH2w/h";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268139-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268139-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A6A63033EE6
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66725DB0D;
	Wed, 24 Jun 2026 10:24:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56823D7F4
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 10:24:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296692; cv=none; b=OgmjCu8ymFhY3pq4yRSKxlp8JT3V+ccl8vUU30i+gs1wmRFw/Mk0g93FXKoMLPrIItb80YELorphezO1XEwMMXoyKwzDYsotlDUjyioP+2KfPAhIOj3GX8YG45FXYM+7bqt/kfFX23uuJIXiF5uK0qugC90a4LhmaAkKoYH/Rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296692; c=relaxed/simple;
	bh=5Mey65aFEMMsVLYRqQkLW5v1sN0ij2YCq1EqZjWXdng=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Rd01fkHWDwCyBEBznC+cEgIjYWxcTNov2Y6vh+gKMjgfd08C/FuDaoVT+KVXLCCDrs5viPNzgHa3T55BsnLr1OvOcz3alCk0WJpK7J53QYUX+jeSINrVmfq2kU2RSTdigYsD9dgKt91oE8wPUfFmIdt+jNBHFqaiG6UvB3YZYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5QH2w/h; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782296690; x=1813832690;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=5Mey65aFEMMsVLYRqQkLW5v1sN0ij2YCq1EqZjWXdng=;
  b=T5QH2w/hM1c1wAgl2ja+P2DOLoPv+mMe2axJjZc+grrI1UEtHcX54uE2
   SrqRE1ThY0YbvQZSlDXnpd44svB2m3L0YXIZp89L41cQA0o0bdHZBUemC
   7VZaehg+ym2QCKTsLXxrlLaPvEdEM/nqEaeWm6O2TL96m5WgPl784Kc4g
   CcycSyta7XiEunZ9KDKqEJ91+353hVAVYYFZzKpQUHuRrW6Nj2XlvEOX0
   ur4p7xiPF0X9VtKKl1/LXDa2l/asj2Pi8fUF+AyUxNGTiQRtzI1JYxlT8
   cjDoNaLzJA0z3Q6/vK/5st4J6C/lcdlajao27wLWh27YVQv3cXX24SQy2
   Q==;
X-CSE-ConnectionGUID: O1yquWoLSqKPRvojegT8Bw==
X-CSE-MsgGUID: e5yBgEbNQuqt3L8plAl2hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93651635"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="93651635"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 03:24:49 -0700
X-CSE-ConnectionGUID: 9yUWxfg3QY+DmmslQGYWdw==
X-CSE-MsgGUID: QHjZWvbwRI6DZnFG3U7AgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="243420969"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.147])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 03:24:47 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DJH67X9IJD3J.1YRKHO7I0JSZF@intel.com>
References: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com> <DJH67X9IJD3J.1YRKHO7I0JSZF@intel.com>
Subject: Re: [PATCH] drm/i915: Return NULL on error in active_instance
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Martin Hodo <martin.hodo@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Date: Wed, 24 Jun 2026 13:24:44 +0300
Message-ID: <178229668435.102045.3320967434448969310@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.hodo@intel.com,m:maarten.lankhorst@linux.intel.com,m:thomas.hellstrom@linux.intel.com,m:simona.vetter@ffwll.ch,m:stable@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:sebastian.brzezinka@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268139-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonas.lahtinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 232076BD54D

Quoting Sebastian Brzezinka (2026-06-24 12:27:07)
> Hi,
> On Wed Jun 24, 2026 at 11:09 AM CEST, Joonas Lahtinen wrote:
> > Avoid returning &node->base when node is NULL due to OOM
> > during GFP_ATOMIC allocation.
> >
> > Discovered using AI-assisted static analysis confirmed by
> > Intel Product Security.

<SNIP>

> > +++ b/drivers/gpu/drm/i915/i915_active.c
> > @@ -318,7 +318,7 @@ active_instance(struct i915_active *ref, u64 idx)
> >        */
> >       node =3D kmem_cache_alloc(slab_cache, GFP_ATOMIC);
> >       if (!node)
> > -             goto out;
> > +             goto err;
> just a nit: this jump is not neccesery, you could return early.

We specifically want to embrace the onion error handling idiom with goto
rather than doing the spinlock release inline here.

Preferred error handling should look more like:

	if (!try_lock(lock))
		goto err;

	mem =3D alloc();
	if (!mem)
		goto err_lock;

	if (!bla_bla(mem, bar))
		goto err_mem;

	...

err_mem:
	free(mem);
err_lock:
	unlock(lock);
err:
	return ret;

Rather than:

	if (!try_lock(lock))
		return ret;

	mem =3D alloc();
	if (!mem)
	{
		unlock(lock);
		return ret;
	}

	if (!bla_bla(mem, bar))
	{
		free(mem);
		unlock(lock);
		return ret;
	}

	...

Regards, Joonas

