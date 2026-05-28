Return-Path: <stable+bounces-254858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wbNiOUAnGGp3eggAu9opvQ
	(envelope-from <stable+bounces-254858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:30:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F305F14EB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AE55301681C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446EB3E316C;
	Thu, 28 May 2026 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGPn3K/y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12433B6ED;
	Thu, 28 May 2026 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967803; cv=none; b=PhosaNMARI3sAyxqgCqFXj6yrZ9ZXfAYYONRM7Q7Wiv83GB+rLLeId53mrpeId1g0XVjC9rpEqkiapHx8FDl4bFuyOUCC44aN1XbPWtXye6M0rHuyaS8K/2HqaDu8oWkzhWra0iKtvwEv2t5JT7RWYt5QbWh4/+4aQkPw/eTxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967803; c=relaxed/simple;
	bh=A1Anli8CV6kkbxeXNyKboxPmva+bQB6lZqK+WPALhb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=odW+zbmMCGqrEctAIEbTHIZUYn1AlGw3TPyXAeLfjVxu1lU0ZgEu3XkJJcIOgo+8sIn6BugJv69zgAbu7Vx2nLQ8WbYbfbCqia6JqS4ixMUeQYDm6j38uKvv+SWdPVC0uR5mUUhylUYbibezOBf3LbOnGbK7RSd69kDFQxp68N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGPn3K/y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC12E1F000E9;
	Thu, 28 May 2026 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779967800;
	bh=hbKD/B8Lb7nPPNoBEvSoUuRTpiXuLg9ZFc0j5swoUIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TGPn3K/y+iANl6FJS0y108S3RYrkXqjGCECHuWX85x1BaEMbpVgc8b5YhF61PAht4
	 Rxwt2/d+To5FTyNxJyWX0wSDwj2LMqH2QeFISyxgIWkzPdN5QG71cJF77Gz7oXb52o
	 abe1GlsBFFMlaKk4A6MpmAASR8lS609q/OBwwntU+8eYUXYHxkGtsv40RC9sxdAICQ
	 qz4+WVF9yn+hTQUZQedVRXYWVrmQR728D+CEBAHek8jSlXthVbclaGLlXhZ0VRggzy
	 WrBm6FHIKoRGX7hZoQywBunfVVf4ZvNKUlNRs3uxocqUpXXFMUl2nODS8s/XTzNIpx
	 TvaQqMI099cmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CA53811957;
	Thu, 28 May 2026 11:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177996780540.882966.17298529776161153629.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 11:30:05 +0000
References: <20260526041240.329462-1-minhnguyen.080505@gmail.com>
In-Reply-To: <20260526041240.329462-1-minhnguyen.080505@gmail.com>
To: lazyming <minhnguyen.080505@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sowmini.varadhan@oracle.com, willemdebruijn.kernel@gmail.com, w@1wt.eu,
 security@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 asml.silence@gmail.com, achender@kernel.org, mst@redhat.com,
 jasowang@redhat.com, willemb@google.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254858-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,oracle.com,gmail.com,1wt.eu];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E4F305F14EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 May 2026 11:12:39 +0700 you wrote:
> From: Minh Nguyen <minhnguyen.080505@gmail.com>
> 
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> the old skb_shared_info header into a new buffer via memcpy(), which
> includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> Neither function calls net_zcopy_get() for the new shinfo, creating an
> unaccounted holder: every skb_shared_info with destructor_arg set will
> call skb_zcopy_clear() once when freed, but the corresponding
> net_zcopy_get() was never called for the new copy. Repeated calls
> drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
> TX skbs still hold live destructor_arg pointers.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
    https://git.kernel.org/netdev/net/c/98d0912e9f84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



