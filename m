Return-Path: <stable+bounces-263334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nelGCJUfMGo0OQUAu9opvQ
	(envelope-from <stable+bounces-263334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:51:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F0687E8F
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=TLNnb9Md;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263334-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263334-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17D74305C10B
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AE33AA4ED;
	Mon, 15 Jun 2026 15:44:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD91346ADA
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:44:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538275; cv=none; b=VFPiRwERYLLhNXZSGPnjFB5kv1vIZRhdb7k0RCw2xU3OO7qMMX30vu+f9qh7BO55h1hXfAhI4vS2vYLlTbQ/0iowJTCrIdJ1/X9fvphTgZ9Y0iz0BkNMFs4xNmxPuVQ7kktwLpXXmy6wp+qNxV/D9MqWFU/x9KZxf/spB/Rm7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538275; c=relaxed/simple;
	bh=RlBnfAliqbP4FcoiBfjxsuF7Fu9O+6q2THt4APbSfyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+7T2F/wbNRoGIrNC+CsDdsKZQjLKDaCtYlOcSQtYW95BwlKUiCZ/HTl1BJlA4t853pM3A7b0TTc2gz2jhuWOVAzdOEMi5yg0OtLAAE+u6rvOMFHxOk67PlPYSMN0ozoHEJ4AZQfIs36TCV1QL37ouQRP0HbTcw79uh/TRDEbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TLNnb9Md; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162E21F000E9;
	Mon, 15 Jun 2026 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538275;
	bh=2lAlWzA0z/BMYwqjAtRXH9BfDI2Ta2x/ByHdpWMcz6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TLNnb9MdszwpN1Pw4VHaTywXqawmjoKjgDL82wgGDgL1CnoXDMcQRjKkdAnnV/kma
	 XbFMUVUIX7fqV3wfKCRODLVCZm6s9ImGvRwORf7eqvvyhU4Q3+Moivb4HSzkgvBVYH
	 gpWwSTW2Pc0ask8/CuK+1KiTmcW/cGH6jKQB2P84=
Date: Mon, 15 Jun 2026 17:21:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: federico.brasili@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: don't truncate end buffer
 for bundles" failed to apply to 6.18-stable tree
Message-ID: <2026061553-kissing-overstate-399f@gregkh>
References: <2026061524-overtone-renovate-0e4d@gregkh>
 <8a4f0b60-0333-493b-b59a-eeb4a605fc7b@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4f0b60-0333-493b-b59a-eeb4a605fc7b@kernel.dk>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263334-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:federico.brasili@gmail.com,m:stable@vger.kernel.org,m:federicobrasili@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA9F0687E8F

On Mon, Jun 15, 2026 at 08:39:00AM -0600, Jens Axboe wrote:
> On 6/15/26 8:18 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's one for 6.18-stable.

Both now queued up, thanks!

greg k-h

