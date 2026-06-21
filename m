Return-Path: <stable+bounces-267523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YY4DAOJ4N2rjNwcAu9opvQ
	(envelope-from <stable+bounces-267523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 07:38:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DED46AA40F
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 07:38:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qggICgvv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267523-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267523-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CE8E3004607
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 05:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D61DF74F;
	Sun, 21 Jun 2026 05:38:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890B33985;
	Sun, 21 Jun 2026 05:38:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782020319; cv=none; b=LEDPe3ms1743qsEGXnh6zkD+Rz4OgAmf0kg6lhh/cmOKVHDQexon+iuebHXNojx5J3Fn8tok/AVbcwJ9e3or1j0/BuJLdwEKKvZKQJvtLd+4ElXuZCGC9MWOzJ8iiLQ3YTejKy10eGYG8QR8juh96KZze6tPE63m9fv7E8g9Pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782020319; c=relaxed/simple;
	bh=KCI3N5hsA0tEbO+4K3hwY/UL9X7Tjr1gCAyLd6IXY+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzXr8tywOVVkUNbRysWaAwv4TiEhAr25ui5GyqwVPk4ty/B03nFA+UNN3oSHqz5g0dMd3UUhw64PtG/RHnwMMpviANv6vPYyzsnS3/z6rBZaxgG5ygqsH7Q6mx/VyJ6eviYLEhZ5vDhKfpwVjKSpUq4lljo80LWHW4wX6UDKHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qggICgvv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFA31F000E9;
	Sun, 21 Jun 2026 05:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782020318;
	bh=mKMU7ZpAbRqTnuDft50cZJalrjo3GGSFUaeEDGhH+6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qggICgvvZ7jZGrITSwZqOcOr0HMU+FRcGLyiz0l9MVbEtcIqZ38nR29cfrkJiHW3f
	 rR76uOFKjLVpJMNIxuxloL7YdVGp/CtkkSLMdDg3qUYS+zt7Wjv8E5utt4A1WJkz2O
	 Y/QcL/SEHgBi9B+Q9D6tKLBOQHnJzX/yRZrSEp9w=
Date: Sun, 21 Jun 2026 07:38:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: XIAO WU <xiaowu.417@qq.com>
Cc: Alva Lan <alvalan9@foxmail.com>, sashal@kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_conn: fix potential UAF in
 set_cig_params_sync
Message-ID: <2026062127-serve-valid-f1b2@gregkh>
References: <tencent_42D87A0C871AE6AF019BF6AB46F003577205@qq.com>
 <tencent_D72AF901D90EB103AEB5111845A7AC8FF705@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_D72AF901D90EB103AEB5111845A7AC8FF705@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267523-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiaowu.417@qq.com,m:alvalan9@foxmail.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pav@iki.fi,m:luiz.von.dentz@intel.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	FREEMAIL_CC(0.00)[foxmail.com,kernel.org,vger.kernel.org,iki.fi,intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DED46AA40F

On Sun, Jun 21, 2026 at 09:57:51AM +0800, XIAO WU wrote:
> Hi,
> 
> I came across a Sashiko AI code review [1] that flagged a related
> use-after-free in `get_l2cap_conn()` — it has the same lock-dropping
> pattern that your patch fixes in `set_cig_params_sync()`.
> 
> I was able to trigger it in QEMU with KASAN on a 6.6.y kernel. Writing
> to the 6lowpan debugfs control file races against connection teardown.

That's a very old kernel version, can you try 7.1.1 please?  Also, can
you just send a fix for it if it is an issue there?

thanks,

greg k-h

