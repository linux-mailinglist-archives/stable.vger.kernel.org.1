Return-Path: <stable+bounces-136757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A89BA9DB1B
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4C1689D3
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757F114037F;
	Sat, 26 Apr 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAdu9thO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367061AAC4
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673834; cv=none; b=YdYlTbszyJ6jK1/L5yvmZrgRdWY7eKejEudUgAagVt03K2nSbmMbsDrUS3GZvYOmiobryiDZBNokMz6K/Rdx1PMelaF/fZJkLssqesGT8mAqgU9lbZsSh2Toxy5yr6Yke/5mrsudj+Lk7VWCIdoj3isdjIQ4OiNvlR2mF7cGvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673834; c=relaxed/simple;
	bh=JAacyKl8sc2XJpT90w5A0ZhpJ5qBZUMgjEckl8jeMHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eg77WP78Mknduf0N9n3KZC8U8cZbafiv8PJqi8ZFVnB1hmhn1PPqhPxmNipx3YuxFnypcbI3DH4VelMLq1BoO2POd7K9l7RJAak4DECuznP/c7yydebsuBJ7yq61CdeLRURcMUCyP4m/6aLzOgRTyTMTZq9Bf6dQM5Dc9Yr0zvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAdu9thO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FB0C4CEE2;
	Sat, 26 Apr 2025 13:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673833;
	bh=JAacyKl8sc2XJpT90w5A0ZhpJ5qBZUMgjEckl8jeMHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAdu9thOfhOYfmn6Cv3Tureb6hROTa+F4Gh7xeRrIApEYh5Cn9Kp3rT1/hvwvF1gl
	 oqLjXpqWx6kLeCOZsaUe8aSOyEle2VZd6oCHRNC0kOYUENkeU0xkT6WQ3tPwK8PSxh
	 tQuFzkTBWjhncpLh1caQNw1iNPPFitGVrlhG25eMFNjIOky3zys4ZOP0v48qVIAu5f
	 oKMtg0jsxO66BcGA0AFjNyMKSvKjlMh9fFSV1B/ajIXBaJ6XTyCp/PmOu0LszmlGOA
	 C1wfcbiO6Kl21eb4WOxHB1YlZiTKMBOk/IkPJVNlurBs8clR0lWWwZSn5GlVbUc75j
	 X+RqUlLR8ga1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 4/4] selftests/bpf: Adjust data size to have ETH_HLEN
Date: Sat, 26 Apr 2025 09:23:51 -0400
Message-Id: <20250426052146-875b0767c07d29cf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250425081238.60710-5-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: c7f2188d68c114095660a950b7e880a1e5a71c8f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Shigeru Yoshida<syoshida@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  c7f2188d68c11 ! 1:  cccb0c9fae094 selftests/bpf: Adjust data size to have ETH_HLEN
    @@ Metadata
      ## Commit message ##
         selftests/bpf: Adjust data size to have ETH_HLEN
     
    +    commit c7f2188d68c114095660a950b7e880a1e5a71c8f upstream.
    +
         The function bpf_test_init() now returns an error if user_size
         (.data_size_in) is less than ETH_HLEN, causing the tests to
         fail. Adjust the data size to ensure it meets the requirement of
    @@ Commit message
         Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
         Link: https://patch.msgid.link/20250121150643.671650-2-syoshida@redhat.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Fixes: 972bafed67ca ("bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()")
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c ##
     @@ tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c: static void test_xdp_with_cpumap_helpers(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

