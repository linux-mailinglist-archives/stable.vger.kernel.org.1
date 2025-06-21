Return-Path: <stable+bounces-155228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79320AE2886
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 12:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A6A1BC0C00
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED00E1F4163;
	Sat, 21 Jun 2025 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu3HkzN9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE671E5B73
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750500915; cv=none; b=ZbP+89ZAugStxASbUzTl295rTqtfRZkyCayVUzVpzrMKT/O35sHaRORMWerT0AwohGTQB9w1nqPlgqzCp7EMUh6qLdz3cNM1JsOwJn/Q/06MjBpk6z9JLJsldhxSWqxZdg0NBg33vksuhyBEWFEzJ7aZpZW9NurVXyjrRW5yqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750500915; c=relaxed/simple;
	bh=Dw8Gc1Jb/gKwgdK0IU5FU2LAHqfnqxtDE0QOoY4Lq98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brlJ1f88kqmhyUGd4eS4Zjz7x/0xR9m76S/RaHK8PRzKWwLxeXxfCzr4/DACVNTeClP6b5UAI8aqAofkttNX9bjqQa2dF0/npc8xoNLJ0m2412BG1vKcPsZHvyCi1WE+BQ2mSuDpuJbzEge2er9P2Q/45Igci+UeFRaIGTHQf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu3HkzN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54C2C4CEE7;
	Sat, 21 Jun 2025 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750500915;
	bh=Dw8Gc1Jb/gKwgdK0IU5FU2LAHqfnqxtDE0QOoY4Lq98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bu3HkzN9q7Dy87c0+0DiWa7cdEV1dHYCd9pSulciXqjvhwHIqW4aj0GzmpYRQeYi+
	 60DtrmjcEir/YPodq5LB60yHTIp/7O2TNIV3ZJ2gzFpJbWK+KBOaRuAGvWVI7NYOza
	 6NEsq2FhM012BjsFd8Y/u9QXg8+a1gq2D+6INm+CtYdPOo5m4hWOlW7yB2xCS2kNaf
	 R4yi5UIkmqEWZFSNqZi7sINDZIdztfG2SNUmpwJuXhIOlCmArbXSZ6cqsD59X1YGkZ
	 DiWZE6GxVXDe7qpG81ESTgar7EX7LxQPD1R2U1TozQPTSCuj+e/k55tJWSY3BBrhHp
	 0n2TUSrSkAjig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gavin Guo <gavinguo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Sat, 21 Jun 2025 06:15:13 -0400
Message-Id: <20250621051555-c4f8d863d9d34c17@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250621053951.3648727-1-gavinguo@igalia.com>
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
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  be6e843fc51a5 < -:  ------------- mm/huge_memory: fix dereferencing invalid pmd migration entry
-:  ------------- > 1:  7a3a963d92bdb mm/huge_memory: fix dereferencing invalid pmd migration entry
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

