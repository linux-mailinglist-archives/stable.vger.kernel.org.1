Return-Path: <stable+bounces-121317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D958FA55646
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB641896D2A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B89263F5F;
	Thu,  6 Mar 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImzKh6h3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8125A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288304; cv=none; b=VM6oA3kz1cP/LucgnZRFlyvMvoWcbY7mliQe5CWrZxZhX25oGd7KwgJYw+OfrVjBEfwtYgixjnOXK0xeYBQWf8aQZPLM6G/y0km0/thSmeTWO6cmFvy1RiXBe0B9ULieNa3f3rQWiZ3HYKPD7Rqm0iuUElLH0tFnxXhKi38ehAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288304; c=relaxed/simple;
	bh=vlufHQzdoTDlNBpyVX767ytZWJWEWyp4hvBYzXBV8v8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PA2MOmSKK+ep9ZNag9zMa7kf9Lyyh+CtU4VEv9WMxGwqzjzfz54Ryw3WrGRiq8VEOuxTBWsYFjcfDe9CVDWqlDN3XgzrJ3pDsNDrFcWVt0ystFfBL6fWVE46z4EluSIcIVOJbwrsuJVcYUc7rl+kGIbgk+0N6+dY7O9RR8y0VrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImzKh6h3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B57C4CEE0;
	Thu,  6 Mar 2025 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288302;
	bh=vlufHQzdoTDlNBpyVX767ytZWJWEWyp4hvBYzXBV8v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImzKh6h3E8rwCFPgwREno4DGIBpQDDfm0QRBsxRJTut6MdCxRUPwSYVWta+Ixv0Xz
	 Z9TAIXvGUOSG2Hc3js8ruxj7WpAUUHvW+CNDvmULrrb1n3EljFykUM74NFhB5z9AcV
	 uN1w849os5bXEJqFebTUBQrUdkcjvqRWXcKOm2yRtju8q3UXl4JYDlg7iHU/BcfYZt
	 m0QuEJrQ/sn3i5GM3iM0HwUTe6UAb9iFW3Z9fz454sjT3Rotc7sCbRgSQgujS+Sne9
	 8ckVgCm18WnBH4D/ti35IxchLMH59RFYYqYvZeNH/ovTVCW4B+tTvgJP2+PdE1cpJq
	 TjcJ4tOwsCqog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4 1/3] overflow: Add __must_check attribute to check_*() helpers
Date: Thu,  6 Mar 2025 14:11:40 -0500
Message-Id: <20250306123347-50976169a12191e2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250306010756.719024-2-florian.fainelli@broadcom.com>
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

The upstream commit SHA1 provided is correct: 9b80e4c4ddaca3501177ed41e49d0928ba2122a8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  9b80e4c4ddaca ! 1:  131091196f2cf overflow: Add __must_check attribute to check_*() helpers
    @@ Metadata
      ## Commit message ##
         overflow: Add __must_check attribute to check_*() helpers
     
    +    commit 9b80e4c4ddaca3501177ed41e49d0928ba2122a8 upstream
    +
         Since the destination variable of the check_*_overflow() helpers will
         contain a wrapped value on failure, it would be best to make sure callers
         really did check the return result of the helper. Adjust the macros to use
    @@ Commit message
         Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
         Link: https://lore.kernel.org/lkml/202008151007.EF679DF@keescook/
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## include/linux/overflow.h ##
     @@
    @@ include/linux/overflow.h
     +}))
      
      /**
    -  * array_size() - Calculate size of 2-dimensional array.
    +  * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

