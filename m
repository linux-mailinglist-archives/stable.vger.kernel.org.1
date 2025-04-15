Return-Path: <stable+bounces-132794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA16A8AA47
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AF33BB3FC
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6E5257AD1;
	Tue, 15 Apr 2025 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZUHk+pA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE122253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753411; cv=none; b=FFOdSXP/9YvoUPGR6D7r1//GaHvRcW/VEINs8O8O8in7xdwRPCt06I8RFSeRljyckNXYs5wJgP4XufYJV4cr/rzyBs6nsdukQuGpPbxRpbe0D/OtwFCOnvyKTon7qjzvdtI1AqKZHlTVUBYLfWNKjfB4hsKoiJ9Uq2EqG+xRujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753411; c=relaxed/simple;
	bh=iv9R04GJ9xskVfUGepDqZAzTiNaUXyF+f8Jat1XnrYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUFAGknwa8Me62YRokl9GRd7Is5shmqph4LsqKzcOycZhDfJ4K5MKgRA9xSRnB6UFKkQpHa29sdZl3998ht7C39GPj4dLPA2OXdSzVvfhJAhhZI1zT8Hd2b/mA1gLgGUYTcxgqPApnihAeGWm+5elTX8LHw1EVvONLDpgXmBP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZUHk+pA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6F9C4CEE7;
	Tue, 15 Apr 2025 21:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753410;
	bh=iv9R04GJ9xskVfUGepDqZAzTiNaUXyF+f8Jat1XnrYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZUHk+pAPqROH0fqxnRTceTQTc8KeME/MqV3z6HWKZ/7J8Y7jeXOYTOqaSEh4kZ9h
	 RssTRPjbW9uETDML8oVmm6h9ah9Mw6wMeXJEDavzQS8dm4YcLDiG3IkSJ/ojx54r/0
	 1+nih2e2UUPPtG4ppoIqF5PVsrJA1kaFmLf1ObUTXb7hT+7X1yOG7z/96z8W1m/NQc
	 6V3HuGvLHdcjWgs0GWYKUbQeqmacTrw6c/XrxuAzOAnk/n4FE0n6rpovcrvNFF3oOx
	 uAGBIOOm9Rli6c02pwr49uCwWixpstWIGn69FCqCdjSf0M8HgfPSSy6XtsFl6w7P4n
	 drjyLyPj/dsWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bin.lan.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
Date: Tue, 15 Apr 2025 17:43:29 -0400
Message-Id: <20250415130726-b1e2caa49c56d5d6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415015659.312040-1-bin.lan.cn@windriver.com>
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
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 56971710cd54)

Found fixes commits:
b0e525d7a22e usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()

Note: The patch differs from the upstream commit:
---
1:  e56aac6e5a256 < -:  ------------- usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
-:  ------------- > 1:  0d00efada893e usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

