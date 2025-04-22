Return-Path: <stable+bounces-134892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB119A95AD6
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C1F16F7BA
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B8F13AD1C;
	Tue, 22 Apr 2025 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA96+UtM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13E33C9
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288141; cv=none; b=puSv0sezMukeMioNepZxMxEAerZrCs1HpCFy/8lNljIJAOPmodbrkt2J5d9mU7pJfAgge1k6Ypr52Avgb9EiC5Ax5l50p88+IuQRDjqMgi/mS86ym3UVUD4oeFo9wQ/b/2bKzPoJlQI1i6RBDXju2Q5eUmxl0xAwKLGaCZOsINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288141; c=relaxed/simple;
	bh=HbN4lK4j3nsZTypVjkdXZw/2totbYIymfWP5H7tX8do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/8eoDmsxqyEHS2MKv437Y60385pUk9zVFSQXop6y9ijSvUrL//QlMlwa0gFsoATGuW0OzvOce3UX+rW13+ErkpB7ImOwjT69pzWvLN4rPA/bUzD+6HvBZ6zZclN3pVwFJA7guQaAmG7j1erHvQ/fn4KJETh7DFqRxKmWVsSA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA96+UtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5DFC4CEE4;
	Tue, 22 Apr 2025 02:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288141;
	bh=HbN4lK4j3nsZTypVjkdXZw/2totbYIymfWP5H7tX8do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VA96+UtMXgsUHXyJfGtSaA873XkfEF/B9VV+XsiMNTtY9+z78rMIf7xM/4cAYTLC3
	 cgr1z+dIxeUHSf93ybLktHI56UdgfaPBUQaryhH/lnE1IFv6Sejx9q2njM3iIyqmed
	 24SH9gbcgaFPC1uTcLhRMZkAbKbruVmscFNJ2mJwjKUWdVCM6GG75PV51IDG8J8O49
	 XAO7od5WeMZu5VyTPH/b1iAbiQatmU5LdEJcabvXkS61PnaHOKKVDMrkNNSGrNBgvF
	 cSYGDmQFLUjtjuf1ErrknrrI3XQP/kSsGIw1oK4ZHVbZiGoT9kDXGSy2EohBk5E3iu
	 nEyxgjUP4Abaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
Date: Mon, 21 Apr 2025 22:15:39 -0400
Message-Id: <20250421195021-ca023ebdc519650c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250421154059.3248712-1-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: ed2b548f1017586c44f50654ef9febb42d491f31

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nathan Chancellor<nathan@kernel.org>
Commit author: Kees Cook<kees@kernel.org>

Note: The patch differs from the upstream commit:
---
1:  ed2b548f10175 < -:  ------------- ubsan/overflow: Rework integer overflow sanitizer option to turn on everything
-:  ------------- > 1:  a1c5f5e8b07ed lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

