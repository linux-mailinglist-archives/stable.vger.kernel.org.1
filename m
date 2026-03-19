Return-Path: <stable+bounces-227244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNZwM7nEu2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:41:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFDB2C8DA3
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE5E3046512
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589EA3A543E;
	Thu, 19 Mar 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yle47foc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156613B2FFF;
	Thu, 19 Mar 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912549; cv=none; b=oGqdrFLOq6EWz9kDyU0vXgLOTuDq54vfB2DD1gKdHYt7Pf6Ftgvf5gjw7m5FWov6XsCJyzUE5qdwwumZs7drJP+yxhnOJYTXFwNl1W37CQWg30k8Vx60o7TaCY9UXjbZ/XhssWi6PUlHTT3Zg5Mu92QK/JBpuG76jUfUrp561iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912549; c=relaxed/simple;
	bh=OZjDCPMvyj6fBM0TxtQk7RqfV7z4fzmGkmhMdYSyKPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8452HzkDGgpvx+QdbS904xm8pO8HCUAlmCWPz+tpAIbXwZBTNTBjA2REKYg4bzEjF8B8ngPnAp+5e9wnU6diBY4fJ/7La04ks2zUgciKrRJpLPiIoFsBwCB2uvqg6Q/cNofvEnt2tq4mf8jAALjxYyMaiGoOW6YJ7R+dY87IFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yle47foc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B3EC19424;
	Thu, 19 Mar 2026 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773912548;
	bh=OZjDCPMvyj6fBM0TxtQk7RqfV7z4fzmGkmhMdYSyKPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yle47focBnxRT+SdDcr6Gf4SB+uaGyxoSyMeJx28hxIuIeTTAZwXUOBql8zI0FECs
	 KvGqBEEgjANLjiKV6nsNAizv1/ECeVBvPapDHa/nMNt8HCURARRZV1AAClOMfDthZL
	 xoWPJJR1/9gflHg8zrSOW8ydzEBSzSj9Sa4p4rwQ=
Date: Thu, 19 Mar 2026 10:29:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6.19 240/378] sched_ext: Fix starvation of scx_enable()
 under fair-class saturation
Message-ID: <2026031953-undrafted-postal-4e78@gregkh>
References: <20260317163006.959177102@linuxfoundation.org>
 <20260317163015.844144806@linuxfoundation.org>
 <d80f17e4-bd3f-4053-bdf5-671439d5b72e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80f17e4-bd3f-4053-bdf5-671439d5b72e@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-227244-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DFDB2C8DA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 08:11:39AM +0100, Jiri Slaby wrote:
> On 17. 03. 26, 17:33, Greg Kroah-Hartman wrote:
> > 6.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Tejun Heo <tj@kernel.org>
> > 
> > commit b06ccbabe2506fd70b9167a644978b049150224a upstream.
> 
> This one likely needs also:
> 2fcfe5951eb2 sched_ext: Use WRITE_ONCE() for the write side of scx_enable
> helper pointer

Ugh, I missed that, thanks for catching it!

greg k-h

