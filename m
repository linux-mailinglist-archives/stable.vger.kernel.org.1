Return-Path: <stable+bounces-226105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEN4B+h0uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:36:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8EC2AD20D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3129230ADD1C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294513EBF1B;
	Tue, 17 Mar 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rH0pv6lI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F13E9F76
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761559; cv=none; b=kbXjgzwgPQPKHzkrnU4xPhvXeYA5jFpfIoCsfkbVKNb5cycVmDhbKRviWnY3hU4Qe/YBZJJeXLZv5FltMc4/EeVq/Tc/HQfXuRdgO6bR24B0LWheGL3hFKkEgrM8BgMdWKqyBffMaQ9rDX186jf/1lvIulnpHyrAK78ByxQ//eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761559; c=relaxed/simple;
	bh=LZF4ht2A+VV/ashS8fHXKHy03wUKBImmRiSqDw8tB90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLHDtFc8h0f9RKE9E9/uua7KCP6PvjKaCxH2bVy5dBypDHZpStwnuIB+t2NWh3t9s8W6m3aOIgk7erd5gXb29eARzb17pZkdviKoP5CdWUNvXbQuY3O4BbiLoRq8eEx8XvChQzfABu/m/gyTBJpEtzNvIKAT2xst32UDDmSAkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rH0pv6lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7B7C4CEF7;
	Tue, 17 Mar 2026 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773761559;
	bh=LZF4ht2A+VV/ashS8fHXKHy03wUKBImmRiSqDw8tB90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rH0pv6lIfqJVfJVba5WPqc1yMWOasLVszp40BG8LTeV+So+HsdLqv7ZdTZ7O7YN3h
	 5Ys+huNTOYS1UXUnFvxfq7QcXz1NXyM0AL6HEp6s3wGQt7qq9i9iNTpSS/a7m144tY
	 cZAdVd72e6c2pt7Rxu6s2CXcyamgp59vYK8ECWhE=
Date: Tue, 17 Mar 2026 16:32:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, naup96721@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: ensure ctx->rings is stable for
 task work flags" failed to apply to 6.19-stable tree
Message-ID: <2026031708-magnetic-scuba-0ffc@gregkh>
References: <2026031717-scowling-sandfish-e480@gregkh>
 <65795284-4721-470a-92ea-1c68d5e75f86@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65795284-4721-470a-92ea-1c68d5e75f86@kernel.dk>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226105-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: BB8EC2AD20D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 07:02:12AM -0600, Jens Axboe wrote:
> On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.19-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's this one and the following one too, for 6.19.

Applied, thanks!

greg k-h

