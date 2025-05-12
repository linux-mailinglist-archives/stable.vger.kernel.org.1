Return-Path: <stable+bounces-143877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C99AB427C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FCE19E75AB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82B297B9F;
	Mon, 12 May 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHlWBOyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26C297B94
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073158; cv=none; b=K4ZTsMFwL2qCfZr/WJvPb1IJIVmOR4uKHoV3KlD5usJb49BiCdmBzAzrkxFRNhnWc+/qZMUE3mhZHMOyu+4NSBW2nsmc/qT/AvIkV8m0w8g8Ow/95brEsY3qje8sTk3QplHUgQskfk0q1CvqAsulCG/LxZkWzO3z74AaQQxXuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073158; c=relaxed/simple;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAlbyuA4HIj3RIVOIJcqQ4pjHhpwEXl5LB40ageNgDL70FTnkPDOA1ZgGannK25BvKw6cIHPQLK1sFOMJhtjSVWBmTzc/VC4EbNZQsNH/fajIM9MPvYFydIxQoery2crJ52gAFILV0ovZCTyLWf5npGl++2X05lei5H6B6FQN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHlWBOyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE68C4CEF2;
	Mon, 12 May 2025 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073158;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHlWBOyT7g0bobRvtnMbYaDSziXehAkn34uP0TFejFhDidEl35iFMUu/3hf1axDAH
	 xNCdlMLmbzFYl0zYtFgYVI98lRzl9Qx/CCCUsZTsz+48/0zGyt6IOeS1WtE9hE250j
	 fz+lnBjJMMxNhJVpLqqf03ZaagUwAeJoM0uAgXa9+9MZiYhbuYq/cZzuUql5RQUm2X
	 iVdwm6suG7HW7uATqHJ/PJb66JDkP1Q4BCJCKN/z8pBOw7tTZBmq3AvJUmhYXodO+n
	 ym5LUmRB6u7+iQXMajT5jm+2TqeRy5rvFZVduij2wsRHZqGD+fjjOxUUbODt0ffOtE
	 4ESJWVe/qaLIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chunkeey@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12] Revert "um: work around sched_yield not yielding in time-travel mode"
Date: Mon, 12 May 2025 14:05:53 -0400
Message-Id: <20250511212826-8ba19997afa05cb0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509095040.33355-1-chunkeey@gmail.com>
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

Summary of potential issues:
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

