Return-Path: <stable+bounces-272210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9a9vOIOyS2rUYgEAu9opvQ
	(envelope-from <stable+bounces-272210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 15:49:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B327117E2
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 15:49:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aajUuWD0;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272210-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272210-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2FD533DAD7E
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468A424661;
	Mon,  6 Jul 2026 12:08:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0A424651
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 12:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339725; cv=none; b=TD/k7vAbQPxnQkbXhuW2Lfijvm+yRAg3COXkZ1tfDxksvQM4OeCYVEJstNb9N03Y9n/2hBUq/3S9XWpLheoyEc+qE4aRhRENpmtaIeHdtUTeX0rU6Vit4MKNlHi9S3o9XOOlC+t7nSYA6TZ1uXMdS2hZgS3RTPv4WQHKylCJwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339725; c=relaxed/simple;
	bh=r0nMsLopU+3PUG9TIOs6IDKdoiGhf+Ksmh7NWcQxvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N13GatNgbZhVt6lhX5K6GszrGZE2hO6/+wWyzC9SG+XIBcrMGXddvWSUIn6cvhkCo6FTQzXb4RmMB6ZnzzDVOqTiYfaudrN2BIdfBcqszPggDfq8oz90YVy/m6PPP+kJ7CfZqukOjAYTCqqkyrcNB59ZiYDtVWzh6P+MVGbfwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aajUuWD0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA9D1F00A3A;
	Mon,  6 Jul 2026 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783339724;
	bh=bR9pG++rdjE091/GA3ZPkBFjn6j18xXvtzj7/DVEyK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aajUuWD0Uja9NyAUFuuAsNodZeWPUIfx8YVP1xhO9VBsiu91zNd5Grvrx17fOO9+z
	 TeXeDAAdtkMscY6X9bMulSYWcnyrTmWIUHOTCLwJ2NuIHjHMf38FKNVFSGTAI+/m7m
	 u9OufD0rcCK3USgVFA+GwOwqNQlUxCG7ujTuadhQ=
Date: Mon, 6 Jul 2026 14:08:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: stable@vger.kernel.org
Subject: Re: f2fs: fix UAF issue in f2fs_merge_page_bio()
Message-ID: <2026070631-vaporizer-viability-d57f@gregkh>
References: <e6003504-96f1-4dc8-9e6b-e17c8f809d75@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6003504-96f1-4dc8-9e6b-e17c8f809d75@amlogic.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiucheng.xu@amlogic.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-272210-lists,stable=lfdr.de];
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
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75B327117E2

On Mon, Jul 06, 2026 at 04:52:12PM +0800, Jiucheng Xu wrote:
> Dear maintainers,
> 
> A f2fs patch should be backported from upstream mainline to the stable
> 5.15.y branches. The patch's information is shown as below:
> 
> [Subject]
> f2fs: fix UAF issue in f2fs_merge_page_bio()
> 
> [Upstream commit ID]
> edf7e9040fc52c922db947f9c6c36f07377c52ea
> 
> [Kernel version]
> 5.15.y
> 
> [Why]
> We encountered the same issue on the 5.15 kernel version. After referring to
> the modifications in the upstream, the issue was solved.

Great, please provide a working backport that you have tested for this
branch, and all of the newer stable branches, and we will be glad to
apply it.  As-is, it does not apply at all.

thanks,

greg k-h

