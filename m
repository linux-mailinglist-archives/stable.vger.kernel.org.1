Return-Path: <stable+bounces-100670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FFF9ED1F8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9720D285D2D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C566E1DD9AC;
	Wed, 11 Dec 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn1uAlf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4038DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934791; cv=none; b=SzJVu3sWhGvH8HpAv/lVJOTlwH3KwGsZKQ/6TLFyXWuKpAuZcqnkjjvsZ3QP0K9Pn5ZDEna8sZAlOxteafYNgSzsll8GSD67A1+MSj8GElqaG1XdFKU8KMgHWABNv3AILppf0Qbl3ja0aWQSCM1iwM8vqY40+KATDnddfSDHrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934791; c=relaxed/simple;
	bh=EiSBQsXk7oqM7i78QJsfuux3iZ6PzinPEAoi+l+VJzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7060NBS6ZD9PlWwfbe4v/AxAXJrLyFXXK2IsSjB8cJF+/yo4mcOjbqvd/gcBkBgx94PQldC98U869xsb+01ivHjC8r7DI4CGDxbucWhQawxzu7paVvsmrbl2v933cUWR3tzLRL+Kx6QPjxMLFGJX2BTkfKkghr+ZGfSVqUPjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn1uAlf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAED3C4CEDE;
	Wed, 11 Dec 2024 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934791;
	bh=EiSBQsXk7oqM7i78QJsfuux3iZ6PzinPEAoi+l+VJzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yn1uAlf93sUhrWK3cWYl/p96LptGhLa4SZL3HQZtuqaNaPHOalJDOAT3GVoluwrSd
	 SDwl+DRR0rACkbE8FWCq1Ie9Jb1wFHl2ukT3xAnCkWhH0318UB+R4VmrnT/RZh20wm
	 Gu5AuHNvZ5v/4jVFFRXBW6RLd2mPeovuMDX8NGFDrxoV5a/XDQWZZG/qhXCqjN83Jp
	 gIOdSUV5228BNhPgnRpig8biKW1L7dk9EOSeNY1c9185ks/L6GrE7S9Xjls0KtDPxj
	 fJvJwDkyW9FNW0rQpzN7xKCGFSMeClhuuoPIEmy8GTte0Us/A151wvQWKJrYDdgfDe
	 9C71NStmdVSnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Wed, 11 Dec 2024 11:33:05 -0500
Message-ID: <20241211103221-d2024f9fdaff30d4@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211100953.2069964-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Cosmin Ratiu <cratiu@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4dbc1d1a9f39c < -:  ------------- net/mlx5e: Don't call cleanup on profile rollback failure
-:  ------------- > 1:  14dc5a3a9829e net/mlx5e: Don't call cleanup on profile rollback failure
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

