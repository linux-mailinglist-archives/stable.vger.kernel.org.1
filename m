Return-Path: <stable+bounces-165182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F0B157A0
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 04:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD564E2D61
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 02:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FC11BD9D0;
	Wed, 30 Jul 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGBYRzZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10E15A8
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753843407; cv=none; b=lXPXRN7B/TWRGGkpZXeCES3xThXXwEgSL5VY13wPHHWbWUpGjMvLB08R6GzGGH1hsGAOJPu/XOWgQSdXAbeFKgaRkniIDbLSGvKpuTTvp3TE8RQHnFiDZ3tTenBR2+u/iivkdMB9ZOCg3+FT4Y4spLVqm+fFs0CiYW9u9Srs6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753843407; c=relaxed/simple;
	bh=BiW14KQ9MX5y63T1gQeFalS76C/fjSYKJZP11i+SHYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKzAuP9ubs4fE1S+ULg9RnnRx17D1midPDv9xSHVdJ8oFrnNWLIyfu5SQhsD5L4x+bl1VW7ibincvPt+nEtr4jKnmmJgu1Ih5JMP3e8eIeYYf2GnopC1MbRAZddp+KaUrrPjtjm5+Dl2mAj59v78HHPG4JxeK6hIfAjrZn98KjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGBYRzZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45C9C4CEEF;
	Wed, 30 Jul 2025 02:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753843407;
	bh=BiW14KQ9MX5y63T1gQeFalS76C/fjSYKJZP11i+SHYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGBYRzZIMgv5AcEtvORMJ34vr29d4V3x0fVv6Fh61xkmu57jpgky8aXoDvgut1K+E
	 viat3wNdT8EsUOXsG71Q3Uyd5+JdbAfG+KDKALTHE5qU3vDpbN2Wna8RjndCQM/PCa
	 zxYZe1G0cjLf1+Kxlxeb+Q0rPZDAYaVFB3pleJjj/Vs0Dc6ErMVgXF8xJErNRtNyEi
	 aRpFkrKD/w4PIYvY+odN5gdJgl7ZHFiDXRUQHADwae1EYwN52IA1Wfz4w1INjTnqf8
	 aFyr6dQKOHt8t/F1yE6wwuL4hYsGp1TR7I51Rjj34SUJf+m5gKMD1ByzfbpRLFdT4k
	 zIVESXVtxtoFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 3/3] mm: perform the mapping_map_writable() check after call_mmap()
Date: Tue, 29 Jul 2025 22:43:24 -0400
Message-Id: <1753842308-b71afa99@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730005818.2793577-4-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: 158978945f3173b8c1a88f8c5684a629736a57ac

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lstoakes@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

