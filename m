Return-Path: <stable+bounces-266928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J8/YOiAXM2p69QUAu9opvQ
	(envelope-from <stable+bounces-266928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 23:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F669C94F
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 23:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U28s7e3v;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266928-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266928-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D733C300A66F
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A63A5E78;
	Wed, 17 Jun 2026 21:52:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E6386C20;
	Wed, 17 Jun 2026 21:52:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733147; cv=none; b=NjSu2x05oajh9iQTFRK6Ldnl/y02CTOpGIJGlNrkDDwArXB5sFpMgBGe/RtrvON7Eo2Ui1J9gV9ocMcm0ri2bhXrD1LQciaA83zQCuCSwXLzRdxzroAQAm0v/p/NCn6mKFrQ0RNTFPNRmmPmjP+3PIt+SrzVUTfaASImBanl+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733147; c=relaxed/simple;
	bh=u91/Gr8QP7fH6w2fiW94UDBR0FPYyTtWXCVs9PXPN8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv7jn9hTyBHFFcpIqE8n2vjvHZubPryr70N7RZq/qdxglqnxWMlEX1JDnzbk4IHWCtHYxaWlVlGZkLyf4L7PyACXJ5pcBJOhoarta99F5y+3KYySKfgo0rOu5U+B0iHpw8f87r53Qtb20f/UQrP8TrvPAKBzRYM9Mcqz80iSvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U28s7e3v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74761F000E9;
	Wed, 17 Jun 2026 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733146;
	bh=XBhULN87TTfxM8KHC3ilMiQOCnX7++hxcpXK3eSVbiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U28s7e3vr1Tib0RGPLU81tBoz9VlTgzJ9XndxETY9vLceedtJcdC2w5VUKDoTyQNn
	 +7riiQx+CuAQdhGewnNZ6pJssnCoG5cP7tVs67S8DQCxESYN6O7654PNP4bw2DTWIb
	 zf7jQ9s4BA5N6om67Gin/438ltTFd85CHX2KmfLY4c1vcCljN5Fm9lNVkdXLQpz2US
	 j/rJdnO3pZbaXiBru65m77NXt4YFnMgW9LjPJafRMUAvm9xsi8+tMc/vsOoVl/GFDE
	 5IsxmrTve1qXnFba9PYAQPqOFciuIPZ9oyMgnm9mKi8bvIVAFhs/dwRo6cXGDwoOAD
	 rVk8+4QMBVTbQ==
Date: Wed, 17 Jun 2026 17:52:24 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK
 table for parsing
Message-ID: <ajMXGIoyTqpZCvw-@laps>
References: <2026061543-superior-passerby-d597@gregkh>
 <20260617180410.271223-1-sashal@kernel.org>
 <20260617132704.0e1fe56b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260617132704.0e1fe56b@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:stable@vger.kernel.org,m:dhowells@redhat.com,m:michael.bommarito@gmail.com,m:marc.dionne@auristor.com,m:jaltman@auristor.com,m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:netdev@vger.kernel.org,m:stable@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266928-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,auristor.com,google.com,davemloft.net,kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E43F669C94F

On Wed, Jun 17, 2026 at 01:27:04PM -0700, Jakub Kicinski wrote:
>On Wed, 17 Jun 2026 14:04:10 -0400 Sasha Levin wrote:
>> Subject: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK table for parsing
>> Date: Wed, 17 Jun 2026 14:04:10 -0400
>> X-Mailer: git-send-email 2.53.0
>>
>> From: David Howells <dhowells@redhat.com>
>>
>> [ Upstream commit 333b6d5bb9f87827ac2639c737bf9613dbae7253 ]
>
>nit: you missed the "skip patchwork" header on this?

Hey Jakub,

This one is a backport crafted in response to a failed backport of a stable
tagged commit.

I followed Greg's template to sending those backports to him, but I also think
that I do want folks to review the actual backport itself.

Do you think it makes sense to add a skip patchwork header on these too?

-- 
Thanks,
Sasha

