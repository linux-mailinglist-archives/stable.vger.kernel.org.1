Return-Path: <stable+bounces-158703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FEAAEA3F8
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 19:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4344F1C43407
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E61216E24;
	Thu, 26 Jun 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+GmA7VV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1519214236
	for <stable@vger.kernel.org>; Thu, 26 Jun 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957496; cv=none; b=upo3H8FpNtHoh+8MAsO6D7FdzwlZpBAshnKprRUKQ8FdhLEegTpADQAE11E41GzME6VNtB9lQp8DOFs09c2lyoc6quCu2ULWpH+hAXnKslQF0psydgHGiUwG5ztF2JH7Fpu7varAjmo6nar7s3zmtjPaPhY08lryzaQoPnJKbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957496; c=relaxed/simple;
	bh=H0t0WvZ/Wwcx/5TG3QZ/5MbnzmtzifnbaRaXVI2FSUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nejCIWmfJRvjQwP63Ip230Zz3w5g77TrYFFtXIhUfa+2cygeuaXO2efVYmmLhvNhhemTJVRKiMgeQfEKsqDqdt3jLS9PbzUEd182VNgHvOmeLp1l3llw4hN5N6GnjE1aoondrt1Rz5BZ7B6l2setoHvilh9/689brl+Bi35Es8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+GmA7VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DA6C4CEED;
	Thu, 26 Jun 2025 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750957495;
	bh=H0t0WvZ/Wwcx/5TG3QZ/5MbnzmtzifnbaRaXVI2FSUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+GmA7VVcvB8m6hM2NDmUxN6hbB0x3RtIsbbuRhi3thE74Bdy4THs/bDAYQtBvspM
	 WXSoUUOVFgSxtqEgT6TeOti6VwxQPCrej9LrkMGemGeJk17IlJoWzwnDrZiBAk03K/
	 TZiG36lF9o+WKt2NRW/vXrFt1ECQsvOXOZ36kIdtjaw8jDYAdEKy0Wn3pI6a6d6wFw
	 qHBt2noPTE5Vw6GSIBnKOjZpOSRFk/UTHPIwOYIPPfT8V14yk6Lic/WYMahbCqD3kD
	 0L92n2Z+ssFOiKDqR3gsDIHqGLhfPPJCDno+SdIzUusNDjyjuu4vf/Wi1JqSre0oIX
	 7uJRSSB+tWDEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pranav.tyagi03@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/vkms: Fix race-condition between the hrtimer and the atomic commit
Date: Thu, 26 Jun 2025 12:53:28 -0400
Message-Id: <20250626120819-02861fc697c8f416@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250626142243.19071-1-pranav.tyagi03@gmail.com>
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

Summary of potential issues:
❌ Commit was reverted in mainline

The upstream commit SHA1 provided is correct: a0e6a017ab56936c0405fe914a793b241ed25ee0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pranav Tyagi<pranav.tyagi03@gmail.com>
Commit author: Maíra Canal<mcanal@igalia.com>

Found revert commits:
7908632f2927 Revert "drm/vkms: Fix race-condition between the hrtimer and the atomic commit"

Note: The patch differs from the upstream commit:
---
1:  a0e6a017ab569 < -:  ------------- drm/vkms: Fix race-condition between the hrtimer and the atomic commit
-:  ------------- > 1:  a2b47f77e740a Linux 6.15.3
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

