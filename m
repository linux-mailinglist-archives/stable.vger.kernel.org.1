Return-Path: <stable+bounces-263616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KbLFOLnnMGpPYgUAu9opvQ
	(envelope-from <stable+bounces-263616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:05:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E768C59D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:05:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=RjHrhQY1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263616-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263616-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A5083016777
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBE23DA7C5;
	Tue, 16 Jun 2026 06:05:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610AB3D891B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:05:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589942; cv=none; b=NtF7/y9jCHNHGAygQ+Up/0nY3MHaz2waM9FW/tmXwWn/lU49jGlmhxMtqSwEUXVda5dzBgIN/IP9JE3RMfWfDorwur8VtQgWHXjSusukvAcQCxRo7gy9cPdCPdOjjSZ9SRXGrDhpViN3CYzZXNlrmCc7FVoGp6KcOSmw5QE7bg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589942; c=relaxed/simple;
	bh=eyld99tGsz2RoTLgVyBu8BDrVoAiteBGbLA/AmbyR30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJYCqt5Bxuix5W4w0I6JPExiuM/2ujwsvmKYSKHLqen+A3kmAz5JOCFBAswoEhRLsxB6qCMWOUmmu9PZemwVG4xr6Y2of54Z1U5MqgX5xUzjEJIogsoyrmKa3qoNc01SijYBnZttQkDtduNVMksx5Hl4hyeWtd/CHZLNsidzhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RjHrhQY1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374FE1F000E9;
	Tue, 16 Jun 2026 06:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781589941;
	bh=eyld99tGsz2RoTLgVyBu8BDrVoAiteBGbLA/AmbyR30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RjHrhQY10hBzsK7NkfHXKmepdAST7ipu3GCPYwoioewt0Yco4B3cZo0OUrFchhD0b
	 90f55tvfbVs62aTggg72JPB/dU/TncYGWLY1rNYlQOsk1yRn3ABzGc3LoOmIOn3lrW
	 YeW/8DsRutmiAgRR1XGis8hhd4lMkei6q6DvRl1Q=
Date: Tue, 16 Jun 2026 11:33:22 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kevin Berry <kpberry@google.com>
Cc: xmei5@asu.edu, bestswngs@gmail.com, chenglongtang@google.com,
	joneslee@google.com, pabeni@redhat.com, rnj@google.com,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
Message-ID: <2026061614-trunks-outcast-6684@gregkh>
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com>
 <20260506202842.1788682-2-kpberry@google.com>
 <2026061617-flyable-civic-a986@gregkh>
 <CAMAJAJE+w+vYwcEzkZoNDwoAC3PzJ54sGGr7s+5edBW3JJFKHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAJAJE+w+vYwcEzkZoNDwoAC3PzJ54sGGr7s+5edBW3JJFKHQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263616-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[asu.edu,gmail.com,google.com,redhat.com,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kpberry@google.com,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:chenglongtang@google.com,m:joneslee@google.com,m:pabeni@redhat.com,m:rnj@google.com,m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 790E768C59D

On Tue, Jun 16, 2026 at 01:55:04AM -0400, Kevin Berry wrote:
> Hm, looks like the patch context changed because commit ce7a381697cb3
> ("net: bonding: add broadcast_neighbor option for 802.3ad") was
> applied to the 6.6 stable tree after I sent my patch. With that,
> though, Xiang's original commit 2884bf72fb8f ("net: bonding: fix
> use-after-free in bond_xmit_broadcast()") applies cleanly to 6.6 and
> should fix the double-free. Would it be possible to cherry-pick that?

That worked, thanks!

greg k-h

