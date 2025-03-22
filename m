Return-Path: <stable+bounces-125826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0547A6CCE4
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 22:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183193B1A41
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E061E51EB;
	Sat, 22 Mar 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ/eAyLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3186338
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680300; cv=none; b=l1X3LMMI6W/JFjBCUnyXYQ+e0Gtht9aSglrJb+pAzlFgKStf9g2Z8igDs8zcJbvE0k/MJm5Ri5ruJXI6FR1N+JkeebzU73NOC7vn9m9CcfrvVv0z5Ic2ksI3HLaYRJ9b92S0+fXRqENUGF4bNU5xWE9uqav8bq8vEa3VM1Yjxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680300; c=relaxed/simple;
	bh=yinCjzMU3kO3tkBACyPFDmJcnmwxdTkhYWsRDPBcoPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfLr9mNCi4OwpzGBdGYGonkgviz+5IOo164/d4/1Ipa9D9I7ma9U5SmzoCtr7dstQJjeI6a71UHp1MStOCEdiSD3767STmcMkNPOVR8Dn0pxfQpInlhh7P1f/gJEpCc9HIWHl936icnsM9A8qHJjF63zhK6eO0HnwLcreWrvOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ/eAyLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774E1C4CEDD;
	Sat, 22 Mar 2025 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680299;
	bh=yinCjzMU3kO3tkBACyPFDmJcnmwxdTkhYWsRDPBcoPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQ/eAyLL6Y8t7CQfgtZmE+UxQoD7cZ38h2JZMOaPsRcjBDSor+DqMSZQ3rRNqSB22
	 9v9sYv7ppz3uIlurk/omiEeskB5UCGeRTkF+aM+Yqby43L28Jlc7voD8SbspLfD85g
	 ubq1H98xxl283q+lAYkbk4GVlycHAvlik6AOcZSdDa6PG3AKrcQteX3qh7oCuuUNPq
	 WN5cD+anlvbHltK2kkvZ/THP/qMFbrYlkRmr6Xc5bpem6Ea4nQh/PEmpyCosAT/Zb/
	 UxHIpDqtwozxQqSOdv0iyOhg8VxBwI9JKtdhsNe+SHgEX8AusK/fMhipXzF3GXZUWF
	 bN8ESWE81FXjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 6.6.y 2/3] lib/xarray: introduce a new helper xas_get_order
Date: Sat, 22 Mar 2025 17:51:27 -0400
Message-Id: <20250322104005-f41d884c5c71715f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241001210625.95825-3-ryncsn@gmail.com>
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

The upstream commit SHA1 provided is correct: a4864671ca0bf51c8e78242951741df52c06766f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kairui Song<ryncsn@gmail.com>
Commit author: Kairui Song<kasong@tencent.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 734594d41c8e)

Note: The patch differs from the upstream commit:
---
1:  a4864671ca0bf < -:  ------------- lib/xarray: introduce a new helper xas_get_order
-:  ------------- > 1:  344a09659766c Linux 6.1.131
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

