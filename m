Return-Path: <stable+bounces-110419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8400A1BD01
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81D9188FDDF
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280C2248B0;
	Fri, 24 Jan 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBGWsB0L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30BD4A1D
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748332; cv=none; b=I/6LJ/XYJCd2OSQMvaSQxfCrUm6MMOj+OnHfMUoLSEg0nb6R2ipGjB49lZcKBEb03wGjWWFmxiZDROnN2EnwsMxD1aqCdMwjN1j0TmzGLpUENPRLI4+fNdoJNYGG2OFDc96ZHOyPkkRRjXmilapts4rZsEzHhSKzRsJRRMEP9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748332; c=relaxed/simple;
	bh=0LiOs0KmAnTcgDecI8uVq0yKVwXzPC+C0mhcFRFT0Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dT6EwzkPUAkntML+lKuuwVerIA0Ezi2MWwn5UpPmZAF2GWfpdFgKXZSQXPbNfPmvIlQtQVEa3F0Xsh5woKILDZIN9yqErLQcqUOZ0axEl635fL76XpECfeHibbdiK4pck4yQExsvzw+5A+vJkHa9VJjlfFTuZVJTYdMFaUDSqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBGWsB0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28579C4CED2;
	Fri, 24 Jan 2025 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748331;
	bh=0LiOs0KmAnTcgDecI8uVq0yKVwXzPC+C0mhcFRFT0Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBGWsB0L+G7pI/iJxqMedgQsRD58TWWRABMJnPv/Q1xVdijoTnZTL1h0A81oaL19q
	 4UG+LOvy6y48CDDm9DxnD9LaM/c/v2cCMOfTVyHbNPlBBRJzi+qV8QBSg6GpqQWMoC
	 3kcp7aGnbwiKjkd2yI0RpYT6VABLcCZH2kiTQVAMcQKPMLrWp73KxfrRjyQh1o0wk9
	 +dIPRgLDa7yarM5mxmyPMFVInDHu9/DU2yxzCUAlDvdrQ3yMlctEu9y4aZwi0iVazT
	 Jo0yhfPF9fBs2C6Xy1q8zXB3lx/+4pPNZYDAT2faXgpmyZbg0CK2IrclHogzMZzp1y
	 qmwHY2DVTcruQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Fri, 24 Jan 2025 14:52:09 -0500
Message-Id: <20250124095822-fbee4c72eab6cdbf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_39296D4D4DD6C7BC24B0B51FCE080C53C306@qq.com>
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

The upstream commit SHA1 provided is correct: 90e0569dd3d32f4f4d2ca691d3fa5a8a14a13c12

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Ido Schimmel<idosch@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  90e0569dd3d32 < -:  ------------- ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
-:  ------------- > 1:  0f208d3b6915e ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

