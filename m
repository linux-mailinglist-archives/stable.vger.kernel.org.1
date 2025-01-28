Return-Path: <stable+bounces-110988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4D0A20E5C
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3976916744C
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662B1D958E;
	Tue, 28 Jan 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8F84WNp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6C1D8E12
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081078; cv=none; b=TMVqLgvMzPiKSWHGG5joszwYreQmFykcSQ0do9aAuY6m4cm1isu+ebPx4txS9siJSX7U6lVDrRbZ8qvPl8TzBascjcNWsZjgmRml1xtLz9zvuzxIsCMvl3nK2oC/Sybo+/iUydzNuYR7NXubzRmP4IH0D7ZoLiHZv6ZI3JJOrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081078; c=relaxed/simple;
	bh=rjsKOird+BmvNg9TAst5uz8ixgw0VydUC75Ktxt0ksk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0WdUka1VhQ6EsarhQ3OWjb7i5dkb7umn52fkydipPp5eNYshlof07NMlVHMybmNbleoVoMuMWhpqUzhbhIRtCY6NAPJ1a9HSKwVQYvYl/IAoA4Jf0mlREDQlhddU3rmxwqHYzzTszpPRdoVsOc817XAEPPJt3ENV/Eu8Yj5TUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8F84WNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB27C4CED3;
	Tue, 28 Jan 2025 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081078;
	bh=rjsKOird+BmvNg9TAst5uz8ixgw0VydUC75Ktxt0ksk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8F84WNpGYBGhqP9nuUpkWtJ1fC718dvAL6ZvyGkIhfohHxDGWRvRe0h8mCUyRKNj
	 Fsry+fjbHKWtFgHly3NBRUqMbDE7hfx6QpURH61zc9XuVjZnIe+/zaizFw6IVJaYLx
	 8ArlIMa11XziMhLwOMU9i7B5YlhxEJKFUknZQUKEXdfhaHkNyTMNFJPj00BVO9LY22
	 zBXnA+85l98qQ3DB6V0ggorrs4VaoybtbT/481dAtD4/uaGEl5hjpLbMTvC2HDcWxG
	 MV7ubW8NBE7KF64QGph/DGRmOnh1I6n8JVmQ38wIkzLGiMe/n8X5qKqGj5UmxwJRO0
	 t60cigaoOVcUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ciprietti@google.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Date: Tue, 28 Jan 2025 11:17:56 -0500
Message-Id: <20250128105801-ea665ba4840ac960@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250128150322.2242111-1-ciprietti@google.com>
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

The upstream commit SHA1 provided is correct: 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a

WARNING: Author mismatch between patch and upstream commit:
Backport author: ciprietti@google.com
Commit author: yangerkun<yangerkun@huawei.com>


Status in newer kernel trees:
6.13.y | Branch not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

