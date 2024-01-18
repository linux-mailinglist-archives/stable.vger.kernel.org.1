Return-Path: <stable+bounces-12177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5007B8318D5
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 13:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E581286CF9
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D5424A18;
	Thu, 18 Jan 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsTvMYY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0A25116
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579359; cv=none; b=ZPxjHe1ouY404L30eVQlERGioCjRRva5TNVn7Ztl1Wc1jKe+9KdbG/S2kCiXVstxLWrX8gnJ3ByO49r9B2prdKXJt4XSCW2OdFBnVdb3tDkyTNXCRD/jIIt/vboUJWozJm1dsGMrG7tpg/DN9aYK3T4gdpsL9geVBkxL/wzd0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579359; c=relaxed/simple;
	bh=pzYBPEZr8EZ5ZI3pR8S8xbO8dnYY2ubYVtztB9ugQtQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=X0MPPPAHC2Qp3Yi8GdSX6HH3zmVcmfw3PxShdlE2kPmCZ+DS2LSjPiB0cnCKThBHNT1o+1DV+7IsRMVE0AHpGpFXVqGXjbdcaK/6DcDSbu766im9VwmNbqlsoF7tyAYsOb4JGWZ4sT3JInE6czB97hG0OU2nyfpbu4SgnIQ+Q9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsTvMYY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7941AC433F1;
	Thu, 18 Jan 2024 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705579359;
	bh=pzYBPEZr8EZ5ZI3pR8S8xbO8dnYY2ubYVtztB9ugQtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsTvMYY+b/yJcCjMGHcIelyBji22CmuNo0vgsLCZ7RVjKGKTf9Th9hlJUvdjf7uYK
	 GLx22fJEQd6J4TKG5kOfOeQaGqKQ5yfAjx9vgOeBe/o2uEE5/vyMJQFy1lh8Fjn4iW
	 YyW897KzJKaU9xzPkoOJETMuITjXuvfNJwxXsuERr20AwP7cU2seJzqICWOQG1elNm
	 ViBbGZO1Zu5oAMo7/oB/4rXERKmMi+vhtzomARkDJM88ZFy46B8m10ClIaKA20mmVR
	 RJkdJ5fQ3xkvDlI+08IQfrT5fujXgO5NYwCTE6UwzZUrKtkVMw+K+OGu7XifVuqgbS
	 JDRwpBb+LD7iw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	stable@vger.kernel.org,
	robh@kernel.org,
	james.morse@arm.com
Subject: Re: [PATCH 0/2] arm64: fix+cleanup for ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
Date: Thu, 18 Jan 2024 12:02:26 +0000
Message-Id: <170557561037.3200718.6656632532505785315.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240116110221.420467-1-mark.rutland@arm.com>
References: <20240116110221.420467-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 16 Jan 2024 11:02:19 +0000, Mark Rutland wrote:
> While testing an unrelated patch on the arm64 for-next/core branch, I
> spotted an issue in the ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> workaround. The first patch fixes that issue, and the second patch
> cleans up the remaining logic.
> 
> The issue has existed since the workaround was introduced in commit:
> 
> [...]

Cheers, I picked these up, but you might need to shepherd them
through -stable, so please keep an eye out for any "failed to apply"
mails.

Talking of which, the original workaround didn't make it to any kernels
before 6.1:

[5.15] https://lore.kernel.org/r/2023100743-evasion-figment-fbcc@gregkh
[5.10] https://lore.kernel.org/r/2023100745-statute-component-dd0f@gregkh

Please can you or Rob have a crack at that?

[1/2] arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
      https://git.kernel.org/arm64/c/832dd634bd1b
[2/2] arm64: entry: simplify kernel_exit logic
      https://git.kernel.org/arm64/c/da59f1d051d5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

