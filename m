Return-Path: <stable+bounces-144247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAACAB5CC6
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A1B19E861E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CBF2BF3FE;
	Tue, 13 May 2025 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHCGm9dR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6CC20E032
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162218; cv=none; b=d1vrPyrYvZ6FDKwLc9YrU3lib00t9mOIwIvjwNhufRFWWg/AChMdstDuPa+qvesfr5R9UpmQLDzsk4jwLsxfTqTTzcn1qpsPoza9Lo+mBQqGMjWBzgAenVk+e/V2c9UrG6RCbtFDe7YhX1rmFJAEblaRe16YsOI8PS0Q8Dmuo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162218; c=relaxed/simple;
	bh=oaThZHxmnFBLTHwATtrAkMhN5uTcUkHu+Q2Rz3UyK9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg0EKUlj6/2x6xG6laQriOpk14+6lw0DNICawkhcQb1/AyQQdR/LLltnsqujIvzgCeeYFb0HNgtnqwRhBgT0DwxwPL1h4cTucUEB50E+fFeMHUzDzxpbX3mlx8Pc4NeHYXB0joK5f3gh7zgU9Z6zO0bw2Hf/Oxie98fUco71Vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHCGm9dR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2EDC4CEE4;
	Tue, 13 May 2025 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162217;
	bh=oaThZHxmnFBLTHwATtrAkMhN5uTcUkHu+Q2Rz3UyK9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHCGm9dRJ+G96dW1NDDvh/5Rjig+qvtG9OwIRCKwxN2Pt35Ak867a8PCHv1odZXlw
	 A8wg0JoESC4ClUARmvzSmyV70zyg2hGZ1VQ4O5TLEeLkwWsXRJfBUedgSfrV5o7C36
	 Ub4LqwReHtwe3dNKqySYzToMFN3EfIu26SAAHZatEiRTR38s60jAQXemD0qozkaayM
	 q4RQJ5DOyuJ4BUw8lvGjWHlQCwBI4YxtHeTVbNdX4jfQ3UlEMxe2TiuLMFBEv9ubN1
	 g67FXHuI8aK0p5wdlPCF9LdTnrn9kys175nUTVDu47xfWxPe8q/Lx9Tth97aZ6L4sz
	 czROnKsfvQSCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 09/14] x86/alternatives: Remove faulty optimization
Date: Tue, 13 May 2025 14:50:13 -0400
Message-Id: <20250513133822-93462f3078feae9c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-9-6a536223434d@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 4ba89dd6ddeca2a733bdaed7c9a5cbe4e19d9124

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Josh Poimboeuf<jpoimboe@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4ba89dd6ddeca < -:  ------------- x86/alternatives: Remove faulty optimization
-:  ------------- > 1:  3b8db0e4f2631 Linux 5.15.182
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

