Return-Path: <stable+bounces-160267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF67AFA21B
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403A54A6F5E
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74533298CDA;
	Sat,  5 Jul 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phtXKHYT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D62989B2
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751629; cv=none; b=QboVhjkGss4YrguTmWXSO9tdI7z9DpIud+FDfT5qBzf9NQvgqpOMJGxOz6hVkhseSqUtsgS8LMrzMcqmj/tzNfrK/qt7Q9bmNXX8ITzZxTaj/KU7pFHFXTMDVvBqO4Lw10P0IyU/sUGxNn0KO+TJ84qojmvsQe9QvoVKxs3sxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751629; c=relaxed/simple;
	bh=9SSU9IlQTn1sSqNIwWo+wJaGUtBHb17fE2s0LzI+rr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCbmO0TULaIMKsslm0EW8QnVFyUyMj3R3JscC+2NheQoZBKiBqmhRRTwVUgUEcX9GZwSjgAXirQQPKCefuYnue3E6//48YHwO5IrAVl0atHDN0RTzkLQDkC+yW16kt0xxQR2GGX55j17wykc2tUuaTiCtcZdjM30ANYZ4C67xbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phtXKHYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D08C4CEF0;
	Sat,  5 Jul 2025 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751628;
	bh=9SSU9IlQTn1sSqNIwWo+wJaGUtBHb17fE2s0LzI+rr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=phtXKHYTf6LLGsxZoWyqid1AB5Hnahs74V8G5GqAdxmWBNmeCT0oncHAdbHEx1RMC
	 WD2qQfSr2IEWUO9H/9foj9GT5FQL/Mhga7T2ZY+52jjwDf8gp6wIdWyBZOYY8ATL2c
	 AICet9/OQVTeKHMDIcyrM1Y+SeZaE8//Xp8Mx9nWC4aWhFuFFKIsRPB+63Qk6bTaEr
	 8Okm91/ZkI1CCglbvWDHQTkwEtplJ/KDzGBE6e2oKvn7tdMq8gq75T4Qx01B6ItTc6
	 5j0tx3Qdguicz7aO65Gb/njQMSNoyq9zlnDC8sTXyYxOxjVEI0s3qyGKy9I6J+tPvJ
	 Why2f8oZ45qJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Teddy Astie" <teddy.astie@vates.tech>,
	Sasha Levin <sashal@kernel.org>
Subject: =?UTF-8?q?Re=3A=20=3D=3Futf-8=3FQ=3F=5BPATCH=3D205=2E15=2Ey=3D20v3=5D=3D20xen=3A=3D20replace=3D20xen=3D5Fremap=28=29=3D20with=3D20memremap=28=29=3F=3D?=
Date: Sat,  5 Jul 2025 17:40:27 -0400
Message-Id: <20250705104831-9ab14bed1a9039e7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <ea4945df138527ed63e711cb77e3b333f7b3a4c9.1751633056.git.teddy.astie@vates.tech>
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

The upstream commit SHA1 provided is correct: 41925b105e345ebc84cedb64f59d20cb14a62613

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Teddy Astie"<teddy.astie@vates.tech>
Commit author: Juergen Gross<jgross@suse.com>

Note: The patch differs from the upstream commit:
---
1:  41925b105e345 < -:  ------------- xen: replace xen_remap() with memremap()
-:  ------------- > 1:  e60eb441596d1 Linux 6.15.4
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

