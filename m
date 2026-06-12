Return-Path: <stable+bounces-262896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0NNOGOPNK2p3FQQAu9opvQ
	(envelope-from <stable+bounces-262896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:14:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC4467824F
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:14:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FFo6c/gw";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262896-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262896-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64FD2319F970
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20102369203;
	Fri, 12 Jun 2026 09:08:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C113B3019C8;
	Fri, 12 Jun 2026 09:08:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255329; cv=none; b=fORcVHzBfqKOjzsxiXMgUsI/3yx2grfxb6yP6syLWDY7GCua+R9HTWbozoz7wnLETjzlTH/8UCK7rqF8UtgpL/1Z29f1oVme+Ytg1dQodKBRMor+7bU/zETT9Oe/QTIW/7tgu5dK9C/TKn9JR0XxZDxPYDAjKvEosrH2afhxkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255329; c=relaxed/simple;
	bh=X0h9qzffs4Mr+jLbQ6wsfgUWcYZaSs/OHsx1tSguQhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESEz5m5y3cYI58i6eL+lOUok2ZpO3lpXo8Q0Nq68BTU+0OwpIxHBRsQx4njBjjDkOitRLKnMMKBwJaUNporkMpz1rxbyqaTHGPdLoQONs8q2J70r57nx8fFV89hU/bg7wNmTD9XTsS/tih/Pmdt+vvMj/V7azXmKGqWF2qnchNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFo6c/gw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C4A1F00A3A;
	Fri, 12 Jun 2026 09:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781255328;
	bh=uFe+jQS8ife+ArR1PefA5xIjFY5vP2b+bv7MvqxNs90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FFo6c/gwD5+/iMeteUmloxED+zhI1Jsefq05Le1kipgpQnHu/2MhqurllCutE3XLq
	 wYxFJrjztv+7CGF+DguhK4C/ZQlkOGTG1rftY6t73Qbd2lNklOILx6n8pMNUDpm0iQ
	 tsK6OybAzAHvrYxFUy32m0j6P1FaZPRYWhMi0TRYdatebDbeKWfyq+X1b6duVSWUFB
	 ypdQFpq50xfdR6eteNidBnHOUgszRuyQfT6wIiL5XcNDWHmUZyNsiLvyHBhJR3jYEO
	 I213v0/uufi/t5ljalanAoJeMM7qMf7o9yA6RybVGjgQC7ixxt5AejlZ3rJ+zmzBQQ
	 V2LyLKSCWIfOQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXxsb-00000002A1O-4AO2;
	Fri, 12 Jun 2026 11:08:46 +0200
Date: Fri, 12 Jun 2026 11:08:45 +0200
From: Johan Hovold <johan@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
	mathias.nyman@linux.intel.com, khtsai@google.com,
	thorsten.blum@linux.dev, kees@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: hub: fix refcount leak in usb_new_device()
Message-ID: <aivMnTkZ-jTRH2Jy@hovoldconsulting.com>
References: <20260611130223.80884-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611130223.80884-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262896-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:gregkh@linuxfoundation.org,m:stern@rowland.harvard.edu,m:mathias.nyman@linux.intel.com,m:khtsai@google.com,m:thorsten.blum@linux.dev,m:kees@kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDC4467824F

On Thu, Jun 11, 2026 at 09:02:23PM +0800, WenTao Liang wrote:
> If usb_new_device() fails after pm_runtime_get_noresume() has
> been called, it does not release the corresponding reference.
> In the successful path, the reference is properly dropped via
> pm_runtime_put_sync_autosuspend().  However, when an error
> occurs during enumeration (e.g. usb_enumerate_device() failure)
> or device registration (e.g. device_add() failure), the function
> jumps to the "fail" label.  That error cleanup path only disables
> runtime PM and marks the device as suspended, never putting the
> usage count back.

> This results in a permanent imbalance of
> power.usage_count, preventing future runtime PM state transitions
> and proper device cleanup.

Not really, as the device is about to be freed. Sure, the runtime pm
usage count is never balanced, but it does not have any practical
implications whatsoever.

> Fix the leak by adding a pm_runtime_put_noidle() call before
> pm_runtime_disable() in the fail error path, which releases the
> reference without queuing any suspend work and appropriately
> matches the pm_runtime_get
> 
> Cc: stable@vger.kernel.org
> Fixes: 9bbdf1e0afe7 ("USB: convert to the runtime PM framework")

So there is no need for either a Fixes or CC-stable tag here.

> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

How was this "issue" found? Are you using some kind of static checker or
LLM?

> ---
>  drivers/usb/core/hub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 24960ba9caa9..05f1a4267aec 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2731,6 +2731,7 @@ int usb_new_device(struct usb_device *udev)
>  	device_del(&udev->dev);
>  fail:
>  	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
> +	pm_runtime_put_noidle(&udev->dev);

The reference should be dropped after disabling (so that the device
cannot possibly be suspended here).

>  	pm_runtime_disable(&udev->dev);
>  	pm_runtime_set_suspended(&udev->dev);
>  	return err;

Johan

