Return-Path: <stable+bounces-145975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7E9AC021A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1B34A7671
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD135953;
	Thu, 22 May 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFftgtqq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9701758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879522; cv=none; b=GW9fdsbUHn3ZqKsRa9LgficDqPBIUwnIjtaOh4AVBiFHfyy+MsijkheSq70usoPjxQdQnD+rXzmyM6jIb3tWEYDmP1ZrSuUGNu7VvLkPme6ajoi86jR0kcVJDb34aYDON4TNq4AAOZ4CmBodOSDf0Pit+rIlC7bixQcQpxBVLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879522; c=relaxed/simple;
	bh=pFp/tDx3sXWRJsdEcR5Pj9/fnxRLCBOTDOwWd9k73xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX7ub0WDRIdEWID4TO+rdhLA2T3ZRSFr3BWxuyIZ71X75lrgrOeIxdHlakvRfu6k3920OhahAcGYm9RMO7qMQwbXjFYCZu+bDaEu0ut9bcF6t2wD88wAvrb61SBkpJaqrXq7ww3IEY4oQuoBeQg6xkIdimhkrllgMHWmMikkLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFftgtqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAD0C4CEE4;
	Thu, 22 May 2025 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879522;
	bh=pFp/tDx3sXWRJsdEcR5Pj9/fnxRLCBOTDOwWd9k73xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFftgtqqC6Q5SuG+nZWOPzyVnTKWgxnaWa6Mz9ZY6fFz78Xp2LnKq8QwbS2wTX07E
	 gJP40qAStrXDe2JxNYOBLi7msB4CKTe6yxB5Fzf8kund5mbWkXHplFEP24qA+hNZ9/
	 EHvVthuZ90qfwH1u0MFeq5Wzqe0nOvU6LM9ZrzuKDruawIjixAVT4NPctFHqtxiZxs
	 anIF97dHgtWkXMB5IZuXlu1a872lm4bvHH6HEPL111hPlhOVncox6tlg3hAEcjAiMk
	 tGizD8uKL8lRB+xjmVwZtmrtWR3J5ihrPTSqh2FML3QIqHIbQW6KV+eMjQSv1FBRYl
	 AM8zj9PEB3pmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 22/27] af_unix: Remove lock dance in unix_peek_fds().
Date: Wed, 21 May 2025 22:05:19 -0400
Message-Id: <20250521212445-0934ac0cabb2142a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-23-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 118f457da9ed58a79e24b73c2ef0aa1987241f0e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  118f457da9ed5 ! 1:  6abd6af9bc94d af_unix: Remove lock dance in unix_peek_fds().
    @@ Metadata
      ## Commit message ##
         af_unix: Remove lock dance in unix_peek_fds().
     
    +    [ Upstream commit 118f457da9ed58a79e24b73c2ef0aa1987241f0e ]
    +
         In the previous GC implementation, the shape of the inflight socket
         graph was not expected to change while GC was in progress.
     
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240401173125.92184-3-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 118f457da9ed58a79e24b73c2ef0aa1987241f0e)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: static inline struct unix_sock *unix_get_socket(struct file *filp)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

