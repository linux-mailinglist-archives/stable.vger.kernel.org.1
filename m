Return-Path: <stable+bounces-274125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qg8yMvTFVWrEsgAAu9opvQ
	(envelope-from <stable+bounces-274125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:15:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1807510DA
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aG8KdQ8w;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274125-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274125-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3CE3051D1A
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9638D2F7EF9;
	Tue, 14 Jul 2026 05:12:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E462F3614;
	Tue, 14 Jul 2026 05:11:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005921; cv=none; b=XujYHIEV70Ab65gkz+CXoP47e6CMWy8rT1db/arAdzT9JnNapnUFjOC4bN7sbjalPeork5rHe/paC3P8XP1FgKD6dcedcPKHkiDe0L/RJ/FwkOv8FUYCYzh17N+RKND73drMiDzLhvyDMAEN2MRnGaRIZ5hUb5hC2lrDKADdzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005921; c=relaxed/simple;
	bh=V+J5wcDt9BT4FocIidr/3kedEYLhbq3IG640h+4YwDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ0902db+/ZQVVXOBcCS91NshD9Fb0g5gmIJDoahvT+GxZE115tZCEOrZHWoiE4lE3w+a4R1/Ne5lNaN7yfpa4L71Rxck+Ibri9Ic/k8jNpgOJ2Fs91p1Tzb9NKHEBB4IduHeR/yabI5m6Zgwapyu5ssICiOzZv+uWuTX8szlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aG8KdQ8w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2CD1F000E9;
	Tue, 14 Jul 2026 05:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784005919;
	bh=9YQUitHq/d56p1N9YWz+5SWWA2J65cSwrWop/b6GfVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aG8KdQ8wrhhEtGXaHTdZYpPLTNgdjLvwaaHENqvNG+lDQRxG6Kpk8uRU2aWybw+nC
	 Xj0uo5jWQ7+7rQMj3qh2xXGQMsMb4g/f58MiD9GIpsxvrzlPxsSRk0Ees7F9VhlxLN
	 hETgpwDVffluGJs4UjVHUxKgHcqVZmA448CvptJ8=
Date: Tue, 14 Jul 2026 07:10:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jay Vadayath <jkrshnmenon@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [BUG] USB: serial: sierra: slab-out-of-bounds read in
 sierra_instat_callback() on short interrupt-IN packet
Message-ID: <2026071453-reminder-ageless-dcea@gregkh>
References: <20260714033729.11023-1-jkrshnmenon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714033729.11023-1-jkrshnmenon@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jkrshnmenon@gmail.com,m:johan@kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274125-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C1807510DA

On Mon, Jul 13, 2026 at 08:37:27PM -0700, Jay Vadayath wrote:
> Hi,
> 
> I found a slab-out-of-bounds read in drivers/usb/serial/sierra.c that
> is reachable from a malicious USB device.

Great, please send a patch for this, in a format we can apply, no need
for the LLM-generated wall-of-text :)

thanks,

greg k-h

