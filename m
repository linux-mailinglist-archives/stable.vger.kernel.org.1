Return-Path: <stable+bounces-144249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38683AB5CC8
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC33719E87BF
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7B1E521A;
	Tue, 13 May 2025 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSiDp5rp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957F748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162226; cv=none; b=cdLLpcaWslGonw43IDfAwtRKlQbXyIhmmIqJMSwgr7QC3ZqwjsVL8wVgZacF2cRxz+8Gkpj1jI7JoWjAG9ClvaEzSLI/5MBM+7gop5h7uFA3Yu+46owJs/PoPc7CJufULLEzfa6whg0/7McWnr8zXJVttSdirhAZOyv2IvPf5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162226; c=relaxed/simple;
	bh=7bXYXDSjCrqSRWAii/GIghtTE35ogTHrDPND/YKiqqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKeMwIQ31wRJuv+/wXcKdc9xWFPzB+ek8TwU1nfHeMGLDbSgylgYdZ8PkvotnFz9xj4oJCbwvZAv3V88kPyODAIrnaD3hNAFYHF8RBt/BXHUMn3l9oApHZFaFejWYkL9L7eoLKak+geCcHLX9+Rq3q+elRcBdXN6D1PffF0Jf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSiDp5rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44729C4CEE4;
	Tue, 13 May 2025 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162225;
	bh=7bXYXDSjCrqSRWAii/GIghtTE35ogTHrDPND/YKiqqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSiDp5rp3xMnsnvC0/IKDvtza3FYqKhDHWyasTshH0d6lJTxWwv5b3vfKVrpbwfUo
	 EhNZaF9+nYE2CVd4XaqjqgMD7jC5BTco2XjqAWNh15qbAXkuw1XOy0ETmM9iC68qDx
	 f23UjMTVhD8oWK05B9gCN9Vo7YaCwWAiOyBUuhsrvCzzpfq3lhVjh4P85Mp0iiXctD
	 XaWHuuNvuRD3SBs8AKdbcXpJo1IcvjMRHKf9RUrUXgJfTc90L4CtgFfsC2kTsYlHIX
	 8t0KCElZATPXSks3j8kUW02y+X5cre98YfYvQd9Rjhbspfpg8AWjgzfZR+0rvqZLe4
	 vXQSczI8Wt12g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] btrfs: check folio mapping after unlock in relocate_one_folio()
Date: Tue, 13 May 2025 14:50:21 -0400
Message-Id: <20250513101056-2770ae6fbbaa9b84@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513032523.377137-1-lizy04@hust.edu.cn>
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
-:  ------------- > 1:  37544dec5c1fd btrfs: check folio mapping after unlock in relocate_one_folio()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

