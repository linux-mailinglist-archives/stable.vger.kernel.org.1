Return-Path: <stable+bounces-259337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOKALGggHGosKAkAu9opvQ
	(envelope-from <stable+bounces-259337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 13:50:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FCE615ECB
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 13:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45BBC301EB6F
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C03845D5;
	Sun, 31 May 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ue1Vj2S9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9636CDFC;
	Sun, 31 May 2026 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227849; cv=none; b=SaJifCu9yIoC9St3+u8XQwFQlGr/KkoOullXmh3jawSWJp9kSaQQLB6dlp3vCKlXjz2nBnLnXVLsbr8SCxtijJkvxgP5u/K2nJvxO+6YKVSZ03iUzfC8RvJk4V5q1hsW4dMNTJ7xnchWd9bzdIunwno+JhcfDPqIldAH1UDQjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227849; c=relaxed/simple;
	bh=z2muXvYQE2Me+Nv4x8NzdyI1ffq+ibCmdGtId1aSJkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmbsrkGaf3wXIamv14FZFoODE+3zPpugGJUzDfX3F0J8EVgax5K5UxZwU6XHWcpe9eLkV38+ANhpLkjzqBOjk4tcvJm/M/u75xyE6M6ySp/aa5GXp/i0W1tON3JMWu4tZ4hJ2iFIcgG2Ip3lMlwFxt6co2CxX3WUHfk2Pbx3PGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ue1Vj2S9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ED41F00893;
	Sun, 31 May 2026 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780227848;
	bh=+y00Ah9wIWTgYhJGFLLWj7NlWeNyuJ0QIN43RRZvfRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ue1Vj2S96m/XBBjc8YR0JTJsHIrpMn2Pr3s2NeYCuqIYesjsqYb36RxDp8hp30C8t
	 eWerYIyqM5vMYIJ6Qu6IvXUtOWx9YvQgtryH7RbXn4l3toXbHwhmkDayrO0EahYXqA
	 4RSzARC2uq8KhqrhypzEPjtrob38vkMpUVR9Ve8Q=
Date: Sun, 31 May 2026 13:43:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Artur Chlebek <achlebek@poczta.fm>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression
Message-ID: <2026053159-unread-disagree-0da7@gregkh>
References: <002901dcf0eb$9472e210$bd58a630$@poczta.fm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002901dcf0eb$9472e210$bd58a630$@poczta.fm>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259337-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[poczta.fm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F1FCE615ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 12:52:30PM +0200, Artur Chlebek wrote:
> Hi, I have 5x fps drop on amdgpu Radeon 260X 1GB between kernel 7.0.9 and
> 7.0.10 or 7.1rc
> 
> Original sparse mail got flagged as spam so let me elaborate:
> Newest vanilla Fedora with Plasma, Gigabyte GA-H97-D3H, looked into things
> like clocks, PM, ASPM, tried flags, GTTSIZE, .dc=0 - all seems fine nothing
> helps.

Can you use 'git bisect' to find the offending commit?

thanks,

greg k-h

