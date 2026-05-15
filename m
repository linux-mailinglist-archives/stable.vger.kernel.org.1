Return-Path: <stable+bounces-247473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMFUGYnYBmrKoQIAu9opvQ
	(envelope-from <stable+bounces-247473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF954B3FA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44DDA30451F6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF423FAE10;
	Fri, 15 May 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EUjCXgb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A083FADF8
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833389; cv=none; b=aCVQzMz9uJjQxJZFAeSnyTU8is3V6uXD89/5TCAGFUcY7qjhTfCfl5J2Frk8u0stoxOdQF6CHq3bd9eKov6a6MHsTo1hc+bVZUdwfSMZzpUKpnmotJqjNly9XoYxsMpNEouAzrIIs3MPvf/RCfS0QYqx6BR+EGOewm6DmGSLJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833389; c=relaxed/simple;
	bh=VlpT5gxeJqgr3AeGk71wQZ8dTM0ci8SLGYX94BTcep8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY7BfKTeZcuhdO2i/Pwafr438cq/YpTRRnU0g06z9rmpj132l1cREqI56QQqYy8GxXAZbjTMxxP/YACtagbAxsFa0Sjf2uexj/xwONgkNaMIJoob/rqZC5FaG2UAEEc2zC59n7IGHfz0G1bfKI52icrqvQKoOZW1hQf8edYwkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EUjCXgb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0ECC2BCB0;
	Fri, 15 May 2026 08:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833388;
	bh=VlpT5gxeJqgr3AeGk71wQZ8dTM0ci8SLGYX94BTcep8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUjCXgb83qCvzYiZDrwOMqGOcQH3WubYTeiOvZF8qKXPJ1XTIvnIkkPnKw4+oLmqN
	 AwAyqkGmenKIgoayqEYh09DMuM/+eKjglVtaam3BX2zRU/aAirZV21rKX/C4CQJMzK
	 8CEgDLSq72wSBMwT8sT4uEGbTE9ISmVo6Ibg0Zw4=
Date: Fri, 15 May 2026 10:23:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>
Cc: stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Qualys Security Advisory <qsa@qualys.com>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 7.0.y] ptrace: slightly saner 'get_dumpable()' logic
Message-ID: <2026051503-crusader-magnitude-ac29@gregkh>
References: <20260515073404.2974912-2-ukleinek@debian.org>
 <4cfc6feb-7344-4b52-88f4-d010c61a4266@debian.org>
 <2026051559-coil-evident-ede8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026051559-coil-evident-ede8@gregkh>
X-Rspamd-Queue-Id: 0BAF954B3FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247473-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 10:06:35AM +0200, Greg KH wrote:
> On Fri, May 15, 2026 at 09:39:38AM +0200, Uwe Kleine-König wrote:
> > Hello,
> > 
> > 
> > On 2026-05-15 09:33, Uwe Kleine-König wrote:
> > > From: Linus Torvalds <torvalds@linux-foundation.org>
> > 
> > oops, I forgot:
> > 
> > 	commit 31e62c2ebbfdc3fe3dbdf5e02c92a9dc67087a3a upstream.
> 
> I've already queued this up to all of the stable queues a few hours ago.
> 
> Note, the older queues require some manual rework, which I already did.

Ah, I see you did that as well, sorry for the extra work :(

