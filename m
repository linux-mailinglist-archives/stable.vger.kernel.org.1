Return-Path: <stable+bounces-110176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463AAA193A4
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578C716A252
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA60214213;
	Wed, 22 Jan 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlwOBoab"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478B213E7B
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555382; cv=none; b=Ia0sZli+RdOFzcnbomhweo2+GZaI8h2KKeBNgb4us62gxjYowiebC69Je4lSAVqMVYdKvTuYLGR9NK5xijTN5XIk6G143AtdROkV1P+0qdPU1LGhigMYMbDgnxQkgTdpUTw7ghgMuXSpu7jNOV1MB5/kvCCWH+kziJT/qI+eMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555382; c=relaxed/simple;
	bh=DGY2gWqQMYrthDbJLcPfQPw02ju9xPIxQfsPetuZ6T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ccZn/zEeQRH+zJxi61DejRn/ycXtPtI2IU/uq0klaXCwmaN4wd16JeV5FwJcye/2o3qEVdJ0SYDGqxhX3BxsxX2La+etWRKmQJ7sySNSZ4dPwmrfir0wVTm2ePL3QN03CYeq9tofdLoemMXnymjJpKjs+eBwX8ERCvMCAFfa8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlwOBoab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C29C4CED2;
	Wed, 22 Jan 2025 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555382;
	bh=DGY2gWqQMYrthDbJLcPfQPw02ju9xPIxQfsPetuZ6T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlwOBoab8lPaq0KhfA3zQ6hxDg1y4EmAbl+El7HeuZWimmJQc0jTfVuOsp4B5NzrV
	 q2P8/ridGlXRsePlWfW8lGRAVDl3FRSMNGe55gVrsW08ZqxBwnLzc2Svv0zxaOPy/z
	 WNtnrZXV8jwzeScBqPVvd/NOVRNs8fmtapmzucJHNETIN9RWB4XQNhSjOepflvU5Vu
	 QGLWHDU5fcbn0OKhGz3N0hMdIjmrppJG0wE1B/qMMVO+P/+wloqgtcqnN2THVdVRRR
	 Lmip7eOAbAU4DkWekKBgUFmqRJeYxQmmLDmTefrQZnx9U0E2pS0xJLA8rz7vS3IZTX
	 hDxPQDB2H28cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rajani kantha <rajanikantha@engineer.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] ipv6: Fix soft lockups in fib6_select_path under high next hop churn
Date: Wed, 22 Jan 2025 09:16:20 -0500
Message-Id: <20250122082916-3165cf02b59b56fb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <trinity-a30632ee-6696-444d-a0dd-76e9e929e6cc-1737535705261@3c-app-mailcom-lxa12>
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

Note: The patch differs from the upstream commit:
---
1:  d9ccb18f83ea2 ! 1:  0728fd5237ce0 ipv6: Fix soft lockups in fib6_select_path under high next hop churn
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
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
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
    +@@ tools/testing/selftests/net/Makefile: TEST_PROGS += test_vxlan_mdb.sh
    + TEST_PROGS += test_bridge_neigh_suppress.sh
    + TEST_PROGS += test_vxlan_nolocalbypass.sh
    + TEST_PROGS += test_bridge_backup_port.sh
     +TEST_PROGS += ipv6_route_update_soft_lockup.sh
      
    - # YNL files, must be before "include ..lib.mk"
    - YNL_GEN_FILES := ncdevmem
    + TEST_FILES := settings
    + TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
     
      ## tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh (new) ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

