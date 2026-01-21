Return-Path: <stable+bounces-210777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIBrCC0IcWmPcQAAu9opvQ
	(envelope-from <stable+bounces-210777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:09:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E45A508
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB675A89E12
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073254C0430;
	Wed, 21 Jan 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h/pW5asY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831D4C040E
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007953; cv=none; b=Eus1VDbjYlXvl87Tq/l//yw6YxPKFAXBildwEDor+u05Aj/y9yWcKRFY+bXv6m5eWXCGYV/A2yTejOlGE4OJgRk1ewDM8vC9J1KJTCh8+4XIiiRaFnWa7UyK5HeEeb9QRrTnBDbbkB6skyYD32kQvqUOJ1vSVCSI0ibRzgV1EOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007953; c=relaxed/simple;
	bh=dseD36re0XXVAu07rcBz7OI4Pa0SSXIEckDtnzCWi70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTGEcx3MMprCLA/kta+/zYQKKcsNNXErt59zUKAo+bdoOmPVm7j3gfNTXuJWFYY9Zc1KxlCTiMWz3G4bZlV/texJqnLAfzOvyUApj7LP/ZNWBDCIssYt6Mc8n1ZBQInbzCqgYYgAhBH02DeAQdfPQrmb7W+rGkVuyMt9lz3vaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h/pW5asY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3F4C4CEF1;
	Wed, 21 Jan 2026 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769007953;
	bh=dseD36re0XXVAu07rcBz7OI4Pa0SSXIEckDtnzCWi70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/pW5asYvjwSS7AZyEhjE6bbYNycwRkqE7m6eBdO76B/hdBjjaROjLkS+hwR9ki67
	 RJxHPvVGKsCP/hDLAxZhVXbA10Iux8xNN7bdGOarBovlGkFRb/aDvjt3/g9pMt9n6C
	 0ULXS6kYPGkfPoRWEmLAOn8X4OVa0d9fEicw5PLE=
Date: Wed, 21 Jan 2026 16:05:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: ming.lei@redhat.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: move local task_work in exit
 cancel loop" failed to apply to 6.1-stable tree
Message-ID: <2026012139-throwaway-broadly-e887@gregkh>
References: <2026011957-earful-capillary-a00a@gregkh>
 <6a690ac5-1bee-444f-8ff1-4a9d67a0ba8e@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a690ac5-1bee-444f-8ff1-4a9d67a0ba8e@kernel.dk>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210777-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 777E45A508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 07:34:51AM -0700, Jens Axboe wrote:
> On 1/19/26 4:47 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x da579f05ef0faada3559e7faddf761c75cdf85e1
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011957-earful-capillary-a00a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> And here's one for 6.1-stable.

Thanks for both, now queued up!

greg k-h

