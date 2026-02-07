Return-Path: <stable+bounces-214787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMW6LctTh2neWgQAu9opvQ
	(envelope-from <stable+bounces-214787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:01:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3490106498
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B42433008A41
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187B238D22;
	Sat,  7 Feb 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePlp8WeH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633F17A2F0
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476482; cv=none; b=Hby/QHjaLvM+k3YeR/JDgCiTQRTmeLoge+zFasPjE6cpMZBQkAwZfkN6iJwkzi28yPqxrhQie7H8PKrSH1kaDazLLSvcZJcXLdJlnaaCdLgYpH55OTIv+wtmvMr+ZquN8/HlX/QlUYY38DGJFR2WPPXJp6c5Wgol5n19oIKD1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476482; c=relaxed/simple;
	bh=/hZP4AF3qZqJOG6l9qEdkH30kXehEmzpz1JZLBYScv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b70km6HD4BGzwEXLpOIBP2k+37CP2XJdM27VPpROaL71j0YhZXCMFtOP0EWDsQ5ZcynAF0Pw2CitEMVg1uukoKVO8giF3XjcN3hyP3paJlX1YlRg96XEJZ8xBATsOEw7tgf8FFnblrxnHmdGcm95kwIuht4G5w8OshJIBGr99qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePlp8WeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09F3C116D0;
	Sat,  7 Feb 2026 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770476482;
	bh=/hZP4AF3qZqJOG6l9qEdkH30kXehEmzpz1JZLBYScv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePlp8WeHtvm9vhvZfoALxYPG3UbQ3ZiFiSJUknmc3kO22A+EItg+uYBN5NDKCfxGS
	 2LMoYvvzFrlNiEW0eWS5+luYOEu62rGxloBVxfzikVqsD/z6oSm0nJklKQfOmM80nS
	 t6RXr6PYOAgpDWuzAXRDE0PSdxHhWtVQyy2GIAXY=
Date: Sat, 7 Feb 2026 16:01:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: sagi@lightbitslabs.com, hch@lst.de, roys@lightbitslabs.com,
	sashas@lightbitslabs.com
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nvmet-tcp: add NVMe over TCP target
 driver" failed to apply to 5.15-stable tree
Message-ID: <2026020759-desolate-cozily-df60@gregkh>
References: <2026020722-probable-democracy-26e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026020722-probable-democracy-26e2@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: F3490106498
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 03:35:23PM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 872d26a391da92ed8f0c0f5cb5fef428067b7f30
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020722-probable-democracy-26e2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 872d26a391da92ed8f0c0f5cb5fef428067b7f30 Mon Sep 17 00:00:00 2001
> From: Sagi Grimberg <sagi@lightbitslabs.com>
> Date: Mon, 3 Dec 2018 17:52:15 -0800
> Subject: [PATCH] nvmet-tcp: add NVMe over TCP target driver

Crap, wrong commit, sorry!  I was cut/pasting from a fix that resolves
an issue in this commit, my fault.

greg k-h

