Return-Path: <stable+bounces-160108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5CAF803A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBE55844CD
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA242F5495;
	Thu,  3 Jul 2025 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUCueBOu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21D2F548E
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567695; cv=none; b=c2RaeFrHEAnsFIWwY5J2mOmJ3M/82J3VoBgIDLtFvoi+YCrVjMT5a4MtJEgJNpoFMeuyy2tKmIw2yiNdzj/7ZI0jxoxsE8ZlW9jXlDAOihUxMCRAb41z9V3QNGqt/zawkaj+43WACnmFzViSHTlKfk6ISO40ivspLQ/YDJ4JLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567695; c=relaxed/simple;
	bh=tT1YF7mTaeT/SIZqpau5SiXfk4l3OBSB7U2My8Fb6ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ku2owHoDeGUBtU1IlhUEsqTT0r4bJX+oFHyx4v6qGyaimwxXUJNSiyNibI+WMuVSzMZ4s4VsJlYwlxc+Lj19tuDu10wSU0fwJ4keemRSWrl34YF3Iq2133YsJfKSsvU3/9Uz0IViAe82ob0lTfFXE+NBTT9FuSw5hvZpzUq3+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUCueBOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F6DC4CEE3;
	Thu,  3 Jul 2025 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567694;
	bh=tT1YF7mTaeT/SIZqpau5SiXfk4l3OBSB7U2My8Fb6ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUCueBOuiQJX1yzIGhzaGAPO1RvB1dsUyO4FstkKGTrR1Bj0aSou343WlVVRaUcHc
	 OJ4KKw5sCO04HlIbr5MRViEmg9etFhhJUYQxbkLFZksX3W/R8Igpja41xlTeMhBSb7
	 5lHvNvmE96qZmUQKDXodJkLikb2rTZ6ztUW4iAwEj5L+Iiba66fTCbqVaVotFDfmhw
	 J20nlhahByquFuUivEehsuS3TqYwS8SFJVR65ZpDPfj+Nnm6PObAP7OCGmmSTsBWLT
	 kPChMIS5LYZqq/mfpdMZTOh6a0TkgmcBvcRx6eAMAb6kUfp/R0eatcEPz+F5USgb3o
	 SQhYHpmyVjRTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] Revert "ipv6: save dontfrag in cork"
Date: Thu,  3 Jul 2025 14:34:53 -0400
Message-Id: <20250703120155-30b7f044e0f177b2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702113731.2322-2-bacs@librecast.net>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Brett A C Sheffield<bacs@librecast.net>
Commit author: Willem de Bruijn<willemb@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: c1502fc84d1c)

Note: The patch differs from the upstream commit:
---
1:  a18dfa9925b9e ! 1:  5a27b7b998176 ipv6: save dontfrag in cork
    @@
      ## Metadata ##
    -Author: Willem de Bruijn <willemb@google.com>
    +Author: Brett A C Sheffield (Librecast) <bacs@librecast.net>
     
      ## Commit message ##
    -    ipv6: save dontfrag in cork
    +    Revert "ipv6: save dontfrag in cork"
     
    -    When spanning datagram construction over multiple send calls using
    -    MSG_MORE, per datagram settings are configured on the first send.
    +    This reverts commit 8ebf2709fe4dcd0a1b7b95bf61e529ddcd3cdf51 which is
    +    commit a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a upstream.
     
    -    That is when ip(6)_setup_cork stores these settings for subsequent use
    -    in __ip(6)_append_data and others.
    +    A regression was introduced when backporting this to the stable kernels
    +    without applying previous commits in this series.
     
    -    The only flag that escaped this was dontfrag. As a result, a datagram
    -    could be constructed with df=0 on the first sendmsg, but df=1 on a
    -    next. Which is what cmsg_ip.sh does in an upcoming MSG_MORE test in
    -    the "diff" scenario.
    +    When sending IPv6 UDP packets larger than MTU, EMSGSIZE was returned
    +    instead of fragmenting the packets as expected.
     
    -    Changing datagram conditions in the middle of constructing an skb
    -    makes this already complex code path even more convoluted. It is here
    -    unintentional. Bring this flag in line with expected sockopt/cmsg
    -    behavior.
    +    As there is no compelling reason for this commit to be present in the
    +    stable kernels it should be reverted.
     
    -    And stop passing ipc6 to __ip6_append_data, to avoid such issues
    -    in the future. This is already the case for __ip_append_data.
    -
    -    inet6_cork had a 6 byte hole, so the 1B flag has no impact.
    -
    -    Signed-off-by: Willem de Bruijn <willemb@google.com>
    -    Reviewed-by: Eric Dumazet <edumazet@google.com>
    -    Link: https://patch.msgid.link/20250307033620.411611-3-willemdebruijn.kernel@gmail.com
    -    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
     
      ## include/linux/ipv6.h ##
     @@ include/linux/ipv6.h: struct inet6_cork {
      	struct ipv6_txoptions *opt;
      	u8 hop_limit;
      	u8 tclass;
    -+	u8 dontfrag:1;
    +-	u8 dontfrag:1;
      };
      
      /* struct ipv6_pinfo - ipv6 private area */
    @@ net/ipv6/ip6_output.c: static int ip6_setup_cork(struct sock *sk, struct inet_co
      	}
      	v6_cork->hop_limit = ipc6->hlimit;
      	v6_cork->tclass = ipc6->tclass;
    -+	v6_cork->dontfrag = ipc6->dontfrag;
    +-	v6_cork->dontfrag = ipc6->dontfrag;
      	if (rt->dst.flags & DST_XFRM_TUNNEL)
    - 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
    + 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
      		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
     @@ net/ipv6/ip6_output.c: static int __ip6_append_data(struct sock *sk,
      			     int getfrag(void *from, char *to, int offset,
      					 int len, int odd, struct sk_buff *skb),
      			     void *from, size_t length, int transhdrlen,
    --			     unsigned int flags, struct ipcm6_cookie *ipc6)
    -+			     unsigned int flags)
    +-			     unsigned int flags)
    ++			     unsigned int flags, struct ipcm6_cookie *ipc6)
      {
      	struct sk_buff *skb, *skb_prev = NULL;
      	struct inet_cork *cork = &cork_full->base;
    @@ net/ipv6/ip6_output.c: static int __ip6_append_data(struct sock *sk,
      	if (headersize + transhdrlen > mtu)
      		goto emsgsize;
      
    --	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
    -+	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
    +-	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
    ++	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
      	    (sk->sk_protocol == IPPROTO_UDP ||
      	     sk->sk_protocol == IPPROTO_ICMPV6 ||
      	     sk->sk_protocol == IPPROTO_RAW)) {
    @@ net/ipv6/ip6_output.c: int ip6_append_data(struct sock *sk,
      
      	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
      				 &np->cork, sk_page_frag(sk), getfrag,
    --				 from, length, transhdrlen, flags, ipc6);
    -+				 from, length, transhdrlen, flags);
    +-				 from, length, transhdrlen, flags);
    ++				 from, length, transhdrlen, flags, ipc6);
      }
      EXPORT_SYMBOL_GPL(ip6_append_data);
      
    @@ net/ipv6/ip6_output.c: struct sk_buff *ip6_make_skb(struct sock *sk,
      	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
      				&current->task_frag, getfrag, from,
      				length + exthdrlen, transhdrlen + exthdrlen,
    --				flags, ipc6);
    -+				flags);
    +-				flags);
    ++				flags, ipc6);
      	if (err) {
      		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
      		return ERR_PTR(err);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

