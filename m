Return-Path: <stable+bounces-145684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE95ABDFA4
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837944C0473
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A170F2641F8;
	Tue, 20 May 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4nQqJG6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7525F7A1
	for <stable@vger.kernel.org>; Tue, 20 May 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756336; cv=none; b=jHwUMjlhqGnQOsd8arDuxFi1F8wRHN5hUdJO8DMSWTnDJWnIhoVUwCiI6FeNCNsZc78LCV3gIDrDWKt+KQsEk10Q1MCv85oLxmGagixZsyte6K4KV+579V/KWVg3DHX+i6P0gLbDUKjB/DJoeEylipJtv+mbOQyOIszXGPcyD20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756336; c=relaxed/simple;
	bh=QVhhu+gwgekivPVawIa5mP6dP+YoedGEEZVQLMEky6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxgtKQ/eKwTAw8XD8tP/45cPWGJaHhcoAnr4IgagnSfr/CMtEnbslS6rzp7Ih83R/ut6pZ+TaqnfDRIiuhXu7Ji+GtyANswob/p53UazTvXD+gdq+PVCs3y5Ugo8aPPJl27d8KDiLz6pI1SO7Spx4TOsYgmMcYdh/6eUNDzE37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4nQqJG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EE9C4CEEA;
	Tue, 20 May 2025 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756336;
	bh=QVhhu+gwgekivPVawIa5mP6dP+YoedGEEZVQLMEky6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4nQqJG6mlb616K0Pk1tqd0ACpZvuj7alIbzikO6Yw8sjiz5g0mmT3+PIszS+z0WN
	 AsktI/HKPiEzHCZloLYAEz7B3/j+jtOn14Ty4aW/TjzigVtfjEWgy/RerwRxS4Tb5+
	 XjSD7m4jF9oe7ZOofwoVfb+LVpLQTqyL4EK5hQd9nNuHMOcUb7Y2ZZZnrwQQawcZbS
	 spoRItXNSzMHReimiA1+kRR136+jmBOO94GBscIZILpGewk5uB7PZmQ0J8z4NFkv6r
	 96jqVSNepWVq1cVPXw/0GIyEZ7rNcbatBfHODLzXw7RU1lrDbSYoEwPy7sMrN1IBJ7
	 rRvlma8i7y56A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6/6.1 ] hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio
Date: Tue, 20 May 2025 11:52:14 -0400
Message-Id: <20250520105806-06d3d8d0abbc7338@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520090322.1957431-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: af288a426c3e3552b62595c6138ec6371a17dbba

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Ma Wupeng<mawupeng1@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 576a2f4c437c)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  af288a426c3e3 < -:  ------------- hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio
-:  ------------- > 1:  fb4faead0c1ec hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

