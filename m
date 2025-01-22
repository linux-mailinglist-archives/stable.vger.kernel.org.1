Return-Path: <stable+bounces-110182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EE2A193AB
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CA416A1A0
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B41E214204;
	Wed, 22 Jan 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXRzybeg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8AB213E7F
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555396; cv=none; b=Frm34MeFNsnjsR41M38bCJFf2o9cHtFQwlB5wZD0AmMowIzJnHjpUK7Sg85prd1eoVk6sL4mj1InUCBu5/fx/Pyu9RK7TSpYqGQq2zdlcCOJDxtfsKj9j5I2ZbdlMGhfnyMzp4EASA85czp4qFkBhlnGP8gR0ukEy3Y1jPgOpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555396; c=relaxed/simple;
	bh=SC6gkgi6+feE4Af5JiIFgSP81AyI3L1/z2+8SQYzyFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQ7dUIV6HEMCgYMY3/3ixctVxeCN5oDlcmbRQjOYnaUwNnJe/Vvz/BEC6yMQut1f0drTxQLtlBz+suUamVRyIcyh4ZPsJ8ehlsEqT/cjWS1AXxKObkW+yuKF5CbAAowT7MIQBpz5MlZV/zn1chtJFWO2HcrCE6c7d5/k0vn/ULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXRzybeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05313C4CED2;
	Wed, 22 Jan 2025 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555394;
	bh=SC6gkgi6+feE4Af5JiIFgSP81AyI3L1/z2+8SQYzyFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXRzybeg+J4Pw6MnpH/t7SCExNBCKIWKVCGdWuwttDQ8UxiWfMsfpInzlCS69EeGJ
	 heJ+A7dgyb8ecuwgrX8huO8j9iFrVL4NUHaROUwYDL6syQHqPtgBgupcgaUAWYYcQd
	 m7ueMQaXBXIXPn9p8LUB5tmX5Lpup1jC6euXbc9yh69KpdJrNTkWykz7Uuxu0XA/YQ
	 XNSRhzene/wc9yVN9L3EoSTtzcQuMtnluGZi0Del2oHSiNFFV06gXYNHn/orE9SBnv
	 gwKSVAhRkyYItd7DZfjP152NZ8ph4z/RUJBa+onio0VxPabTfFm8Fs1MYJiojkKG4q
	 p17Qk+9WC9ecg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rajani kantha <rajanikantha@engineer.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ipv6: Fix soft lockups in fib6_select_path under high next hop churn
Date: Wed, 22 Jan 2025 09:16:32 -0500
Message-Id: <20250122082004-895dddd05e086879@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <trinity-180b6d3e-b093-4995-a9cc-fe14098ee9a0-1737538325744@3c-app-mailcom-lxa12>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: d9ccb18f83ea2bb654289b6ecf014fd267cc988b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Rajani kantha<rajanikantha@engineer.com>
Commit author: Omid Ehtemam-Haghighi<omid.ehtemamhaghighi@menlosecurity.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 34a949e7a086)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d9ccb18f83ea2 ! 1:  041d43d42e6bc ipv6: Fix soft lockups in fib6_select_path under high next hop churn
    @@ Metadata
      ## Commit message ##
         ipv6: Fix soft lockups in fib6_select_path under high next hop churn
     
    +    [ Upstream commit d9ccb18f83ea2bb654289b6ecf014fd267cc988b ]
    +
         Soft lockups have been observed on a cluster of Linux-based edge routers
         located in a highly dynamic environment. Using the `bird` service, these
         routers continuously update BGP-advertised routes due to frequently
    @@ Commit message
         Reviewed-by: David Ahern <dsahern@kernel.org>
         Link: https://patch.msgid.link/20241106010236.1239299-1-omid.ehtemamhaghighi@menlosecurity.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
     
      ## net/ipv6/ip6_fib.c ##
     @@ net/ipv6/ip6_fib.c: static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
    @@ net/ipv6/route.c: void inet6_rt_notify(int event, struct fib6_info *rt, struct n
     +		    info->nlh, GFP_ATOMIC);
      	return;
      errout:
    - 	rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
    + 	if (err < 0)
     
      ## tools/testing/selftests/net/Makefile ##
    -@@ tools/testing/selftests/net/Makefile: TEST_PROGS += fdb_flush.sh
    - TEST_PROGS += fq_band_pktlimit.sh
    - TEST_PROGS += vlan_hw_filter.sh
    - TEST_PROGS += bpf_offload.py
    +@@ tools/testing/selftests/net/Makefile: TEST_GEN_PROGS += sk_bind_sendto_listen
    + TEST_GEN_PROGS += sk_connect_zero_addr
    + TEST_PROGS += test_ingress_egress_chaining.sh
    + TEST_GEN_FILES += nat6to4.o
     +TEST_PROGS += ipv6_route_update_soft_lockup.sh
      
    - # YNL files, must be before "include ..lib.mk"
    - YNL_GEN_FILES := ncdevmem
    + TEST_FILES := settings
    + 
     
      ## tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh (new) ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

