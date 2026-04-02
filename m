Return-Path: <stable+bounces-233022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFWkFCF2zmk6nwYAu9opvQ
	(envelope-from <stable+bounces-233022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:58:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D238A223
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3AC3302A2DC
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2BD3A3E69;
	Thu,  2 Apr 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwSxP2kY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EE2FAC14;
	Thu,  2 Apr 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137867; cv=none; b=fcjSIkAGzhkSx537/X8V2Y2HZxfUHKBwZxG3bQjwqGNliwOmmN2WxJ2RAX/cGTAAJq6SmkuRHOOv0HtcBCA/c0R63RAWrume2OAk0MygSXzQwgSJC8Kn9tBLKjST7ydH6gB8qrSdtk0ueuJIVI8IiUjeCmhwX+dJEGWKK42Aeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137867; c=relaxed/simple;
	bh=1LRa9JvqkRKk2y9M498eMMinGpQPt05KLNCp7fuuBMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjCvuMCrwxBwlAsJp7jtpp/ysL9vGavqIxRUNo8FY3CuHIPbZ9+ZjRwhVPJXzY9ttsFFVWIqFr6kLEmG1YZj0jWho0gPnmTduYqyjUmDle6OfswCtQlSE+KerQtwVbWBw0Sz3tjknALD8TnxjpzVo9ofSPWTSR4S4sJN32mQk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gwSxP2kY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68097C116C6;
	Thu,  2 Apr 2026 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775137866;
	bh=1LRa9JvqkRKk2y9M498eMMinGpQPt05KLNCp7fuuBMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwSxP2kYdK+TdDLp/8aPjFZZcU496XYeJCqYALUXSu9MAJ94lFyOBM4vXI+F5uoz2
	 jymMiRfS+N0NFcZVaMixVxhxoEe6UxOUPd83T4qNL+GNciaW7kap/Tb2WwktFkVAVG
	 roAsoEZAZieMFg26hp/mgBRR9670g57RxGLJdk+U=
Date: Thu, 2 Apr 2026 15:51:04 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: Re: [PATCH v3]  uio: fix uio_unregister_device
Message-ID: <2026040254-afraid-multiple-569b@gregkh>
References: <AM9PR07MB72044638C53C08909D71E12B8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR07MB72044638C53C08909D71E12B8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233022-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,nokia.com:email]
X-Rspamd-Queue-Id: A37D238A223
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Feb 13, 2026 at 02:10:43PM +0000, Igor Klochko (Nokia) wrote:
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
> This creates a racing problem when we are in parallel creating and removing uio
> devices. The uio-minor that is freed when calling uio_free_minor can be claimed
> by a subsequent uio_get_minor call. The problem is that the device_addi flow
> can end up triggered, leading to a sysfs directory creation; while the
> device_unregister flow has not yet cleaned up the sysfs directory.
> 
> This patch cleans up this problem by mirroring the registration and
> unregistration flow correctly.
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
> 
> ---
> v3:
>  - Updated email subject 
> v2:
>   - Fixed commit message wrapping
>   - Placed 12 char sha1 in "fixes"
>   - cc'd stable
> v1: https://lore.kernel.org/lkml/AM9PR07MB720434A2B0CC99BC0BDCD74E8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com/#
> ---
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c index fa0d4e6aee16..5dd137a85576 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -1125,8 +1125,8 @@ void uio_unregister_device(struct uio_info *info)
>         wake_up_interruptible(&idev->wait);
>         kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
> 
> -       uio_free_minor(minor);
>         device_unregister(&idev->dev);
> +       uio_free_minor(minor);
> 
>         return;
>  }
> 

Does not apply to the char-misc-next branch :(

