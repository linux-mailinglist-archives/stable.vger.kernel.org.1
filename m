Return-Path: <stable+bounces-125823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED83A6CCE1
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 22:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0413B1957
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE01E51EB;
	Sat, 22 Mar 2025 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caD1e1r8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9486338
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680263; cv=none; b=X6KScl4rf5Z5sSKx4glAwl/2bMlcxZSeucz/Rdk0QEbCkAa69n4N1z1rwfrprPEPIqE9Xys0sCMTluRWydpCx3LEdrT3Rpx8APWlr9OFTIkWD8TofETnXhuZbbdt8OEfksQnmFYTsIO+2kGVcHjqPhYy9y9oS9P1yIGLmGT2blw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680263; c=relaxed/simple;
	bh=ctezF5yt85Y5gK/+QG736upPA1sGC8kcSwojh1Tv1iM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaj1/+3+1G6S4j/JbRkwpbJ7D5dRaAjlWH9HHt7bWf1SSabc7D/SHnQ1xWJcvyAKetugMeuktH3LbRSCEJMujRmRs5txxb/0WLI8CjCFmFejrqZFQgfumuuxydc3du6LcPk4bvr2TjxyBAP3Bzh7bCJbXMIF9vYvKcY7F/2CIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caD1e1r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4940AC4CEDD;
	Sat, 22 Mar 2025 21:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680262;
	bh=ctezF5yt85Y5gK/+QG736upPA1sGC8kcSwojh1Tv1iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caD1e1r8uKZvczYwJY4AP8O/eyWyUAQu1ONlh4fNKNnYJ9Ht4EwWWV65jdy9eqMz9
	 4WbXPFudH1XB12JdXgZJA7mY/fnrtYqMN4HRucQua9mLlAaZNCXk/sF8JQt9/orsjp
	 zEf52N8G4TOgkwRW4j7vxrkTDKUfnMTZVCKLbaqjbLhwFejzhzz3H9nkRcJ78qCEzX
	 9i7VSedoGPxF1ftZzpmJc7t9WmCp8Rpi7F0DW2pbe7ARAbe84xv25HKAviPRZI7xNN
	 XpyT6SidWcR2A4If+eMO4wzuPVhMJrP1eM2KVtpLwB5EQIKJm1I8SiVOsDex+Rn0F6
	 XM9H3XZfGzfvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 6.6.y 3/3] mm/filemap: optimize filemap folio adding
Date: Sat, 22 Mar 2025 17:50:50 -0400
Message-Id: <20250322105039-278ef1371cd16a00@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241001210625.95825-4-ryncsn@gmail.com>
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

The upstream commit SHA1 provided is correct: 6758c1128ceb45d1a35298912b974eb4895b7dd9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kairui Song<ryncsn@gmail.com>
Commit author: Kairui Song<kasong@tencent.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 722e9e5acccf)

Note: The patch differs from the upstream commit:
---
1:  6758c1128ceb4 < -:  ------------- mm/filemap: optimize filemap folio adding
-:  ------------- > 1:  344a09659766c Linux 6.1.131
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

