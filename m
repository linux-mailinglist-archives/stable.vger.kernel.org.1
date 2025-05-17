Return-Path: <stable+bounces-144672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7EFABAA30
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F22616667A
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7311F4717;
	Sat, 17 May 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2McQK9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3C35979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487288; cv=none; b=ZVadyTOExcL707VEKvr9BYaDXuYAso1tJn2H4lsGwFKoK4EXdxQmo6PIRCL7H8Fldo1GUsO3URrPwvZUrFVeW/xa5pS6DZUoAgZP2ice4pOsWHNSyk43N+xJGehyDDiCsoiS0QSohElArnEa1yMNtlCJXowTbkds0RSN2S7NrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487288; c=relaxed/simple;
	bh=2Wez9c6dqXCKIsJKxTz7zAakNAR8pbU/1fDQgWJK+PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn9IazefJNCMyYjqdvdxyYBKvLZD0JlcwU7jA5NdJfJjHvghr6tYS8mFvJvSeYC+Ul/F6hSh0Xi0ji5LJ6O6y5xEwz8VJ+X2AoOWFloTjl8gYh0pIQnPynDLm2ccP4JwE28AjS3kif0jRSucacqqtIsIFQDDjleVHt7qVhEiUjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2McQK9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02789C4CEED;
	Sat, 17 May 2025 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487287;
	bh=2Wez9c6dqXCKIsJKxTz7zAakNAR8pbU/1fDQgWJK+PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2McQK9fb9Go1WK5gPKdbewhE/o6KOPy5piGkz4SjcGvQ35EvZpzxXSPXuD59B2FP
	 Kp1lbsNZDBuluwu3UPy1CSnbt/GdgMJU1bc76ATxj+vQ1c85QIRQzxd7KnbBHmfJBk
	 51h/b/K2419ZvKgP1bmQz7Hnn6nWgnOiYXltZIyAA39ct5RsjR9JM7DNRqmv1JR6A9
	 rsWeZrOJ6FjomZQ2/WT6bntGXqGExblI9QbIpL+73hg/Y2fuk3QsLowfB9xbof4goa
	 BzaNVHbuhCfovktCfstNhdjMzmfStimbYZDq7+wOJXcJP687Bpa0sQnPqY/mQAkMqG
	 n8sAJt/mEwLEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2] iio: light: opt3001: fix deadlock due to concurrent flag access
Date: Sat, 17 May 2025 09:08:05 -0400
Message-Id: <20250516211535-9c2dbd3945cf02a6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516184154.5622-1-luca.ceresoli@bootlin.com>
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

The upstream commit SHA1 provided is correct: f063a28002e3350088b4577c5640882bf4ea17ea

Status in newer kernel trees:
6.14.y | Present (different SHA1: 3950887ff9a9)

Note: The patch differs from the upstream commit:
---
1:  f063a28002e33 ! 1:  99a94f9f0a69a iio: light: opt3001: fix deadlock due to concurrent flag access
    @@ Metadata
      ## Commit message ##
         iio: light: opt3001: fix deadlock due to concurrent flag access
     
    +    [ Upstream commit f063a28002e3350088b4577c5640882bf4ea17ea ]
    +
         The threaded IRQ function in this driver is reading the flag twice: once to
         lock a mutex and once to unlock it. Even though the code setting the flag
         is designed to prevent it, there are subtle cases where the flag could be
    @@ Commit message
         Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
         Link: https://patch.msgid.link/20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit f063a28002e3350088b4577c5640882bf4ea17ea)
    +    [Fixed conflict while applying on 6.12]
    +    Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
     
      ## drivers/iio/light/opt3001.c ##
     @@ drivers/iio/light/opt3001.c: static irqreturn_t opt3001_irq(int irq, void *_iio)
    + 	struct opt3001 *opt = iio_priv(iio);
      	int ret;
      	bool wake_result_ready_queue = false;
    - 	enum iio_chan_type chan_type = opt->chip_info->chan_type;
     +	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
      
     -	if (!opt->ok_to_ignore_lock)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

