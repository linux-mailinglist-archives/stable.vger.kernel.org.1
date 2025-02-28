Return-Path: <stable+bounces-119963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36FBA49ECF
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065D83A4135
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A00A27427B;
	Fri, 28 Feb 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCJ998Jf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CE274274;
	Fri, 28 Feb 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760201; cv=none; b=jHCZ2w1HZyrO/ZgxL6FHPOorQUHRXLYl76rdZAHplTHy7R18sRQnoNQFQxImjPJ1yXoqMdUK0lnqjpFHBiAzqnoqZy6UM0B8lu7OOqgYQ4JKepHqIyFnLiVjtcGcXtyGkOhYGq7um/2R2qNt1NpRqG2r6rmgaqebQMRBq0dpcno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760201; c=relaxed/simple;
	bh=G5rKdfQ0+3VplmsFRvQVIXVao+ovPVqnNlr0+RqAmuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rq1Chz7u9VSRSzI1IOFV4gwZZgBnh7npXzKB++rejDfSFfPXtVZ7zAnrHzhorIVyo+Gx+WKDBXxKYPdA+E4qxNXyLfckhkZjOgD7RYAbOrMe37ZoW8JkuY1o20QA4HTkfU32WGobnMFkD5hOxgx9IIGS8SodNHR131Ah0uRe3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCJ998Jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F226C4CED6;
	Fri, 28 Feb 2025 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760201;
	bh=G5rKdfQ0+3VplmsFRvQVIXVao+ovPVqnNlr0+RqAmuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCJ998JfZb7nOvtnr7xv+jSyfeNDdLg+2Y9XsaZgDWNQHfZIWgX4n9dfrwPmF7/8k
	 eMp4VJWA2DYAwpWOsr7B1hibOdp4e9QpKW7ZsX+QGMjFiE1pgjrMwxGvD+e+/mG5y6
	 +lckeVFK2N8T1dV/M/6GQAa/fPVFSjhlT8E0RbZlntjrB//OyyO1wTZnGjcx3GVGZY
	 G+SU06q99F7mjQKhFYjxdzRe8WzSu/wMzRcNzN6p9eT67zN2a8c+9ZG86B0hqLMTPA
	 mzEtY1/tMiuqMI29/4zJD2iRQHESV1Chyoz+LvME4xNL/YJQwVWGyanXzpCWw9acmJ
	 rZR8IN2X1hO6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE29D380CFF1;
	Fri, 28 Feb 2025 16:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix the missing write pointer correction
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174076023354.2198557.8859219710807097797.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 16:30:33 +0000
References: <20250227212401.152977-1-jaegeuk@kernel.org>
In-Reply-To: <20250227212401.152977-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 27 Feb 2025 21:24:01 +0000 you wrote:
> If checkpoint was disabled, we missed to fix the write pointers.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 1015035609e4 ("f2fs: fix changing cursegs if recovery fails on zoned device")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix the missing write pointer correction
    https://git.kernel.org/jaegeuk/f2fs/c/201e07aec617

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



