Return-Path: <stable+bounces-256445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBwVFSHSGGqTnwgAu9opvQ
	(envelope-from <stable+bounces-256445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:39:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A505FB770
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 736A53020FF6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAFA36D9F1;
	Thu, 28 May 2026 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJu+1S94"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488011DBB3A;
	Thu, 28 May 2026 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011550; cv=none; b=fZqLOq59+mmOAu6VWWlSfu+gYfPs2C/azzyA6up5YyEmwi+rqxcOoBjgpYvavtLUvZ6wiibwHyhMlSLYCAb4shLA+0B/v9vWEwAFzcFPjOQA94vs0pMyWE2fZ4PRf8yuS8UTAFuyMQ3TkpgqqB+13Sd+R3yaQ7pvMxZwZyFNWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011550; c=relaxed/simple;
	bh=iDrTPOX6GGDt+nbh9lhKPL6Ecpsqypq4y6HAaTEnrQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmoZWJHYbaYGEuyPZFNe9IFve7P4lLR5gRxKkd1kY4gKlqOOp8eXn2AKFLeljvR+FXLLkH6RKXRgphNmf0raahgXoleIOqd147bBpuZSOI196c4gPe4FTKutJsEDX8IE3g1iL/KZSRzuDbh+JkuGNfkNrkne3Y7OoujhX0tNbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJu+1S94; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B051F000E9;
	Thu, 28 May 2026 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780011548;
	bh=dmBIoxz66k2rHcSMbm0eP8qTyH3vYzffzxZnEsn0ck4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RJu+1S94uLW4cQvcEK8SoMGPhXx44RpgTo0OfCuWQXiTAHfsWbNm+PRublWTU+NKE
	 vDoQK+865o528s8QWzzsdGTESQXZJejtxmrghU8AJRmzuEJs2gIIBfha6e4qqOZHu7
	 9D0FXdHDX5u0wmB9QpOvLPxyMV/99fV8KtzhuLZiJMsGdx7+w2+ntQyDgemmHt8g3P
	 3rQJgPo5AFRxgXzF/TKi2Jg1WvJ5EXrrugkYpdnfxwpcQLsoZaw/WpeOYPwIlBzaO9
	 DefqDbXlwI1Qxg8vAmWBzsACIAhMVqqT1YAQUCeWcpKgzbDKOZ8tQWOsjBk+mrzpC0
	 Ra34TheMbeOaQ==
Date: Thu, 28 May 2026 16:39:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 0/3] selftests: mptcp: reduce bufferbloat and
 cleanup
Message-ID: <20260528163907.619420c3@kernel.org>
In-Reply-To: <0e676b57-ca1a-4f2b-8166-a085fe69e0f2@kernel.org>
References: <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
	<20260528144258.58bbc950@kernel.org>
	<0e676b57-ca1a-4f2b-8166-a085fe69e0f2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256445-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simult_flows.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C0A505FB770
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 09:13:44 +1000 Matthieu Baerts wrote:
> Hi Jakub,
> 
> On 29/05/2026 07:42, Jakub Kicinski wrote:
> > On Wed, 27 May 2026 22:11:33 +1000 Matthieu Baerts (NGI0) wrote:  
> >> Bufferbloat is baaaad, even in our selftests: let's kill it (or at least
> >> reduce it). By doing that, the tests (seem to) have a more stable
> >> transfer, and are then less unstable. That's what patches 1-2 are doing,
> >> and they can be backported up to 5.10.  
> > 
> > Could you explain a little more what this is actually fixing?  
> 
> The simult_flows.sh test simulates very low speed links using netem
> qdiscs. With the current configuration, still a large amount of packets
> can be queued, which means high TCP RTT samples and then large receive
> buffer size. Minimal inaccuracy in the pacing rate can lead to using
> only one subflow towards the end of the connection for a considerable
> amount of data, while the test expects to use the 2 available paths in
> parallel.
> 
> > Does it give a huge increase in test stability?  
> I would say no: the test was not that flaky, mainly on NIPA in fact, and
> around 4% in the last 100 tests [1]. On my side, I had to get my system
> busy to reproduce the issues. My hope is that the success rate on NIPA
> switches from 96 to ~100%. No failure since its introduction in
> "net-next-2026-05-27--15-00".
> 
> I sent them to net, just to increase the stability when validating
> stable kernels as well. But all of this is not urgent, and this series
> can be applied in net-next if preferred. Do you want me to resend this
> series targeting net-next?

Thanks for explaining, I will take these via net-next, no problem.

