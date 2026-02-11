Return-Path: <stable+bounces-215773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL/RJbJJjGmukgAAu9opvQ
	(envelope-from <stable+bounces-215773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:19:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEFD122A5E
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4844D301370B
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F76350A20;
	Wed, 11 Feb 2026 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M5UzgdeW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0423346A5
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801581; cv=none; b=uBvN0424Ot6cLR17poI4Bus6Sq+2okTQUNk3oua7VCNxijQX+RMADfWedPd6WCDrjY7CGWbw5MDwoIEH0C/y2tPYFemgp7Jtj5TasxvYk/BGl62D09nWblj22lYgSU4kDmR1/3K88WnXkKlh6YW5lVOz0NdtKZeq6+ETBUBmKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801581; c=relaxed/simple;
	bh=58Z4uB9Pkeol6hTI7MeGr7wp1yT5hcTC8QqAYBryOUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ2aBeUq3XcMHoi7jK7OB+llCL7UbtRqQ9A2RfOkQHelY1YHJKbfrgY7SwD++pnVYG0aUcmqc77D2o1UxNYlbAa724EHB1zsMqf9NB62t2/ItPDmcBbJoXPLKF8EnnuKX+F0X17x9/RpxDLh8QKBBjubjAXeYCnB0GfbfF4sFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M5UzgdeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D646CC4CEF7;
	Wed, 11 Feb 2026 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770801581;
	bh=58Z4uB9Pkeol6hTI7MeGr7wp1yT5hcTC8QqAYBryOUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5UzgdeWozsUWlySaOYUfwVPWb5tNvgUx4Jz7Ar0o3Tf5GDnWXCe14TiuPNyX/x8e
	 OyT8z5Kz9bWqmS6r4uJAlrBKfOViNTICENxGnoWxx5kJBQ+tuSsxXInCirkk20r4vO
	 x3kpKmsWcKoqmAZFM0CavOjzN5HpVKZFNYNfyo14=
Date: Wed, 11 Feb 2026 10:19:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Michele Palazzi <sysdadmin@m1k.cloud>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com, sunpeng.li@amd.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	mario.limonciello@amd.com, Rodrigo.Siqueira@igalia.com,
	alex.hung@amd.com, aurabindo.pillai@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: add module param to disable immediate
 vblank off
Message-ID: <2026021146-mockup-pushup-5f47@gregkh>
References: <20260211074529.131290-1-sysdadmin@m1k.cloud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211074529.131290-1-sysdadmin@m1k.cloud>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215773-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BEFD122A5E
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 08:45:29AM +0100, Michele Palazzi wrote:
> Add amdgpu.no_vblank_immediate parameter to optionally disable the
> immediate vblank disable path on DCN35+ non-PSR CRTCs. When set to 1,
> a 2-frame offdelay is used instead, matching the behavior used for
> older hardware and DGPUs.

Please no more module parameters, this is not the 1990's with only one
one device in the system.  Please fix this the proper way.

Also, this isn't the correct way to submit patches to stable.

thanks,

greg k-h

