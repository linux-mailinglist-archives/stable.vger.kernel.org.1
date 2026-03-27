Return-Path: <stable+bounces-230576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI/tNCPxxWkkEgUAu9opvQ
	(envelope-from <stable+bounces-230576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:53:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E01D33E8E9
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7528A3039695
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C655F33D6FA;
	Fri, 27 Mar 2026 02:53:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67133C187;
	Fri, 27 Mar 2026 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579983; cv=none; b=rqBh6pGXQ6UyQoCQyH7QYfRJ1vxgxkxuJy9dWuOyZTb0eaxxdl+zsRDE2pIZVg/94lV+P/ZaCzEBQThDv9heDKI7xfwMx6TvXT2G0hRazRgU3lLIYhIp56U0HQcIn6rO3y6jlSAabzuSIAR5Lu/oYVKnlR6+7nnpTdNEXdxUh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579983; c=relaxed/simple;
	bh=9Gm0h2I4XBohDWuXDCNOcBA6Edwdde7TG1q92CZfBKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C15/isNSB/3ZZ9g7Pm+XpFMCJV3dcECCqqPcw3Z91yv0jn/mTYygz9CYbUapxu/jb3bH0CUwLTKepa4kZL1EDZBKy3DURAhtHMtyfq4KJK+YFKDZh90xrM0OV27ShAUd8yxGfw6isBW6PFnQY5PisczYHVw6DcFUm9UTtSHHo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: S17c/odGTAaIByKdhKfwWw==
X-CSE-MsgGUID: wHrv/UYNSsu+iZLDe/Ogvg==
X-IronPort-AV: E=Sophos;i="6.23,143,1770566400"; 
   d="scan'208";a="144767818"
Date: Fri, 27 Mar 2026 10:52:58 +0800
From: Dayu Jiang <jiangdayu@xiaomi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Kuen-Han Tsai <khtsai@google.com>, David Brownell
	<dbrownell@users.sourceforge.net>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: u_ether: Fix race between gether_disconnect
 and eth_stop
Message-ID: <acXxCu5/8jcl0bMH@oa-jiangdayu.localdomain>
References: <20260311-gether-disconnect-npe-v1-1-454966adf7c7@google.com>
 <acTl6bUJTQp6kjCO@oa-jiangdayu.localdomain>
 <2026032614-most-opposing-4363@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026032614-most-opposing-4363@gregkh>
X-ClientProxiedBy: BJ-MBX02.mioffice.cn (10.237.8.122) To BJ-MBX03.mioffice.cn
 (10.237.8.123)
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xiaomi.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiangdayu@xiaomi.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230576-lists,stable=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 7E01D33E8E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 11:35:31AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 26, 2026 at 03:53:13PM +0800, Dayu Jiang wrote:
> > On Wed, Mar 11, 2026 at 05:12:15PM +0800, Kuen-Han Tsai wrote:
> > > A race condition between gether_disconnect() and eth_stop() leads to a
> > > NULL pointer dereference. Specifically, if eth_stop() is triggered
> > > concurrently while gether_disconnect() is tearing down the endpoints,
> > > eth_stop() attempts to access the cleared endpoint descriptor, causing
> > > the following NPE:
> > > 
> > >   Unable to handle kernel NULL pointer dereference
> > >   Call trace:
> > >    __dwc3_gadget_ep_enable+0x60/0x788
> > >    dwc3_gadget_ep_enable+0x70/0xe4
> > >    usb_ep_enable+0x60/0x15c
> > >    eth_stop+0xb8/0x108
> > > 
> > > Because eth_stop() crashes while holding the dev->lock, the thread
> > > running gether_disconnect() fails to acquire the same lock and spins
> > > forever, resulting in a hardlockup:
> > > 
> > >   Core - Debugging Information for Hardlockup core(7)
> > >   Call trace:
> > >    queued_spin_lock_slowpath+0x94/0x488
> > >    _raw_spin_lock+0x64/0x6c
> > >    gether_disconnect+0x19c/0x1e8
> > >    ncm_set_alt+0x68/0x1a0
> > >    composite_setup+0x6a0/0xc50
> > >
> > Hi Greg,
> > Hit the same issue during NCM switch stress test.
> > Can you take a look at this patch and check if it¡¯s ready for merge?
> 
> This is already in my tree and in linux-next and will go to Linus this
> weekend.
Got it. Sorry for the multiple copies of the same email¡ªour mail server had some issues and sent them repeatedly. My apologies for the noise.
>
> thanks,
> 
> greg k-h

