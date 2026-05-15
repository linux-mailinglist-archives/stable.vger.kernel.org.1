Return-Path: <stable+bounces-247472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VOx9Aw/UBmomoQIAu9opvQ
	(envelope-from <stable+bounces-247472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:06:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F954B09C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E82C230078AB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777041E7C2E;
	Fri, 15 May 2026 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yCmJo6zd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF723E3DBD
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832391; cv=none; b=Xhrs9x119iL1U2TH3iC1j0d1Dl4QUc6+yEcAQIEdfuIIzLLECNzz2CEK6vsogSyP0stN7u2LoeqZtl7sv9qKtppOyEkuYlvD5XWYCc5ssVGLX/xCfcvFhkw5BS1aB/lHgxGqPqBBf+CwbZTGYPI98x/NCovn9+fPXLzBwKwpf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832391; c=relaxed/simple;
	bh=1QfanSaVT8VQt8vCKDmYOVo2+5mCeKnws0asDaWY7Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHPl/EZMrNJ4TszzMBy7SFd5DAD6pPV8SDg3flpyg+Zn14jdGW7Iatmlorfw1Z+iFlaNIUGFnZJyaJejvRFZDqQFZdPfiZkMts6V2ksuDqN2MneK90PJrLD+fxM33urjhgt5Ua+cDlAc4w8KQbdAWsSgPaFGgOQ5PIUwitCQxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yCmJo6zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5CBC2BCB0;
	Fri, 15 May 2026 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778832390;
	bh=1QfanSaVT8VQt8vCKDmYOVo2+5mCeKnws0asDaWY7Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yCmJo6zdzYbs9LvBs900wIo4zz7pbTbOtMdwC/JUw72Vnjt4GOJrzQxy7yeQDrdFw
	 eD+9B38TaorNvxVzt3hCESZjYtaIGLfHkZx5BISNpWOU0LqHvmU06ZK4d/ljNrrf3j
	 wcjVYqyf7PwglJiPTgBBSiflpJ/VklHGXqrDPRCA=
Date: Fri, 15 May 2026 10:06:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>
Cc: stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Qualys Security Advisory <qsa@qualys.com>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 7.0.y] ptrace: slightly saner 'get_dumpable()' logic
Message-ID: <2026051559-coil-evident-ede8@gregkh>
References: <20260515073404.2974912-2-ukleinek@debian.org>
 <4cfc6feb-7344-4b52-88f4-d010c61a4266@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cfc6feb-7344-4b52-88f4-d010c61a4266@debian.org>
X-Rspamd-Queue-Id: D31F954B09C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247472-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linux-foundation.org:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 09:39:38AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> 
> On 2026-05-15 09:33, Uwe Kleine-König wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> oops, I forgot:
> 
> 	commit 31e62c2ebbfdc3fe3dbdf5e02c92a9dc67087a3a upstream.

I've already queued this up to all of the stable queues a few hours ago.

Note, the older queues require some manual rework, which I already did.

thanks,

greg k-h

