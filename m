Return-Path: <stable+bounces-152430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA552AD56DF
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A801D7AC8DF
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77724502D;
	Wed, 11 Jun 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWnAYL7g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA061E485
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648274; cv=none; b=g4PacZ6owsajGLWkZkz6dGJ5oQiPYXslIdyjKOo2DzE3Bu7lEukIxhIOVhOzSLXyG4IXxDvmPposs0XMpZDfQBtw/WYvth93Ht621sKKtb8lq2JjhOITz7NxV3cjrM9jP72yb6zkHALOqR2fXsTAggq8gjLsU7Sd8HBb2x49XGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648274; c=relaxed/simple;
	bh=KjgsEj0tpYxwdWbAev/p0Ky4qIhAATsmGH4ZK8w8WYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BD++iExQiD/KA5kEj2DHpXtcIRuH+e9uBiluYFeS+KxISKYw9Z0QNQ0brAsxk2DWh+iQeoUvtaNlaZsiagVS9zLes9WsySm0WS22psIOWFjKTJSskSXf00Ap6ufJtjrfn+Q1+EzijCJsHRpG9ZrpQMndGDC8iDLBRrjSEMKgxr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWnAYL7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8031FC4CEEE;
	Wed, 11 Jun 2025 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648274;
	bh=KjgsEj0tpYxwdWbAev/p0Ky4qIhAATsmGH4ZK8w8WYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWnAYL7gxI76bpJec/XVOkCRIqUJWY8SnRjQjh2C/3sZugvGXo885by/cbpRH+uy2
	 GeW97sK28meQyUogSudUgG880q2RoyTdyZLQa+qp8GrTsi/2j+ah2HRv/dS0bmzIh6
	 TI/nikA7rqoWL33GaMAvW2HSKpRmIs6PzDyqHgdZ63/3m9z8KybLez49W709xgWdX9
	 4TgH5avds7+SNxuizIcCZNwp046oInuQiooh8fDdPSIxo2K/KIKJUjzqYIzA+ZZykA
	 4RT0P06amMUi+08mubkmOTMGH+JN3pssSYqLa/ZqQ2qsH4SD/lwrkPfj39grZx61XH
	 3VvJiGnLOrYMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 3/3] rtc: Fix offset calculation for .start_secs < 0
Date: Wed, 11 Jun 2025 09:24:32 -0400
Message-Id: <20250610180120-50d991767c9b46a7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:   <1f965f4886f65e45423f863930ccc7139944272d.1749539184.git.u.kleine-koenig@baylibre.com>
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

The upstream commit SHA1 provided is correct: fe9f5f96cfe8b82d0f24cbfa93718925560f4f8d

WARNING: Author mismatch between patch and upstream commit:
Backport author: <u.kleine-koenig@baylibre.com>
Commit author: Alexandre Mergnat<amergnat@baylibre.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: cea549ca705b)
6.14.y | Present (different SHA1: 57082e0300d5)
6.12.y | Present (different SHA1: 6b482b16f32e)
6.6.y | Present (different SHA1: 3d8efdcbc6ce)
6.1.y | Present (different SHA1: b2677da58ed4)
5.15.y | Present (different SHA1: 0931dc7be5dd)

Note: The patch differs from the upstream commit:
---
1:  fe9f5f96cfe8b ! 1:  8aa260951391e rtc: Fix offset calculation for .start_secs < 0
    @@ Metadata
      ## Commit message ##
         rtc: Fix offset calculation for .start_secs < 0
     
    +    commit fe9f5f96cfe8b82d0f24cbfa93718925560f4f8d upstream.
    +
         The comparison
     
                 rtc->start_secs > rtc->range_max
    @@ Commit message
         Reviewed-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
         Link: https://lore.kernel.org/r/20250428-enable-rtc-v4-2-2b2f7e3f9349@baylibre.com
         Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
    +    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
     
      ## drivers/rtc/class.c ##
     @@ drivers/rtc/class.c: static void rtc_device_get_offset(struct rtc_device *rtc)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

