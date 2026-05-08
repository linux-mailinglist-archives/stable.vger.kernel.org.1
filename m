Return-Path: <stable+bounces-244701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPPFKtqg/WmwgQAAu9opvQ
	(envelope-from <stable+bounces-244701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:37:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE194F3CC2
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316833030111
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29F03859EB;
	Fri,  8 May 2026 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhDLbn+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288D3845A4;
	Fri,  8 May 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229307; cv=none; b=Gn7493i21EtnCrEiE0C92sVsRhR2lrs5rQ5UB/LgzuNjq+XBe4hwGgPOxIumtG0WVvyfh6oq3RMScjxz8tiP8JuYN34pFzVPOS0taqaML58rvEPwY1Z5eK4NDTqD3cBuP3/DlrgVLZCI8XEeyAHX6pbd59zj2EEBUFb2ZShlUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229307; c=relaxed/simple;
	bh=yzFoA9cU7dt1cHir/Uh2y5hjcUO7TW+C6zLAKE5eHMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N10pcP0oUbPimk0oaoeCHT0b1td+AZflAH4nXi8yBRIiIW3P0S1HKi6L+QpPMScsigOTzoHEHmz/5WosTwx+AGCiJV1NBcwV480WUsbXXB1D8R45RDIH/M2IG4UrGCuS+8OeZnfmcRWXl5E5pYVpmneHTKzoQHIJe8A94ijEcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhDLbn+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BA4C2BCB0;
	Fri,  8 May 2026 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778229306;
	bh=yzFoA9cU7dt1cHir/Uh2y5hjcUO7TW+C6zLAKE5eHMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhDLbn+hFt9F2Jd0XI4b9/PceC0vDsn9t0FJmcxKpYErFUOCR45cvZ1eEeVPJ3v0A
	 fMkcK71ZEi1bdGDouhtT5FDQnIC1nycF+wc9ZbTnRtOnBWw5eRM1jI6+d2A6LGpw5o
	 WV9nQ6JVQqruIWb6UKC4CuSbVavbCMD2q+a4RxBskw1yj8DSXL944uJ2MD52Jbd7O2
	 HB1n8StbrkYufiN1vMM62kMlCbolTiziE0/qD1+knarkkWxcA1071sJj2kTnINXw/R
	 mDequjFwfvexhJkYES2pwlkHDDHAkBDMedtwSk8pZxh0Mu0mgB9UIGDL+js1GNdwZE
	 6MiJDfhokDcXg==
Date: Fri, 8 May 2026 09:35:03 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Joonwon Kang <joonwonkang@google.com>
Cc: akpm@linux-foundation.org, jassisinghbrar@gmail.com,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] mailbox: Make mbox_send_message() return error code
 when tx fails
Message-ID: <20260508-imported-smoky-skunk-3cfbdb@sudeepholla>
References: <20260507-large-wren-of-protection-93bb75@sudeepholla>
 <20260507144737.3343314-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507144737.3343314-1-joonwonkang@google.com>
X-Rspamd-Queue-Id: 1DE194F3CC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244701-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 02:47:32PM +0000, Joonwon Kang wrote:
> Hi Sudeep, I appreciate your review! And I apologize that I missed some
> important context about this patch.
> 
> > On Tue, Apr 21, 2026 at 10:46:52AM +0000, Joonwon Kang wrote:
> > > When the mailbox controller failed transmitting message, the error code
> > > was only passed to the client's tx done handler and not to
> > > mbox_send_message() in blocking mode. For this reason, the function could
> > > return a false success. This commit resolves the issue by introducing the
> > > tx status and checking it before mbox_send_message() returns.
> > >
> > `tx_complete` and `tx_status` are per-channel, not per-message. Although
> > `mbox_send_message()` can queue multiple messages, all blocking callers wait
> > on the same completion, so a completion is not associated with the thread or
> > message that triggered it.
> > 
> > This creates two issues:
> > 
> > 1. Concurrent blocking senders can consume each other’s completions. When
> >    message A completes, `tx_tick()` may submit message B, then set
> >    `chan->tx_status` and complete the shared completion. Any waiter may wake,
> >    including B’s sender, which can return while B is still in flight. It
> >    happens even w/o this change but with possibly wrong return value after
> >    this change.
> > 
> > 2. `tx_status` can be stale or overwritten. Since it is a single channel field
> >    written just before `complete()`, a second(possibly fast) `tx_tick()` can
> >    update it before the first awakened sender reads it. Because `msg_submit()`
> >    happens before status publication, the next message can complete before the
> >    previous status is observed if the controller re-enters `tx_tick()` for the
> >    same channel.
> > 
> > We need to see if there are other issue that needs fixing before you can
> > propagate the tx error code. Let me know if I am missing something.
> 
> Yes, the current mbox_send_message() in blocking mode does not support
> multi-threads. I have tried adding the multi-threads support [1] since the
> first patchset and adding this patch on top of it [2], but the author was
> not convinced about the necessity of the multi-threads support and instead
> preferred that clients, instead of the mailbox APIs, serialize the multiple
> threads' access to the channel [3].
> 
> For this reason, I went with the author's preference [4] and clarified that
> multi-threads is not supported in the API doc [5] so that clients can be
> clearly aware of it and serialize its threads' access to the channel.
> 
> So, this patch is based on the assumption that such multi-threads
> protection is given by the clients already, i.e. mbox_send_message() in
> blocking mode is called on the same channel only when the previous call has
> returned.
> 

Fair enough! Add a reminder note in the commit message that multi-threading
is not supported and hence the proposed solution works. With that, you can
add:

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep

