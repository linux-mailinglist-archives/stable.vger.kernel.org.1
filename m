Return-Path: <stable+bounces-142885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E90AB0018
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB7A1C075D4
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E318281346;
	Thu,  8 May 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwhIwIx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10C22422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721077; cv=none; b=IyjFcANqygdrMrRYeXyWwq1WUX2JzGGBym1bccNamWtBWgjtaEYNwbgbH0KRP/QnuMSb+wHB85Qk6+B4N4TJLon3+hq1R2QbCYU1qnkYUMotJ/1GQ7gnb99hgEYDnldsEy+NLYIOB2o931/f1GdbKrdErHTRyOMgfAX1CdOYMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721077; c=relaxed/simple;
	bh=r6b1pThhHAMDxd2booSv/ARSMP5QWx/E0PoMeYY3V+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgRgTSH/oPZwTc9ALwS5gS3ESoJg4tDiGFaRrPawuHoU2dQ03kHdeOMyxdNexnKIEO+JW0tK+7xzREXt2RtORZsBi9wCbPdL6cDgQpNIL8/efeUyuvk++9rwmSqp4fXUB+q9BH8+uQoxREJDM5ra3VylYrCfbP3WxbiQoa0Toxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwhIwIx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876E7C4CEE7;
	Thu,  8 May 2025 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721077;
	bh=r6b1pThhHAMDxd2booSv/ARSMP5QWx/E0PoMeYY3V+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwhIwIx4J25lf8V0aX1Wxjy7j5PBtJT6WHsrhQR3TDCPHUqTTRs0u264KDWHcqUxW
	 b3sc6u5CnnV3mPkTjSqrSYRt8XgoNjJm2gZapguOnkxwrFw8B3aIggJTadB5IIDTEP
	 9+wWReELNn+Mzr8SPwbRGf13z7Uqz4B90UoerHWVquMsJOswKcUDJa0pT9vPaLriSN
	 Fu3684V4QHtl3wJttYaSzcb4pKUtlysJbge+/vOIvdvbV7pGAqloCJiihw/68S6XM5
	 OeZ3N0NxnE4WPnPVB6KnAe41Nbkvx5PMGVrrZOINKj/va3Eys4uiL4gR1N7ozqp0jN
	 LMcLPn1byPs4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jared Holzman <jholzman@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y v2 7/7] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
Date: Thu,  8 May 2025 12:17:52 -0400
Message-Id: <20250507085227-891f6a1dc77e536e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507094702.73459-8-jholzman@nvidia.com>
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

The upstream commit SHA1 provided is correct: f40139fde5278d81af3227444fd6e76a76b9506d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jared Holzman<jholzman@nvidia.com>
Commit author: Ming Lei<ming.lei@redhat.com>

Note: The patch differs from the upstream commit:
---
1:  f40139fde5278 ! 1:  7ae6d5a88218e ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
    @@ Metadata
      ## Commit message ##
         ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
     
    +    [ Upstream commit f40139fde5278d81af3227444fd6e76a76b9506d ]
    +
         ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
         we may have scheduled task work via io_uring_cmd_complete_in_task() for
         dispatching request, then kernel crash can be triggered.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

