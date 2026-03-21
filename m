Return-Path: <stable+bounces-227656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOuEHK8vvmn3IgMAu9opvQ
	(envelope-from <stable+bounces-227656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:42:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82212E36FD
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91ED13035243
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 05:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456F035AC0C;
	Sat, 21 Mar 2026 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cFHPTFIt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A836359FAA;
	Sat, 21 Mar 2026 05:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071697; cv=none; b=pkWW/kQAcST7S9WCgI92SJFJ1fWsyww1dN9wd+OMbZQTnPjMMZZUl4Id8I5H87Fs+POy6c6WI+0KSyZMXrPfpDLAaPH+0VgzBc5H7T+muqgLC8N30L1NRZ7fksc+xgxOhv+pcPqF46tb1TPU9ZVhg+NmbSOyI1TPEo59/xzMC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071697; c=relaxed/simple;
	bh=BXIGdxMVeUnAUhuTpgulK+W7qGntXQqxJ6sZczyjNvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3JHUoArSN8PlP10bcMZTqWZmhsTlkDBf0iuhqvc2Obtv1Cdoqy+kqm0Y8Y5xPZSfiAZqv8Y2EuvA4212P0pW3kgyPr02vhNFamJ6TZvXZ+Ff9bclmXPrJSmLY9v5bf9wvNoYxg+P5urycp8K6nxPy5VjZoBmVghN8VNI+zysa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFHPTFIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B2BC2BCB0;
	Sat, 21 Mar 2026 05:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774071697;
	bh=BXIGdxMVeUnAUhuTpgulK+W7qGntXQqxJ6sZczyjNvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFHPTFItqtkoKV/58Yg88Fbt+l40mZvSsnzxIOk/7qjU5zG5NgDkcuezWjvWONv8e
	 g2TXA4Z8Jt11n5+PTEgH1E31MCWwD1cFPiBlY1aHYCosEu4ilB/MkXI7QylexjLjEe
	 VkilbTLai5ClwZUaPnMuSbGACOd8bEGl7Ibg7ptQ=
Date: Sat, 21 Mar 2026 06:41:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
Message-ID: <2026032152-getting-carmaker-29d5@gregkh>
References: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227656-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C82212E36FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 08:06:58PM -0700, Douglas Anderson wrote:
> The moment we link a "struct device" into the list of devices for the
> bus, it's possible probe can happen. This is because another thread
> can load the driver at any time and that can cause the device to
> probe. This has been seen in practice with a stack crawl that looks
> like this [1]:
> 
>   really_probe()
>   __driver_probe_device()
>   driver_probe_device()
>   __driver_attach()
>   bus_for_each_dev()
>   driver_attach()
>   bus_add_driver()
>   driver_register()
>   __platform_driver_register()
>   init_module() [some module]
>   do_one_initcall()
>   do_init_module()
>   load_module()
>   __arm64_sys_finit_module()
>   invoke_syscall()

Are you sure this isn't just a platform bus issue?  A bus should NOT be
allowing a driver to be added at the same time a device is being added
for that bus, ideally there should be a bus-specific lock somewhere for
this.

When a device is added to the bus, yes, a probe can happen, and is
expected to happen, for that device, so this feels odd.

that being said, your patch does seem sane, and I don't see anything
obviously wrong with it.  But it feels odd that this is just now showing
up for something that has been this way for a few decades...

thanks,

greg k-h

