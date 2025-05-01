Return-Path: <stable+bounces-139359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F482AA6330
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659E23B8CF2
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F03221FCE;
	Thu,  1 May 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWOBj+k+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41952153EA
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125521; cv=none; b=GNILKoATk7nE0RZTlT5npoSqopaZpssA7NM9sJCHrtBhmDRLrJA20HA76NPTjRNF9b0Tt+VA1aYel7lNvG6Op7zJgQlQ2WX0UEAghMN9Al0hcfe45jnt069GWNVfpGADrpvCCP3yX1dzuhXX4j/nMFlMS5SKlJnOEXAMvz2Mdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125521; c=relaxed/simple;
	bh=csVbm5yFIKAlpRnJH0w33U6C7LVYoali4NeN8i4Qehc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1P/K4rxbLSUOjHU4US4Sigt+IYf+qCftRo5drXhq9t1sUATLmvsJjyHDkI5BgrFJmMAMYQ4pHqkU3ZzzxY+8FJ2C5buHHnZdIKDxwKOZ4HVyfDbftMqn1r8T7Dr4h5EiInxDfj5+9PG5SB3VwrOMd8YjguYng9dpQBn7PpF9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWOBj+k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182CCC4CEE3;
	Thu,  1 May 2025 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125521;
	bh=csVbm5yFIKAlpRnJH0w33U6C7LVYoali4NeN8i4Qehc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWOBj+k+yKBcsLelUJcS46sBCyori4yduCHNF+f2pFSQjo1xokD+thIV7RM9RX7Ay
	 RWY/F1AKT5SBoBklFvtJtGPQjEMjfvZJhO9rZriv4pss+jG879OwpLqvQHpLWhRj0z
	 w3qdvqmUhwRGFqVctTMcvEWoSEiXz67vZgxtnGPKd1tMjhgVnDSrzEnqEUjz6kyHG8
	 7pyvr52jPsQRaTrwP8TME1bpJuhqY+/coEKR1gszBWMySSTend9SzQE33nAMutNc8t
	 yoeGpgNPHQC+5CIrpaopgZQ9URMUdws21mMgpgQ+n79HxBBdTZpeDStq3mx4tDjvvQ
	 RfUcw7ukqkvjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 6/6] Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x
Date: Thu,  1 May 2025 14:51:57 -0400
Message-Id: <20250501121710-d33ad10d7dd2de61@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430230616.4023290-7-alexander@tsoy.me>
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

The upstream commit SHA1 provided is correct: 2dd1c1eee3e496fcc16971be4db5bb792a36025c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexander Tsoy<alexander@tsoy.me>
Commit author: Zijun Hu<quic_zijuhu@quicinc.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: ece126a8a2f5)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2dd1c1eee3e49 < -:  ------------- Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x
-:  ------------- > 1:  23ec0b4057294 Linux 6.6.88
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

