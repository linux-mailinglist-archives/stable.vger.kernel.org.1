Return-Path: <stable+bounces-95399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0079D8A13
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA31BB3ABC2
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AF1ADFEA;
	Mon, 25 Nov 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiDrwpuG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473D1B2196
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548043; cv=none; b=rIeUe0MRyDVpiDFMSRlAYEL88a5rJkMT9grieC6vnnmTEORh9lN/c4oQ8qOFcMMLzEEDGB3q7cv4T9CLjZloTZElwVFAgDEmK4roIe1EJzsIo0DLPxtARALGF4lnVExuhDWKJeY8CJ6C/7c/yAp5ffslWdllWX72/GA0M6F9h48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548043; c=relaxed/simple;
	bh=VdNziEUBBhDUeEs/HVaTamzSMzr6n2NvEX5EvsQpN1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cq994kUikVPcbyUkfe9jXcbkepQiH/FDl7xx2+85rdonksOdImM1xQ4usOuhU+qOy4kcsK7bbUhnjwht5cvWy9kJUA0xosBRRmFBa7yrrDKvZxniNdPiJElPhiyGI5WWSZPmLQoLXGsoMDnir8DZJsJP6lq0fNc7OpoLHwBNryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiDrwpuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3B1C4CECF;
	Mon, 25 Nov 2024 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548043;
	bh=VdNziEUBBhDUeEs/HVaTamzSMzr6n2NvEX5EvsQpN1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FiDrwpuGeXufWbrBe7VPGYNvxzKvDAIYBdmtYrHm+CjbnXXDbh+jnLu0TxTWelE+4
	 PMAttrQevX/E64GzrYloBz9t8Vh/uYKK597iQP0lEFQhrnWuQiClRzq5zaiPWPgFz0
	 c6lWFeN2CUqjgRTyo/vsw0KHfySxckhxbLK+xvBqMXyLQ5OHBZWknyd7+PoCw9vXDo
	 OapEblHGTY3Y+kJdAbDxcsVILML38mMCI428sV/P2Zy1xwcGQQvlsB0dWGPFVpsbqP
	 /AOvNl1F2yzvkV/tFIh+FBVcuFWnRrZcBjBKvaMiJzVWrVggpoYgf5mWkgMQmu9NQq
	 R9LI4Ckp0VHPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/3] net: fec: refactor PPS channel configuration
Date: Mon, 25 Nov 2024 10:20:41 -0500
Message-ID: <20241125092501-5a5e64a593bdcd26@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125091639.2729916-3-csokas.bence@prolan.hu>
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

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 09:20:12.188256676 -0500
+++ /tmp/tmp.UYjfIU1OfM	2024-11-25 09:20:12.180896704 -0500
@@ -5,12 +5,15 @@
 Reviewed-by: Frank Li <Frank.Li@nxp.com>
 Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
 Signed-off-by: Paolo Abeni <pabeni@redhat.com>
+
+(cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
+Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
 ---
  drivers/net/ethernet/freescale/fec_ptp.c | 9 ++++-----
  1 file changed, 4 insertions(+), 5 deletions(-)
 
 diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
-index a4eb6edb850ad..37e1c895f1b86 100644
+index a4eb6edb850a..37e1c895f1b8 100644
 --- a/drivers/net/ethernet/freescale/fec_ptp.c
 +++ b/drivers/net/ethernet/freescale/fec_ptp.c
 @@ -84,8 +84,7 @@
@@ -46,3 +49,7 @@
  		period.tv_sec = rq->perout.period.sec;
  		period.tv_nsec = rq->perout.period.nsec;
  		period_ns = timespec64_to_ns(&period);
+-- 
+2.34.1
+
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

