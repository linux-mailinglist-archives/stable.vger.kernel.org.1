Return-Path: <stable+bounces-145950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF2AC01FE
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2031B62D5C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A8618E3F;
	Thu, 22 May 2025 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxoDBH1O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1F1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879423; cv=none; b=fmuTFMGEXRtoJ/ZX9w5/Gkw8Ht3ISnAeufVIyIXyHmSCZONTncXiP9bioaR5KS2trwxzd4cArMnENlOL6uD+f2trHpG+msSgED+rrcm72jApJScAJFfDuBdT11rIxqUzqYrzpXIrrK6IbxRNuhuzHpgxAkUWVZjycjoCSb6xh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879423; c=relaxed/simple;
	bh=1SQfZymwbo0LAKCdQoWwAnq+PjCeIN7tf6E7uGPkzhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9yUuZn98Ac9+gf+laS5L1trvOErn+/kl9VQnLjTNl2GQ1GOh+NORPly8aErA2iHovChXT3Cf0djjk+yzFgdCyMMq5u4stKgkWhUh7zUyqEJl1SP2//jRz+C7Ml4XUGszzvHvVbam0M12oGNSM/Fkt94XR2LQU0ye889Pja2gks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxoDBH1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A26DC4CEE7;
	Thu, 22 May 2025 02:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879423;
	bh=1SQfZymwbo0LAKCdQoWwAnq+PjCeIN7tf6E7uGPkzhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxoDBH1Oq3bAnEoUmVyUFGG4DTmAXA3NId1DJA1DZuFU0Q37U+WVG3oSotHycgfRd
	 uAKUHr9AhrUM6FoQBPQmgPxpqhzHKnKAWmxTYchfdx0OEFvAAzA+uEhxYNz4OyVFAk
	 kDqJ80NfvcgwQrJCWrlxjGKwGm32ifhXgNlHYaI/gqplfcUnyv5L++1qm3gEZEmS7o
	 EGYMhH7k0td8zT+T394mOtuFVeIVFSpb7aGb4jJVVeGlnB3lshAUq9x2kEXT96WEPa
	 yOA9hhi3L4m5M6tlpkQZq9g9hTCYjjrrpk9sQjDJUsWSoEG+aBNhOdSvXvx5EPDYL+
	 aeJXxuz1usvQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] btrfs: check folio mapping after unlock in relocate_one_folio()
Date: Wed, 21 May 2025 22:03:38 -0400
Message-Id: <20250521140957-9a81980c55ce4cd9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521015043.533471-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: 3e74859ee35edc33a022c3f3971df066ea0ca6b9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Boris Burkov<boris@bur.io>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: d508e5627038)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3e74859ee35ed < -:  ------------- btrfs: check folio mapping after unlock in relocate_one_folio()
-:  ------------- > 1:  2a49a64c854ef btrfs: check folio mapping after unlock in relocate_one_folio()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

