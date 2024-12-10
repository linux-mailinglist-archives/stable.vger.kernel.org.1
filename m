Return-Path: <stable+bounces-100480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B309EBA18
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3021283C3E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC83214237;
	Tue, 10 Dec 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSybGxZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C023ED63
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858709; cv=none; b=TZ7Oz8SZjNu22YmRMtqVxI2UILU+rzx4XCrW+3CGod5mj0vRps9CnT55a/mb9wXh2Yef/UXtCq7jdgClrHS2GObKnFHiXS3guLepwKiZx7fPy5SPlwHXAMnquns4HpxnKsWHvsTm5E+OamuQQbbffIIkOYyGQj3EqgOjfvJuo0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858709; c=relaxed/simple;
	bh=Q7lpyFd4wrdUYkvSfIHd1r4So8K90Bi8X402AAEq2es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg5vHu4FOHBHunDebX46tlZ/km4rdgo7mqaEPX8rrCrERaBH+ucvNei3jL7Vv9Ad7NmI3240nGtA/GGNV1TdA5LPw6UmY4/toMskranMbEmiqmQxjTM9WCXFy4mgC0c8qwnVDLpRp/8/LAmFiel4UXg9M26y3hjh5Ng/qaJ8dX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSybGxZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD52C4CED6;
	Tue, 10 Dec 2024 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858708;
	bh=Q7lpyFd4wrdUYkvSfIHd1r4So8K90Bi8X402AAEq2es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSybGxZS3febIvaoQTlZuyAZaP5plssQjfeWEVEFI6L2Q359tFvd8bux/tKVhD4Zl
	 yDcNJWsrZA3ZbN478SXQfC6xsMYOeyby8FYPANWHlvltNoHhbPjOY34Knwk1q7cJQS
	 kVbWj9th0gXA6c36pGuLcLhLUUn3Dg20RtZE4WSupysA+8N3H7xE4WpZ5/sYBs3nga
	 zFh6usNzyNc1ACmSSQT9zA6qmWyve5Zo+Ahjf2EmPIeGpXxuSlOphy2BxJbpnJEQKI
	 N1x461x4ts6nSdma1OGZ2tNMu02gxrJq8wwwR1lIPDz6vC7GdhLFT+1BfTYgdtAWR4
	 +zEGXW7OzUaUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] driver core: bus: Fix double free in driver API bus_register()
Date: Tue, 10 Dec 2024 14:25:06 -0500
Message-ID: <20241210093117-6f265186669d2e2c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210094942.408718-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: bfa54a793ba77ef696755b66f3ac4ed00c7d1248

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Zijun Hu <quic_zijuhu@quicinc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d885c464c250)
6.1.y | Present (different SHA1: cb6ae5642a3b)

Note: The patch differs from the upstream commit:
---
1:  bfa54a793ba77 < -:  ------------- driver core: bus: Fix double free in driver API bus_register()
-:  ------------- > 1:  554a31ffcf40a driver core: bus: Fix double free in driver API bus_register()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

