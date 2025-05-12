Return-Path: <stable+bounces-143819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B3AB41D7
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280BF8C186B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFC29B22D;
	Mon, 12 May 2025 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0IRPNGL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178829B221
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073091; cv=none; b=lXaWyUbKqvs760yvkqpbYCzjMovVU3bIO3ERqDPXqjTgCCsiJPoZKZULgkHRPtYgmUDF4dPTHxrTVFDOS2rzBsc+/+0F5XuUQ7tX0i3PWwcOh8ujalCHOKT0gROOGo1UMI8QOdF3drUt7RoBTE11gViS/PXp3yanByiVA85QAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073091; c=relaxed/simple;
	bh=PFtfz2uVovy9OMx9R3qSWCVrha0WMW2MNHsN33BIRxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZZVJuDoRkChg6UScfD5Jh314PAT7cvm0k7W6xmL4jxrcqQS6tjHEsEPWePnpjtzLn3wm4BXVR+BdmE9GY04olHjmBUO4HG+amrWFvJZZ4uGmW/5NA27HcDhtTNXIsjRs8H/0Gytaoqbq/Tw5I4xpIU1Q4xEc6VRbw0cjbNTHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0IRPNGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5E6C4CEEF;
	Mon, 12 May 2025 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073090;
	bh=PFtfz2uVovy9OMx9R3qSWCVrha0WMW2MNHsN33BIRxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0IRPNGLztDsrHfuehSZK6FrONouzRxXsKIsI1fqDruDxsOeBGRAnrUQNo3Uk7/By
	 k6IjEE+5bmdB/8mX+H5c0g/j9pt39h6DgpHzz/82dqF7vcsUXfcHIX1SQxRfVDwFWL
	 yK0SyRnVcM3CwZXsb5mMXAqOX1FPUHKOo7RgF48uIRXiVNSkDqfJyPFE1RcGt/hmsb
	 gYiXyL+8ufM0QEqARhc0fpbtm2P58UX6h0KzZ1najTLBwkb0wsq4SXSY3oM+C+uD8J
	 zRtTjvYGA9fpH42PAeAcc/ZUQB5V7usJjnAgNTLGscwIq2CepA/mDy1FpaWF2nNnLb
	 nP5OrrJaKUjJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bin.lan.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
Date: Mon, 12 May 2025 14:04:46 -0400
Message-Id: <20250511224546-df2666fc91e24edc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509061740.441812-1-bin.lan.cn@windriver.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: e56aac6e5a25630645607b6856d4b2a17b2311a5

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Dan Carpenter<dan.carpenter@linaro.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 56971710cd54)
6.6.y | Present (different SHA1: 0e66fd8e5a2e)

Found fixes commits:
b0e525d7a22e usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()

Note: The patch differs from the upstream commit:
---
1:  e56aac6e5a256 < -:  ------------- usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
-:  ------------- > 1:  8a00c49b69f2c usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

