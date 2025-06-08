Return-Path: <stable+bounces-151880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78021AD120B
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99547A1DA8
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED186207E1D;
	Sun,  8 Jun 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IprKRO4Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCF1C6FFA
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749386939; cv=none; b=TM34+CxBLrxVS1IcAFISypmJYNh8EohHj/QtaTWVhGcbQt9m7JKR3FKzxho7PTg4J2wVL6eHKvpAVCECPXkJl2BKjChXyqkTZLuSjSRuvfR73p2uHGmfDgHqI7ZFzznBv8RnBVo64wGbAm+wAwMAX7Z00LPtt0q7b/KZQdkFZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749386939; c=relaxed/simple;
	bh=p10FlYwzA0fbGx7myvnoxwSGBKWROFOCLzfmmPb0c7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/XPiJ9IuyLVyh+dCya1oA7eQwdUHiPwoEetDc0hQeMxDRbvqE6ibbkUDPeooA91nuIohzTH69JhWI9FC2NDul4Xay18aTGlU8DDawJ5yI9xl38cLOHss8xK6LBDTyJLK6PCbsbOEWD9PIS8Hs+0+PYWKD8FDHCh7cfASZDopds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IprKRO4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C44C4CEEE;
	Sun,  8 Jun 2025 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749386939;
	bh=p10FlYwzA0fbGx7myvnoxwSGBKWROFOCLzfmmPb0c7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IprKRO4QiYEkJ2LnMjwHTX1xTL/Q0XI3R6taSlI+4YTnSmvYDWZPKh9jPnjumepz1
	 JTFDZm+xt0j0svHK67L+B9++WiiapnC8SJUu2CqkhNvdYOKiA2T58yvemeu7E6ODFt
	 WDmC8nYYZDu5Cc6ipjX+rTz4Ht+kZyNUegKg2OjfsEI7brAB4e/KqPy7J1y1br41mJ
	 AXpdXhezR7fksuSjxbPbfgp9jyh0Ohf8zbHz8H4RYTkxdqo3BC+7zebIyVi1ISTr85
	 xNcoPqAhipWRCeEZ7JpvjWtgqZ69GCIjcJnGoZD5bT2jHn81eu2ZzzhpYcgmXk/9YA
	 isKksqOmKD8Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y 1/2] rtc: Make rtc_time64_to_tm() support dates before 1970
Date: Sun,  8 Jun 2025 08:48:57 -0400
Message-Id: <20250606231001-b0b2551e0797a4d7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:   <b36409ef16fd9662b442a0fc908cb44f52535d63.1749223334.git.u.kleine-koenig@baylibre.com>
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

The upstream commit SHA1 provided is correct: 7df4cfef8b351fec3156160bedfc7d6d29de4cce

WARNING: Author mismatch between patch and upstream commit:
Backport author: <u.kleine-koenig@baylibre.com>
Commit author: Alexandre Mergnat<amergnat@baylibre.com>

Note: The patch differs from the upstream commit:
---
1:  7df4cfef8b351 ! 1:  6da0666c8846e rtc: Make rtc_time64_to_tm() support dates before 1970
    @@ Metadata
      ## Commit message ##
         rtc: Make rtc_time64_to_tm() support dates before 1970
     
    +    commit 7df4cfef8b351fec3156160bedfc7d6d29de4cce upstream.
    +
         Conversion of dates before 1970 is still relevant today because these
         dates are reused on some hardwares to store dates bigger than the
         maximal date that is representable in the device's native format.
    @@ Commit message
         Reviewed-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
         Link: https://lore.kernel.org/r/20250428-enable-rtc-v4-1-2b2f7e3f9349@baylibre.com
         Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
    +    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
     
      ## drivers/rtc/lib.c ##
     @@ drivers/rtc/lib.c: EXPORT_SYMBOL(rtc_year_days);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |

