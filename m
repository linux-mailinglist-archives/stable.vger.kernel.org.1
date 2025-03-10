Return-Path: <stable+bounces-121656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C05A58A52
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A483A8E73
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C117A2F0;
	Mon, 10 Mar 2025 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhUlezx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7A156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572891; cv=none; b=huu5cyDg3/LntrQxtUMbHINxRW9SdqSFPak/J366xyQ2RIgIpMAn92qzpSOuQgcN3rjNzRknjYlbYpJbnNPubmMS6Q5SFaB6+nLJdQy8kKbHGY4D2+aTQyf6HTk1JETZXcKdaVNQOFcVM21lp9xrlqlPxVj3ZGwMi87tJLRcGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572891; c=relaxed/simple;
	bh=oCnMpe1SREh2biqQviWo9NlYsU6U/KWafex0vO1bgTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpY+bn1psnidh6ujMy1NFDq+OU5dAfU/p158FkjJFVV8vvmsAQNkqj1MUuV6o6lOEEyoLroZiX7sYCuWorG3tJ6EeShp6kYkvUzss6Fbk2+ux01vDrBGqJSGNaRrQvtU0ct8Qkk12ip1Q7d92ZyVL4DxK9r5nLCNc6BdzLPc1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhUlezx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A28C4CEE3;
	Mon, 10 Mar 2025 02:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572891;
	bh=oCnMpe1SREh2biqQviWo9NlYsU6U/KWafex0vO1bgTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhUlezx980JoTSxH4NnOdxzNgF/o3feOgYBpb6xbNHEkJeLOacbtcurkDEfwGQajX
	 wsR6TjLm1NO1Q7pIsAUi+9iVTWpTbXfJanIZbrtA6HnjchpDcgQEUWfNY2nmIaAODH
	 npP5xjPpBa799hdYWffwxNoJTwGQSD0RbyMUyelFqlNCMNibSVnQ4nQat3jqk36ODv
	 Epz4WuVAvY+4F1eticxD6uQeHZPSXjJIp+nKHvJqTATjqKW99ZuPkB9Z9WNTL1QZxO
	 rvm8srtkrOv9EKCcRYHhVIzwJuyb1bPD3YyY70sQFL+dsWudQH/xsQBl3zMWo+OFE/
	 WcfPB+nKcFudw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Panov <apanov@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.10/5.15] mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
Date: Sun,  9 Mar 2025 22:14:49 -0400
Message-Id: <20250309165521-4f42f36a8a1e7bf1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307122830.10655-1-apanov@astralinux.ru>
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

The upstream commit SHA1 provided is correct: 091c1dd2d4df6edd1beebe0e5863d4034ade9572

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexey Panov<apanov@astralinux.ru>
Commit author: David Hildenbrand<david@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 42d9fe2adf86)
6.6.y | Present (different SHA1: a13b2b9b0b0b)
6.1.y | Not found
5.15.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  091c1dd2d4df6 < -:  ------------- mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
-:  ------------- > 1:  5691ed935909e mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |

