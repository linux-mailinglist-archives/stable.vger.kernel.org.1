Return-Path: <stable+bounces-155229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A56AAE2888
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 12:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AF47A87DC
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC591F4163;
	Sat, 21 Jun 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHMzkjtg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0C1E5B73
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750500921; cv=none; b=ljVnHY851DIrz2Ox8M+9DVw+3+Bq6xi9e0MSbFH27iSf9Ba83Lk8+Qs2MNMjW6TWVOTZVYp2o6+ikX4W6No7xCGlwpqMMDnyBbyOeEqYwf/Lyj07HRAeqjQj4qzkdH53oqGDGI1hReroFkDfTUx9B3edEJb9432kIhca0O9ftRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750500921; c=relaxed/simple;
	bh=XTPtTdM7V6Q9heb+B/f4J8k3851UkBdB06T2mc6YG/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ2JjlmQShU8hC+LxonFgi1ThlfCyPg0RZ2IAScUiZBM6oZs+NRe4Ez/rpNz+iqXWMzNm+sKxbdC/lRaQwYA0HvYvnw4/NTaEA3/UxmPxheeDurs+UOvNUCkcYQAWHuEvf0peqLalHaCIAySj8uwIXLnaOLemqd76uQo9jq7Wok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHMzkjtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90478C4CEEF;
	Sat, 21 Jun 2025 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750500920;
	bh=XTPtTdM7V6Q9heb+B/f4J8k3851UkBdB06T2mc6YG/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHMzkjtgXNl8ORuKVjG0iSqD7eCnQYbq1QzbDU1viHy0rqQ9CQMKa7oknExdwnIy+
	 Q8CS6P3cc1iOkM6LXWcxJoFgLGsrH/HntKEQ8s7nrkGmAj94Mpp1YYKKo9wGr77bkJ
	 7Kw115G2OJ78etujkhnqm4HUagBOwaSVfAg72Jqy0p9lfyinXCMwGa3IDOf7ZtlayP
	 kP/Twtge8frr6Pbp2/l/8hYIcRLikGtSXW9gU9YBAkOkZJOzGlBODk98h+ILoP12be
	 LWyQVpe6qy44oQEQMDSO3q/HAAedrgOmIhllHKH57rdXvj4Bh5vtK+7QvfJIVzAqiN
	 uYBFfOaUQN8PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gavin Guo <gavinguo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Sat, 21 Jun 2025 06:15:18 -0400
Message-Id: <20250621050528-9708e6054f15647d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250621054106.3649809-1-gavinguo@igalia.com>
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

Note: The patch differs from the upstream commit:
---
1:  be6e843fc51a5 < -:  ------------- mm/huge_memory: fix dereferencing invalid pmd migration entry
-:  ------------- > 1:  9b81485fcaa21 mm/huge_memory: fix dereferencing invalid pmd migration entry
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

