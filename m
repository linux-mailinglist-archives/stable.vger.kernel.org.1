Return-Path: <stable+bounces-132156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12887A848FE
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C5D9C18D6
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301901EB1B9;
	Thu, 10 Apr 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r35C/S6D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDA1EA7FE
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300481; cv=none; b=Gt9O8RYAroggPO5XL1vHw6Tkj7m1jfElxWFABTwtl8CV50+AZ3QrW7KzuGG+v6a8VyA2po4NgXRziNCg/YcPgRLgolqWFlNnYrM8Ka+p0XxbOwYqyOYCF09a+zlu1zCw8cWs0SDa4i2qQu3+tWQNt9pAufNfojcv6xG0droXI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300481; c=relaxed/simple;
	bh=GvxlUa0vDvahMe06atRwd0mSWFUeaWNMBxQ2Fcv90u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlHPbffR2bqf1rd89nybHRn+2DnZJ4OpyhapeYC4R0sN7YIFI/2N2DwdvXgwirJBTZPWpKMnfk/fS4DJkxZ+lnTWTuhNJFWxdGQGiz5P5fCgcQ3EZA6ZvOhlXSF1tQTfrSZBKr13gv7tBFHGAesJo9Gcs92lV+kZx+TXMr/KHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r35C/S6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF91C4CEDD;
	Thu, 10 Apr 2025 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300480;
	bh=GvxlUa0vDvahMe06atRwd0mSWFUeaWNMBxQ2Fcv90u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r35C/S6DfK9OIJTN2N1XBdtYxvuHERm6qGz70qwMzlXYAMaAju5qkFTVsF5mGqyNg
	 Pv9YPkA9iIHMw9mVYaPxel9wxTW01D7v9lG7I5gk3CLta1vlufsw9xhKzTZBGyl7u+
	 gZ6M3oCZEwqbUFpCcrh3BUsEI+Aw9khlTmK5IR6vNrdDiqCb/7dRAY6R6cvc4VuEgO
	 QYdMaQZRi4An/f1dczNC73IkbSRXbccRXPV32F6Q7pEaT+kb4bfgGmfuKcY+tj44MG
	 Q7AyNUEjzuJIjXqb9gerWcXU0r0d4nUOC8CRHf6J6UwOI2/QmrpzWBnCvno9OdhPdy
	 CHuMYI0cUgZNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] ACPI: platform-profile: Fix CFI violation when accessing" failed to apply to 6.13-stable tree
Date: Thu, 10 Apr 2025 11:54:38 -0400
Message-Id: <20250409231217-cc80e71836b29e47@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408184518.GA2217235@ax162>
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

The upstream commit SHA1 provided is correct: dd4f730b557ce701a2cd4f604bf1e57667bd8b6e

Status in newer kernel trees:
6.14.y | Present (different SHA1: 373b7e8da8f3)

Note: The patch differs from the upstream commit:
---
1:  dd4f730b557ce < -:  ------------- ACPI: platform-profile: Fix CFI violation when accessing sysfs files
-:  ------------- > 1:  ccffc69a474fd FAILED: patch "[PATCH] ACPI: platform-profile: Fix CFI violation when accessing" failed to apply to 6.13-stable tree
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

