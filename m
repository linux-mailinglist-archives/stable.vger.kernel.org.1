Return-Path: <stable+bounces-126663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEBA70EF1
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B24C189891B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0F137775;
	Wed, 26 Mar 2025 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+Ge+VtZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5A13633F
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955827; cv=none; b=CK1rYvgNZJ3C9kG4ZUFURF3U7YbvHRJWetijs2MxWsH65CkYg43mIpwuzadQ583duQ/lORGDJ00ZHyrcZsPoRsHGlFOfO1509GltJ5rJRSu2KzsEhqOjhm3+sNQQ+rxqLIst50knC61xK2owpnhWXu+mil+hZrSqbozOGj6VS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955827; c=relaxed/simple;
	bh=Vs3xBFXYMgVw6lye5As6FCRxFSIClUlUr30MM0jX9tY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKW8e0LBVrORrng7fjBtRu3zY5mJQrGTRTvBbCurF4L/AgVmSJ9HfYxe7qldWmjyBhAUBlUQlNaSj9pYXq44mU6nwa7Oq8n1EyDKJLUN9PCdaausVfEBrFHK9aIIC9pllopB5dF+nHIpPSj93uTJz8yb0stjdrH+IFgwY6kipZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+Ge+VtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F6FC4CEE4;
	Wed, 26 Mar 2025 02:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742955827;
	bh=Vs3xBFXYMgVw6lye5As6FCRxFSIClUlUr30MM0jX9tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+Ge+VtZOWhLF20QPwBmQFRYuDuUfDhNqTEJ17yY4OsaWiiliFgVImgx9AdGWXkCz
	 sDJxsieVEk8SNowSbfg0N19X9Yww4EmNqX9QQrRtRJ5gtmcvC7qg0nimcFuloui6t5
	 JQzlpkWVXT0sTIMzl4qelqa2Su9R1oTSb8puvHEF07XCEa/AIlHh5/A6r/CCdORhVq
	 r4XoHfJ60gtpWS7wirsRwViMPvhFWliYAkUwcVs3rDWJXfYphptrE1lTuCFeE6iYfR
	 /DpJrY6yiDEZgl1R7UcVyaxvZ8HIIfIVrYvzyc3QCdfbEWcnL78/x1oCuzLBqJtOi6
	 JaqfLeVKKietw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	s.gupta@arista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64 mcount_loc address parsing when compiling on 32-bit
Date: Tue, 25 Mar 2025 22:23:43 -0400
Message-Id: <20250325213103-4a630c4ee322794e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326001122.421996-2-s.gupta@arista.com>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.13.y       |  Success    |  Success   |

