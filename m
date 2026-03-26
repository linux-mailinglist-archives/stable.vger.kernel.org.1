Return-Path: <stable+bounces-230448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIA0OUcNxWkI6AQAu9opvQ
	(envelope-from <stable+bounces-230448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 11:41:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28B3339D8
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5953A30786FF
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4113C9EE3;
	Thu, 26 Mar 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hn1ToLLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63A3C13F8;
	Thu, 26 Mar 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521355; cv=none; b=ABGdA5aEZYPKseYV7gh9MX5AcSZ39/wseyLxrq8L8zcyIFotPMUxo7rAUY2sbzILV9EviP5pLvJNgyomgXq6XzxnJCccd4ejkJrUN3wJ813P4o0Bgm86ROa7RGdzffbOVMfT6CVBlQpkB502YI8OoElZp/hvvUkJkAl5o66gZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521355; c=relaxed/simple;
	bh=T+tLJajTyOj4cDuHYlCGpyyZ8ZAzb5glWR6e0jJZxUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2NIOSKWjojW6ng8GrBIqncREPMO26jWbc8XOdael9vfjZqbufwDgOqZ0kKkitQ+XUQs6wzQmFLmiMP689pKkhbi66KeJUKZfrcOeQSYgUBdwUUVh08f6dV4EolKyt+cJINEMrs3hc7kriHAL0hNSQl2KL8MFFJmZim/B2FNEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hn1ToLLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C138EC116C6;
	Thu, 26 Mar 2026 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774521355;
	bh=T+tLJajTyOj4cDuHYlCGpyyZ8ZAzb5glWR6e0jJZxUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hn1ToLLB2byk1NZDFwKzsUicxXfVcpJWB2UGJWqAAa6O6Mg1F6OCgCOm8+ZcdD7US
	 53YcIQH/1t1M8tTmiFuw0+K3ah+GP08177/30dA36jyr1uzLO5mNjciwPoA8wqedf6
	 aA4XdlPTkWshdiohafwCmMu92n8PqcGjGDctfrJ4=
Date: Thu, 26 Mar 2026 11:35:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dayu Jiang <jiangdayu@xiaomi.com>
Cc: Kuen-Han Tsai <khtsai@google.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: Fix race between gether_disconnect
 and eth_stop
Message-ID: <2026032614-most-opposing-4363@gregkh>
References: <20260311-gether-disconnect-npe-v1-1-454966adf7c7@google.com>
 <acTl6bUJTQp6kjCO@oa-jiangdayu.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acTl6bUJTQp6kjCO@oa-jiangdayu.localdomain>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230448-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9D28B3339D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 03:53:13PM +0800, Dayu Jiang wrote:
> On Wed, Mar 11, 2026 at 05:12:15PM +0800, Kuen-Han Tsai wrote:
> > A race condition between gether_disconnect() and eth_stop() leads to a
> > NULL pointer dereference. Specifically, if eth_stop() is triggered
> > concurrently while gether_disconnect() is tearing down the endpoints,
> > eth_stop() attempts to access the cleared endpoint descriptor, causing
> > the following NPE:
> > 
> >   Unable to handle kernel NULL pointer dereference
> >   Call trace:
> >    __dwc3_gadget_ep_enable+0x60/0x788
> >    dwc3_gadget_ep_enable+0x70/0xe4
> >    usb_ep_enable+0x60/0x15c
> >    eth_stop+0xb8/0x108
> > 
> > Because eth_stop() crashes while holding the dev->lock, the thread
> > running gether_disconnect() fails to acquire the same lock and spins
> > forever, resulting in a hardlockup:
> > 
> >   Core - Debugging Information for Hardlockup core(7)
> >   Call trace:
> >    queued_spin_lock_slowpath+0x94/0x488
> >    _raw_spin_lock+0x64/0x6c
> >    gether_disconnect+0x19c/0x1e8
> >    ncm_set_alt+0x68/0x1a0
> >    composite_setup+0x6a0/0xc50
> >
> Hi Greg,
> Hit the same issue during NCM switch stress test.
> Can you take a look at this patch and check if it’s ready for merge?

This is already in my tree and in linux-next and will go to Linus this
weekend.

thanks,

greg k-h

