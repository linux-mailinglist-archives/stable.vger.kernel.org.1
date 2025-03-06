Return-Path: <stable+bounces-121309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B889CA5563E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD023A8D07
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD2E26D5B8;
	Thu,  6 Mar 2025 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndpV2Mho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC525A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288286; cv=none; b=UScGkLTjt4YBp7Zlqbt939jJrGbazFyjMaeQoxyx2bBFWbX2Z0196FDVPxRWEN6Nfsg+txdg314JPgfN9kCruhkLBqgKXG0WcMpOvyQ70Jr7JE9EQdShUmHWZ0Xdcv8pi5VKiJPSI5GfVQaLzNBfz7wtWWZeX2/JQJXmg5Y/eBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288286; c=relaxed/simple;
	bh=NYfCd8NcrxfrBsXmOf1Xhwjxu/zYokPAzSWpQTZ40RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSBTtJj5kt6noU2L0rTW45OMJO0+QUfk1KChOm1ChwLHZ9NkXPNRWDHn8LxeENCLUlF0tYz/dQx9H/NDsDGcwX3Y29g0H7LHYsYkBagzsad4cjQZXHP9b+7p5BXqqhkbczesrZouEjlTWDVM7Mg+vTGy7Qp/NYm11qD/nT9wVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndpV2Mho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB658C4CEE0;
	Thu,  6 Mar 2025 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288286;
	bh=NYfCd8NcrxfrBsXmOf1Xhwjxu/zYokPAzSWpQTZ40RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndpV2MhoUGBNSksqb697KZ0s3Pnaw3E6v9DwbmbBwY6kutYzg7m12UfI+q0zBTbAd
	 emZRQaA7PbcL2heq5+yjehKzYmgaA10S4Ol2kLkVIIxlK6GcjMqPCpS+67+aF+uSl0
	 tlOGC2MMwYpN1kj7WkQwHpwUHH/aydITf4UlAdUicwkXq8KvxJcAmRU1m5JoOH61L4
	 2xhqjHqo8Fr2L0v3Tfd8AIwlxWu7aIljjzEjIFl/cHDe7g0wth1JTcNqWeGwvw/rlz
	 /wtqmTYOXT0adjJ3ATKEvSlVLvQatBq2apS3jkH5IXBlbll3kPNrhbJ2tF72EvCl3L
	 TquJuBVqI4xgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4 2/3] overflow: Correct check_shl_overflow() comment
Date: Thu,  6 Mar 2025 14:11:24 -0500
Message-Id: <20250306124236-bbf79fa520f05031@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250306010756.719024-3-florian.fainelli@broadcom.com>
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

The upstream commit SHA1 provided is correct: 4578be130a6470d85ff05b13b75a00e6224eeeeb

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Keith Busch<kbusch@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  4578be130a647 ! 1:  e1ba20ab4a83c overflow: Correct check_shl_overflow() comment
    @@ Metadata
      ## Commit message ##
         overflow: Correct check_shl_overflow() comment
     
    +    commit 4578be130a6470d85ff05b13b75a00e6224eeeeb upstream
    +
         A 'false' return means the value was safely set, so the comment should
         say 'true' for when it is not considered safe.
     
    @@ Commit message
         Signed-off-by: Kees Cook <keescook@chromium.org>
         Fixes: 0c66847793d1 ("overflow.h: Add arithmetic shift helper")
         Link: https://lore.kernel.org/r/20210401160629.1941787-1-kbusch@kernel.org
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## include/linux/overflow.h ##
     @@ include/linux/overflow.h: static inline bool __must_check __must_check_overflow(bool overflow)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

