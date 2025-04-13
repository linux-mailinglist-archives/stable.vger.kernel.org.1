Return-Path: <stable+bounces-132340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48459A872A4
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBCC16D1C9
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E51D7E37;
	Sun, 13 Apr 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJsSTIJ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857814A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562798; cv=none; b=S70qTQBcPJBcj9eQZX5qrTh8W8AWaVYJ8pTUK0Fqk/Am3esl21PVI57niQATPq1gtMkyyAD/DaqsK3kSOkrH0ItYuPYbjwowyjp58vSTR201TpLDHGOVL5jfl3B1wqnL4dUHx5XndGkaYAxwht0NH60PQq37RYykl6TPU/WWLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562798; c=relaxed/simple;
	bh=s2LCbkMUKReWqPIm7pcCWTG5wzpWVYI7HKy/HxSQ98g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcTW1VHU6+YBuzfZnHsgYkenK2baPonbrNu1jWcGL6vb9G53jtXoWh0+6Z+fKT1U9k6hw0SvRv/uvaCejgqz5R/p0gfn72mopL0lCleajSFPgl+NThIfKdB5ob6PWCRKYFb+StNHX8e6fBAdLZ0JFPsTjsvg4zyB7EY8FMmTpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJsSTIJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE69C4CEDD;
	Sun, 13 Apr 2025 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562798;
	bh=s2LCbkMUKReWqPIm7pcCWTG5wzpWVYI7HKy/HxSQ98g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJsSTIJ13/Z+bKYl2UChmR5jCaez8+KDyuPj8h8ADvinLtm6Mr0U9N5l34/4zkfdQ
	 Sm25V6vOLx+eEOmsV3BlkToLgVpqKchtsH7Rg+Kr518W0J3sz9RwKyq42v44SU0gZh
	 hKilGctlQuk0F5n03NTjsGCnxNnGpE3MXG7BL5m4SosNOw7y8HLoX8zuCxRMnS8QXp
	 SpIuY1dXXXdB6KHkOR+5cMtuYQMW5gI7H2kZQ0mu8c08LmSeu+oN78kK0zvh0c2oTN
	 JVPU3lz9UH+yWfPDbqwfawapfG75+4e2Wn5UoeyrfiD1q8nVccP4ukfG7frFog3SO9
	 eS5hN4QibMkjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
Date: Sun, 13 Apr 2025 12:46:35 -0400
Message-Id: <20250412100538-96e5cf1aa82cc9a2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411064213.3647619-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: 0974d03eb479384466d828d65637814bee6b26d7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Nathan Lynch<nathanl@linux.ibm.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  0974d03eb4793 ! 1:  510e3f8eef3ac powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
    @@ Metadata
      ## Commit message ##
         powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
     
    +    [ Upstream commit 0974d03eb479384466d828d65637814bee6b26d7 ]
    +
         Smatch warns:
     
           arch/powerpc/kernel/rtas.c:1932 __do_sys_rtas() warn: potential
    @@ Commit message
         Reviewed-by: Breno Leitao <leitao@debian.org>
         Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
         Link: https://msgid.link/20240530-sys_rtas-nargs-nret-v1-1-129acddd4d89@linux.ibm.com
    +    [Minor context change fixed]
    +    Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## arch/powerpc/kernel/rtas.c ##
     @@
    + #include <linux/kernel.h>
      #include <linux/lockdep.h>
      #include <linux/memblock.h>
    - #include <linux/mutex.h>
     +#include <linux/nospec.h>
      #include <linux/of.h>
      #include <linux/of_fdt.h>
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

