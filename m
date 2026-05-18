Return-Path: <stable+bounces-249286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLRvFMkSC2o5/wQAu9opvQ
	(envelope-from <stable+bounces-249286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:23:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9E56D8DA
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40FA6305A702
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C33480335;
	Mon, 18 May 2026 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1DGK6j7M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A8481650;
	Mon, 18 May 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110196; cv=none; b=Bi7vBOewM1PX9yefSmB/8UlB4DoB/jAuNXbL6ZayNXBdvqngu3Tnr/+30m9Ft5jLRldILjZFWQmHueco0vb/XpzIwxNqSntFTp8dKzxC2WfPsod2r+Mji/5AFjz+/B6fohkaG/ziukqB0jOaGm91jiIuHWftNuxGkg0DTsY21go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110196; c=relaxed/simple;
	bh=XfuwFfgb2Gqx7EPfyuGOTI5wvqO8XsKVRHP54WZD1PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCCxynhspwgHVxuF98iJERCZAPnFLIbVfTUadq9SA/FeblPcU2eiNIxPuaFzj07rfEvZptKZgl6Vted6Qtyw/SaVy/BsqAFbVmh/xydVyctL7rrvHtXnGQzkh+tTi+9oQwZ3DCmxCGqyweqjrseOXA5WtYcuP03lD2jH5xZWZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1DGK6j7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD83C2BCB7;
	Mon, 18 May 2026 13:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779110195;
	bh=XfuwFfgb2Gqx7EPfyuGOTI5wvqO8XsKVRHP54WZD1PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1DGK6j7M9lGwRI4VjwY54ArGEDqdUD+4KHGpIKCeKkPLd4R/aVfqUWpLH1bgz8LXq
	 KOLZbxTKSRX3dFZDgb86oMaGFjA+l/opzI16r8JWHj236om/o0wirZfhodg8BsdWnd
	 XwON0g2HnXFt5XoKO3gNvYI65QkKfCUam4HXzY4E=
Date: Mon, 18 May 2026 15:11:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>
Cc: linux-usb@vger.kernel.org, laurent.pinchart@ideasonboard.com,
	balbi@kernel.org, w@1wt.eu,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
Subject: Re: [PATCH] usb: gadget: uvc: hold opts->lock across XU walks in
 uvc_function_bind
Message-ID: <2026051856-unfunded-sandbox-720e@gregkh>
References: <20260430154104.61633-1-95986478+SnailSploit@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430154104.61633-1-95986478+SnailSploit@users.noreply.github.com>
X-Rspamd-Queue-Id: AAC9E56D8DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249286-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, Apr 30, 2026 at 06:41:04PM +0300, SnailSploit | Kai Aizen wrote:
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
> ---
>  drivers/usb/gadget/function/f_uvc.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Did you send this twice?

Still need a real email address.

thanks,

greg k-h

