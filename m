Return-Path: <stable+bounces-164965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B9B13CF2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA97188AE9E
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70E26FA50;
	Mon, 28 Jul 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGdLP65T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57A26F47D
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712435; cv=none; b=dDlt9gWv4YQvjQ/3zz4zvOZZXwboAR4as5aZyChfjPXxzVrpLQVUUciz/6AXTNPwEAc5DpWeQWmMKvbBBh9frNnbRg2VQc7PvbOAfRfjqxOKkdgZ1IEHfe/FpmOibTJAyD6wYWRbt7d137yPceg10GFW65yyoqzuaoFsOInM/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712435; c=relaxed/simple;
	bh=r/c6xSpBvvWEHYmgUYfPPqqGkP4SW229z3c3SUXrTxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDljGMQMH/JFTZ8bi0niBTJ4IutHtSeAzuhcL8ukgc+5UPg9yP+7hNRK/Z17oo7Sfx0Mjvb5C2PzK6tm+hJbViQJhFtb/xPbLbb2IAGo/ICGhGSr3yidgkefSpnShL6CISbAbTIIFy9ikFERIY7IKpSN19RtY2iaPvQ8iY4unV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGdLP65T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428AC4CEE7;
	Mon, 28 Jul 2025 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753712435;
	bh=r/c6xSpBvvWEHYmgUYfPPqqGkP4SW229z3c3SUXrTxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGdLP65TBBQs1LCeCxkHZG21zWWbJnk84c7L0usptcXc+q74D5piOATEayQJCm9Xk
	 biGzkZMGYYonam4KD1l2Q9upmg5w/LAvALaeKSpWA/3J+ipcDF1qngOyAmr9IFHNGL
	 EEzQgcrAnd5jCgLLAD4jeOpuj7c7qOjTuLMoTj18/0yM3KXFgA002H46h2lZoFX3Ji
	 eNeOTovES3EUdCDR/Ap/dTAetX51hL1jDUpV2zgq2DvPLZ0xVwEd59e5JryfbDMNfU
	 Nxjjgdi6oBkZ5P3rbndYm7/F5Yvv2BOaIeQX3maCaERn5TZILjM+9QLETOR754F6W0
	 CpvdkYtXmgT+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/3] mptcp: plug races between subflow fail and subflow creation
Date: Mon, 28 Jul 2025 10:20:32 -0400
Message-Id: <1753710354-495ffcab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728091448.3494479-7-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: def5b7b2643ebba696fc60ddf675dca13f073486

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

