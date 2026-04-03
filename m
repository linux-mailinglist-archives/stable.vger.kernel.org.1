Return-Path: <stable+bounces-233165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCroDUOPz2kzxQYAu9opvQ
	(envelope-from <stable+bounces-233165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 11:58:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB13930FB
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 11:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1787A309E03B
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE3E3A7588;
	Fri,  3 Apr 2026 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFXzBAJt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D293921CD;
	Fri,  3 Apr 2026 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209950; cv=none; b=jgJ4uJpR8AWJLUc930Q1/GbySIXkm2q30x7/xBIhInzqf+csveFsvDG2SpwX6r52ouzDLVXgxUwjcq0WFKj88NmwwBnCeMe4zX2Mc91YwBSEi+avLlsK0XnsMS4MutHKnSCdyYpyZJEu3UJljQ1lCG6F1NrVp2FP8LAnuZUDALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209950; c=relaxed/simple;
	bh=xiVT3gj/2E+pbcwqXN32TQj4dBsR1wOkLVWLoPsjit0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8j6pjFFpCwIhJRsWMji8LP88RoP7CTAaMf62Ox3Lzim0aMnL24YU3HZ1hl3RWFDVRugQN6tO+Lw4Mm1gWcOjNWPtcB9YM+SZrhInLULJSYUR5OAxe+NfzUiIdEzBOV/31gKhCzXgmFyU6vPgHz0uEpe/qoW+lGo9u1/0VbUlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFXzBAJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92BFC4CEF7;
	Fri,  3 Apr 2026 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775209949;
	bh=xiVT3gj/2E+pbcwqXN32TQj4dBsR1wOkLVWLoPsjit0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFXzBAJt2ddUEyUQ/YRZn4xFCcf7zpjcZFo86tApebE3YqWw9diNizTS69eYCv4Re
	 efXTlIMhteOKh2IjTvVQwIC3GBA0jKTMbZmdZqivTW0Po7S4gwvZlGORvjlOif8oko
	 5H5hbbNYitGhTSmZfS1SoNWQdXkudiNmS3gt/Xtc=
Date: Fri, 3 Apr 2026 11:52:19 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: Re: [PATCH v4] uio: fix unregister_device
Message-ID: <2026040353-nautical-struggle-f43b@gregkh>
References: <8927c7a9-e23b-4a02-a88e-1eb47fe287e6@nokia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8927c7a9-e23b-4a02-a88e-1eb47fe287e6@nokia.com>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233165-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:url,lore:url]
X-Rspamd-Queue-Id: CCBB13930FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 04:19:09PM +0000, Igor Klochko (Nokia) wrote:
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

You sent this patch, so you too must sign off on it.

> ---
>  v4:
>   - reformat the patch
>  v3:
>   - Updated email subject
>  v2:
>    - Fixed commit message wrapping
>    - Placed 12 char sha1 in "fixes"
>    - cc'd stable
>  v1:
>  https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
>  .kernel.org%2Flkml%2FAM9PR07MB720434A2B0CC99BC0BDCD74E8D61A%40AM9PR07M
>  B7204.eurprd07.prod.outlook.com%2F%23&data=05%7C02%7Cigor.klochko%40no
>  kia.com%7C065fe0dc34a742a815d208de90bee494%7C5d4717519675428d917b70f44
>  f9630b0%7C0%7C0%7C639107346738079714%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e
>  U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIld
>  UIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=2h7wcsPPy0iiFG0jCYCTgl3iRzan%2FSIP2F5
>  xDJrzHc4%3D&reserved=0

Not really a valid url :(

thanks,

greg k-h

