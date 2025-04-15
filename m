Return-Path: <stable+bounces-132797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47F9A8AA4A
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB9D178290
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4709257AD1;
	Tue, 15 Apr 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKf36TB7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95630253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753435; cv=none; b=LuCBL5l89IPaEkeIlaVUOd8s7oL4zNnhpFdsS1I6+t9zqy87jLIomvG61lrpbd7CBXmgjTy9lX6iHzjNRlKslh9ZB9pKqzwU9kWOZkLiivdx8+UeUqkr5xXcxFxQN4o/VBAVEwQeGkoJx9kGsLBGOlFXnXghXVmmJXdcnqnF3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753435; c=relaxed/simple;
	bh=BSMlUWczqKWE9u7gT1yz13CE+tclL8/9kPYVGvSRy4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPl+VLR8vm3tVtkqxpfEqx0as9CVlHSyxjlF1FWuInspXtBAejS6HNGpvYMMUjty3bKelHzZrEPq62Ja2WEEN7ldhZgZQG0NG3RrS4DX09cn5mOKWWAu2tyxIOg+rHS1GgqynoTakXkRSw/CG7tl3NhMtE6ODxpVb43Hy3LPjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKf36TB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94335C4CEE7;
	Tue, 15 Apr 2025 21:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753435;
	bh=BSMlUWczqKWE9u7gT1yz13CE+tclL8/9kPYVGvSRy4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKf36TB7cRwd95d9VSNZGgiinf3SJuAGCURNS4GBq+wYnrVuwktiPC6T+q498dzTc
	 q+WlOSqKyo0qNdTmAJ1IWZQJqwKqMsXco7Pexi2qMN7cT1Blog4LjzzgkueLk0ZrZ+
	 UpjFHb/8w5DtBKnUUDZ4oHEixq/6ZxVXFNGzEnnyX48+KdOwuJmd5U3QfXsbtvc/Nw
	 tgrDLsqGHCean3cnnrtz/szZXz3qif93dU/Y/gHxROsjKuO3mIGXFUIQAtGQNebqS2
	 1ZRYACSQm8+RSokRHkk7D75Y67cjjqnviHWymc/7U8sDMxHjPKHS/sHnVWopBRb+oY
	 A3Xx+xpWNyPHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.6.y 2/2] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Tue, 15 Apr 2025 17:43:53 -0400
Message-Id: <20250415125600-d073171a9448951a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415103125.15782-3-zenmchen@gmail.com>
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

The upstream commit SHA1 provided is correct: 9c1df813e08832c3836c254bc8a2f83ff22dbc06

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zenm Chen<zenmchen@gmail.com>
Commit author: Ping-Ke Shih<pkshih@realtek.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: bf1aaf8eb546)
6.12.y | Present (different SHA1: e5aeac73ab04)

Note: The patch differs from the upstream commit:
---
1:  9c1df813e0883 < -:  ------------- wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
-:  ------------- > 1:  ecfa2677556ed wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

