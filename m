Return-Path: <stable+bounces-227303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABSnMPb/u2murAIAu9opvQ
	(envelope-from <stable+bounces-227303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:53:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADCC2CC3C0
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AED6300A117
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D512D781B;
	Thu, 19 Mar 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hOJRzPzD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CD2C1780
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928377; cv=none; b=lxc608szwOcFZddyOhpJ8XL//pd9nieW4unoo10aoiS0dITi8hrF+tOgFzuMapDEY9qAC1yZ559BgcwIrL4t0y3jtrMJ5yxIJzB+EOuL5jch3EX7NeekWfqX7G3FcVNLxvI8anuz4SJ6AnybK23R6bEf3CP9Af/xooBEMJcK/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928377; c=relaxed/simple;
	bh=lpEfKGDXi3G72m97JMg3OIewvq3AydNVdETuF54mwEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjysvZHv7Jh2J26yrdEIIY85HcEWyGVucROMiSUPd+in0q7BLJ+zbpHd33akWCIq97pnZmj7CzUS6758HPck+mYAtHNHZkD/9+p4VnrM3HpVu0lKjHqcc7EiQvNb9yuXnXXmr0B19blgNgnjDKEhYcI/FNXaQ5wYJAk5Uh+HpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hOJRzPzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C73C19424;
	Thu, 19 Mar 2026 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773928377;
	bh=lpEfKGDXi3G72m97JMg3OIewvq3AydNVdETuF54mwEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOJRzPzDsUVwZdhGm1uX2mr+Imm/1W1HymCKHJ5VFU6nZ5HL8PF4Grawa+gK+yTDY
	 yOtMhsdwwj4pKMtX+KGy3MuqHt7l6MM/hZxMccSZz+kuSmlLngqZjTut4UBRzsr7eJ
	 QBuxq7wxX7YB7gCyNpLK8cgQr6+EE5P09ayjLD7w=
Date: Thu, 19 Mar 2026 14:52:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: keenanat2000@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: check if target buffer
 list is still legacy on" failed to apply to 6.1-stable tree
Message-ID: <2026031948-stingy-feminize-2945@gregkh>
References: <2026031701-elsewhere-bulk-0f93@gregkh>
 <d016a6c7-3790-477f-8f8d-100d3b100afa@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d016a6c7-3790-477f-8f8d-100d3b100afa@kernel.dk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227303-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.880];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 4ADCC2CC3C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 07:00:53AM -0600, Jens Axboe wrote:
> On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's one for 6.1-stable.

Now queued up,t hanks.

greg k-h

