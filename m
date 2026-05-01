Return-Path: <stable+bounces-242456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPF1NfvK9GnEEgIAu9opvQ
	(envelope-from <stable+bounces-242456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 17:47:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8670C4ADB41
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 17:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 262DB3007F52
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895B3D0938;
	Fri,  1 May 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRQhm9ud"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BF13E02A;
	Fri,  1 May 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650361; cv=none; b=peICEMnvMxir0Eus1J4sHtR7slYruqyRW0cicBLZgUsKOjcxVreQ7hZvXH4VIC4rCuKc+HIDyPLTTzhJMw2riJWDRbXn14O0S4TosNLNr9+cDJqAY+R8+5xN5PcQJ+wQrqCY2rDg4rizLnWeJJVQo5KEn9BSrCWWCQRXtfaR4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650361; c=relaxed/simple;
	bh=LZDWViGmTKhCWD2dXNJkS+yut6Rys5QsqWiU9+4akSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sox9wzT/6DcFrGax9uE9htpqOSn1A+cCJXsXHKMFE5raeGZxBOAUhwhnUEKOUmrHv7lq78vDBrGDJuWPVf9LWnKtyLJEQYDuSdFjS70Dp4Xx8iLRU+s1CufjjemUbZ8+q7VDxHT7wVU+ZsutVIxlAjnc2TnB6r7ekUHPhSWZaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRQhm9ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA23C2BCB4;
	Fri,  1 May 2026 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777650361;
	bh=LZDWViGmTKhCWD2dXNJkS+yut6Rys5QsqWiU9+4akSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qRQhm9ud5DUwCEOZeLinJbC1bOMRzuNtnoU7wuy3dvbcql+eXWFS33PQxFVNQDRj1
	 9bbxuVpMNqpGjN8hjf+VsmbdPUZW8YlRp8F1vhA4KOomJ0DDsQtmxW2xOn4GyeBcnV
	 v2G8tZCxksyiAZbcNMTqtUpMOfrWqXfbhgPYhX2pvw5fPhINn0trXrSt8Q6SCNhFH4
	 pYkeHl1CCtn3W5V+EFihadmjzYtCj6NmSLuW6NFUl9bEWb3BL7b0Jl64lqV0jcBlWQ
	 f/D51SHGLyAeB/qksjFm/mRKHS9HcNidvEYJbqHu+d8z/426/J9+A2zX/CjlrkVOO4
	 ybimtCqrlgqYw==
Message-ID: <44e564f8-d059-407b-8f5e-a149dd76dea3@kernel.org>
Date: Fri, 1 May 2026 17:45:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] selftests: mptcp: add test for IPv6 subflow SLAB
 placement
Content-Language: fr
To: Vastargazing <vebohr@gmail.com>, martineau@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, stable@vger.kernel.org,
 Florian Westphal <fw@strlen.de>
References: <20260501151454.211598-1-vebohr@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260501151454.211598-1-vebohr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8670C4ADB41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242456-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mptcp_v6_initcall.sh:url]

Hi Vastargazing,

(+cc Florian who did a similar review on netfilter ML)

On 01/05/2026 17:14, Vastargazing wrote:
> Add mptcp_v6_initcall.sh to verify that MPTCP IPv6 subflow child
> sockets are allocated from the TCPv6 SLAB cache, not the kmalloc-4k
> fallback.
> 
> tcpv6_prot_override must copy tcpv6_prot after proto_register(&tcpv6_prot)
> populates tcpv6_prot.slab. If the copy runs too early, override.slab
> stays NULL (frozen by __ro_after_init) and subflow children fall back
> to kmalloc-4k. This lacks SLAB_TYPESAFE_BY_RCU, allowing lockless
> ehash lookups in __inet_lookup_established to read freed memory.
> 
> The test exercises the IPv6 accept path via MPTCP connections between
> two network namespaces, then checks that the TCPv6 slab active object
> count grew. On a fixed kernel, the delta is ~2 * NR_CONNS (one subflow
> per side per connection); on a broken kernel, it stays near zero because
> children land in kmalloc-4k instead.
> 
> Topology: two netns connected via veth pair with /64 ULA addresses;
> NR_CONNS parallel short-lived MPTCP connections are established and held
> open long enough to sample /proc/slabinfo. The test skips if
> CONFIG_MPTCP_IPV6 is absent (checked via kallsyms) or /proc/slabinfo is
> unreadable.
> 
> Verified on Ubuntu 6.17 kernel predating the fix: TAP "not ok 1 ...
> TCPv6 slab gains MPTCPv6 subflow children" with delta=0. On kernels
> with the fix, delta is well above the threshold of NR_CONNS/2.
Thank you for adding this new test, and for having validated
9b55b253907e ("mptcp: fix slab-use-after-free in
__inet_lookup_established").

(...)

My following review comments are very similar to the ones shared by
Florian for another on the Netfilter ML.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_v6_initcall.sh b/tools/testing/selftests/net/mptcp/mptcp_v6_initcall.sh
> new file mode 100644

This should say '755', else you get

  # Warning: file mptcp_v6_initcall.sh is not executable

(Plus our CI will not validate that test.)

Me too, I'm not sure whether we should add regression tests for
regression tests sake. Else we'll also quickly accumulate thousands of
such scripts and test run time will explode. Globally, we prefer adding
a new subtest instead of a full test.

Here, you are validating an issue in the init code, that is very
unlikely to change. If a test was needed during the submission of the
original fix, I would have suggested adding a quick test in our
packetdrill repo instead:

  https://github.com/multipath-tcp/packetdrill

An existing packetdrill test could be modified to check the slabs in v4
and v6, but I'm still not convinced it is worth it.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


