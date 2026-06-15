Return-Path: <stable+bounces-263335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xOG/G5wfMGo5OQUAu9opvQ
	(envelope-from <stable+bounces-263335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:51:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43613687E95
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=efNxHUoI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263335-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263335-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE987305DA83
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539153CAA48;
	Mon, 15 Jun 2026 15:44:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70183A8733
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:44:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538284; cv=none; b=VIAwsOi6aa1IvnEn4kO2Ld4QEgtRte78psxmEF5W3Bm1EbOLln3YS1qY7Axg//u4N1ScFpbQUCyODq0qBqPoatReXDyGUnwG780V8uf5ZGgEcU9P3LReJMDbYZDc+Lcz+8FXN+7O8yVqfuf4cPeH0ieVozqageF+uW6EUrSBqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538284; c=relaxed/simple;
	bh=i+/Kyvkv2BU6nDT2s/X2kcy7qeP757Y54wcW3S3RM7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/4K8GawXFagUf87ircWYAZdPAuuJERWnA0UNaWAEv4l3XRhmEBf+hryib4Njhj/7cy1eFhzCn0boaAFiNWzNVjzRYru2U0iAkOeb0y409hAlon9dsWq596sB59Y9XtKNXjRH+SHDU7XvboKI8+kwoMLpHDrAgRARw+UkORgkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efNxHUoI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64AC1F00A3A;
	Mon, 15 Jun 2026 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538282;
	bh=BSYvuQxDmeiiEQuGJ8IFcWFOzE6p1Gsyx5Yc1xvVxow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=efNxHUoI+LS+NAOgxqkHk/ZtYmoTzqTFoJRgK/BC45omjCGMRVUmU06cj5aEWu37h
	 azBhAJzi8BCSvCazNf88UkeklKAvrSfxUZ004nWe2YNRPTnOFwQLYgBdcge1KI7knZ
	 IYnW0rvCpEJTzgqAC7cVmMCvvowh6RSxWG9dbvb4=
Date: Mon, 15 Jun 2026 17:21:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: lk@c--e.de, tip@tenbrinkmeijs.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/wait: fix min_timeout behavior"
 failed to apply to 6.18-stable tree
Message-ID: <2026061538-boxer-shanty-a69b@gregkh>
References: <2026061509-unwatched-transpire-cd39@gregkh>
 <b3189608-5ff3-497f-a1a1-f5e8219da914@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3189608-5ff3-497f-a1a1-f5e8219da914@kernel.dk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263335-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:lk@c--e.de,m:tip@tenbrinkmeijs.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,gregkh:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43613687E95

On Mon, Jun 15, 2026 at 08:38:38AM -0600, Jens Axboe wrote:
> On 6/15/26 8:18 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's one for 6.18-stable.

Both now queued up, thanks.

greg k-h

