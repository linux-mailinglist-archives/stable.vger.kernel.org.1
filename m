Return-Path: <stable+bounces-127698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95CCA7A729
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1472F177349
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FD250BF3;
	Thu,  3 Apr 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt7nmAqZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F024E000
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694784; cv=none; b=VoacPVtfzFUOSqAakTacIfpkZpuxh45XX+4rBafO4QF4FAGcqEqtdMr/zUxHzHFQFWavdCsdBe1wAghdXdrn4ELikplvt9kLequibv1HLE6BWpJgsp3cYjccNCVB/4XGaj5mg0aIqW3CY1t+VOcFm9CrvWiNZ4nc6OU1+0g4Iyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694784; c=relaxed/simple;
	bh=toGg2JCvkJbx1S5WqWbEEJr2DajYDUX/WH+mTQVEAzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1eU/Nkj7ULDbnJkMVQtxZ5cEtVrM+aRnWIf5vSFWAy+r9kVsDEkAUPMyizChUgj7Rpy+caLXn4tQklPwZyhRUYZaFW6ommOS8/kMFFkHGpJjC9dNmc96V8PkQ2Izg/UZH5Xjfb68pp4Tc0h0QHqNEyGo6Sh31aFUI0EyI3XHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt7nmAqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03327C4CEE8;
	Thu,  3 Apr 2025 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694784;
	bh=toGg2JCvkJbx1S5WqWbEEJr2DajYDUX/WH+mTQVEAzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dt7nmAqZ4c4iqqGFc1tEWZ2wNpuo5fc7I1XrzbV6iCMkXmhVXi+CoqQQmPJ4nRDaO
	 mMSNMxKs0L9vCojevVQ/5NeSSJo0wTNJBHT8EfSCIn/0ZqmZsGLXk+dRu0ccE/kCTT
	 4yRn4r8zQHbZOTv2/QvoGbRE2Izcn5hrq1/r8etCYadip7ebBiOc8dtn3l2fnNVlzk
	 iUkh1XronJykzGPgdgPMj6gR9+rgFoby5d/fc4fOykypM3EeGTvRmIYjKE4HdcJSlk
	 YSlpSU6IYZftFURyVQkGg16UTFUlzD/Rsf77x6jZutH/r+heAJQTWgA1Cw4wD3pK5J
	 fwqKIcFilqpaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 04/10] arm64/fpsimd: Have KVM explicitly say which FP registers to save
Date: Thu,  3 Apr 2025 11:39:40 -0400
Message-Id: <20250403103904-5e978f972c2a23e9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-4-30a36a78a20a@kernel.org>
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

The upstream commit SHA1 provided is correct: deeb8f9a80fdae5a62525656d65c7070c28bd3a4

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  deeb8f9a80fda < -:  ------------- arm64/fpsimd: Have KVM explicitly say which FP registers to save
-:  ------------- > 1:  e2f3002f4f737 arm64/fpsimd: Have KVM explicitly say which FP registers to save
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

