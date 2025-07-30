Return-Path: <stable+bounces-165551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F999B1649D
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBD218C4283
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753E2DCC06;
	Wed, 30 Jul 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdVbPwYa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3471DFD96
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892936; cv=none; b=SMkJao4nhOIivv1sLWKPqOdDPjtGaqcaUQoTKuKEOzWnoxr56fpoSRqZvOXSeLgKd3VN0vxKQxWJKXy/pvVIRwxlMse6Pnt5ytSuXawTnnS0Z7GpgpFoRrp1EHuYy2aocQnNdEo2svxeH2+jgZMcBHKfm8Aqvh2F30X4kGIj74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892936; c=relaxed/simple;
	bh=QKx0aKzZNUAosK/88cXzbpqCeh75jUXfuW+PIguZuMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGM+lG/8YfVcP8ptE4LvXhbYs5TxldEKueLJmzZywq1cLr2UIm0JoeTpsFdoITM6SMNrOkV0MKXeUEDcm0aPzRtsyfPpm4NmTeT4i0zVQxUSoygZx/na2THaBD3qNbFnFWhviEC0TrqmavXFyDmcKKwwXv4TAjAJZmXLHE8W0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdVbPwYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1D8C4CEF7;
	Wed, 30 Jul 2025 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892936;
	bh=QKx0aKzZNUAosK/88cXzbpqCeh75jUXfuW+PIguZuMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdVbPwYaTbTl0RhYCC7Xe4EhX7E8RfiCNkIKPxC9lEkAqpw+N/S+GX6fz0pLTzdxp
	 k1OdMFp9sqM2WIhIM0P/J0KQXFM1Y4jN56jIWRv/6dIHYeDX5xy7PwC3AK9nBIDnn+
	 BjxF4Qw0ey//c0QIFNW2uDsuWpVZfvlPiIK/4vz9GAmOeptc4DBBCx0SjOLHb5Mip8
	 YscKSfvUzVynEJTLd7Dog/lXtWVe56M87gzxlB8mwShib9sEbwrO0Map5SgyO75ylo
	 /XkrbNqv7v6zzn6vFiJt9+OnBrqPNIlE+RCQDXapNERgFuRIZPaiSKXxhACcDTGJmR
	 WbYXGkWsYdeaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 4/4] selftests/memfd: add test for mapping write-sealed memfd read-only
Date: Wed, 30 Jul 2025 12:28:54 -0400
Message-Id: <1753862086-900b1730@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015247.30827-5-isaacmanjarres@google.com>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea0916e01d0b ! 1:  6ed30ba1cb86 selftests/memfd: add test for mapping write-sealed memfd read-only
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
| 6.1                       | Success     | Success    |

