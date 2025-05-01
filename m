Return-Path: <stable+bounces-139372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981DEAA6387
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE8462E91
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D479215191;
	Thu,  1 May 2025 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTPgwqVm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F3224B12
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126610; cv=none; b=G/+YoCX4L/7eVQ4RMK5rw4pcjV77C30LlkWEl18rShqoV/fCF1AsEZT0gbvMY8gyhD+rT6O3f326+NNbeQ7JgOY29QI3o/9I0gsnhXaJ9WENBhvcMMxiAWAr4F6RRDT9e2YuAxcZGyZp8Rrhq4eZos1q72v3jnByOvL33NdOgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126610; c=relaxed/simple;
	bh=kQdevxmNerGORbT10JQD7lXh2N6eKszmpGF2Vmn/abc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o71G7RKF5ZBmTlaIvPbPx3G+YN1HGQkgIXVPc5nPAUQq9jq+72y/aiy2GhztMto/bIWCzHbi7Q/daS00wPVsx2alyrDwQ4uqGbWpJkV4tLpjOW/7o85dW8YW3F2b6Si/Y0cTu/Y2HXeJqOuP4+5AtRQUbLlLS4grEonyupnproM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTPgwqVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD31C4CEE3;
	Thu,  1 May 2025 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126610;
	bh=kQdevxmNerGORbT10JQD7lXh2N6eKszmpGF2Vmn/abc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTPgwqVmwi5mP1f0deilWaqoAkCSip7y8ky01ilpbUE50pwd+brP7DdbNBzvEx5Gz
	 yuTQ0Lg9Mhrmy0E3Q7JzGKrRIE7PRDppN0sFuKTS9sfWYtNRT60IvaOb9Q2UaGO7td
	 3DU1RPXWgQYaqV+YZiuTI1Thed2k0vuw20LtCSImP8LTQvIu6hw4/ay4A72WZSjilF
	 GnNFRJGURZ5qKdAdwP5SM2xPxOGXc7vcqTJOGybKmSzYPpdqHOS7mcl5r3naUrzvWI
	 fz2reMkKGvdt+j3OMifkercGP9lTLDnUOTMPkzXemS3BAp5FCG7JAXl5UdQFFl0Lot
	 L7wPBUR9Dv5qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 07/10] bpf: consider that tail calls invalidate packet pointers
Date: Thu,  1 May 2025 15:10:06 -0400
Message-Id: <20250501090913-3d681020742e8e70@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-8-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 1a4607ffba35bf2a630aab299e34dd3f6e658d70

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 1c2244437f9a)

Note: The patch differs from the upstream commit:
---
1:  1a4607ffba35b ! 1:  ab43ca5545f85 bpf: consider that tail calls invalidate packet pointers
    @@ Metadata
      ## Commit message ##
         bpf: consider that tail calls invalidate packet pointers
     
    +    commit 1a4607ffba35bf2a630aab299e34dd3f6e658d70 upstream.
    +
         Tail-called programs could execute any of the helpers that invalidate
         packet pointers. Hence, conservatively assume that each tail call
         invalidates packet pointers.
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-8-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    [ shung-hsi.yu: drop changes to tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
    +    because it is not present. ]
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## net/core/filter.c ##
     @@ net/core/filter.c: bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
    @@ net/core/filter.c: bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
      		return true;
      	default:
      		return false;
    -
    - ## tools/testing/selftests/bpf/progs/tc_bpf2bpf.c ##
    -@@ tools/testing/selftests/bpf/progs/tc_bpf2bpf.c: int subprog_tc(struct __sk_buff *skb)
    - 
    - 	__sink(skb);
    - 	__sink(ret);
    -+	/* let verifier know that 'subprog_tc' can change pointers to skb->data */
    -+	bpf_skb_change_proto(skb, 0, 0);
    - 	return ret;
    - }
    - 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

