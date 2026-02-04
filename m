Return-Path: <stable+bounces-213382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAXbBvVQg2kalQMAu9opvQ
	(envelope-from <stable+bounces-213382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:00:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECAAE6BD6
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 089463095C8A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C859740B6EB;
	Wed,  4 Feb 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASZpbMJf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621E23EAB0;
	Wed,  4 Feb 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213303; cv=none; b=q6ngSwp/wPxoRQTQh6eWaAxXfIDJS81u4muxUDebsqEHbTf4KcPKpKRjeC4VO+dZCc5TAsE5lBm7Zqb+XJrWfPuJaIL6bha9wZGzygK9gkhQOasiotV/oQjxycg7qepK+swwzyCVXDyMps28yaHzihlgDKpq5bslY45BB/9tBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213303; c=relaxed/simple;
	bh=8H0FJttPLV+PsYZHtqc3wJOmv+iUeb1QGvPrfoVUvvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3C3NMkHwy7aC4ti91VHOTER9NJhI7CBuQwlg0w2+wf80WYcHIfIlBWCRxiHuPHNeOf2f7iybbuLAI/wFmqxqVW3Leu3HaTSVJAaNsniVy2ahyCvDrx1BngzMnoYd4UkDOUZSQT9APmn7eFG1oUvaO0LqJoVqvQJgPvEs9JttvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASZpbMJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79A1C16AAE;
	Wed,  4 Feb 2026 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770213303;
	bh=8H0FJttPLV+PsYZHtqc3wJOmv+iUeb1QGvPrfoVUvvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASZpbMJfIS+2/tmTtSZ+slpz75fuRvbg/bVChDZUtvhpFnL9Qb258Ml3XlnurNdke
	 NjAUvOy54lNBXJ51sXSxTMf8srSs3Qp5ryI8WCNGsaB+2Iyuae7EsgtfznFI1yXoZw
	 GWkYprY9Zl9JxYMatG24VyxJJnzDz6IgMt6aDYAw=
Date: Wed, 4 Feb 2026 14:54:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, wen.yang@linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: Allow to use SMP threads for backlog NAPI.
Message-ID: <2026020449-deplete-swoosh-2387@gregkh>
References: <cover.1768751557.git.wen.yang@linux.dev>
 <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
 <20260119082534.1f705011@kernel.org>
 <20260119163026.aA1PeSmP@linutronix.de>
 <2026012040-unmolded-dreaded-6e06@gregkh>
 <20260120080104.0yYtfQR7@linutronix.de>
 <2026012039-shuffle-apple-43ec@gregkh>
 <20260120103833.4kssDD1Y@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120103833.4kssDD1Y@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213382-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ECAAE6BD6
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 11:38:33AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-20 10:21:58 [+0100], Greg Kroah-Hartman wrote:
> > > > Please see patch 0/3 in this series:
> > > > 	https://lore.kernel.org/all/cover.1768751557.git.wen.yang@linux.dev/
> > > 
> > > The reasoning why this is needed is due to PREEMPT_RT. This targets v6.6
> > > and PREEMPT_RT is officially supported upstream since v6.12. For v6.6
> > > you still need the out-of-tree patch. This means not only select the
> > > Kconfig symbol but also a bit futex, ptrace or printk. This queue does
> > > not include the three patches here but has another workaround having
> > > more or less the same effect.
> > > 
> > > If this is needed only for PREEMPT_RT's sake I would suggest to route it
> > > via the stable-rt instead and replace what is currently there.
> > 
> > It's already merged, should this be reverted?  I forgot RT was only for
> > 6.12 and newer, sorry.
> 
> Jakub doesn't seem to be thrilled about this backport and I don't see a
> requirement for it. Based on this yes, please revert it.
> 
> If Wen wants this still to happen he should either provide better
> reasoning why this is needed based on the latest stable v6.6 as-is or
> ask stable-rt team to take this instead the current workaround.

Ok, both now reverted, thanks for the review!

greg k-h

