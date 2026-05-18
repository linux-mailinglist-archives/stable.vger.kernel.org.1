Return-Path: <stable+bounces-249285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGYGA5ARC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:18:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB1656D7AA
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4F1C301E4A1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499C481641;
	Mon, 18 May 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8O1xZ6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4283EF0B3;
	Mon, 18 May 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110193; cv=none; b=VM7e9AgD1p5jQJrgGZytq32iAuPlQNHJBvN+JJ9H5JvcZhRygJ50i4FA6Z3ATocKJ9wt2jl87UBIvKpraozhHmZ9mQxk6/knRoqM5XUaxG3+o9D9FewbnYd+eiIzpvNIY8i1AcI1mz+pO+FTTn9cN2awFNg5g7WwXpKZGncAqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110193; c=relaxed/simple;
	bh=vzWTlP3kV/s0WrkONdqr1IhqEI7kfy1mlq+6vTPh5Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUFMqpQaXTKvZKL2KNnRoGCi/fJHzObcL8gf8kAX0m1l/WrQo6q9zHbON/c1f3CeMf/jLHOARCQIBmihfvTB44xk2I9cXjKHUNAlh00E9XPrjJpL3dOzDUiBSMfdr7ZEhYZ8d+euGeVyEm1nHpc7NMkYEsKXWsh94fBnqvxTYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8O1xZ6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA314C2BCB7;
	Mon, 18 May 2026 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779110193;
	bh=vzWTlP3kV/s0WrkONdqr1IhqEI7kfy1mlq+6vTPh5Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8O1xZ6i8KOIcvjH6ysB+n2ghGmgJXVbqxmFWLfqwVjeHh1HBCARRV/tIERlBSqAa
	 DQisiN5lB8+ZdKpTohxVPtPP75WMky7QBVEhB0mGDDBWqfpabjTV+abNsDjwK6l/HM
	 uuMJcKAJ/yPE1jV5wO0aVJq3aLMCf6PX8QqjAi1k=
Date: Mon, 18 May 2026 15:10:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>
Cc: linux-usb@vger.kernel.org, laurent.pinchart@ideasonboard.com,
	balbi@kernel.org, w@1wt.eu,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
Subject: Re: [PATCH] usb: gadget: uvc: hold opts->lock across XU walks in
 uvc_function_bind
Message-ID: <2026051836-citable-overripe-4abd@gregkh>
References: <20260430152702.60771-1-95986478+SnailSploit@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430152702.60771-1-95986478+SnailSploit@users.noreply.github.com>
X-Rspamd-Queue-Id: 9EB1656D7AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249285-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,SnailSploit];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Thu, Apr 30, 2026 at 06:27:02PM +0300, SnailSploit | Kai Aizen wrote:
> From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>
> 
> uvc_function_bind() walks &opts->extension_units twice without holding
> opts->lock:
> 
>   - directly, for the iExtension string-descriptor fixup loop;
>   - indirectly, four times via uvc_copy_descriptors() (once per speed),
>     where the helper iterates uvc->desc.extension_units (which aliases
>     &opts->extension_units) to size and emit XU descriptors.
> 
> The configfs side (uvcg_extension_make / uvcg_extension_drop, in
> drivers/usb/gadget/function/uvc_configfs.c) takes opts->lock around its
> list_add_tail / list_del operations.  A privileged userspace process
> that holds the configfs subtree open and writes the gadget UDC name
> to bind the function while concurrently rmdir()'ing an extensions
> subdir can race uvcg_extension_drop() against the bind-time list walks
> and dereference a freed struct uvcg_extension.
> 
> Hold opts->lock from the start of the XU string-descriptor fixup
> through the last uvc_copy_descriptors() call, releasing on the
> descriptor-error path via a new error_unlock label that drops the
> lock before falling through to the existing error label.  This
> matches the locking discipline of the configfs callbacks and removes
> the only remaining unsynchronised reader of the XU list during bind.
> 
> Reachability: only privileged processes that can mount configfs and
> write to gadget UDC files can trigger the race, so this is a
> correctness fix rather than a security boundary.
> 
> Fixes: 0525210c9840 ("usb: gadget: uvc: Allow definition of XUs in configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>

We need a real name and a real email address.

thanks,

greg k-h

