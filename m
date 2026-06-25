Return-Path: <stable+bounces-268582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id duZqDjZCPWqT0QgAu9opvQ
	(envelope-from <stable+bounces-268582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:59:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8326C6E14
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:59:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dXrhJzBR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268582-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268582-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B0C03037149
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446E3E7172;
	Thu, 25 Jun 2026 14:58:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC1331ECC;
	Thu, 25 Jun 2026 14:58:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399488; cv=none; b=CoSxAl7w9MQHZjHKo/Wi4Hxl9EAvrsvyQBdq/dvAvm7ry/Z0tCniyOTYFl6qMGWxwPfDurAjExCnkjKJMa0AMdtAYeIsrzhFQxDvAnB6yuuQq3AQRQkorIIszf9ytUYKx+LgjIbhTcZtHX7GampymjOOCVhPNbF9qDpfYC3Lqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399488; c=relaxed/simple;
	bh=pSb9HlCrDrSyzMM7xZNFv4Kr3g0QpIeruoin5cin0Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0vL4jZageepEEJaQavPVDn1Zq1kzfBKJInyC/c1QLdwvQwteoSQXHsAT/qU7ywYb2TEet08p9V6l7ga20ATrWMLvOac1UMk1c6jsRLQmXD8dVFm1/Xr7DFEN8qflWJ/IClxylnRDMhfQnESMG7snka1WhbCohhjEpmxZX0Fgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXrhJzBR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC04C1F000E9;
	Thu, 25 Jun 2026 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782399487;
	bh=MNZWLCYE4VmycRO819/fu330j9HLVM2sZRLtKNHCeqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dXrhJzBRb7Y255wkmBApyv01HkNQ9rk0oy7SBnqs6NdpMt5Ua0F2wEg9cOsFGmaK8
	 t7vhgvS+AHqSFqICcfnNNGns6SqCG7iIBcfQaXWmCMbQ4DwhZ0DMYm10y1R351fPfm
	 859XO0OoUz/+jpt8Vg2LqpzPGD+AFOWZVAgvt7WE=
Date: Thu, 25 Jun 2026 15:56:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: digi_acceleport: fix hard lockup on
 disconnect
Message-ID: <2026062550-facelift-happiness-7279@gregkh>
References: <20260623151110.315126-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623151110.315126-1-johan@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268582-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,gregkh:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA8326C6E14

On Tue, Jun 23, 2026 at 05:11:10PM +0200, Johan Hovold wrote:
> If submitting the OOB write urb fails persistently (e.g if the device is
> being disconnected) the driver would loop indefinitely with interrupts
> disabled.
> 
> Check for urb submission errors when sending OOB commands to avoid
> hanging if, for example, open(), set_termios() or close() races with a
> physical disconnect.
> 
> This is issue was flagged by Sashiko when reviewing an unrelated change
> to the driver.
> 
> Link: https://sashiko.dev/#/patchset/20260610132232.356139-1-johan%40kernel.org?part=1
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

