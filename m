Return-Path: <stable+bounces-144623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279BBABA2BA
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC823B5A98
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046D027AC46;
	Fri, 16 May 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPlsKwlJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B987319938D
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420005; cv=none; b=fR54uqh8oy19gtDdLxC/YalsJ50+RZOr19VAeRb+xanxlssvCXFrx4EN4l2GTbosduHcnM7aR/LQFRh6UK35WHSqlkABqCX6fXAZpsQZBJw4PIyIAguzAGC4MY9DM7o/BKFGwUVcqVzfYn3g+RM0SjtHUJKlQjvIqMw0GTKMgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420005; c=relaxed/simple;
	bh=r1NK/jfuSIRjIABqaM/hkDfJV365Zw87ckclYxBOxdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6YNzSR5mTq6WpSx9X9rbH/GLKfVxN+KDt4IKr5vBlM/A+8XeSrf54jsBQqmplQMJRFYjcoTUxRByreVQq8B2Om2cB/iRfxllTssgBf5p1iIawEKVDYjbfNgPJh28hpIBdNwI2MooJ3SEW9ZSsxQd2Stka8OgeuK3gJiHDCmTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPlsKwlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1852C4CEE4;
	Fri, 16 May 2025 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747420005;
	bh=r1NK/jfuSIRjIABqaM/hkDfJV365Zw87ckclYxBOxdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPlsKwlJAvr25WefJ3Nun+XZkPdrZKXzfWS/05Ol5iKSPE5k1bkd7RrVuTS3LRqbO
	 Y08bquVSTQ8/kZxDYbipZ4HnfadVR5odrLAJ9Kz1lnPfrspBL8BMDK6AgYy5vVZ412
	 Loxu+/N5jY6iMo3eW14gLBevDgr0wcfqWuz9lve4k8onc/ql7f+CLEfI5UrscWitSc
	 DWHEixXaSU1ElrwUza9S8o/cVaScjvfyGsXE99G9hxDEkStS/A65aAzoqionXVz57W
	 kOvL02e8FkryG20EWcATcovsOK4qUt/Sc/OAJpG4DLreThzfQ15v6RXRsMASPNq7p/
	 Ckpf0yMfmGTCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] spi: cadence-qspi: fix pointer reference in runtime PM hooks
Date: Fri, 16 May 2025 14:26:43 -0400
Message-Id: <20250516113055-3c78756e26b8c396@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516062528.420927-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: 32ce3bb57b6b402de2aec1012511e7ac4e7449dc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Théo Lebrun<theo.lebrun@bootlin.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 03f1573c9587)

Note: The patch differs from the upstream commit:
---
1:  32ce3bb57b6b4 < -:  ------------- spi: cadence-qspi: fix pointer reference in runtime PM hooks
-:  ------------- > 1:  6764cfc0045d9 spi: cadence-qspi: fix pointer reference in runtime PM hooks
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

