Return-Path: <stable+bounces-164962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2716B13CE1
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBCA7A1921
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAA26CE2E;
	Mon, 28 Jul 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IspsWSMA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCA26D4F9
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712426; cv=none; b=FP8NhfUOHMKarYzGPBIfVhjier0l4va1pB+Cf7S1o1m/Eq+HqlQkzo6qub8T6B7RyGK0xxaOC6tGDsO4Fc238XybKbgOw66UDBHSBmFnzSMsfXyK26+ZsXw3vbvYDuvMoUwdnHEfo0v0YPmVM9wmTNAcE8U35slKhfttJEwYQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712426; c=relaxed/simple;
	bh=pSw99ixVbKhE3MnhPREk/I4Eg9bPdmjaMugkyfQTn7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnxGxgqTqd3d9UD3ncozMJTq4beG0ehz8eKKX6fvrHViGHNLgUwRHmFJFuvjkzG14Q9cEV6//Ue3ch509jP5g7vPJVrxI5ZxNG32/K3XgQwTHIA7b58s2BtoUbQCXSMMshv2wzDkhWaQdSDj/jUeaDImEy0VyDNzVMNeCxtWUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IspsWSMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9454AC4CEE7;
	Mon, 28 Jul 2025 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753712426;
	bh=pSw99ixVbKhE3MnhPREk/I4Eg9bPdmjaMugkyfQTn7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IspsWSMAYxdAXGvO0AuiD8pRRGSyq508We4MxGBVC2DVpz233/z/0JmI/3Fn/MKuT
	 gpgClZXxawXun08CxtjN6FLfDXQAU4fZNzzfh6RfWLqJ0d5jCFa73edre+r55mosSP
	 G3dAHJcq70xHhyMD66FK31TQ9E5qXetRKIMD5rejElvH+9TbHHFHP1M0yMHZOBxAls
	 go2D5x9scassYzfQTJ95RoB6j2LTpFia1oV3Nk1gF6W/rLX5BsdJdagEs9unbGqdl2
	 /YSkO4RyasrG2kh1kqmKoLSCOb1fAYWoedT7Av403cBf6LiC7Ps4CXXVRAw9F9Hcfr
	 WnhutNM8GBhvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shivani.agarwal@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10] ptp: Fix possible memory leak in ptp_clock_register()
Date: Mon, 28 Jul 2025 10:20:23 -0400
Message-Id: <1753710855-90354577@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728081121.95098-1-shivani.agarwal@broadcom.com>
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

The upstream commit SHA1 provided is correct: 4225fea1cb28370086e17e82c0f69bec2779dca0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shivani Agarwal <shivani.agarwal@broadcom.com>
Commit author: Yang Yingliang <yangyingliang@huawei.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Found fixes commits:
11195bf5a355 ptp: fix code indentation issues

Note: The patch differs from the upstream commit:
---
1:  4225fea1cb28 ! 1:  ed4903766eee ptp: Fix possible memory leak in ptp_clock_register()
    @@ Metadata
      ## Commit message ##
         ptp: Fix possible memory leak in ptp_clock_register()
     
    +    [ Upstream commit 4225fea1cb28370086e17e82c0f69bec2779dca0 ]
    +
         I got memory leak as follows when doing fault injection test:
     
         unreferenced object 0xffff88800906c618 (size 8):
    @@ Commit message
         Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
         Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [Shivani: Modified to apply on 5.10.y, Removed
    +    kfree(ptp->vclock_index) in the ptach, since vclock_index is
    +    introduced in later versions]
    +    Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
     
      ## drivers/ptp/ptp_clock.c ##
     @@ drivers/ptp/ptp_clock.c: struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
      	/* Create a posix clock and link it to the device. */
      	err = posix_clock_register(&ptp->clock, &ptp->dev);
      	if (err) {
    -+	        if (ptp->pps_source)
    -+	                pps_unregister_source(ptp->pps_source);
    -+
    -+		kfree(ptp->vclock_index);
    ++		if (ptp->pps_source)
    ++			pps_unregister_source(ptp->pps_source);
     +
     +		if (ptp->kworker)
    -+	                kthread_destroy_worker(ptp->kworker);
    ++			kthread_destroy_worker(ptp->kworker);
     +
     +		put_device(&ptp->dev);
     +

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

