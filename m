Return-Path: <stable+bounces-135181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD1AA9754D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4B23A9613
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C282900BE;
	Tue, 22 Apr 2025 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/PE0Yh9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08599B666
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349482; cv=none; b=ksRYnAYKbF/PHenfF8CUUWZgQwCUwgnq4aRzgk0XYWfKGVSZGJDSPkptODO1c85rDfAX4sb6ebWMsEC1mXtHgFyfwOdL6EAL+27gMr3JGGjC/IV6ddJYLW6OAPbwNtUSilv8I/pAvNzJWNX8ph9JG028PDzr/BmYYj1MQN7P1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349482; c=relaxed/simple;
	bh=QYbggscbRpDk2Rhna39Ly6e3HnD/FvMdDw0PE9GmkTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLbRDAJSwQ6auV3SDJc42SWbwGAoVmOCSIQJJq2RGw5mrOiqYqieEKWZH1lCfcWVqCpy38aHJK891YiB/S3TbcJKMT6h8t/vEYGnIv3QOM0wMTFchePQEcVRNhNaTtohGZHqOi6O6hBf45F42FngI5TlAjSFFBP+sfITI/dZeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/PE0Yh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E23BC4CEE9;
	Tue, 22 Apr 2025 19:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349481;
	bh=QYbggscbRpDk2Rhna39Ly6e3HnD/FvMdDw0PE9GmkTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/PE0Yh9mT3ynZB4ivC6VSYyA4E7Q2FL8nBiChKnFdwBKdDmRc91vCakKAw47AhhY
	 80f0JRGQ7G7um2Qio9vUTId8kZa/lmkei2CGYIlNhcmwN5lsKjA8EPRXv1iUGGlqqw
	 T4mi/hopJKx7ZmVO9QSpfxmoUctGjTehmeIad2NJeRVlMihpuM41gXsIfFxV8SgB1Y
	 b59QEfePb1zXL79kxJIeTFCDk/Iu4QHCJe0G69ycWbRyuJLa4T7++a0+Ou0a3f8BFA
	 smhmD2RxzhFM1SOEx3LJaETa2cLcY8hi7VGUU3iur+FeuI4CGaFw7e4UjZHT9NE4SE
	 KMo5mTYUadVjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6/6.12] LoongArch: Eliminate superfluous get_numa_distances_cnt()
Date: Tue, 22 Apr 2025 15:17:59 -0400
Message-Id: <20250422120633-36c89bf6f1a0a1fb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <BE39E39147C04E96+20250422082006.89643-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: a0d3c8bcb9206ac207c7ad3182027c6b0a1319bb

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a0d3c8bcb9206 ! 1:  f2e42c975a335 LoongArch: Eliminate superfluous get_numa_distances_cnt()
    @@ Metadata
      ## Commit message ##
         LoongArch: Eliminate superfluous get_numa_distances_cnt()
     
    +    [ Upstream commit a0d3c8bcb9206ac207c7ad3182027c6b0a1319bb ]
    +
         In LoongArch, get_numa_distances_cnt() isn't in use, resulting in a
         compiler warning.
     
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |

