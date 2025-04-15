Return-Path: <stable+bounces-132801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5BA8AA4E
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8AC19032EE
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE70B258CF3;
	Tue, 15 Apr 2025 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAcYFzrp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C0258CE8
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753443; cv=none; b=WAV1Kvof1drVB7UdU/0Yp/vFzmJlsXZKrbCRijlb1MxcEuFj5ENnUOia1t4FrrJAtMFn3GLN+0lSiOEzYnpERUsh2HnksicOV4TndJ9FIxF30BOf7Ms1ZKMGdDAniayj6CC2i4aj5TpMbPRWeoxwOqJG2AoMy2b8okmRSLBo4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753443; c=relaxed/simple;
	bh=fseorZ6vv1QSUJUmivRsxtIRpS8R+lHFEc66XRwFtcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6LeOxhBGiN8ehruQJVjOAMHwpC2ZcnkwiaYPl8WN2oj6lipCqK+JsgPE1vbuSgNrHIiHVpUa97vQy6iTgWsZXaAjkjDldaBuaZyLIUUn9NQy/ggMA2u7kHQb/KCyhJ1SfU2wrUMh2iFvrNU815XkEuI/nkQO4vV2rNUvK9+glk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAcYFzrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E2AC4CEE9;
	Tue, 15 Apr 2025 21:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753442;
	bh=fseorZ6vv1QSUJUmivRsxtIRpS8R+lHFEc66XRwFtcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAcYFzrph5CaAb9xB+79FMePs6P8CzOk+lKIekHbeceGX6H1xsXdWjIoS5JKpArfK
	 36QVsLx+nu4cY4kvczn1KyFjIaRD8/N6pivJs278+HmlvowctmTk3O+N4vmFD4IFlJ
	 lhp6hPt7A0NLWmg3d6BJZbjGWo7p4Tb6l22vvmb4GQor6jAe1Y/0h/4TtyIgeADYls
	 L0k/p6+YvbYYlEpGAJ8/HOhMpX2OrP4hEXj6IlxbShKuAa4LZ3KP2BhW+05zjI8HDj
	 I8ItKQveoDx+Hvf0AGKKJ8sQ/sB6wf6VW8iNYCcryIZx/GWG3JnxF2nCqPv4HwxWGS
	 GOFOqgL7+3CKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 6/6] ipv6: release nexthop on device removal
Date: Tue, 15 Apr 2025 17:44:01 -0400
Message-Id: <20250415124744-17ef78c88445aa68@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414185023.2165422-7-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: eb02688c5c45c3e7af7e71f036a7144f5639cbfe

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>
Commit author: Paolo Abeni<pabeni@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 0e4c6faaef8a)
6.6.y | Present (different SHA1: 43e25adc8026)
6.1.y | Present (different SHA1: b2f26a27ea3f)

Note: The patch differs from the upstream commit:
---
1:  eb02688c5c45c ! 1:  47cc8122c9644 ipv6: release nexthop on device removal
    @@ Metadata
      ## Commit message ##
         ipv6: release nexthop on device removal
     
    +    [ Upstream commit eb02688c5c45c3e7af7e71f036a7144f5639cbfe ]
    +
         The CI is hitting some aperiodic hangup at device removal time in the
         pmtu.sh self-test:
     
    @@ Commit message
         Reviewed-by: David Ahern <dsahern@kernel.org>
         Link: https://patch.msgid.link/604c45c188c609b732286b47ac2a451a40f6cf6d.1730828007.git.pabeni@redhat.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit eb02688c5c45c3e7af7e71f036a7144f5639cbfe)
    +    [Harshit: Resolved conflict due to missing commit: e5f80fcf869a ("ipv6:
    +    give an IPv6 dev to blackhole_netdev") and commit: b4cb4a1391dc ("net:
    +    use unrcu_pointer() helper") in linux-5.15.y]
    +    Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
     
      ## net/ipv6/route.c ##
    -@@ net/ipv6/route.c: static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev)
    - {
    - 	struct rt6_info *rt = dst_rt6_info(dst);
    +@@ net/ipv6/route.c: static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
      	struct inet6_dev *idev = rt->rt6i_idev;
    + 	struct net_device *loopback_dev =
    + 		dev_net(dev)->loopback_dev;
     +	struct fib6_info *from;
      
    - 	if (idev && idev->dev != blackhole_netdev) {
    - 		struct inet6_dev *blackhole_idev = in6_dev_get(blackhole_netdev);
    -@@ net/ipv6/route.c: static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev)
    + 	if (idev && idev->dev != loopback_dev) {
    + 		struct inet6_dev *loopback_idev = in6_dev_get(loopback_dev);
    +@@ net/ipv6/route.c: static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
      			in6_dev_put(idev);
      		}
      	}
    -+	from = unrcu_pointer(xchg(&rt->from, NULL));
    ++	from = xchg((__force struct fib6_info **)&rt->from, NULL);
     +	fib6_info_release(from);
      }
      
    @@ net/ipv6/route.c: static void rt6_remove_exception(struct rt6_exception_bucket *
      	/* purge completely the exception to allow releasing the held resources:
      	 * some [sk] cache may keep the dst around for unlimited time
      	 */
    --	from = unrcu_pointer(xchg(&rt6_ex->rt6i->from, NULL));
    +-	from = xchg((__force struct fib6_info **)&rt6_ex->rt6i->from, NULL);
     -	fib6_info_release(from);
      	dst_dev_put(&rt6_ex->rt6i->dst);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

