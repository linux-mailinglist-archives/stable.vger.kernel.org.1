Return-Path: <stable+bounces-247648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P78NqT6Bmp6qQIAu9opvQ
	(envelope-from <stable+bounces-247648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:51:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9AF54DB7B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D068430A4B57
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1DB3CF037;
	Fri, 15 May 2026 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i8EwZN7H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB93CEB9C
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840641; cv=none; b=NC1gs8dGecwpyb0dJLXX8IBlw0vsYkcHSn9eFVKuEAepDgWYKqTiI2WGWdQEzG5wfEz+bmXLndWb34l9LBPP4iJC3mbSui2bHegnDcWiEAeVs/D6sdTeqmaplv3CP4NA1UYn1LKN45jKDs/czxoKPYxGOf38WCa2eSfNMMtYG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840641; c=relaxed/simple;
	bh=O8CSnvGsSBV2GdZ3UlEPmqkJFsGRuN0pszZC56TCdVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip6jr5LaJeD/yd1/wZkGWKyIPBcF4NZ9XRqwhabo/KYpACdNGIDXl2sjmdCZ9vWRwluf0bPwuuLmEAHjDKVWhtO2q9XPy7dJN+rN04u94Mo/XzQA8rotMXAX3E9+QbtvEJZNy/DUewjfS/4q8yof3T5TLN/ibCRHypgVRG9mlls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i8EwZN7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909C3C2BCB0;
	Fri, 15 May 2026 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778840640;
	bh=O8CSnvGsSBV2GdZ3UlEPmqkJFsGRuN0pszZC56TCdVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8EwZN7HPujbMCqIyM9QXVF2QOJkW/JqeWfIaH9v1vxS+NQOb68gusrFi9/1pe7gZ
	 /4DmwXU9w3g+nHZYmSF7T9giTPzefGsVd6YzmnKo9gyU0bfK2b4zlkl3PS1NVpA6bX
	 eaZkZwLI0IBf4FF8gvFrrz6xI/vA6HugQFRFAe5Y=
Date: Fri, 15 May 2026 12:24:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: code@mgjm.de, krisman@suse.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: support min length left
 for incremental" failed to apply to 6.12-stable tree
Message-ID: <2026051557-anthem-plural-7ac4@gregkh>
References: <2026051233-murkiness-french-8ca4@gregkh>
 <28c625f8-e34b-4086-b112-a3a99fc4950b@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c625f8-e34b-4086-b112-a3a99fc4950b@kernel.dk>
X-Rspamd-Queue-Id: 2D9AF54DB7B
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-247648-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:49:13AM -0600, Jens Axboe wrote:
> On 5/12/26 6:41 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 7deba791ad495ce1d7921683f4f7d1190fa210d1
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051233-murkiness-french-8ca4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Here's on for 6.12-stable.

Now applied, thanks.

greg k-h

