Return-Path: <stable+bounces-230484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIqrKdxOxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:21:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32281337794
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC44B3088035
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6733FEB04;
	Thu, 26 Mar 2026 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j4fjF2R5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80991AB6F1
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538267; cv=none; b=obHpUN429Tc9sg36Mp2Ktk1Ipu/h/KZ8bMvTLgb/jiHj5HDMzTEp9vEqVwB2yrSuyUL6aAh+N08fKJQNioDKnSxsPoeBrQa5NTu3L33eF/HxaOail7LldtBpmteEBxHGil6hNPtgSmf4A4K/UnDM4+pCxvNDI9vl2+x2i+fI1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538267; c=relaxed/simple;
	bh=zBKVMzPbxNOzDCuWr6Ndfev0XEmKz3sq8PqZR/61pw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FySlLzxHfnV9rpYzstbl6S3SRglKrsTpjvBDsfS8KuWR+DaVYbnw9KpEaCaekxt8d0JBrCeGKu2+aRqbHcpFSmNlvwUaQEKAginrRrzCRJoC2XedNFwPzE9WtpW9eGU2h4Xg3LwNUhLqDAFO1tmdTdijCmOCwA+ncY66fxAqN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j4fjF2R5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215CEC116C6;
	Thu, 26 Mar 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774538267;
	bh=zBKVMzPbxNOzDCuWr6Ndfev0XEmKz3sq8PqZR/61pw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4fjF2R55x5lufKoPeU/4H49QU3EWCn9v6rvNa3uFy5nQFV2FpfqB44VK5ATC4N6U
	 hfmVj0EOsIJYPF9UjHRRMqmA0TO6WTvszEvm5Rsoeq04yZSTf3O1xwPGkU/y4U70gu
	 Dih4v6NbeO8l8ngkmgJNU0SdJJ4P9c//9HlS+fYo=
Date: Thu, 26 Mar 2026 16:17:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: appletb-kbd: add .resume method in PM
Message-ID: <2026032613-childcare-exposable-3a75@gregkh>
References: <20260326145134.1371-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326145134.1371-1-gargaditya08@live.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230484-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[live.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,live.com:email]
X-Rspamd-Queue-Id: 32281337794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 02:51:47PM +0000, Aditya Garg wrote:
> commit 1965445e13c09b79932ca8154977b4408cb9610c upstream.
> 
> Upon resuming from suspend, the Touch Bar driver was missing a resume
> method in order to restore the original mode the Touch Bar was on before
> suspending. It is the same as the reset_resume method.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.com>
> ---
>  drivers/hid/hid-appletb-kbd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

What kernel tree(s) is this for?

thanks,

greg k-h

