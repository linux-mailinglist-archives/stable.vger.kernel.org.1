Return-Path: <stable+bounces-246711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHR6CJTUA2ol/AEAu9opvQ
	(envelope-from <stable+bounces-246711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:32:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CC52BE7A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8E83113761
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36965360EF1;
	Wed, 13 May 2026 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPubm+Qa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC037756C;
	Wed, 13 May 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635769; cv=none; b=VaVpVrZgd23N+NabAasfxddKpZ3mLygphinEO+i5pI0AprYdiV/I4d/DpLlU+S2e3tBtlxGdrWVgdpK4ZeWY9pVj5CProLkp7sKUasYxSn2H+mK62PDToWXpGPc2gRXSmb7pqwdsstiENqRVP8qKslR7rdoCsZQXQsep3HhhUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635769; c=relaxed/simple;
	bh=UI60qE0xrssiwXQX/k9lqGBdzhvN8cNyoClGMjrfOxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEPxYhm8ZEyOkNEGLJ4H3G4sWora9bKH/mApyMxE3OmoyQ8ezUKYDCITmTn3Hhgsv4UL0l1B2C+QCNRoWvsfekA+O3eBpe46A3psrH1ixVcNDLJwiKkPFcAgk3/doaUaAqF3e1Op53OKhPbwJYpTZffZJLG5B5Dl81JWWJv/td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPubm+Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F95C2BCB0;
	Wed, 13 May 2026 01:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778635766;
	bh=UI60qE0xrssiwXQX/k9lqGBdzhvN8cNyoClGMjrfOxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPubm+Qa+ETRSx4xpk3PAsAhzl9n82ikv4pYFrnCd8epEV76U0+DZLyBcPHMYMPvz
	 ncqdcH9w9DokMX9BXZFP08pRXcQ+jRlIF9CZ0pCSbphgUGuQFdj9BPvGNBMSJlZ7QE
	 UN3UH0DsP/Th7MT5K5rKkFQ6VvclqfhCLeLlV1sXHVP5fNcNHJIParVZ2zTym191pi
	 Lu7WkOQogABoMmunIf54kx5mwrCEid/5LyneC48DoULQrYANZmVT5osbiQvvqPuL3k
	 1q2skli8kp1u4pqfF63H4H4aXBX4Ef8/bOHRQfsWARdvUoWs/au6mGahkmHTdcQTqJ
	 wmGMvQJusmh7Q==
Date: Tue, 12 May 2026 18:29:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 5/5] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Message-ID: <20260512182925.4b4b9082@kernel.org>
In-Reply-To: <20260512182611.7bfbebe5@kernel.org>
References: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
	<20260511-net-mptcp-misc-fixes-7-1-rc4-v1-5-5ee57cb2b7eb@kernel.org>
	<03ad4927-6bde-45c4-a90c-92ecfa0a680f@kernel.org>
	<20260512182611.7bfbebe5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B71CC52BE7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246711-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 18:26:11 -0700 Jakub Kicinski wrote:
> On Tue, 12 May 2026 15:02:20 +0200 Matthieu Baerts wrote:
> > Arf, I missed that when reviewing this patch: the 'inline' keyword
> > should be dropped here.  
> 
> I'll drop when applying

Let me take that back, IDK why the Fixes tag points to the commit that
fixes the issue for TCP. I don't think that commit broke MPTCP did it?

Also there's a review in netdev's patchwork for patch 2.

