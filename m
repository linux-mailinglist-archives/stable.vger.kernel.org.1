Return-Path: <stable+bounces-242167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJGLMOCJ82m74wEAu9opvQ
	(envelope-from <stable+bounces-242167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:57:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647F4A61C2
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FF03307DA8E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3442EEDD;
	Thu, 30 Apr 2026 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YczDOytn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9566365A19;
	Thu, 30 Apr 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568009; cv=none; b=VBe9BB0GYKoqS/Z/Bn2CILWvMALZugGzigMXMG9ANp/VpbYq8rxnwmIDEUGScqHISi2Jt25la2RG0Y7JmOwNR5+Jv2L6fw+KUkRqUXZAAwP/igoCXdmIanXhy3DE5xrVKsLnWp9oq/mq4endQ0L3Px25mcrPkgkeQMNy6TzuR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568009; c=relaxed/simple;
	bh=6w4iw2zeADltB653674XblRvf+VzLBCWAhzSrkTyIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc8K2G+6Eal3TpomyJz4KEzq27jManzxD3ut7uU3gUTT10vU1lQbSAT8MEcxIHJOBcG5dV9cmzISnFH7FtjiT8kxx5M02ve1LQ8yhWAZ5xdul0Z+OCi+FExe40A8vyPHF0j8klzcFu5vLGL7+4Wbz6Mgp0I3Dlo5anWnL4h7fYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YczDOytn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5421C2BCB8;
	Thu, 30 Apr 2026 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777568009;
	bh=6w4iw2zeADltB653674XblRvf+VzLBCWAhzSrkTyIYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YczDOytnbHOog3TjPbkM00wBTm9uVWcmzIEhrktmXn9L2VwRx+guepvsOhfePyoOo
	 pWZSxgu2MfGIZ/sDR7wPlrnddAvuZda1R1AH8KznjCxDIebL2aWrx75nF/20p6jbmX
	 ELqnxBz7IToZxa2YcVXlNHV0VU/VB5EZrpcclusI=
Date: Thu, 30 Apr 2026 18:47:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>
Cc: linux-usb@vger.kernel.org, laurent.pinchart@ideasonboard.com,
	balbi@kernel.org, w@1wt.eu,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
Subject: Re: [PATCH] usb: gadget: uvc: hold opts->lock across XU walks in
 uvc_function_bind
Message-ID: <2026043055-atlantic-boots-cc28@gregkh>
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
X-Rspamd-Queue-Id: 5647F4A61C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242167-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]

On Thu, Apr 30, 2026 at 06:41:04PM +0300, SnailSploit | Kai Aizen wrote:
> From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

Again, please use a real name/email address.

thanks,

greg k-h

