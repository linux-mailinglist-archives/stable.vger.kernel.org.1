Return-Path: <stable+bounces-217541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELulEdv5l2mH+wIAu9opvQ
	(envelope-from <stable+bounces-217541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 07:06:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E3C164E37
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 07:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E99223012BDE
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 06:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BDA2773EC;
	Fri, 20 Feb 2026 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ysOn/ZQp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC920237707
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771567575; cv=none; b=WPVGuK3WeV1KVqU+MJnLNVFDgxO+2BkWFnz+foT8J0CSWHfgrT7Ldce8fmfUBEnpfctF7NYy4dTYnGBux63yDu3mF8xw1Q0jruB+ZeSUWGc1ntAxqgMmaj4l9rJVwmp4hPKhmrHnv1wPI+ueA/uKu/s/D5Bn4n8Ae4BN64z100U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771567575; c=relaxed/simple;
	bh=K4J5kwrWG6Klaz0TWaWDwYqm9sura75BmlC5zDrxEic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdOkANVIv/657hJ1TEK26brvkdiyqR18OkeHXBFgpcCNsfU9vaT01oFg7vnn2eO4VvekhN8LzMyAxtQHTv7OBTrOUFrfuzzq8/s7PSaGoP6VSU15TbmCnMYen0CwUV7UutbDtJpoIIFz1GPZj5XqkHzKwLxx/4QeMw6R+YUjwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ysOn/ZQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E2C116D0;
	Fri, 20 Feb 2026 06:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771567574;
	bh=K4J5kwrWG6Klaz0TWaWDwYqm9sura75BmlC5zDrxEic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ysOn/ZQp+kpa+h+su/QdYoLZ9kPZfUB18kZEl0AJHkHijbDfpt0RdrOevuMjaVu81
	 l1PvMbTSwjKI86Bd9q1r25ghHZKdw5pWXi95I7G6jOF1Qg4KM01QWvN+HICS2qXn1A
	 3Z1DD67/W89jg84AxoptP8KaqH7t077dKwYf5hlM=
Date: Fri, 20 Feb 2026 07:06:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Koen Koning <koen.koning@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Chunming Zhou <david1.zhou@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm/sched: fix module_init() usage
Message-ID: <2026022007-radiator-schnapps-e557@gregkh>
References: <20260216111902.110286-1-koen.koning@linux.intel.com>
 <20260219213858.370675-1-koen.koning@linux.intel.com>
 <20260219213858.370675-3-koen.koning@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219213858.370675-3-koen.koning@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217541-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,nvidia.com,intel.com,kernel.org,amd.com,pengutronix.de,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 62E3C164E37
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:38:57PM +0100, Koen Koning wrote:
> Use subsys_initcall() instead of module_init() (which compiles to
> device_initcall() for built-ins) for sched_fence, so its initialization
> code always runs before any (built-in) drivers.
> This happened to work correctly so far due to the order of linking in
> the Makefiles, but this should not be relied upon.

The linking order of Makefiles should ALWAYS be relied on.  If that were
to somehow change, so many things will blow up.

But be careful, none of this fixes the issue if you use modules, so you
still have to have symbols resolving properly.


> 
> Fixes: 4983e48c85392 ("drm/sched: move fence slab handling to module init/exit")
> Cc: Chunming Zhou <david1.zhou@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: stable@vger.kernel.org

Why is this for stable if it doesn't actually fix a real issue?

thanks,

greg k-h

