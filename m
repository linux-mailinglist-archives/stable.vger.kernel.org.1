Return-Path: <stable+bounces-161429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9393CAFE7D9
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2AB6E1690
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34421291C38;
	Wed,  9 Jul 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQfy+8hC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619A2586CA
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060735; cv=none; b=tmZSYKAXt78c8iy02FkBYXPePJ/uw7l1PHhsexafTLMHkZdlSXT/qPEuxtWgR4GMWBuiQ5mFW2/qobJ3cDJ+jywHqQZyh5Ynuo5/Thgg3Z4Qy5aMrpvmC+/PEKuwcAKOx55q4imcclh64yKRBDG4oOKhW16w+LHAc03m5Anl5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060735; c=relaxed/simple;
	bh=1QKqUSXv7GhghBV404XiybQ2NV/v2TWGUV++VQc+rmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q43RXFE2dWzB5qFT7A3RLIZaRVScyS2ay2L9VDL29ZVx49+fxs1NZ65VLls4i/zsojM+PiMk/ClLCvEoFY3rCaocCmQT4y1OULRGJffGyDjA8lUjXS9Izden5ridgLXim1PDwRZjdUW1qScH9P+XdeQDoWqqOWR/CXUq5mbzg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQfy+8hC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3257C4CEEF;
	Wed,  9 Jul 2025 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752060734;
	bh=1QKqUSXv7GhghBV404XiybQ2NV/v2TWGUV++VQc+rmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQfy+8hCBdtq+m1d7WfSQhPMhMDoLXu/+xGDWDgqU6U6m7uERYaAxBNhwYmmoyIQt
	 XzpMWzIVozBmVuNzyB5MCITP14wvHfgla+RyfLeM83vmD7EErUaGlOCiz0qFfM4Sbd
	 2ZCoB6Ros4rt8OdqXK8e++1aEwhVfborUFlhrW8lZPAIBkv8fDGbeCkuJHWREaGXvo
	 64pSLf145oD7dxVqr4PUfid3Vby/outZMreoHMRcQseqNMRWomtPn4LR0I58pMxdYW
	 4wGlraCw35dTOaGprRkh6iCLirXgWbYx9vqLRdQEwd1C1m/WT0UBGfZbdsUm5fL59b
	 jZEGfCKuQiJEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [BACKPORT][PATCH 6.12.y 1/2] firmware: arm_ffa: Move memory allocation outside the mutex locking
Date: Wed,  9 Jul 2025 07:32:10 -0400
Message-Id: <20250708161445-68646f4dfd5ac197@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250708194223.937108-1-sudeep.holla@arm.com>
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

The upstream commit SHA1 provided is correct: 27e850c88df0e25474a8caeb2903e2e90b62c1dc

Status in newer kernel trees:
6.15.y | Present (different SHA1: 59bc31bc48c5)

Note: The patch differs from the upstream commit:
---
1:  27e850c88df0e < -:  ------------- firmware: arm_ffa: Move memory allocation outside the mutex locking
-:  ------------- > 1:  df64e51d4ab83 Linux 6.12.36
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

