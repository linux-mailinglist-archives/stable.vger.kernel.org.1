Return-Path: <stable+bounces-121657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED04A58A53
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A523A8CE3
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924F18FC74;
	Mon, 10 Mar 2025 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyRcviQN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39553156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572893; cv=none; b=fCxNa2NCIqk38BGezHznoQA+Fwfc9qlBefZ9ka7lR7EDjMQOs0pG/abq8WuMc9tP1fajErrRUsAVDkj7wxzL3oyLFDZ0HDmACJ9ldHdoLKz/cwOWqz7h1ypBPknYeCSNeQhd2ZxFQ18jZx8Ph2zy3LDMzt+0ngDuaAK49X6AS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572893; c=relaxed/simple;
	bh=TkVVkSM802Q6kHtSgKlKhxHU82KphsQadkXvInGiNmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpKiTcD0JEywatKeUzsj3raIj38TCR/yBZEOvbatcOsC12IBKm68a5qXQ0QZ9W6vCnbGTYnkLApltxe1K6I5qqJ5iMOqsGzLnY8uixZEk9c/PN9y4foCurRc6fHKUDQoT4Gt8xPkFuTMjv6M1DuXXei/MuEurZZotOvB4N6pCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyRcviQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2350C4CEE3;
	Mon, 10 Mar 2025 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572893;
	bh=TkVVkSM802Q6kHtSgKlKhxHU82KphsQadkXvInGiNmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyRcviQNcQnwk0+08VhU7xejgVZiI5j1FFM3qpsJ9/lMmPTjvtCeTJA7GebWxXz+B
	 oPaFvDbu5I5nnalFf5G8p7DUyEsq7Tra9wbOXMU0mYKI6kPZX99R50hRdjWEpFfNec
	 JDTSAVZPRKElm8H39Hkww1fgs33c/BKe6Neues0fGRIYp1Nnl3sU1NrGYBN7T/7mMe
	 u1Rk35EmUJVWa+F6LT7SLnxncExG9LH1tergIeBF4I8JCBooFRX65d7D9Yuqd9Nk7R
	 oXQ4H3dnL3owox4Y18BRvumBmxr/XyuRG5KHrfrpTrlKz5klLTqKbLNecRWQ6ELVuG
	 DiwHpRZVDNsaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Panov <apanov@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1] mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
Date: Sun,  9 Mar 2025 22:14:51 -0400
Message-Id: <20250309203432-73c18af6088d5e1a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307122804.10548-1-apanov@astralinux.ru>
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

Note: The patch differs from the upstream commit:
---
1:  091c1dd2d4df6 < -:  ------------- mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
-:  ------------- > 1:  872437ce0bfb1 mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

