Return-Path: <stable+bounces-114315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3486A2D0EC
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D0416D5EB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6B1B4223;
	Fri,  7 Feb 2025 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1peMlkO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100861AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968639; cv=none; b=jBjY8rUPJPIcrh2jJmYhG2jYdoX0SrL9LMa3hBLHNwFb3xDc1cRQdVZXnOeQruiQmD7V5bUDNd7qUl2lSvBkHFKP7WDymxgVjEgXREIx3yWOyrKntd923dFRJYvg05F6y5DdIORIDCN+7pzAv0Yq2H+6foi+7cK56U8/VRFy0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968639; c=relaxed/simple;
	bh=KJ1n++Vq1QZM9WEOu8KSVwISr6A6k5ssx7PVd3FHzbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjxPjT/t8SDXt9LM6VQh+w0MFL6EladmhbSZudGoUt2fyWkDPjAtIvpQ0K7EPHu8Sduq9h7/sTzgNQchzeS0MAhBx+apviZSdmxoL5FddVKcLNNd8yhCbYiDfF87tezqdrnFIJr4anMSkrtZFehgCy/FAcriSyJrNdboC8qRq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1peMlkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C074C4CEE2;
	Fri,  7 Feb 2025 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968638;
	bh=KJ1n++Vq1QZM9WEOu8KSVwISr6A6k5ssx7PVd3FHzbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1peMlkODpOG4tu78OFx06KpKINBNRDUfqGV1wbva9G7X6MdEhV64PpwVPfiSRMuQ
	 fYyLWtfBb3uiWgf4z/vL4YlwD40DHGhEapgXs0qGIju7IhCv8UogHCsRX+zrHi7okv
	 tB4qG9zgLMAxGhvYQZCmRzCeVdtkzADDh5NIJFbNL/9Dana6oEkMpOGn/YWRvz9EXR
	 9UmWj0vXH7dOovpg0R7jiSHhuTFq38IyYCehsrfKmKAUVj3gEJh8vxpHErkfkko6Ae
	 G+bHmfKPVPEGN0N095uBLKJB1IqstuAA1cCgpGTltMqZlXTzLEEm0rC1YOskBQLsJq
	 j9+MvQJnggvVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Liu <yifei.l.liu@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH Linux-6.12.y 1/1] selftests/bpf: Add test to verify tailcall and freplace restrictions
Date: Fri,  7 Feb 2025 17:50:36 -0500
Message-Id: <20250204175901-c3cd9d008e0ad4a3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250204222850.1993819-1-yifei.l.liu@oracle.com>
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

The upstream commit SHA1 provided is correct: 021611d33e78694f4bd54573093c6fc70a812644

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yifei Liu<yifei.l.liu@oracle.com>
Commit author: Leon Hwang<leon.hwang@linux.dev>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  021611d33e786 ! 1:  f573e53561b20 selftests/bpf: Add test to verify tailcall and freplace restrictions
    @@ Metadata
      ## Commit message ##
         selftests/bpf: Add test to verify tailcall and freplace restrictions
     
    +    [ Upstream commit 021611d33e78694f4bd54573093c6fc70a812644 ]
    +
         Add a test case to ensure that attaching a tail callee program with an
         freplace program fails, and that updating an extended program to a
         prog_array map is also prohibited.
    @@ Commit message
         Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
         Link: https://lore.kernel.org/r/20241015150207.70264-3-leon.hwang@linux.dev
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    (cherry picked from commit 021611d33e78694f4bd54573093c6fc70a812644)
    +    [Yifei: bpf freplace update is backported to linux-6.12 by commit 987aa730bad3 ("bpf: Prevent tailcall infinite
    +    loop caused by freplace"). It will cause selftest #336/25 failed. Then backport this commit]
    +    Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
     
      ## tools/testing/selftests/bpf/prog_tests/tailcalls.c ##
     @@ tools/testing/selftests/bpf/prog_tests/tailcalls.c: static void test_tailcall_bpf2bpf_hierarchy_3(void)
    @@ tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
      
     +	__sink(skb);
      	__sink(ret);
    - 	return ret;
    - }
    + 	/* let verifier know that 'subprog_tc' can change pointers to skb->data */
    + 	bpf_skb_change_proto(skb, 0, 0);
     @@ tools/testing/selftests/bpf/progs/tc_bpf2bpf.c: int subprog(struct __sk_buff *skb)
      SEC("tc")
      int entry_tc(struct __sk_buff *skb)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

