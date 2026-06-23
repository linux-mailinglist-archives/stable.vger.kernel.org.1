Return-Path: <stable+bounces-268035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZiMmIVT1OmpGNAgAu9opvQ
	(envelope-from <stable+bounces-268035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 23:06:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E16BA309
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 23:06:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IX6onWwp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268035-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268035-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C42A3013A50
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3D3AE1B8;
	Tue, 23 Jun 2026 21:06:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386D242D65;
	Tue, 23 Jun 2026 21:06:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248775; cv=none; b=oA75UR7Vo52/UPrg+rDNEp+3aIZ3UFNFnJEnurtA3jF1Ls8Cmq5dsmjrhuJg9aAEpBAlC9dyJswq4lma1igARqEj0ap5ExC45Vu6+t5LDt5jGl8yLO/O2/INxhPC+Fedvi/0Q8iJd1f83AspPdyK7L1WYGUt6wNzRtJzsGeIy00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248775; c=relaxed/simple;
	bh=OmlqrksIMUEC1pIlVjNzTHZ3h4FHLGXpP7MGs0ygmGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4miEMPO3nb1ZuKGEEkAM2930Ia3QqcmUdK9u1zub5RQ4a9aI79TSLBBbTw1D0M01XTITDVrRbLftnk1PeY6VXJnRrsfesta5bbJXuFqFMmzML3aI674mcANNsXthat3XHraCjfQhA4wZX6U+aTCPbAPbTTr00Z4e83uxr9fko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX6onWwp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB22B1F000E9;
	Tue, 23 Jun 2026 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782248774;
	bh=btyawJkQsfw1oo8Y8zJTe7hXSr4b47wC/ZxD1Tk/dK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IX6onWwp1kbVy+CNiR//uNY4MHHZgO5uLW/VlBe5x8DKjYocFDm+FAYBlHKrf2uR4
	 MUe+1G4KJt9A8WvCS745WUjKVBKoY8pZ0VyJbC9TBH0QeeUOPFZST2wRSnCPQjzEVT
	 bNsH1Btdhloxo5f5RHJzRMO+0M1ZgAE0TGyf6jFI4NNnelcxg1+m15gf94O7VMiVjE
	 06yOi+F7Mt3wuoxW5dYOvkoRgXVYCf1FsdujZC4f7rEaphxYPH+ofe20iPNdu1r5Yy
	 u2JTapvc0a0601PiRH20OcVwmMP9QKt8UnsCFTCmbKXUhJKGzzDmhLCEXEb4GdSyK0
	 AlUXAeCFYP6Dw==
Date: Tue, 23 Jun 2026 14:06:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: Alex Elder <elder@ieee.org>, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: ipa: fix SMEM state handle leaks in SMP2P init
Message-ID: <20260623140612.0c7be551@kernel.org>
In-Reply-To: <526c68fd-684d-4593-8c6a-e08aafdada5d@ieee.org>
References: <20260623031831.1788454-1-haoxiang_li2024@163.com>
	<526c68fd-684d-4593-8c6a-e08aafdada5d@ieee.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268035-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:elder@ieee.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 467E16BA309

On Tue, 23 Jun 2026 10:53:49 -0500 Alex Elder wrote:
> So I guess they were never "put" before?
> 
> This looks OK, but I'll just mention that the IPA code
> doesn't use devm_*() (managed) interfaces.  So it would
> be more consistent to just call qcom_smem_state_put()
> at the end of ipa_smp2p_exit() for both ipa->enabled_state
> and ipa->valid_state.

Let's do that instead. The devm_ APIs prevent about as many bugs
as they cause.

