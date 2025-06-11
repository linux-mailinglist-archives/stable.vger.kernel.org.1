Return-Path: <stable+bounces-152428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AADAD56BE
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358F2178C0C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C9289802;
	Wed, 11 Jun 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMtAjsvx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192242874EB
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647773; cv=none; b=VxNNizbk5jT1O3QR2HmmcXb0WykiLVWAUwkZADDuYYwPdmDwKPIDaS4p8+2TLRCU/pc5HXruRiSrBNPIn1ukf4eWRvFBCi+EeSL82d+JewG00vupACnJgYkAvCSyCCXCyejYaBcWkVSYnqqLHyvfmqc9K6W/3HaA6QHYIB+q5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647773; c=relaxed/simple;
	bh=Mciknro2lRnftB/P33rryRE4i+uAgf0nkqit1GNEjBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhPYjEIbRBCH31D75iyHzfFaUFRyhFlBAsIj0ssQ07aOkfhAY5G3j+b76xQ5jadhO5LaJmxfzXo/kdHOkCoDD/JLl72uYm7T+6Bl77V/B/U8GD6S/NmPJoYsGLCTHfh2FWNr2tdrl7LPy9uc5oKaAT0ZBPs9Bl+7pr6KXOPue2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMtAjsvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823C5C4CEEE;
	Wed, 11 Jun 2025 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647773;
	bh=Mciknro2lRnftB/P33rryRE4i+uAgf0nkqit1GNEjBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMtAjsvxQeKoMk3vgcHKzOUfM6pY0OwrP7qsc+BSNsHRxoHPvnJOfHxxLhK4NKnA6
	 DwFW1P1o/G4mUtwUCZHs8KsUI8UnSGUrh9N0cvKtt1v0hb5sTWqiKTXdSYAfue/8+5
	 Z6ChDBbLBm+fnN9nAhTUX60klOdq7dab2wcg/ajONqkwNyMfstzVENrjNUffoZROUb
	 wBR6BRVUwT8UdF5fCaHlqYmb7DjpyxwilGNyMNF9sIfyC4q9G8tzZyi61NPl3zRjSY
	 uiU9XtvnML484uupPaM3ncbhYnfe8ofn6JYwxxs1o/8c1QZkTxLkDgjGobGRKe2o1I
	 z6EmoK9LX0vLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/3] rtc: Make rtc_time64_to_tm() support dates before 1970
Date: Wed, 11 Jun 2025 09:16:11 -0400
Message-Id: <20250610175629-5fd6f979d691cf10@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:   <955e2c8f70e95f401530404a72d5bec1dc3dd2aa.1749539184.git.u.kleine-koenig@baylibre.com>
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

Status in newer kernel trees:
6.15.y | Present (different SHA1: aa9745977724)
6.14.y | Present (different SHA1: 1fd85fd8b7ba)
6.12.y | Present (different SHA1: a6a55fe660f8)
6.6.y | Present (different SHA1: 9af5a32330f8)
6.1.y | Present (different SHA1: 75cd3ea1caef)
5.15.y | Present (different SHA1: fc02a9de9a12)

Note: The patch differs from the upstream commit:
---
1:  7df4cfef8b351 ! 1:  c046d6497bd0a rtc: Make rtc_time64_to_tm() support dates before 1970
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
| stable/linux-5.15.y       |  Success    |  Success   |

