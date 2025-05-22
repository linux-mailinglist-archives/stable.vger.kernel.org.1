Return-Path: <stable+bounces-145993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E64AC0231
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5089E3599
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7FA9443;
	Thu, 22 May 2025 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/GJT3PK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01D66FBF
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879635; cv=none; b=kS+E4QusaQ/nCXvEXUqcGMthyuqYGtAsW+3VI4qDoKluHLJUQhJC/MyIhjLoQWbUajVrGja8OnA7XUl8j9RI15EmgFx9c+OM0j3sAg4c2ARnqtKivLRSPvQujgsLCP/tAV4asTm7WYLsDjHyXGXBwaiGY0sVtqCSHAeQFbZWYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879635; c=relaxed/simple;
	bh=05J9ylpP7XM68A5wde9sPu7IMZysM7JZUkYa6K9/gOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AW0bglca10ykDn6Rk/4HmNZ9H0NGjzHrVWFvD4UriRkZqHxBNVfzKvbEmH7etKF2So7pONU+zGHLdBUpXHINMqE6MwH1Agjf0zcsTnjOBkXiRXU/IRCyp659qt6f0teUQ7y5tuy1zfXBrlf1J7v2DYi4NREt7zbKh3ANHfInjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/GJT3PK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2119CC4CEE4;
	Thu, 22 May 2025 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879635;
	bh=05J9ylpP7XM68A5wde9sPu7IMZysM7JZUkYa6K9/gOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/GJT3PKVFPKQ9niA0jzApHpDgy9566W66ajpQ22e5AOoeB15GTUkPfFxLSjLP/np
	 Eo9iMuGM2PX0lghtfNmnBULc+seu4KU5dnAWUkhKiV7qee8mOz3IRZa8H3RwKJfCar
	 j4JIl8IbyKa7QLn+mFLa9mu/Lyrk44vhvYPAR/WpV4joWTz0PebJcgyD6wVn9I1tmP
	 mhVJGUBFW7qaLssFCguvXS2U/k64fWbFzSltSvPlE72vGdXcJq2nr1TUi8/laIHiTx
	 Y7gEuPRhvCTxqQDRG7AZXc7bH0Rak1OI2ahbp3vnDO+XeTwW+HFKB7RFVsuUyXPzqF
	 gdsUME3ag1eDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] sched/deadline: Fix warning in migrate_enable for boosted tasks
Date: Wed, 21 May 2025 22:07:11 -0400
Message-Id: <20250521160238-7ea340fc558cf543@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521013147.3339412-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 0664e2c311b9fa43b33e3e81429cd0c2d7f9c638

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Wander Lairson Costa<wander@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: e41074904d9e)
6.6.y | Present (different SHA1: b600d3040285)

Note: The patch differs from the upstream commit:
---
1:  0664e2c311b9f < -:  ------------- sched/deadline: Fix warning in migrate_enable for boosted tasks
-:  ------------- > 1:  183a577efa2e0 sched/deadline: Fix warning in migrate_enable for boosted tasks
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

