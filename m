Return-Path: <stable+bounces-270193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H2irAzUtRWoA8QoAu9opvQ
	(envelope-from <stable+bounces-270193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:07:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD476EF1D8
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:07:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZFHTizPR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270193-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270193-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B53A73034280
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9B3E075C;
	Wed,  1 Jul 2026 15:04:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4E3624B7
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 15:03:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918241; cv=none; b=WhL5bjT2oV9TKU8Gii7Ly9hUw1uoJUGLA2sW7ObUk0WT0I3fnQ85dkX7NklOU07gUwzlr/3FvfNpIcsSRiWKgpjgD/O6WpX/xZ2utSAwCSfhnPA7R7eFMSvO9DzIGeIkrHsHrmw6lVkssp8LGsITvm/d2TiJBADZLzrkIq5BDNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918241; c=relaxed/simple;
	bh=BJc5Ck+t4R7+Cmoyn9+Hj4gwInSo+1g1wsNYthpobtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXae+8fRT2i5P1pzDiMUzomalE+ZsxR9ltqkQZyIBoVCce7GLXQp28ega35AGMNxEzhxqqXvoYkMZ1Y9yDIKytU8xySfi3sffz3t/W8ZtiMWQPuTa4E7RIvqRKT5K+XoQpdWnCD4PPbEEmjm2Garq2nkleLfqptQuhVxCtQAeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFHTizPR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5081F000E9;
	Wed,  1 Jul 2026 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782918239;
	bh=zk1agxCFt6nBM0rrZXtqvdO2lHxzgZTETSU2JH6M4JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZFHTizPRHQweZY4aMchzZQHYcXubYszoHd/c8wNEcJTbsm7FIqbir23niTe0zpqde
	 UTc4ZRMUFiJQHzVSjL5NFdUDZK+xgg0KyKZ9umuLXaqDKFTQjklRJ/qPHHyLS0YpQm
	 szo68Jd4qddjgjPli5zXcNiCaRODPrSuPKTgTuj1JaeVe1hvc1fvuOcmlumbT+YQan
	 kXhvhO76xsEefJYJKtw04NVI+d3MsLOd+25b4N8bkgf3eZvnzc/983oX4NaLc4+ZZ8
	 jaFVSRa2hIT5JYk9V4rGbub5PVk+GYdlx9pi1AgU7RS6yRljC60pVx3O/JKUoxagwW
	 TJjmW3k/tKXXw==
Date: Wed, 1 Jul 2026 17:03:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, 
	Direct Rendering Infrastructure - Development <dri-devel@lists.freedesktop.org>, Martin Hodo <martin.hodo@intel.com>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
Message-ID: <akUqglq2Do3FF1GH@zenone.zhora.eu>
References: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270193-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:joonas.lahtinen@linux.intel.com,m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:martin.hodo@intel.com,m:faith.ekstrand@collabora.com,m:simona.vetter@ffwll.ch,m:tvrtko.ursulin@igalia.com,m:maarten.lankhorst@linux.intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,zenone.zhora.eu:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,igalia.com:email,collabora.com:email,ffwll.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DD476EF1D8

Hi Joonas,

On Wed, Jul 01, 2026 at 10:55:55AM +0300, Joonas Lahtinen wrote:
> Setting context engine slot N into I915_ENGINE_CLASS_INVALID /
> I915_ENGINE_CLASS_INVALID_NONE and attempting to apply
> I915_CONTEXT_PARAM_SSEU to the same slot N will deref NULL.
> Fix that.
> 
> Discovered using AI-assisted static analysis confirmed by
> Intel Product Security.
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

