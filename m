Return-Path: <stable+bounces-227667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBc5NWQ4vmlGJwMAu9opvQ
	(envelope-from <stable+bounces-227667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:19:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6453E2E38D5
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5F243019B8A
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB181347503;
	Sat, 21 Mar 2026 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oFwNA1/e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB54362149
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073949; cv=none; b=FI9QkuQ7V+kLiM9EHHEs1RHUKrYhG545I3JXBu7VjLAy5bnbFr4bsDahUp4IYpamMsZJHy7GVYe2vNYbclImphivjP2T5k0owJKP//vQT2KM4G4ytyWjcoYuAcTuOBvvlyP57mbyr2uDHmMaqE9VLXZ3O/jhM5ivGDNJ7qj5nmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073949; c=relaxed/simple;
	bh=4CZwcsNBMK561lizDhxzRP2Gf/ggRNaaRoBI3K5dM0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1gR44IQu2rgAiE4I5YcjOYKcPxOaP1M8ktIru48J/W/RVzyhbNCTf35A4Dd/Jb2a4kO8BAXwvuZcEWgYrtBKMNqlpLX0Br4s80jILPR1gbdmbx5kqMWeKeZ/48f015veQd2E1KUZMkFG2v3cSrMGcmilx1r5315ivNQKVbcf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oFwNA1/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A2DC2BCAF;
	Sat, 21 Mar 2026 06:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774073949;
	bh=4CZwcsNBMK561lizDhxzRP2Gf/ggRNaaRoBI3K5dM0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFwNA1/ea7g4wvjZcc1wVVCW+ONtSI6+jqLVMnAbNxaYOjsmZoQv4q9MPT3IL0nVy
	 3Y/UB8pr5iy58WyU7moQ4cPeDKHAQDihWudqos/2CU7BpbMWI7pcjlZTZCtH2LKwRh
	 J04WilYOuzcX68olZntA50sOIitcNF6jMr76gAWc=
Date: Sat, 21 Mar 2026 07:11:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: code@mgjm.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: propagate BUF_MORE through
 early buffer commit" failed to apply to 6.12-stable tree
Message-ID: <2026032123-slug-anthology-f473@gregkh>
References: <2026032021-amused-playable-2e81@gregkh>
 <c6099d0e-3f0b-4b25-9366-f258445a8e99@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6099d0e-3f0b-4b25-9366-f258445a8e99@kernel.dk>
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
	TAGGED_FROM(0.00)[bounces-227667-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6453E2E38D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:28:58PM -0600, Jens Axboe wrote:
> On 3/20/26 11:34 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's a tested version for 6.12-stable.

Now queued up, thanks.

greg k-h

