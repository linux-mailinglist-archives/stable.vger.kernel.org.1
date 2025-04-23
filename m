Return-Path: <stable+bounces-135279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602BCA98981
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAAC7AF0BB
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1036633062;
	Wed, 23 Apr 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7GK2Ji5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BC8632B
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410635; cv=none; b=AROAQTsMWhZ5hmWqa56ZP2d9GLnEE98uSBcAl4LzBeAtoBd3TgAmLor++snoGIdAG9z9rKOkHNs00mna7Cjd8jv/GXm3Z930LCxLbdirMZM8luhRUIQ3VivYA6jP7RbE2ZZEk2MsZbNa8VozmAa3GTJTEVLoFHbiq2dO7ryqJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410635; c=relaxed/simple;
	bh=MMAg9FbzeRFKe1pwbCM5togassnu6RmyxVzV+ZsS81E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaBMol4maujdnOk6vthuKj+6lb1jE7p38CTZZPKhZU/i8d9EZO36UmdOfCblu0WjErrbfGbZMOfcSv55SkCJcDUjfefo6sAzP6KRAr/ExmlX6spm/OH2PgemvCG4O7I8nnOVUccH/1uTQgTTegaaaZEhbKUaf6A+95fBN4wKnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7GK2Ji5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87A0C4CEE2;
	Wed, 23 Apr 2025 12:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410634;
	bh=MMAg9FbzeRFKe1pwbCM5togassnu6RmyxVzV+ZsS81E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7GK2Ji5maKVQ9BX0d7aGHtVZOpGiOdecOykwenmMBUVL6X9jHm7+QBJu+gXJgBJI
	 5TRSf7dANVZEq2b8Z4Cj/PzlPke9E5BTiICEeMYhEo64HMnTxBVfAm+Pnm0z/HMn24
	 QUqaBzjFgAP3sqtzumTDu2/ctjOXw2jXLtm/D2JhMRppvby5M4OOPRTy+BvviZmLeB
	 zp7VsuF7XoBRYZzYmYfFsKBR5nKXEMockPhg0Er8Ch4fqAgnAgW+5FGyvlYpa9gzQv
	 gOScevX54xkODMY+PpkFIp0si3xJBrWgB1GnznpW8OrqJqEqxMXK1Ydz/vhSntVNyl
	 O/rRzTfhaqtMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 1/8] bpf: add find_containing_subprog() utility function
Date: Wed, 23 Apr 2025 08:17:12 -0400
Message-Id: <20250423074331-bbf7885ea91870d1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423055334.52791-2-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 27e88bc4df1d80888fe1aaca786a7cc6e69587e2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  27e88bc4df1d8 ! 1:  a26a2fedc40a8 bpf: add find_containing_subprog() utility function
    @@ Metadata
      ## Commit message ##
         bpf: add find_containing_subprog() utility function
     
    +    commit 27e88bc4df1d80888fe1aaca786a7cc6e69587e2 upstream.
    +
         Add a utility function, looking for a subprogram containing a given
         instruction index, rewrite find_subprog() to use this function.
     
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-2-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## kernel/bpf/verifier.c ##
     @@ kernel/bpf/verifier.c: static int cmp_subprogs(const void *a, const void *b)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

