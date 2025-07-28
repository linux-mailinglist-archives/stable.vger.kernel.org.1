Return-Path: <stable+bounces-164931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5470B13AC0
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA97F161F3B
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB56F265CA7;
	Mon, 28 Jul 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBSL6+tB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2E26463B
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706956; cv=none; b=YMkI3O1PShMih1SD21wtGiBPieKpmYV1W5hE0vuyrdzSsBArhF5Ov5xDW1gkDNlhciEic2+FUKjE0eAT1oY61mFPEUNEo0ChGwblUf9qTx5awa56jRuhu/mlB2lTTN64+p3VYp1LNC58DfUM5XDT9IJU686lcMMT8/bEZIWytJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706956; c=relaxed/simple;
	bh=KRAaQlAPOrZJrahY9fkMy9EdMCRGy/AF755MzQI2hhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6IHCBIGgRr0rJYWRN/lE6CXrKMN0q/R0NWaBBJcy4tAK5Dp0MjTwjCe3JcSbGW93qaULU0GXgzSEI/VdAZN1FGvEruIfxIafGL1DKBSlMWBNZT2OVeCUvHJQwo8RhtQQYexRNtoA4Wbn37oR36foI61gM2xMbRLkM6Ngemufas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBSL6+tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C13C4CEE7;
	Mon, 28 Jul 2025 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753706956;
	bh=KRAaQlAPOrZJrahY9fkMy9EdMCRGy/AF755MzQI2hhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBSL6+tBsNPXbDpFz+xQ54wMHDDfq8lZRVRc/2vbrVRSoO1ysZxpVuAFi93cMgVBr
	 J75TbHifYneLWb6v/pImm4K6mQG18f9NjFLvDzYVAkJTJhH7yGKX4jt6fDk83YAmCA
	 hfHE6a4f2iMkdma/Iik5BUY5Pkw7Cy27UjSsnmv+HYoDbjq2bxk2d19IXbUg/Gl8Qs
	 noKFPYvQHC5/245Q5Gr+sAMr/s7u+VAPPSHj6Fh1YuIKCVwxIpXMwF7nLCwrAl+x++
	 iymyNqHapxOK45+pixputVxym1LhWUTdVnNFaZ5W3gTHF8M3XJU2pvolTs6wluKKtX
	 F1I8TZR3KN3Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 3/5] freezer,sched: Do not restore saved_state of a thawed task
Date: Mon, 28 Jul 2025 08:49:13 -0400
Message-Id: <1753684501-fef6e43b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728025444.34009-4-chenridong@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 23ab79e8e469e2605beec2e3ccb40d19c68dd2e0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Ridong <chenridong@huaweicloud.com>
Commit author: Elliot Berman <quic_eberman@quicinc.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

