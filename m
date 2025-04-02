Return-Path: <stable+bounces-127444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF1A797A2
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABCD3B3A43
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CF19D897;
	Wed,  2 Apr 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDZBYk1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E24288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629121; cv=none; b=fdoCdKP0+8u7YiQ6gMwZWQjhdHw5eUVmSKpcr64kHuHSh6JwKOVksVOlTk8Hz4neBL3Q/l3CybA5OsUwyFDbj8aBnUoAXPyhdkamHpbnZmCenKU9PxbXSc9xyurFStgpvmMiVERhn5yo1AkGrOKOaGTqNRjAPN4Bd34sXu7D+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629121; c=relaxed/simple;
	bh=rKYPt5/SoFmAHRjuLdn7aW2/BegRJdNVD4s13mmkCP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fh9KMloTfjbIRrK3wCAIVb1DqxlmnIRN/M67gkrHJeQImUbXGHBBZhB6Dp9RQaU6CauiuT+v2bivwJGFVdOY2d3hMmqWGZd8xmpfBH3YcJMq/hoYMW9IFt/EYKVZpk8L2TZtFf15TteT1FyOgRtHSOvl6VSfVGOnpnuW4c6n7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDZBYk1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAB7C4CEDD;
	Wed,  2 Apr 2025 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629120;
	bh=rKYPt5/SoFmAHRjuLdn7aW2/BegRJdNVD4s13mmkCP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDZBYk1qG+snXI4H81jha2djogtUTpfvqlmenaLiacrvajUiXy5adAZCiT345/eQ7
	 u+xn2bBPWxTmvBZY/jnAc9V20qwZ6DbdJguDVtdQXUnR1jzIO63b3p5z8Zf1uAuTCO
	 uazf09QA4BoxN1pHOK1H4nI2eyd8CgEbmBLyBOVdNy/vO4e/Rq5VE/EGzQivmkO0+a
	 mlq/b3AMJKFCRAHj6FUgngTTZngS40L0wveZNIINOmkX+95/645Z+f+qP2Mwwvn/w9
	 FMqOWvO7i1fC6nn4M76hcEQT36oZ/C/FtCU85O1cqUuKgg34iAihP7ZYKziKAolc78
	 0V+l6rEa8sGhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
Date: Wed,  2 Apr 2025 17:25:16 -0400
Message-Id: <20250402125858-0f51d933e507d030@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402095750.1813300-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: d328c09ee9f15ee5a26431f5aad7c9239fa85e62

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0ab6f842452c)
6.1.y | Present (different SHA1: 558817597d5f)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d328c09ee9f15 < -:  ------------- smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
-:  ------------- > 1:  10851f5b01ae9 smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

