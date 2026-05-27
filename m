Return-Path: <stable+bounces-254464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGvQACRQFmqxkgcAu9opvQ
	(envelope-from <stable+bounces-254464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:00:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE025DE735
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E533D3013A62
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0E34DCD7;
	Wed, 27 May 2026 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv8+aPQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1730342177;
	Wed, 27 May 2026 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847200; cv=none; b=an9/C8tJ/rLXKbjk2yZGQdSGO0USFljJUFRBAfSj36NYzzPtGqYK6HfcwfqE2uTOY5wi8shdTDMQKWvuNE0FULmhNIL20ctmyZinyLGwQF8F2OkeQuQ3jczKbAfUi5DWcEJZClOqGTq+WMCi1B4CxRreQXmfDxKgQdUrnXHwdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847200; c=relaxed/simple;
	bh=9VgnWe+0iu6IzRhws/A73cl4G2v7zJY+Rke7gujGQxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eDbgL04lganDHvCgnEJP4AfFJuQ8VEkfSgPdTPkiHVtqw7sak6ayW/x6mBmF3DgIu+D//m7jAgZoiCcmkqCQ8hX+5j/G9T8dqYkMMFFFx1BIlnzR9I0LJiGoO3dVKsPUwu7U02KZGT7gH6tuxpzxYsy1oow51rdIkPUn4mka/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv8+aPQM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EB21F000E9;
	Wed, 27 May 2026 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779847199;
	bh=jrF/RTmW89hmyKXUb11K0BLFoYBzd+jgy4Y0Yg4BjDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cv8+aPQMp8QlFGvTBdpDCzkkAtbKdbfmbxeCRmWirCwtA03luGMxsX2ngQAuoar5W
	 IhlwE2zvGDqe0pXZVm0Py/wmWE8JMQDSmdcqEDsX+hy2qglX0vto73kAJruzWX/Zf0
	 /voW2TQYIeRmC831+M2a6uanW/+Yeix83hCLaNs8XMqA8gG7FR3KgorVYUlHfp3hIo
	 VG/Q7YDEyugRbsre0SaodL6lqhDidcXKTilym+90tpCpzNLsTKACSE43ctqLiZ2fyp
	 mwmBpPsH+X0amArvZKZ9ea24IB8FT8zyTFAK5ojm9k2cILAvpZOab/cyB6sMdLUkHn
	 0k9KmIpBWwkig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BA7380CEED;
	Wed, 27 May 2026 02:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ipv6: validate extension header length before
 copying
 to cmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984720515.4049208.7153214735821634479.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 02:00:05 +0000
References: <20260523143245.2281415-1-tpluszz77@gmail.com>
In-Reply-To: <20260523143245.2281415-1-tpluszz77@gmail.com>
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254464-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7AE025DE735
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 May 2026 22:32:45 +0800 you wrote:
> ip6_datagram_recv_specific_ctl() builds IPV6_{HOPOPTS,DSTOPTS,RTHDR}
> cmsgs (and their IPV6_2292* legacy counterparts) by trusting the
> on-wire hdrlen byte (ptr[1]) when computing the put_cmsg() length.
> The length was validated only at parse time (ipv6_parse_hopopts(),
> etc.).  An nftables payload-write expression can rewrite hdrlen after
> parsing and before the skb reaches recvmsg; the write itself is
> in-bounds but put_cmsg() then reads up to ((hdrlen+1) << 3) = 2040
> bytes from an 8-byte header.  nftables is reachable from an
> unprivileged user namespace, so this is an unprivileged
> slab-out-of-bounds read:
> 
> [...]

Here is the summary with links:
  - [net,v5] ipv6: validate extension header length before copying to cmsg
    https://git.kernel.org/netdev/net/c/dd433671fef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



