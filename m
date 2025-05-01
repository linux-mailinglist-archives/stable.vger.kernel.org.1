Return-Path: <stable+bounces-139363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF292AA637C
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB57A8501
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E15224AE8;
	Thu,  1 May 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQXcZXPz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5A215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126569; cv=none; b=kw5YYB12OTdYSh4/XufIUBpm4TbbveOVspHfhRWq2yFSXgLY09OzNVUQPR+1lsZuVcwTWrJNOaBVk5VhWdWAohVaK7usqZ35e4jeBcttKn4yGxN83dnBXvToIV82HZVDcBazTJ+sA/2s90GlCFliQAm8JUHS2gkSvXjd5s0WERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126569; c=relaxed/simple;
	bh=Ymw7/J5VZdnlW0O3I0KoVBcFxJ0Av/H13RPuot4wNhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExP80dZjAIzoO4AJ/loeB7hGOY1Dr/PJNlwGkhcI52ezkKWWyVPfSIWWoi/MBWlhNnbTjq6FZiASGdD9Clw0NjDeVM1j5hX8lq0tfdWUhWGW+VaismQtnkDX4A9BRhGympINxL0TcUdYruW3MMJP6fZBmzioB236IWa4W7Weyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQXcZXPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DE8C4CEE3;
	Thu,  1 May 2025 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126568;
	bh=Ymw7/J5VZdnlW0O3I0KoVBcFxJ0Av/H13RPuot4wNhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQXcZXPzYywz1anEd5xk6c4LqOoB5TtyTVibsj8GbrLHr2Eigq8F1OrovkdqjF+Eo
	 AIbfCUNGEvb+qyvit3p+RRsf26Wltm9UxlyRaOBzvXy2akO3f2pvUBbs+T60+wYaFK
	 zTQXrS7MEliu5w6LVZObDRvtvy4AZxitmyvmpOgKy3ZVpAR/M3K6k7jZz17G67rP/9
	 du0D8dJ3pUSw107HUzEJwCHK0Ad05QQT0PwwdVBNxYZtAGOPgnHgsCbPFNKmhPb3ad
	 xigwbFsiCNimqornw97AQo1H8UyPU7M6byxDg7wja6Qk/QEn6783j2++/1phqe+YQw
	 EncvxSvRFfiNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 01/10] bpf: add find_containing_subprog() utility function
Date: Thu,  1 May 2025 15:09:25 -0400
Message-Id: <20250501083958-b636338006a7ad86@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-2-shung-hsi.yu@suse.com>
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
6.12.y | Present (different SHA1: d30b9c5950e0)

Note: The patch differs from the upstream commit:
---
1:  27e88bc4df1d8 ! 1:  a412775f370f7 bpf: add find_containing_subprog() utility function
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
| stable/linux-6.6.y        |  Success    |  Success   |

