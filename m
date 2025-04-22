Return-Path: <stable+bounces-135183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F6A975D3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67161B61C72
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3B1F09A1;
	Tue, 22 Apr 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLfBYPRe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4891096F
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351152; cv=none; b=UXdfSFdzkAtjnG2idxaAt6K+dIZ3h9Kp6rKQHz5o50rEuxHslB8YEt+l3J6MRMhvsOlBRF036xRc98U++Ctn+KGNtWzu4l90DIhgWqZ1kEdPZ7u7rxHSGOY0AgC1Qjx8UvOLLYss6QrYKnZ5f5OjFRVLa9uMvxj5IF7xicRUSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351152; c=relaxed/simple;
	bh=BRjled3ThqxAM58xajy5M0hZdX17oE8xplxmuS3uEYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmOEzULnrOjHW6C18iPC840GsNPKWaWmcKEwilvLT87+XPxHky/pgKnI9uLFDTilxp5G5mmwA5bwaraPxvQtTnVH3MpOeVQ8Vdgq/oRHo9reV/FGfr7+F+ZKDIKpI2CjJnv8zgiLr8PiysWS0s1cKUKIfiWadgydtIFCrxdHPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLfBYPRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED53AC4CEE9;
	Tue, 22 Apr 2025 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351151;
	bh=BRjled3ThqxAM58xajy5M0hZdX17oE8xplxmuS3uEYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLfBYPRe25KW2X1PIDTPSbooCh2nY0lhBRDNdFKxi6tWZswrJZuWMAdAaFXDV0Zcf
	 Oly61xxNj9N8Ath7tNzJVedYpmSiUgYEfiZiy4ESMlJQsT5Fqet99Eu+ngUG6tUcZr
	 6R1eV5yig9KmthuqyKW5L419ue55RiaM9UstumvfQMN+P+a5XC8E+bBj2nMW2NUP0f
	 KnGgh2y6Rti4WXAkepnHvCfzWZRMEp1DRUtRF4IjvIuqAbtCb/bdiea615Du/z4jR9
	 8wNoIMnMs8eUZ1cqn0TtAXGSOA9yxDmQ79SK1W9dTG9hfsZ+imcQ1ADYpoThKR9nhe
	 DbYAHeK7LWE9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4+] MIPS: dec: Declare which_prom() as static
Date: Tue, 22 Apr 2025 15:45:49 -0400
Message-Id: <20250422124015-3050770b6d66fd73@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <D1625EB772D42BA4+20250422090937.113109-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: 55fa5868519bc48a7344a4c070efa2f4468f2167

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  55fa5868519bc ! 1:  73f9cf323b552 MIPS: dec: Declare which_prom() as static
    @@ Metadata
      ## Commit message ##
         MIPS: dec: Declare which_prom() as static
     
    +    [ Upstream commit 55fa5868519bc48a7344a4c070efa2f4468f2167 ]
    +
         Declare which_prom() as static to suppress gcc compiler warning that
         'missing-prototypes'. This function is not intended to be called
         from other parts.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

