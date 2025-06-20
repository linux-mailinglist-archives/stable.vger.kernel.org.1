Return-Path: <stable+bounces-154851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41671AE1117
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929A219E2627
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE713CA97;
	Fri, 20 Jun 2025 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KETsKJ3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A4137C37
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750386302; cv=none; b=byFWZ3E2UHAeOBklLAD9HPvCRI1j4FYNSivPZRjvnfItWQMY7Oh9VISG96DD5NAioE8G61myFjTUtxtHbrdaWvFk1YciYJSJBuxaMWs56gRVxA9yTN5quN62el+6DgI7+mPSABXIPhYtv3j+TtFqP+e2PcgZD6QzynkX25CjPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750386302; c=relaxed/simple;
	bh=xdhGp1prpl+A74jDr1aTWao1XuAu2ednkYG2qqcpBNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PN4Y4jWNuZnNMolulxfv3zrjnECCAyNgxIQzghBMRBfaPgEWSWGXCot1VJuSHcRPDB8l2jgLE7mo1pZzm0bJWexRurXhi19LA4PuHLoK261lR0GtKPwVyztWphGiWiTqkJVe9RyvQ/U5Runw1I8mUhopbD2nJ2kQS1suBplI2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KETsKJ3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9065BC4CEEA;
	Fri, 20 Jun 2025 02:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750386302;
	bh=xdhGp1prpl+A74jDr1aTWao1XuAu2ednkYG2qqcpBNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KETsKJ3M3gD3NG6Bwl2dDgMUlQRICfxD7DhZ2o2Sh/0Fp7lp4tNISSXvJW8j/buvi
	 Ctyg7gYUi2++9dtPwH7fso0AVz0NZmIwTC1kDBtRxGIh+bfutX9ZDrixUGXFin8ssI
	 CwHuYGy0h2P0GKdiAtB5CIz3njHe3u+c1OVl2ukOLEASElgNClbc98vlEOJJC7NYzk
	 ANzpze7YmgP3mhlYWfGnT1vZ2CDRtoEJbd2SxW1bViDpunzltmOpezS7KeCOniBONH
	 AnQedHHbCQQbgE6bMzFz/eHzJTXIQYIWAEJPau1ZGUQ6Jj6BVc942omB7QNe0UUS/R
	 5Xba/mByLabgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gavin Guo <gavinguo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Thu, 19 Jun 2025 22:25:00 -0400
Message-Id: <20250619054958-29abd310d1428d27@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250619052842.3294731-1-gavinguo@igalia.com>
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

The upstream commit SHA1 provided is correct: be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 6166c3cf4054)

Note: The patch differs from the upstream commit:
---
1:  be6e843fc51a5 < -:  ------------- mm/huge_memory: fix dereferencing invalid pmd migration entry
-:  ------------- > 1:  07eac80d67e4e mm/huge_memory: fix dereferencing invalid pmd migration entry
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

