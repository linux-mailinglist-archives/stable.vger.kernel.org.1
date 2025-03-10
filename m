Return-Path: <stable+bounces-121644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03C6A58A46
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB1F16899A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8217190072;
	Mon, 10 Mar 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmUgouw4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0F156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572865; cv=none; b=tRnBpw+PEfyRPPNnYSRxpZ/8Bt6XmN6d6K5V8aZC2TicISQwkGJrTQDpWx4/Uu6Skk+Sq/2f7jfHx3k0ZcBA0f/pqLJUGWSCT18QtfsKRr4Vh0pYkP4XSqAAEoSktHTlw0y5BDjzR0Y4PeiPTGj628QdpqEdtq787a0WobmR2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572865; c=relaxed/simple;
	bh=QDzQGZr8sQQywV24JPj8E4QYLDit/2Rp7/CdsMHI128=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+FSr7o5UD1drr8RnnWHf1MtyWcGg5H82XQ3pZnt1iYh26dYMo9q4aDz00wNdmfN5htGkJaLtbwvBFylJd8RFnwqJdYCQIIr18ujNE1oY9nFeMuJ/YqCcm0wBs8y5j34gm9d8z3fbIjYy7eu+oErJU/Lf2qq1T1t57VrkiYWWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmUgouw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F233CC4CEE3;
	Mon, 10 Mar 2025 02:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572865;
	bh=QDzQGZr8sQQywV24JPj8E4QYLDit/2Rp7/CdsMHI128=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmUgouw4lr8CZefeGVEpC805dve8t4IXd3MOdUChHQ6vF1wNR5VcdbOudW1fuqtYE
	 NNTaZ4G9Q0ev6doZ5K6YiJNzbvjP5k1Wyld+z4IbTEbZ17l9mXLJT7NKoHGYfg75p2
	 rdeaOXqT5yRuViBkuYiPDVIUH3VzhiBAkLMQxV2C1JjqwIkOWndrjKCA5yAWwiWNrE
	 msH3QU+Dx1U1XR0B/UtcjQDwobz7txncI/ehUBG5rP/pRf2M3jvWO6R/iXOGKdSrEj
	 1yj5sl5AVjwkIqO+1HIkX+dsMjAKeHJvpS8Umh0gjfQR0PgxszrSAGdH5W8Vo0EcTh
	 66zkyeI52QYWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable v5.4 v2 2/3] overflow: Correct check_shl_overflow() comment
Date: Sun,  9 Mar 2025 22:14:23 -0400
Message-Id: <20250309204603-67158eaaa5fc160b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307130953.3427986-3-florian.fainelli@broadcom.com>
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
1:  4578be130a647 ! 1:  a99708e5c1aad overflow: Correct check_shl_overflow() comment
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

