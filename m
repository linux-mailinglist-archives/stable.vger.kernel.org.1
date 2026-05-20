Return-Path: <stable+bounces-250019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCkCOYbZDWrE4AUAu9opvQ
	(envelope-from <stable+bounces-250019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:55:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A634F5914F1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEAF630EDC73
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DE63F20E5;
	Wed, 20 May 2026 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZp5hCY1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB5301704
	for <stable@vger.kernel.org>; Wed, 20 May 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291880; cv=none; b=joj1M81C42v0hFdw9omjpJixNrfM/+PRP9q8dbnRxPmrSK3xTPwW82MkUe2bQDllQP1zAJN0vBqSQqlQtg0dHGZbNXQpWg/8Uob98Pg3kLiiDrNNZukaoFlrNrLlLyE6MApejFKsk1wgyyPZhdsIqboKxR23KzeUx6CTyYOzdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291880; c=relaxed/simple;
	bh=PMLWCXGrBxo7gFFRlA7+Js7Jl24cKWQFxjhixB1nLr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbZC1jYwsd3EB4qt6bYLfmoCej/JiX1r1tHr6T/9FX0e+Eth6QHIz+JEZZs9bZsOhH8RLR/L9ZIcl4RmguLLAMGdwNWqJm8afJmC3IZfGpGk8Oat7pOxKVZZXjFegd0PKM1ura+mVvxiDhtOrg1IhaP0PLWqadx+352ORsewnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZp5hCY1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD041F000E9;
	Wed, 20 May 2026 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779291878;
	bh=040oFPWxoJlyM8ppb5GKyFZv8HrL3j1pweCLOPV7I0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WZp5hCY1MEnZnDM+llG7QwJaOiSMXQWxjoDmHObeBb439ytKE3ETjJZJ1cv9evPU5
	 lGj6tHFyiLePdcsMeAmDLRvJZNWwsO7pFGbsEYq/nVwhlkdk8ZqMt4Yd4EwOXm6Hsj
	 kvWcWusB9M/cSXMSHb+qCpioHAklj6IAdulG5l1g=
Date: Wed, 20 May 2026 17:44:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: nicholas@carlini.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io-wq: check that the predecessor is
 hashed in" failed to apply to 5.15-stable tree
Message-ID: <2026052031-unranked-diminish-781a@gregkh>
References: <2026052036-arbitrate-wasp-6200@gregkh>
 <efd4f787-c6df-4ab7-96ce-132cabf414f9@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd4f787-c6df-4ab7-96ce-132cabf414f9@kernel.dk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250019-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A634F5914F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 08:46:01AM -0600, Jens Axboe wrote:
> On 5/20/26 8:41 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x d6a2d7b04b5a093021a7a0e2e69e9d5237dfa8cc
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052036-arbitrate-wasp-6200@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Here's one for 5.15-stable AND 5.10-stable.

All of these now queued up, thanks!

greg k-h

