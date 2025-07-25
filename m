Return-Path: <stable+bounces-164788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E6B1276A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368DE3A36E3
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4025F998;
	Fri, 25 Jul 2025 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDHNdShC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BF26159E
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485971; cv=none; b=Pl4+/SCsE7ESaMVFeXKBc+Kq+v9ccwRH1vSBx4wBln27PA7DiGx1D5mFzq9KwxaFY1a8WstldJivFb1G3nKKu+PNrczvaOBkUZJn3OEYGiQ6caF53z6ano73+x6Jwtaexi2cY+JsZqTRgvj6hSVm/9VjX7A2HT85KslC2vBFREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485971; c=relaxed/simple;
	bh=qUQUH88FX9senmKlI+ax82KAEbQsfbXXpFs15NOitKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfzCT1q4ZyZ8mQt7Qv/o0QCIIL07Q3C5Hq6MGD4K9AiIfSNmtgRv8cB1rL3wArKovXL/VYIumfEeUTCcW7+oQx+rqLSQZeGKFLjDjNUR3GDw6f7Z1MiJxqZtF5WE4LAu1jBJ2LjSoJfVmHW8z16p7hMtt/y+0bAr0baKZPn6S7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDHNdShC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CB6C4CEE7;
	Fri, 25 Jul 2025 23:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485971;
	bh=qUQUH88FX9senmKlI+ax82KAEbQsfbXXpFs15NOitKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDHNdShCQKIuFPmEWX0seacgPfnnyoaNtvh+3BTGFnAt+gb9Z9IjixwqwSS+jVp/i
	 ZcyQuuIMUdrG2Hop+iuWWnDffzlWvor+krbz5qi3N4WabykUUx2XCNOG0GbttdC9H4
	 TwDsb4r/KJFJqPUR5MUEmjS89nmWhkFgnggAao5RT734JJ9xcoiB0KE5TitVCxP9xF
	 ZvWjj5neFUcFYfC19RT51yVXW1SoBGIB35d2/TxGpmp9j47fscNYA2fuh2tAyl8LdG
	 PLn28jbAQu/QZvGtz7hJ+maAOqobk5r7+nYHi6s253WFrHtpUQejPMdR1ii3PkfCzU
	 FT6LGhySghImQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: das6402: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 19:26:09 -0400
Message-Id: <1753467515-921ce755@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-6-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 70f2b28b5243df557f51c054c20058ae207baaac

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  70f2b28b5243 ! 1:  471728920391 comedi: das6402: Fix bit shift out of bounds
    @@ Metadata
      ## Commit message ##
         comedi: das6402: Fix bit shift out of bounds
     
    +    [ Upstream commit 70f2b28b5243df557f51c054c20058ae207baaac ]
    +
         When checking for a supported IRQ number, the following test is used:
     
                 /* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707135737.77448-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/das6402.c ##
    -@@ drivers/comedi/drivers/das6402.c: static int das6402_attach(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers/das6402.c ##
    +@@ drivers/staging/comedi/drivers/das6402.c: static int das6402_attach(struct comedi_device *dev,
      	das6402_reset(dev);
      
      	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

