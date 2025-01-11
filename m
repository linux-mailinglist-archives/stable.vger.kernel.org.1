Return-Path: <stable+bounces-108297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA370A0A58C
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 20:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067101698DC
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 19:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5125B1B5823;
	Sat, 11 Jan 2025 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH+IEZZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160922083
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622301; cv=none; b=YGGKOs86Py90FPImiGFOY2z7ye/tuBScKf0E+UwQOcDO6qdsMiwTCCBTZezC2KQUtFWBhZVmkS9oT20JBf30WRU3bTNB/IAQ2ZtOGKCY2xe587IFAlFGkrIw3usapzMptPTClW0us3zXvEVFUxAWxLTLPafS7tAjWYzbjCYsJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622301; c=relaxed/simple;
	bh=9sQT/Z8eEd+z1WlB2GDOgSWHepC0zoE0Ut2xlzzEUcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdeUXQeOhlwa66SpQPh1FJRbUySMLwoFeWlmx67Wlh553EwOCHUZ/cSS11pWCWLlL5k4V6A5td76an66v4vaCzAxyyDlVxAncRIYLpRNU8XppGO23lYiUoKt6GL10SPHm89fwGTLZZ0meKOsp694s+VlHe0OKC17EZFFgZzOwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH+IEZZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08530C4CED2;
	Sat, 11 Jan 2025 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736622300;
	bh=9sQT/Z8eEd+z1WlB2GDOgSWHepC0zoE0Ut2xlzzEUcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kH+IEZZIoSEF4Bxy8B3aMjLKgWGESOXbPGFHwyTbKrI4bwvd1jCgtph3exzZuqG6/
	 277pJk61rg37jPDov7qeXx4b4yU3IcUmTYDKRtsRI7xlT9EhRJDNUB5eRKlEfyY881
	 dqtI+KK/IuSs3IDKv0JXyri76zezqK6wkkgMgTKTpALmgYvtRKqZ6J9c/JFMK9icWv
	 sRb7ZKxxEhwBLR5aQX2TkY8/B8zkK8k2M5kdncLQ1uOVlBi5lkNqqKBlJorOZ+tP65
	 Yfetu/0ac23KSyuRHloKL7lyHzTbkveoRlnHcToE89TPbD2sF31FkNVDA7UItyVx6d
	 yRJjSKVARJHLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
Date: Sat, 11 Jan 2025 14:04:58 -0500
Message-Id: <20250111131044-19182d8aadaa3901@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_A6390C6B4311AD460DE2C7BDE489B515CE06@qq.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 091c1dd2d4df6edd1beebe0e5863d4034ade9572

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: David Hildenbrand<david@redhat.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 42d9fe2adf86)
6.6.y | Present (different SHA1: a13b2b9b0b0b)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  091c1dd2d4df < -:  ------------ mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
-:  ------------ > 1:  8c55d12358ee mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

