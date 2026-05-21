Return-Path: <stable+bounces-253493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEuYL1TYDmqfCgYAu9opvQ
	(envelope-from <stable+bounces-253493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:03:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A91525A2DE7
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 155CD3004D06
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B937AA6D;
	Thu, 21 May 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRYbInq/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2937BE60;
	Thu, 21 May 2026 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356996; cv=none; b=f8MoV2fHnu9Vb8yjNam2XpKiWwmrBpEhkpmFFuCLoeMeoqjuaueTjekhkTZ3iWbwhHMWXppRW1raiYL1Iy0BmRwhxqluIBy8dLJm86p9a/eg/26pr76opxDtzjrKt4iekQmMvd8mv3cdF4Eu68gU6qwTxWqfK5ZD9Hz/g8foDwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356996; c=relaxed/simple;
	bh=HTKoM62XzHAkVnGdFSshqg8uG1E2BDoZM80JQvmfFhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oG6Ux1F8dMZ9f4QErpqAhX2QX+x9BbJx0mEmRvgoEJyZ2gEPAzaEoPudjMiwvw5/ujiXPFhUcOiJuLN4cKfKYWAlexvz/iCjyHiwHQUZV3I/PAY90GOdIA8XKchv9WNDZYPWx4SdY/Ow9a+xWYNyutZu+rt9r8fYLPZvXORjcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRYbInq/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2251F000E9;
	Thu, 21 May 2026 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779356995;
	bh=QX9iO5UfA8lFU9S3G/bX3+/LNHn4Gm1KTOMQQAuGHeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DRYbInq/PiPR0vAKiZhQWKeeqo9IXTLJBybKkhLrQDxKjxzHQrhjC78sovy9PO3Gu
	 0pGjZJfx/+p7RIYm/1fdpI/BJKxyPF/4yQqTHSn4C2mXhP5dl9xxR3aon3cF92ohcu
	 J+QGbnutifrEjyzao/qNtNIgBE5BzUlHYxuZO1gAgf2vqpAUb25l0g03+5HIf8QzZ6
	 O8kNZhNOcjc7S6oUFsarUQb1Gx/rK2VB7qMB3E4lv51Tp87qVH8JgUJJZty7GYKdEJ
	 dsrS+IRWCOI+AzWUYnA/P4iLyAwpcKY2EdFf4mOI68/ubNsUTXJzdFXpKX+Xk+wXCm
	 UNVa22pYXumNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396C3930D21;
	Thu, 21 May 2026 09:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177935700540.4004798.18308856421484516932.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 09:50:05 +0000
References: <ageeJfJHwgzmKXbh@v4bel>
In-Reply-To: <ageeJfJHwgzmKXbh@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
 kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
 steffen.klassert@secunet.com, ben@decadent.org.uk,
 herbert@gondor.apana.org.au, dsahern@kernel.org, sultan@kerneltoast.com,
 sd@queasysnail.net, malin89@huawei.com, tanjingguo@huawei.com,
 aaron1esau@gmail.com, netdev@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,decadent.org.uk,gondor.apana.org.au,kerneltoast.com,queasysnail.net,huawei.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253493-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A91525A2DE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 16 May 2026 07:28:53 +0900 you wrote:
> Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
> to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
> moving frags from source to destination.  __pskb_copy_fclone() defers
> the rest of the shinfo metadata to skb_copy_header() after copying
> frag descriptors, but that helper only carries over gso_{size,segs,
> type} and never touches skb_shinfo()->flags; skb_shift() moves frag
> descriptors directly and leaves flags untouched.  As a result, the
> destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: skbuff: propagate shared-frag marker through frag-transfer helpers
    https://git.kernel.org/netdev/net/c/48f6a5356a33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



