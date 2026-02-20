Return-Path: <stable+bounces-217542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNf/AfH5l2mH+wIAu9opvQ
	(envelope-from <stable+bounces-217542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 07:06:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 885CE164E44
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 07:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61517300F145
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2F2773EC;
	Fri, 20 Feb 2026 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fipWH8sZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62C237707
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771567598; cv=none; b=SDzSwTf03KTJvIBd0uLWWvOMcTkyA1n3x1qLIeJYWsPgnVBwdQ2u6jJMTyhXtXoXntXFo0RyPLlQjw4Jrs+RpJgqaiRbYGEGoIqyqTm5LCxfSEXfkgadEwYXhpAtB07xyQKtKBs0XIEh6zj8PJvh0qdUw6UOcz6nHp4U5TSARRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771567598; c=relaxed/simple;
	bh=BcVh7QoITwEkqqlbvdhlz2tR9z11qLDn4GSoqYaFwDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyA/CfYE20LVCm0LgOcf4ikvjHL5SGLHw2QBhZpr728lBmmyvuQG99/0dyfpCwPYV3ktX3ffi6vw5d4RZqtghVjAlgARvy3s/UEnmAIN4NNSd/3r1PMLuhrZR6hYyHIt9zWcIDrrki/qDVTbmupaERi6kVrKhJW6ay1ipBEqSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fipWH8sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A889C116D0;
	Fri, 20 Feb 2026 06:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771567597;
	bh=BcVh7QoITwEkqqlbvdhlz2tR9z11qLDn4GSoqYaFwDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fipWH8sZRf3blBBr14Z0J1HDAQvkwKKq+SbkPTI7laBCmWqEm2A+KdFMqtLeQGGw1
	 zvGLwjxWJQyhrHM1GXnQc28s0t6e0WDY+3vLeTyEaNYPimI87222dHAPsdnec3CkDi
	 C7TqEGbNP5T2mroszFFx1dmc7dKFiMCI48FFNW/Q=
Date: Fri, 20 Feb 2026 07:06:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Koen Koning <koen.koning@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] gpu/buddy: fix module_init() usage
Message-ID: <2026022016-creole-limpness-6ae7@gregkh>
References: <20260216111902.110286-1-koen.koning@linux.intel.com>
 <20260219213858.370675-1-koen.koning@linux.intel.com>
 <20260219213858.370675-2-koen.koning@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219213858.370675-2-koen.koning@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217542-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 885CE164E44
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:38:56PM +0100, Koen Koning wrote:
> Use subsys_initcall() instead of module_init() (which compiles to
> device_initcall() for built-ins) for buddy, so its initialization code
> always runs before any (built-in) drivers.
> This happened to work correctly so far due to the order of linking in
> the Makefiles, but this should not be relied upon.

Same here, Makefile order can always be relied on.

thanks,

greg k-h

