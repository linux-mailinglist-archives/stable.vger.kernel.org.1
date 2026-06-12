Return-Path: <stable+bounces-262897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fKrCIufOK2rCFQQAu9opvQ
	(envelope-from <stable+bounces-262897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:18:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C96782F4
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:18:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oNKKriFS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262897-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262897-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6C51300623A
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610237F006;
	Fri, 12 Jun 2026 09:18:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71B363C45;
	Fri, 12 Jun 2026 09:18:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255905; cv=none; b=PkRqrPYEY3M7xxfP1ijLr0y2vEbWBmcED5DYd6N3Yp6jQj2AgRm0dvDyiB/oYwl1mSTGu0GdUvMHZBW8rQgwsYOavVrOUAnAGo7AHdVIWZhf6ZhNIr+lPv7bGuAS388NH2731KYLP/sc0QHMqLtA+ZGFzWLjpL9QWhkq6G0COYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255905; c=relaxed/simple;
	bh=p6mLgEebamRSmFLInTmIJ8H8nKUH3M3khSkpNIeMo10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKCgR+wTB/EMia2O2eEnvtT4adIBxm3kMpNxOc88dQZBXVnwnRtceZ56Bru6ZmrCU+X2+e0DHNDHuLwRstLpgMdXNvPBBgN1cHBhXUbUDoyyUAfEVBsDQJaYuCe62zSinrK4IZN4VQ80oKKa8qLi5XtPGnvDqh9qhiV0Xg/spYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNKKriFS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516721F000E9;
	Fri, 12 Jun 2026 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781255904;
	bh=+C4NgQq6SCabqH2BMmWykUbryNnQiXiiBgq8CnIfvUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oNKKriFSCHWU/6nj6/FY+Wsn/qE1UuPYL5xwMEsu9hbCAtOFk9MFnUkUpTwvaj27G
	 gPUWwE4zmNY8l4ThHGsQccuWydyXj2MKUSNrKJW0I86DFk3vn3dm4ijxea4CIFuH9X
	 4A9fvrmwbelc4d3iB5yYNcHh+6PbxydCqRbK/2FL4VF52oB0S5HKPMe9rSR/uYWRU2
	 wkihsEsQxcpPoJ/5b9D/P/SAz++9KXpk5TPcCzSykd+Ws5kgKnv1K7vzde4BX8mmrT
	 4mxsefEfFe0n2Rnhd0thsp7I3O+0hZajx/JJd4cxUPZsIpI+TW72L8DeMXSSXjsJSO
	 V+SwS6Dd9Ltbg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXy1u-00000002AFE-11eJ;
	Fri, 12 Jun 2026 11:18:22 +0200
Date: Fri, 12 Jun 2026 11:18:22 +0200
From: Johan Hovold <johan@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: fix refcount leak in xhci_port_bw_show()
Message-ID: <aivO3rqbF6Mkjoxs@hovoldconsulting.com>
References: <20260611132120.83185-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611132120.83185-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:mathias.nyman@intel.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 823C96782F4

On Thu, Jun 11, 2026 at 09:21:20PM +0800, WenTao Liang wrote:
> If xhci_port_bw_show() calls pm_runtime_get_sync() and it fails with
> a negative return value, the function returns the error directly without
> calling pm_runtime_put_sync(). This leaks the runtime PM usage count,
> preventing the device from ever suspending again.

A failure to resume to the device will generally prevent the device from
ever resuming again in itself.

> pm_runtime_get_sync() unconditionally increments dev->power.usage_count
> before calling rpm_resume(). If rpm_resume() fails, the usage count is
> not decremented — a well-known API pitfall. Add a pm_runtime_put_sync()

You are using pm_runtime_put_noidle() (as you should), not _sync().

> call on the error path to balance the reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 59d50e53e070 ("usb: xhci: Add debugfs support for xHCI port bandwidth")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Again, how was this issue found?

Also, "refcount" in the summary is a bit misleading as it makes it
sounds like you're fixing a memory leak. Please use something like
"runtime pm (reference) leak" instead.

Johan

