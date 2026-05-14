Return-Path: <stable+bounces-247219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DfJF5LhBWpsdAIAu9opvQ
	(envelope-from <stable+bounces-247219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:52:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C236543811
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECA323033212
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685C0407582;
	Thu, 14 May 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy9q5sO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEB3DFC6B;
	Thu, 14 May 2026 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769441; cv=none; b=MUd6awukdO19Emo2wJHbhUs6d+JU1zO0aK96Wg/2Xeu8wXSd9YJ1/Kyh/cChxO4/olYkh/EEB4e+oarW1AYE7veM4+KsY2PJn8pbYXPFpWdQLb2z7/UJLqomSP0dcwvOZZblZ5blrdMLEZ0e3Wnuif/9fGOZ7TH2rB6wnPR7ERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769441; c=relaxed/simple;
	bh=hMeBZNi1IVe/BW6Daa6AdaTyoKeOM1QtRIG/C6ugctA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maj7PDchoo4iUfntnoFIlwBRJoa3/TTBQrSMNm9H3/pmR7r8YM7l3n6uEA9/nk74ogqSPm5OWON3mcQrexcMvz59xa6eOiOezrugpHmtDoOWDUy+YsIrnu5Yos4aqa4ygWuxb6ksUGS70sHuldXWHK9+qZqiCGnH+RgNqDTFd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy9q5sO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A73DC2BCC7;
	Thu, 14 May 2026 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769440;
	bh=hMeBZNi1IVe/BW6Daa6AdaTyoKeOM1QtRIG/C6ugctA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fy9q5sO8jN+0avC9Pil/hEm2S/HpZLTKnYDd3hK76Pj2oboNYSCkNgRQIXei4sDjP
	 BpZbaLb2LxcRpNZw0DWVjiFDPaMp9VhJM9xir6Akn2HYchHDneKCz8VtfdN3PnGcSM
	 wM0gSGbry95vKeGxEyDGmgm8Jozv5Jk4uNTBny2LjxnRn2KFYEdHnZK3evpu9SvxBf
	 sK8kPTdL0aql7WXwpiSJzdNSQcqlvyNFyQfnPZHpIwSvntXkCTJyn+EbvyVNTnQQ9q
	 cgFyLrDSMwwTK9WFBRTSz4DY3Zz5wZ3Xfcp/GYRLnzBRECxYln/5gQ6NgdLOxCiEEr
	 QWbncE60ez3VA==
Message-ID: <69f72d09-8054-4d26-b277-9e9b7a8854c1@kernel.org>
Date: Thu, 14 May 2026 08:37:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>, Hyunwoo Kim <imv4bel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org,
 steffen.klassert@secunet.com, netdev@vger.kernel.org,
 stable@vger.kernel.org, mhal@rbox.co, davem@davemloft.net, horms@kernel.org,
 edumazet@google.com, kerneljasonxing@gmail.com, herbert@gondor.apana.org.au,
 vakzz@zellic.io, kuniyu@google.com, jiayuan.chen@linux.dev,
 ben@decadent.org.uk
References: <agToIEDI4TaTNLRb@v4bel>
 <92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com> <agWYGuJ__OtpgjnB@v4bel>
 <agWiDlvu351MSuqO@krikkit>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <agWiDlvu351MSuqO@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C236543811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247219-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[queasysnail.net,gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,secunet.com,vger.kernel.org,rbox.co,davemloft.net,google.com,gmail.com,gondor.apana.org.au,zellic.io,linux.dev,decadent.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/14/26 4:21 AM, Sabrina Dubroca wrote:
> 2026-05-14, 18:38:34 +0900, Hyunwoo Kim wrote:
>> On Thu, May 14, 2026 at 10:04:29AM +0200, Paolo Abeni wrote:
>>> On 5/13/26 11:07 PM, Hyunwoo Kim wrote:

>> Agreed. tracing SKBFL_SHARED_FRAG propagation paths one by one is
>> not a robust direction for the fix. Even minor logic changes elsewhere
>> could cause the issue to resurface.
>>
>> As a follow-up,	eliminating the in-place handling in esp_input -- accepting 
> 
> It would close this group of vulnerabilities, but there are other
> parts of the networking stack that consume this flag. For those,
> chasing missing flag propagation is still a useful task.
> 

Seems like this should be an skb helper to manage the flag with really
good documentation on when it needs to be set, reset and propagated.

I walked skbuff.c yesterday as well, and there are several places where
it is not clear if the flag needs to be propagated or not.


