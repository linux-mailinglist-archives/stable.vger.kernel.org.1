Return-Path: <stable+bounces-223018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPzuKf/3p2l1nAAAu9opvQ
	(envelope-from <stable+bounces-223018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:14:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FCB1FD62E
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5595F314FCBA
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4156B39478E;
	Wed,  4 Mar 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h8Ivlvr0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2B391833
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615294; cv=none; b=gFfRuj/7e5unHRvMCW9eJoyW3zGVc9I5UfeaQ57uPMh835Jcz1pOoCjKcWraMJXxFeiizRvLbPJeOYuB9r3SfKnydJT6FxL6fy5DESRR8qyptaQvF0P5p+WI8DzmJkMJyE8XX/LVpCfE0PJvZyvMvO1mcyVC+12Y7+234p320ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615294; c=relaxed/simple;
	bh=IKX0nt4IjjixzAI7TT2z7rZK3SW1WJ270PnSNfV5gw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlZ0axJV/Bm45ZEAehNl6gA6x51fyumCWT0d1pD0ffq8J9ViFX+Wt9pmbHQCI/s6bCzisu1s3LiJbe55E82WW1fOjaXST7aZ+5Eh7rRQ5nHCdUIfaMzWH03/SaPAI6fuHPRsC54CaBUFCT10v9lWlzNb8YEuq5JcV22Foa6xM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h8Ivlvr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41355C19425;
	Wed,  4 Mar 2026 09:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772615293;
	bh=IKX0nt4IjjixzAI7TT2z7rZK3SW1WJ270PnSNfV5gw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8Ivlvr0BRTVJ/Pbi6u8sM40LsIXeJE76kqFjOtXhqrsaXu4awTgsy/02JE1TbSwT
	 8+5x/b4UAwaJaRnSe76RcQm56XUa+fZtF9jm9cYAFwPr5h0hn8cexuj03ELkdh8v4o
	 s9uqQRHxsbMU92DI0B0mLwwhzOc8NhsYuf5dumFE=
Date: Wed, 4 Mar 2026 10:08:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-pl: handle probe errors
Message-ID: <2026030450-tannery-babied-214a@gregkh>
References: <20260303140548.1313133-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303140548.1313133-1-oneukum@suse.com>
X-Rspamd-Queue-Id: 60FCB1FD62E
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-223018-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:05:31PM +0100, Oliver Neukum wrote:
> Commit 3756a272d2cf356d2203da8474d173257f5f8521 upstream.
> 
> Errors in init must be reported back or we'll
> follow a NULL pointer the first time FF is used.
> 
> Fixes: 20eb127906709 ("hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/hid/hid-pl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

What kernel tree(s) is this for?

thanks,

greg k-h

