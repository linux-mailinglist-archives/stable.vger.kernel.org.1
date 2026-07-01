Return-Path: <stable+bounces-270181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMxuMpgjRWq67goAu9opvQ
	(envelope-from <stable+bounces-270181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 16:26:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5236EEB61
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 16:26:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hEXwOwDz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270181-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270181-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2771631EA046
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF72D97B5;
	Wed,  1 Jul 2026 14:13:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4A2BDC05
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 14:13:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915193; cv=none; b=mg3O4aNMZtbf8+IQKteBsG/mmNlfTBVqIdA1xBCwKVEPpeY8w/qIXWMuSLZjjSxvMB75r0rna0UIwedyp0fQdh8/qHsocKKkCi+K49C3AtMQq5yB0GCWapkqIu6vf1jMGGr3Y8eefWpTq5YsDbLy2sTdW0YvRChJLdKiYb5cddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915193; c=relaxed/simple;
	bh=KlbfiRn3uqhHayNWgGpu6Kiz46CxXy9htw0ZGIE6KLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQEa/MFvzDBtwVTGdKwa5933iMy5pnHOwGosuLGE2n97CJoxalNs1mn0KDybNmlcZMYUhjCDh3qtNQmWZwm1daozaDf+CTvDaTZwm6NvpfJFWy/mE8b9UKBCeCLZvi04bhgETKwKZHZcJ20gwcuZCCk1mp9OXxNeuXoV+1xAJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEXwOwDz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6924F1F000E9;
	Wed,  1 Jul 2026 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782915191;
	bh=RfU7bZHw588z2tR//rNfbsQEpkucqzOcm8xzNYEhTQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEXwOwDzt6MuZoLzrdB/v9H/UPJKnYMciWL4Gu/xPMgRXJmRuxx3+BCQS01nXn9Yx
	 iTEC8gZU7DPOux4ZCq4pzSOo9FsgJ3gN2ptFiRMMRrc8QiD5tfSiKrtlijsJzzblx5
	 dbNmYSzj0lwH+2NgzNmnF7Yi5FEOMHC42dF+a2bDm6iG0dTlAsEMOdkJjR3ghgKQbr
	 ZqEMf/bnn7hshNKglnWx7HGQdnjZpzn7ioQt/6//viCffyEQsWy8SlXQg8c9DQ2IO1
	 jFsc5rQ9E0+Hl6JaEXfXnutlcoEgV5W4z5PAyIULZ+lrq17iTuChF/LzeScSIEwPu7
	 rTZ929i1AXumA==
Date: Wed, 1 Jul 2026 16:13:04 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, 
	Direct Rendering Infrastructure - Development <dri-devel@lists.freedesktop.org>, Martin Hodo <martin.hodo@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Fix NULL deref on sched_engine alloc failure
Message-ID: <akUcJk-H3BiTVP0L@zenone.zhora.eu>
References: <20260701114513.221254-1-joonas.lahtinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701114513.221254-1-joonas.lahtinen@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270181-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:joonas.lahtinen@linux.intel.com,m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:martin.hodo@intel.com,m:matthew.brost@intel.com,m:daniele.ceraolospurio@intel.com,m:tursulin@ursulin.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ursulin.net:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,zenone.zhora.eu:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D5236EEB61

Hi Joonas,

On Wed, Jul 01, 2026 at 02:45:13PM +0300, Joonas Lahtinen wrote:
> Avoid using intel_context_put() before intel_context_init() in
> execlists_create_virtual() as the kref_put() inside would lead
> to NULL deref on the IOCTL path when sched_engine allocation fails.
> 
> Discovered using AI-assisted static analysis confirmed by
> Intel Product Security.
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: 3e28d37146db ("drm/i915: Move priolist to new i915_sched_engine object")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

looks correct!

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

