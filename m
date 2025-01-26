Return-Path: <stable+bounces-110814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E2A1CD56
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD9A1620DE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D251547E3;
	Sun, 26 Jan 2025 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohX/Hm2R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7F335BA
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737912181; cv=none; b=qoVRh3YgKS2R0QMrIB6ZEDhMOJx5uLNWJhRK6J39as3wQ1eB8hEEm9upxWiqUlXWjCKftWo1rd9mE4jooTI/5MJ2/h+moui55X4cIAr+xBZqdagIdH9aEbx6rh7l2IA7w2qxnioEKO6kGsNKdkXvhH/T4TNqvcWnkMSWHPxHw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737912181; c=relaxed/simple;
	bh=33dEENP7pPzGhSi5SVXSJ6GW1gjJD/tBxsZEpzOronA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVBuQi8xySch4VVdZRW2czKhW9pXCI7wgBr8tbPh7YkJegbbjleCVRav97btpm8MIvJg4MFS8KHobnhAPgz0X9SSWwhjLBpjmyhie82jAT0XY8kxrbF4xyAXNHhN+Wy1yHdvMmwdWwmWRHLr+cSlTErI2og4Tngupg+gAmt16XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohX/Hm2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E951AC4CED3;
	Sun, 26 Jan 2025 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737912181;
	bh=33dEENP7pPzGhSi5SVXSJ6GW1gjJD/tBxsZEpzOronA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohX/Hm2RjlvkpnzCjX38R5mTfZGB8KEheKvYvqV2EuNlp1+ihuu+oqwnXPy9g6Yyy
	 zZM0BYUgQaBUuxg7boNp0N5w4qepdWNZrAArONk0bZUgEXpCb5vah6IuDwsUjipSr7
	 TcsiRgUSlfXlBPw0fClgymcS0wHrx1JQRysLgj/n85JiCdur0hnxkwZ7iCU3VzF8d4
	 uxiuqthmrnxtFy8tPk8CbzmWZwi+0eXqVAI2Ezddv5/oO6J+tpqJzi1RV31uXwfQp8
	 /ggak/rY7aRsd7jUF7uTJ0iQ350L1P2PBD+k8V/Au/vM+KH+lZjwTjQFLMMd2C7wGe
	 EfvuOEj11IO0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] static_call: Replace pointless WARN_ON() in static_call_module_notify()
Date: Sun, 26 Jan 2025 12:22:59 -0500
Message-Id: <20250126120343-baf447c6d779a6c4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250126100925.1573102-1-sdl@nppct.ru>
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

The upstream commit SHA1 provided is correct: fe513c2ef0a172a58f158e2e70465c4317f0a9a2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexey Nepomnyashih<sdl@nppct.ru>
Commit author: Thomas Gleixner<tglx@linutronix.de>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e67534bd31d7)
6.1.y | Present (different SHA1: ea2cdf4da093)
5.15.y | Present (different SHA1: bc9356513d56)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fe513c2ef0a17 ! 1:  1f8efe18f8487 static_call: Replace pointless WARN_ON() in static_call_module_notify()
    @@ Metadata
      ## Commit message ##
         static_call: Replace pointless WARN_ON() in static_call_module_notify()
     
    +    commit fe513c2ef0a172a58f158e2e70465c4317f0a9a2 upstream.
    +
         static_call_module_notify() triggers a WARN_ON(), when memory allocation
         fails in __static_call_add_module().
     
    @@ Commit message
         Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Link: https://lkml.kernel.org/r/8734mf7pmb.ffs@tglx
    +    Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
     
    - ## kernel/static_call_inline.c ##
    -@@ kernel/static_call_inline.c: static int static_call_module_notify(struct notifier_block *nb,
    + ## kernel/static_call.c ##
    +@@ kernel/static_call.c: static int static_call_module_notify(struct notifier_block *nb,
      	case MODULE_STATE_COMING:
      		ret = static_call_add_module(mod);
      		if (ret) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

