Return-Path: <stable+bounces-124253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B616A5EF35
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C88817DA65
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A3263C8A;
	Thu, 13 Mar 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1TMHi6k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D81263881
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857104; cv=none; b=XB0Sa0tZ10/uLX1+CH2j7q/ME1vvdLpTJSYoAh1Or9w2TdSMgDSYOfHqpSYnot8X1qNftX/kYiCTkkRGjRM9RQ3eSjqmIqHsKkaIE2w00tPzItuBWuhbq1MxNLLLAxHrT1KLPwGosc1dk49ByPxXPx4mF8O6aosVTNyEAMxAk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857104; c=relaxed/simple;
	bh=KyjgnYFv4pBReOY6q8fNugGDatYeKnrSH9Mq36AskQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIz101+AseXVubLsw3QTOp5iMPaA+ZBJhJsao1whx2Sh6f2wtdPiHjqGHttn+7mHE9TbJ3FMF5WjKgb/crYld/WNwwv5tzPMHbqqrbMdiGa3zd5nrB+pOISt+S4TqFwnwyPl+3EFq166dvQk02LGuDZk4ho6rgnpvAoz2jVjYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1TMHi6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8698EC4CEE3;
	Thu, 13 Mar 2025 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857104;
	bh=KyjgnYFv4pBReOY6q8fNugGDatYeKnrSH9Mq36AskQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1TMHi6kfyZUTIe8ecIPB32P87Q102D3+LoZXoWY++0pxvlqpn2dHylq6h7ZuLMtC
	 XfbGo/onfAIZx1kJl8b5rycWN3NvaLf1AZKS/lBUZS3rIwYmdmrEGujUOBP8dK09Jm
	 NsogHnh4NffSzQNyn56Y/8Bu7FqAtZZbhDPZOhCDhrbm4HqGBALwY3XeTvraUhnn//
	 Ob52U7CoqUDuJa4OAkfU+63XMg3IyCpWu2x2mLC1xykYRQ+eIWcQ78I76UL7jDADer
	 yYgKvmzGf6A+QfZt9KUo27RMhNGltBPN2Pz+FWOLMscK7/2uDRCZ1ECwX+CbI5//po
	 Oj1zSASrDviUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Thu, 13 Mar 2025 05:11:42 -0400
Message-Id: <20250312223347-2b8f0fc9a402ac70@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310171930.446781-1-miguelgarciaroman8@gmail.com>
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

The upstream commit SHA1 provided is correct: 91a4b1ee78cb100b19b70f077c247f211110348f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <miguelgarciaroman8@gmail.com>
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  91a4b1ee78cb1 < -:  ------------- fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
-:  ------------- > 1:  e9b0b1ba590a6 fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

