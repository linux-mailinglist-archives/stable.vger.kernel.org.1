Return-Path: <stable+bounces-217540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3sAiBnf5l2mH+wIAu9opvQ
	(envelope-from <stable+bounces-217540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 07:04:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E1164E27
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 07:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B5E930060A3
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94D32773EC;
	Fri, 20 Feb 2026 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVgUiK4H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D81237707;
	Fri, 20 Feb 2026 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771567473; cv=none; b=UQxgWhJIbo5FQ87qq3nxMMirb5T+UWswgmvLfGEcUIhnAOIjPQvoOEFl/42Z+HODieaLib0AE3pnZM9t3Phcwig6hb0IEHt+rjGqdJ12jU9cMm4h5G8YHU/B3kJoeN7AaK2zLDYesmqRrlARvCt/XGSYKm9NL8Ikvff4n0xD2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771567473; c=relaxed/simple;
	bh=86geuscIbdIIQ2fINUIMvkAoQ2Lx5sI5vWIYoQIyw4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMFGKcaiMYKjTqiJ2uBMlt+Cygrn42SMvSZRRJLCftl/jBuNYP3SA2pFHX9cWN4EDQIO67lStteJuBpnMqbsT3ncGEpenA2kQlcGZS1upzRmI564IJbGjTSNCE6BjUjThwYXxkmcnXcBihBCrgzDVXXTkFL3hSQs2dZvXkl9cM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVgUiK4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70A9C116D0;
	Fri, 20 Feb 2026 06:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771567473;
	bh=86geuscIbdIIQ2fINUIMvkAoQ2Lx5sI5vWIYoQIyw4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVgUiK4HJAyPBMHQO1WAPbyoc3jpFCk/S+SS7A9MkmgzkxElGIAZVod9w7Ot5QyKJ
	 mM8xi1iQZLp1QSde3b5OYPkf5siMrZm5T/xmJE0WahBsdW+DBjKyqpAWkv+8axl7IE
	 eN6+XxonN5pAzadnGzAKB3G+2ndOR4u/TnuQCBls=
Date: Fri, 20 Feb 2026 07:04:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: James Kim <james010kim@gmail.com>
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org,
	alex.bou9@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] rapidio: mport_cdev: fix sequential UAF in dma_req_free()
Message-ID: <2026022046-transfer-dullness-cbe2@gregkh>
References: <20260220040821.3511683-1-james010kim@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220040821.3511683-1-james010kim@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217540-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.crashing.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5D7E1164E27
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:08:22PM +0900, James Kim wrote:
> Hi,
> 
> Resending this patch to the proper list(s). No changes since the original submission.

This goes below the --- line, otherwise it will end up in the changelog
:(

thanks,

greg k-h

