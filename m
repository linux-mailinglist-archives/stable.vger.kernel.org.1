Return-Path: <stable+bounces-135270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7898A98977
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE916DF40
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12A1E7C06;
	Wed, 23 Apr 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMPzyj36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84E1119A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410615; cv=none; b=Yjjca7oF0ClLICCTUE6i345UfdTt2XqNkP0fPPmykyTmBn7cg2YRQ0EsFfskXOHzRUWNE2WHsP3/M5CL8RjmbacymDm2HwdPKDtHWw9/QxF17tXlzZLy5vgQFZL2CZL9Zy0XAZb0c45OaSloyRzruhr1XqJTQt77ngH4Mh85E34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410615; c=relaxed/simple;
	bh=mkqLuxJ4SqgummZ0VhCmEdQx2pq+/+iXfzSNvCQL5TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaWLbAifwuQakYMb3pw1o47x9YZ0gqSLC6GEgM2xx2AXB4yQ8fau9ZiDlKHKJlK2noyl/p6LlYsrKfO/+P53EAwu926jhrDgkijHoy8PlFeG+sJyJudGoPAJfIEZkpN+us77tie1BaS8HsvPNwEMR9EDjkQv71WSJlHFkqBgIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMPzyj36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A0BC4CEE2;
	Wed, 23 Apr 2025 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410615;
	bh=mkqLuxJ4SqgummZ0VhCmEdQx2pq+/+iXfzSNvCQL5TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMPzyj36HHbqSRZyZRBiJ85DX41Ovs/xUjW/C8jbuibaGmuMiXLgQy0uRySoOYR5Q
	 AvSYnoGS+f4hleMMGCEfAC/IirA0s8qmK+vRMRz/9aXm86ocG+6gHXbHl1pClUcSTS
	 b5rSta3fdViMDLi7K0udOvwLR+NtWjV5LwxJJwYIxYjfcCk2xWFe8w9Qc9z0xkfPvS
	 QjWhEWswJr8hgAosiQce9ID+ql0gNKJd7PE8AM6Ainh2yFL8PFuqgey6xRGKl68N7a
	 VYYv/ZzhmwfhG+fyXfoVDy9aKHLxNNpM2vjtUtT4u8u6zfzSAqkaKSxEhgLeCBQqkD
	 0M+MCVPqaWcqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 6/8] selftests/bpf: validate that tail call invalidates packet pointers
Date: Wed, 23 Apr 2025 08:16:53 -0400
Message-Id: <20250423080743-3b522db5609e142e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423055334.52791-7-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: d9706b56e13b7916461ca6b4b731e169ed44ed09

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d9706b56e13b7 ! 1:  ace20a807473f selftests/bpf: validate that tail call invalidates packet pointers
    @@ Metadata
      ## Commit message ##
         selftests/bpf: validate that tail call invalidates packet pointers
     
    +    commit d9706b56e13b7916461ca6b4b731e169ed44ed09 upstream.
    +
         Add a test case with a tail call done from a global sub-program. Such
         tails calls should be considered as invalidating packet pointers.
     
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-9-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/progs/verifier_sock.c ##
     @@ tools/testing/selftests/bpf/progs/verifier_sock.c: struct {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

