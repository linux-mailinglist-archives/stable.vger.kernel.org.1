Return-Path: <stable+bounces-145956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFCCAC0204
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02DE9E2083
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972573597A;
	Thu, 22 May 2025 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbDriS/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589261758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879447; cv=none; b=d9pwUplNRuRp7qTkRCjfyM4DMvlKkzqIIgj8P0ILwKsIKfFM+pVrdnoobr61/c7jgI1+r7b/O3ANqThwJuc6tgJOgcrfP4ImF+wl1HpYnxeHmANvDJxufOJmv6ebnwpwCvreiHnsvaT5e5MTfLk7qEfSvNd6oJTX4ik/l4L3RIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879447; c=relaxed/simple;
	bh=TGK1V/JoWqw0fI5+C1LOLZf25QrzQelgwwVSrJTPIeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Clp6z6b1D4sjZBzduNFqw8aG5/fQzSIf1ggBfP9oTA/ecx3AQJYwzWqkYGJvJgC3ZO1s85PlKWtlGcwfdrrpdKlh8wJuaOU8jCQ9496v+320XqDDqKwFNxyxvlxfqaFvtRa8l/e4Le0rQA5qCLpw9AyVb9CIbGIpiFba8ZCPboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbDriS/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB36C4CEE4;
	Thu, 22 May 2025 02:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879446;
	bh=TGK1V/JoWqw0fI5+C1LOLZf25QrzQelgwwVSrJTPIeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbDriS/r/EdKMTyk6u1kFLk8SNE9C2shwBXqq6MpVua3Y2IZwdZhXS5fDEOsXC0e4
	 gphbJl52M9qWiwre0XHiNIicZlkH3eRTsum5yor63QP7iqdz3yK2VFpFNX5D2AArnN
	 H4qgV1UISgrrZkUaTb4oDtowUD360v43T63SMv5jY0NqaY2u/wNqM2QhB1H9mNi+9T
	 zsCY7sUgjEyFXON9pfOUinLkXX6VvJcfKUKy2gWBVPsbVguq+X48bGdGpXjqcBo8EN
	 U11158HmDYim8a0m4q9CXTdUj4QQrpRQ0juL0cAk3OKkqRv2fSJvygXvxUWcerGUCD
	 9nsHSbU2Uj7Eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 14/26] af_unix: Fix up unix_edge.successor for embryo socket.
Date: Wed, 21 May 2025 22:04:02 -0400
Message-Id: <20250521174812-0c8e66938368ee40@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-15-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: dcf70df2048d27c5d186f013f101a4aefd63aa41

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  dcf70df2048d2 ! 1:  c52f7d3bb13b2 af_unix: Fix up unix_edge.successor for embryo socket.
    @@ Metadata
      ## Commit message ##
         af_unix: Fix up unix_edge.successor for embryo socket.
     
    +    [ Upstream commit dcf70df2048d27c5d186f013f101a4aefd63aa41 ]
    +
         To garbage collect inflight AF_UNIX sockets, we must define the
         cyclic reference appropriately.  This is a bit tricky if the loop
         consists of embryo sockets.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-9-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit dcf70df2048d27c5d186f013f101a4aefd63aa41)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: void unix_inflight(struct user_struct *user, struct file *fp);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

