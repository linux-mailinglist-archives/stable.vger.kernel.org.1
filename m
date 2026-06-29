Return-Path: <stable+bounces-269786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TlC3AxqLQmrs9QkAu9opvQ
	(envelope-from <stable+bounces-269786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:11:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5976DC7C3
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:11:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WUHTHZRR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269786-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269786-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAF07303CC6B
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EAC426EAE;
	Mon, 29 Jun 2026 15:04:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C13426D13;
	Mon, 29 Jun 2026 15:04:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745451; cv=none; b=B47gpGHPFCluO8bHG5AsYjhIgFj2X+6YR7XpHz7AAyQkIcG9Nch+wMd0V2dVobQwxdhjawsIsfxfhd3F66aHJIf4l16wX0iXprFE9W9SZxMu/Uypvjnsey8b5qEwofZ7fa0XV4tZT4hM+YH4r7lWKYydx+6ehuawo9L6W58QoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745451; c=relaxed/simple;
	bh=qubJ+N+dc9V0cxYf6uPieT6b9/ZlYWmutB4jGVIR8zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6Ky0fmkf1OMecHnBI92Mwd9orDbtQ20P1E6B90tPsqdR7Y6Esv7sbkmZLaxaHgCQZU5LUtf92B1bVvHnwmMZfD4w/n5pSecdOln3N9Ti8PdOINY1w6/1Bl/ZziOy7tXyoh/cYv0OYYV28k31iHNoEZ95He3dHqJHVl2H/1vmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUHTHZRR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C147E1F00A3D;
	Mon, 29 Jun 2026 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745449;
	bh=qubJ+N+dc9V0cxYf6uPieT6b9/ZlYWmutB4jGVIR8zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WUHTHZRR3rZtUXc6QkfXeX0xOOHV3JHD3M+xTBshWJGG78Oean9LeG9GvMjWDu5J9
	 wZMCue+cQLzdEiY2LgcOWoJRohzD6y03b9xocsdfesWaCEXKoQ7FYQtfiJEMClwo61
	 z230tO+XVVKToqiq19sHXnkW+1HlY3YuKpIYHM+Nb/6KpauelgFGh2w29OZbYs/snG
	 BVO2bfuFmlYDcHwblKNn598oPrSJ/4rkz449J7ksniYskWVx0Csenqz7vSqsnt89CT
	 JBkTyE8MLvnexOLH1s77p2jEB+P6ucbQRCQ/W8uEMhK4FT3dfwM7sDJJCPgnqLHEqy
	 aq0dneZmaGyNQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1weDWp-00000000cJB-30gs;
	Mon, 29 Jun 2026 17:04:07 +0200
Date: Mon, 29 Jun 2026 17:04:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit Cinterion FE990D50
 compositions
Message-ID: <akKJZ5MyUAsYJ7oo@hovoldconsulting.com>
References: <20260612113916.34894-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612113916.34894-1-fabio.porcedda@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269786-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fabio.porcedda@gmail.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:dnlplm@gmail.com,m:stable@vger.kernel.org,m:fabioporcedda@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB5976DC7C3

On Fri, Jun 12, 2026 at 01:39:16PM +0200, Fabio Porcedda wrote:
> Add support for Telit Cinterion FE990D50 compositions:

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Applied, thanks.

Johan

