Return-Path: <stable+bounces-145980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A00AC0220
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45691B65540
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AAD3FBA7;
	Thu, 22 May 2025 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIoIb2is"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099218E3F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879544; cv=none; b=YcoWvWq6AVlKZbWLbbw86eY6qaugEbjnxXdHttLSELU4e8aHx3LtB7eBmwPAy+078DVGEPVMrUhRtIr9Sd0e0dgEgJkj9GnXdo3kpETiEkrwboY7/L9OnMH22SBwmQFxipUOHATE7UcWI+RboSDwlXtssBENGpApCPOkM/iGwWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879544; c=relaxed/simple;
	bh=RM+ES4tMH8GK3RkL0DV/E8x9FRFIL/99FqSxNpyfoAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppLEQZENbdypt4Eewiz43KNUi1XH0phpKNtjz+SiiDkhWvQnV4zWWdvQH3LNXtSQvvOOEC6QBLEL6Rk61PqZbSyUDr0kqfPMapaysCO7rEGQsqploIIhVbh7MyrQOW4h62/lH2OfCe+A5rZUxEc3g1uwumImf0h7v+AwthKanI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIoIb2is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF74C4CEE4;
	Thu, 22 May 2025 02:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879544;
	bh=RM+ES4tMH8GK3RkL0DV/E8x9FRFIL/99FqSxNpyfoAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIoIb2isMVVkGP7yJX5gApUVEba2oHufNQ6F30hzDtRK9RqK+PzMVJo4CZXrYrjIB
	 jNhMzNqHsivNjWNttvjDu2CTJgNBhcjX2qAx4vQGqQxw/8aUstJqZgOsHjjs2o6ldL
	 j5cJkLRk3vGE43EPRJu6z+ToPF4QBRBJ59Mxc7+kuvvRPSREL3lyFOYgBMmgfrsbo6
	 9QFqvG1euRoY+Av8ghLbE6rLnwzqcASWH9I7pxboFf5jV0BM2X6FQunjCiwp6HaZOF
	 cQ7YwTGQXPTfT4WIeOWfBaCOKYuqnB9aBoyrsihgQlZ5V2cLWIGQv/mGZ1BL5ecNAD
	 NT9OIvoTQpAkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 24/26] af_unix: Add dead flag to struct scm_fp_list.
Date: Wed, 21 May 2025 22:05:40 -0400
Message-Id: <20250521184359-41505c6537f10b12@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-25-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 7172dc93d621d5dc302d007e95ddd1311ec64283

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  7172dc93d621d ! 1:  473dfe4f8f6e6 af_unix: Add dead flag to struct scm_fp_list.
    @@ Metadata
      ## Commit message ##
         af_unix: Add dead flag to struct scm_fp_list.
     
    +    [ Upstream commit 7172dc93d621d5dc302d007e95ddd1311ec64283 ]
    +
         Commit 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges()
         during GC.") fixed use-after-free by avoid accessing edge->successor while
         GC is in progress.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240508171150.50601-1-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 7172dc93d621d5dc302d007e95ddd1311ec64283)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/scm.h ##
     @@ include/net/scm.h: struct scm_fp_list {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

