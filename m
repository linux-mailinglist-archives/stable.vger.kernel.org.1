Return-Path: <stable+bounces-253750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKAxGjUxEGoaUwYAu9opvQ
	(envelope-from <stable+bounces-253750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:34:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F35B2320
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B18A5311FC7D
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AD13D301D;
	Fri, 22 May 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yjkplV74"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EAE3CAA3B;
	Fri, 22 May 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445177; cv=none; b=DcIwSAUflZQBP8B+mxHRhPrm9s7cTMS/fbOWiLQXTTsbZV9hy/7fW5xvRl9j2F9UXO47RlC6DJ32cFjwxj80j836lXIZmCTUwN/AUsmXxfl1EIkUzTFf7xWXhbJUtoz+4tcDeJMPiU0/vPC71H1Em6s5MC89XzL5JW/Zm2wPkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445177; c=relaxed/simple;
	bh=IYQttLAb7DC19IlEa1/llayvCzGXhsaO5IiZP8nsJWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npWRP7mr/OhZotBSFFuQ4XmTLbS5CQCc8sbgkhR4CC40FRkhKFtPw4tILrWaKynVMii0xeeIfBlgbr/hSrm1/PjZC2CmBaqHduG84X5eHmCVZOjUBfqHOJmub0vVA640HrdHrlAE53pS/2FqBQ/3gqL6zHnV4dX49RVAXjO93xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yjkplV74; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACE91F000E9;
	Fri, 22 May 2026 10:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779445175;
	bh=SO9N4L4HD65n3H/9XHdb1BnHVQRtgz+9srBg0MgmKGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yjkplV74D1xlGH+wSmCxYM45TEnGYRnIPwZqEA8ozILFmHonB+MViFTOEkAk8ygMr
	 Vz9tr2LZjWji4JHrhQSuVEM8rnIBCDptNd3MFmHIeykWxwLIhztJcAMr2VaUHy36TV
	 BUUpzVGJNNog+NlmHl3usgHOTDhXlyhQRsUGUL/g=
Date: Fri, 22 May 2026 12:19:38 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: Re: [PATCH v5] uio: fix unregister_device
Message-ID: <2026052225-unawake-launch-aa62@gregkh>
References: <0e82fc96-d6c6-4383-ae96-1accfb40d5c6@nokia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e82fc96-d6c6-4383-ae96-1accfb40d5c6@nokia.com>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253750-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DB7F35B2320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 11:34:26AM +0000, Igor Klochko (Nokia) wrote:
> uio: mirrored uio_register/unregister_device
> 
> When uio devices are created end removed in parallel, then we sometimes
> encounter kernel traces along the following lines:
> 
>   sysfs: cannot create duplicate filename '/class/uio/uio899'
> 
> which stem from:
> 
>   sysfs_create_link+0x24/0x50
>   device_add+0x2f0/0x780
>   __uio_register_device+0x18c/0x550
> 
> The sysfs directory creation is performed synchronously as part of the
> device_add call. The high level sequence for uio registration is:
> 
>   1. uio_get_minor (idr call, in critical section)
>   2. device_add (leads to sysfs directory)
>   3. manage attributes (popuplates part of the sysfs directory)
> 
> For unregistration we have by default the following flow:
> 
>   1. clean-up attributes
>   2. uio_free_minor (idr call, in critical section)
>   3. device_unregister (cleans up sysfs directory)
> 
> This creates a racing problem when we are in parallel creating and
> removing uio devices.
> The uio-minor that is freed when calling uio_free_minor can be
> claimed by a subsequent uio_get_minor call.
> The problem is that the device_add flow can end up triggered,
> leading to a sysfs directory creation; while the
> device_unregister flow has not yet cleaned up the sysfs directory.
> 
> This patch cleans up this problem by mirroring the registration and
> Unregistration flow correctly.
> After this patch, the unregistration flow becomes:
> 
>   1. clean-up attributes
>   2. device_unregister
>   3. uio_free_minor
> 
> Fixes: 0c9ae0b86050 ("uio: Fix use-after-free in uio_open")
> Cc: stable@vger.kernel.org
> Signed-off-by: Philippe Belet <philippe.belet@nokia.com>
> Reviewed-by: Igor Klochko <igor.klochko@nokia.com>

The author has not signed off on this :(

