Return-Path: <stable+bounces-167130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC24B224FA
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0E61888B7D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C4F2E92CD;
	Tue, 12 Aug 2025 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7FKdoo5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B49265284
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995928; cv=none; b=OhrOZ/W8uOWHCgWzeZNEg7kwHYZt3ynWi38SspNfk3Fw+bN3kbXgySVLgJGrStVPXyrmaNCS0o96X1J1wmXF8g9cGmSljbwvuSt5iZ9csrOoOFzMh8JpW16HPsFsQyoQL6UTJWGEG7IxeKCPxuHGBCDcJ6mJPQom+DiopztGNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995928; c=relaxed/simple;
	bh=ygo8GAs9wMVPJBQQKXiIRhu1gL8WNlv7dLZ/B4ycKJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tB4/9HCAvTV8oHm/yXzvNe8VA0U0oaVd5o4OkIiTmpfQQVIQJej8XtLXlumMNtP8Y09vSIHWmZGp6NmxxxGRWR0pi5yhJaH7xQDWLo7ENbstbdeW1SNqF+2afTAoafgq5I8whwSnMo8PmSdZvGnxFGFZjpMgPeGkM4uNJkp+qXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7FKdoo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEC0C4CEF0;
	Tue, 12 Aug 2025 10:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995928;
	bh=ygo8GAs9wMVPJBQQKXiIRhu1gL8WNlv7dLZ/B4ycKJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7FKdoo5ZehAONsjW/3j4ynkpv83jvrejxJQstZqJBv2QqJMSN5edNuRKnNUSrZTX
	 uQGnRmgWR53puAu2UMzDv4M4JmwT8//alt4YxxMT5I5/82uekujKpqbMfTQUaknPtM
	 aSkG1nNZMQX85PgYX/nrLHZdgXWPdd5WBTlNBDVM+BoUcM3VENfh7MclrIU0/4x9Qt
	 NRwQijri9TihOWVqCntgawXBozmK6369NuE5l67kvwUDo4DQh8b8bdMwRg7ihCrtDF
	 uhJ2X6BgvpwJ+ht2mVPwCWqA5VjJNedknvJVB0duGAClmIefNxWGj9NojCRZGljPLt
	 0HQ7UHdvj7QDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 5/6] kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS
Date: Tue, 12 Aug 2025 00:12:25 -0400
Message-Id: <1754967622-c52851ba@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811235151.1108688-6-nathan@kernel.org>
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
ℹ️ This is part 5/6 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: feb843a469fb0ab00d2d23cfb9bcc379791011bb

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nathan Chancellor <nathan@kernel.org>
Commit author: Masahiro Yamada <masahiroy@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Found fixes commits:
02e9a22ceef0 kbuild: hdrcheck: fix cross build with clang
1b71c2fb04e7 kbuild: userprogs: fix bitsize and target detection on clang
43fc0a99906e kbuild: Add KBUILD_CPPFLAGS to as-option invocation

Note: The patch differs from the upstream commit:
---
1:  feb843a469fb < -:  ------------ kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS
-:  ------------ > 1:  69d313b2b765 kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS

---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

