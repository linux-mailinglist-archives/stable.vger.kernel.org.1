Return-Path: <stable+bounces-165561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38797B164AF
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AF61891517
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0C2DE712;
	Wed, 30 Jul 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaRwK3CW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DED2DE1FE
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892964; cv=none; b=krSgmRHecdYS0i5xeeYpuibV5Aj7SuQcikGNUU68xRfV1kIlJpuOaxoZKqnhKpisIzInV0SldviprPS11vfh3qKSfkc2LCSHBHvCeQCDWGt3C8n4M5NSqLKYFZ9/qV9mARyLuPYc+nTNvMqcYxkdn3yNINvT458iLClBx5Ab1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892964; c=relaxed/simple;
	bh=vqpgnVlrZKXq96nyrkgBvsteOBo2VY68JgtTH7taTJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iyu7Ifk1NL68HBwjZoc0B1YUyg4dgOTScmTCmcOrkgPPLb9wUm9rKgTVh8eJ3EgAQnrsdtM9SQV02RXIIpgIpY2uoJ7u9irmjhg+v8XWP1aSKdM4NN+TEtIdM0zv2XVtj+oWuf7DLckhPht+gG6C/nRoxsgUZRRNhDsOJHYWQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaRwK3CW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15FCC4CEE3;
	Wed, 30 Jul 2025 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892964;
	bh=vqpgnVlrZKXq96nyrkgBvsteOBo2VY68JgtTH7taTJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jaRwK3CWaWspf741Qmuzpa3U67CyYMpsc4suGoV7HtbJsyA3J4JfI4K5xA8PCo0qR
	 MOaEQm+cRJa63RIxQl4X8D9eCLEfbGne02b29nm1l63YDaoJ4FUaPYdQSob+fJ/xo8
	 rETSgb2iygzBsVtiy1waYHlmViwFtxJsqEBzPr66ziBX76K+bbrWmw83I8kWw8RtX9
	 8fA/2DOzz0yfqURK6vlpu+Nb6Uninp7vuUcQG+7Uo67yF+jJXnGC/LUljzOfJuznky
	 zgV8vX5420s8rNSJSt2xoOZO4xRe0qO1H7aCSmLsItSaG8ZoCuucBCGiWEjeZg0sfy
	 7jXbARQlIKmVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 4/4] selftests/memfd: add test for mapping write-sealed memfd read-only
Date: Wed, 30 Jul 2025 12:29:21 -0400
Message-Id: <1753867338-b9ab0212@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015152.29758-5-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: ea0916e01d0b0f2cce1369ac1494239a79827270

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea0916e01d0b ! 1:  89f08da4592d selftests/memfd: add test for mapping write-sealed memfd read-only
    @@ Metadata
      ## Commit message ##
         selftests/memfd: add test for mapping write-sealed memfd read-only
     
    +    [ Upstream commit ea0916e01d0b0f2cce1369ac1494239a79827270 ]
    +
         Now we have reinstated the ability to map F_SEAL_WRITE mappings read-only,
         assert that we are able to do this in a test to ensure that we do not
         regress this again.
    @@ Commit message
         Cc: Shuah Khan <shuah@kernel.org>
         Cc: Vlastimil Babka <vbabka@suse.cz>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Cc: stable@vger.kernel.org
    +    Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
     
      ## tools/testing/selftests/memfd/memfd_test.c ##
     @@ tools/testing/selftests/memfd/memfd_test.c: static void *mfd_assert_mmap_shared(int fd)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

