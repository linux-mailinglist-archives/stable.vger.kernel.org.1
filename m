Return-Path: <stable+bounces-152517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1EAD659C
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764FD3AE45E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8FB1E833C;
	Thu, 12 Jun 2025 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEFYnvsq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2381E7C12
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694970; cv=none; b=qegOqo/Uebj5SJi7PoWy6Q6oVui8wqPLAs3BXtP7Tiw5WF8tUqAyRk/WR9xO9lkYEy6xgUV4zE3s60miOsBz8fD926sbmxjih4tn5kpgYlc3kwlgVHggSsvTGcKwoMjN4yU+DVWSFbrXmhC1/j++9K7+ftcJy/VrQqUHrwLoE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694970; c=relaxed/simple;
	bh=PJrEFeJE8qIEo52SGx3JlqNwAw/+ksHeTYKbV5U5FxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4G0XfoYbB4VGm7rKLsx7gzs3JDIIIAL3801H0CqASCojnBTbnVN8FTnPcPJFc5wSfxBRIp7kyEv/E3jbno0blECfDdqgdaZECtbXgLT1dAXdQ/4mCznkia/bPHr9quz19W0RQE2Zj/x/VDFF28769mZy7MbJwcDahrQ1NxNqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEFYnvsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA8EC4CEE3;
	Thu, 12 Jun 2025 02:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694970;
	bh=PJrEFeJE8qIEo52SGx3JlqNwAw/+ksHeTYKbV5U5FxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEFYnvsqHe+9vC11h0rymXA1CeGTLNr4TD4MshrQcwICMv3YtnmhsJKg5nIxk/hSu
	 271iGHJqHH3PN4RQJADLNhRHbvNd6F/mXmI43r5rlMRSWCgyojcVvZtbnPtp08GD9w
	 jAffjtQGOanYg/ZNcrF48z7470SQR3+Ey5k9d+GMH4bk9X4B30InaHtu/U0NnVfank
	 J27aCsAhvEViXhWkzZi7Qr03KXil4zL/EROqgrjjtibtI0oTNP2AQyYjN6NyWUatjB
	 WF2SznXeVhL5pTGVQjaZFKWWG/TBnVWRlnmpHZnWpaFZUIoMV0PSo41ZFnynQk/qCR
	 3+4dbVmeSlA0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Larry Bassel <larry.bassel@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
Date: Wed, 11 Jun 2025 22:22:48 -0400
Message-Id: <20250611105004-386fa8a7cd974e6d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250610235504.3021366-1-larry.bassel@oracle.com>
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

The upstream commit SHA1 provided is correct: a648fdeb7c0e17177a2280344d015dba3fbe3314

WARNING: Author mismatch between patch and upstream commit:
Backport author: Larry Bassel<larry.bassel@oracle.com>
Commit author: Chuck Lever<chuck.lever@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 37f2d2cd8ead)
5.10.y | Present (different SHA1: a231ae6bb50e)

Note: The patch differs from the upstream commit:
---
1:  a648fdeb7c0e1 < -:  ------------- NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
-:  ------------- > 1:  4ef4f5c0a5841 NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

