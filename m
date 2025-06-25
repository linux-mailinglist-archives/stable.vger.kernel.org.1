Return-Path: <stable+bounces-158586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F6AE85B8
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392B91884F82
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3883074B2;
	Wed, 25 Jun 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdUfhm0e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6325EFB5
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860536; cv=none; b=t6D6D9THZzaxXccSLQ1uG8Dm1t5eybHCfZ3PqRcCNDlPmzHNUpgIxqmDsZyLe6R5GbnVHVbOKfSp9SFvU6uT6bcmvXDed6GU7OyUnwFgn4OOf43ZiLcAE/pp3iO8kje84kedulzu7GWlV3B1U6jWhMCWRP5XohuoXSJW34MtoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860536; c=relaxed/simple;
	bh=ztcW5Gm/ZIAEdPj9GFxHBu7tnxAzGRKgEwgG1Vowlsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixYWG0MhlA3Qy5Bo6WLEmerEdjhMjJz0Ar4iQexPwhLumH5yV6jKWeAObNHVI5M6IKl2pL0ykmsDHzfHnM0mAHmx5oDM4lSX8fzqFLAqexWvhrCgNIW3lhpwmcn+otvWJ3A1XN5vVZ7Ura8Y/EaeYbzIY1r8ayJbWUsqwR57lX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdUfhm0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648E2C4CEEA;
	Wed, 25 Jun 2025 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860536;
	bh=ztcW5Gm/ZIAEdPj9GFxHBu7tnxAzGRKgEwgG1Vowlsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdUfhm0exdlFaDp8E/hx/DQNT+9xU+scdLSQi+0a6zr2gQWf3KvOl2q2FzCQBcWmN
	 UFCsGy1upc8YD2Sa0FEMSOuUMBC/Nzfyyx+bDC+Fr9W9s7PSJ2GTOSxtWuj4/eFxVB
	 5dfxI/yc4IJgepRvrcE951lCoW7qpvVUWJhAcGnZZ6BOanAWlTBuEHMkyk0K3yypvC
	 opKrLVvLUNYKz+ftnCmbfL+VthkZUACw76ZLf8CZ3mQEja+gbLyH48fgJg5pmI/p5I
	 o8uwQL9sdDeqfXrn5xcMYgLLu3uj9fdu/J+6jxcBZsp5jv6yWl0VXHtjB/eAYV6mgC
	 fEe9BXmyXpyjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Wed, 25 Jun 2025 10:08:55 -0400
Message-Id: <20250624112500-e0aac82a8297bc63@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623100914.2680078-1-schnelle@linux.ibm.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: c4abe6234246c75cdc43326415d9cff88b7cf06c

WARNING: Author mismatch between patch and found commit:
Backport author: Niklas Schnelle<schnelle@linux.ibm.com>
Commit author: Heiko Carstens<hca@linux.ibm.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: 006155681799)

Note: The patch differs from the upstream commit:
---
1:  c4abe6234246c < -:  ------------- s390/pci: Fix __pcilg_mio_inuser() inline assembly
-:  ------------- > 1:  2b1b641950221 s390/pci: Fix __pcilg_mio_inuser() inline assembly
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

