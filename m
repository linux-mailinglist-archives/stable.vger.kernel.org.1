Return-Path: <stable+bounces-224898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOTeFa/3smmLRAAAu9opvQ
	(envelope-from <stable+bounces-224898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:28:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 507702768D3
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55A1B3026058
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5553C3434;
	Thu, 12 Mar 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jfBnM8IG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3837B03B
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336488; cv=none; b=RxVz1nJ3oMMUkoGbmqE6580Kt0zkcOFZzhPJTBAhUVuUyfu0rcMYGFp0CqKxrHWs+CCsGgTWjMeXHSmSgQ+BdmAcjKMb7/nb/+qr0TMrG1/nv49dUkH1Je8P0/wN1njiX+hUwWT4+daK/nRpz2hWa3UdIVDcoNtmO9ec/W4LbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336488; c=relaxed/simple;
	bh=r4N/H3iHwmT0NdlM6rxKsF1IU1ZtLVPCrOohIaM2NoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4ECFnuP4v8ZN60GvAtM548M+QVh+9+8VoOGO9AC304w0DugGHgLp0U6IapKeX+yuDUXeDPdnQmF2z75ClTdHj89C6NRs9I14GncnzBbyAO7LIRgK01QXEKZFx6Tt7RzKcxXXc8enWZIsttt2p46Z8lsIv0hl32ZL0Pfl+zwri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jfBnM8IG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593D3C4CEF7;
	Thu, 12 Mar 2026 17:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773336487;
	bh=r4N/H3iHwmT0NdlM6rxKsF1IU1ZtLVPCrOohIaM2NoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfBnM8IGE4tDTcOhsuBbbDJ3+2VLJbEgOwiJ7QwQL5du2zfP8ybfi16ajbxhC986Q
	 +X4IvjJmqdRB651v33g7o0BPL+jHQrYgbaHv2k3ouJoO/rQuAMH7Bwmo+Mmx08HKLY
	 ttB0Lp7s9uH98snnf7PA0gM6F0+s0/cRVGDoOygI=
Date: Thu, 12 Mar 2026 18:28:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
	GangMin Kim <km.kim1503@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] net/sched: Only allow act_ct to bind to
 clsact/ingress qdiscs and shared blocks
Message-ID: <2026031237-blurred-tricolor-b266@gregkh>
References: <2026031221-tissue-upgrade-f4d3@gregkh>
 <20260312171857.1797148-1-sashal@kernel.org>
 <20260312171857.1797148-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312171857.1797148-2-sashal@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224898-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 507702768D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 01:18:57PM -0400, Sasha Levin wrote:
> From: Victor Nogueira <victor@mojatatu.com>
> 
> [ Upstream commit 11cb63b0d1a0685e0831ae3c77223e002ef18189 ]
> 
> As Paolo said earlier [1]:
> 
> "Since the blamed commit below, classify can return TC_ACT_CONSUMED while
> the current skb being held by the defragmentation engine. As reported by
> GangMin Kim, if such packet is that may cause a UaF when the defrag engine
> later on tries to tuch again such packet."
> 
> act_ct was never meant to be used in the egress path, however some users
> are attaching it to egress today [2]. Attempting to reach a middle
> ground, we noticed that, while most qdiscs are not handling
> TC_ACT_CONSUMED, clsact/ingress qdiscs are. With that in mind, we
> address the issue by only allowing act_ct to bind to clsact/ingress
> qdiscs and shared blocks. That way it's still possible to attach act_ct to
> egress (albeit only with clsact).
> 
> [1] https://lore.kernel.org/netdev/674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com/
> [2] https://lore.kernel.org/netdev/cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org/
> 
> Reported-by: GangMin Kim <km.kim1503@gmail.com>
> Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
> CC: stable@vger.kernel.org
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Link: https://patch.msgid.link/20260225134349.1287037-1-victor@mojatatu.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/net/act_api.h | 1 +
>  net/sched/act_ct.c    | 6 ++++++
>  net/sched/cls_api.c   | 7 +++++++
>  3 files changed, 14 insertions(+)

Ah, it was some trivial fuzz, I've just taken this and not patch 1/2 as
that is a new feature not needed here.

thanks,

greg k-h

