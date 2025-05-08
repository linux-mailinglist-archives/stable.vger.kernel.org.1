Return-Path: <stable+bounces-142893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11388AB0026
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20F79C55B6
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15379280A5E;
	Thu,  8 May 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmEM8c9s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7207281346
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721109; cv=none; b=PQinAw/ZGnPLduiwQ4pzGvckqybWb3tr9bbpnxDFwkk5wyzjWmiNPM3ZWsKQye9cDC+1ghyzPDD1qOurbRvFIyPvuDL7ReEqo//oPfOuGUWQA3Ram0B4DX4exXleZnbKPfPG0DnWMFb8U56Amxpe4keez5v/j/LxNXfulxuMEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721109; c=relaxed/simple;
	bh=K960whzbDp4+ebJAAsQeDOYEwLdwPTraWpyuzCRbVg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+0OIUzGD1Wx5CoV5lvkifqieifkCuarEImuupfCt3TvxcotKF45QWwLtZ9iAYmm8ehhrZ1FE7sgqo28f9qAlCdJy6BmEj6+am6oWUs+TN+L6mTcmqJRNdwpz0VNL4hVp1NZiV/MQIfM2XdgkwRy1s2UX/fQrUFZk4UXCQVR8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmEM8c9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BA7C4CEE7;
	Thu,  8 May 2025 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721109;
	bh=K960whzbDp4+ebJAAsQeDOYEwLdwPTraWpyuzCRbVg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmEM8c9sCVO2burUIM/v5wirsJm3YNSVgvHntBhLKv30XJYZ0QkVe1Im9sBGGc2qB
	 SA2dOf151zk1wno1YiOOXheSMd6NakGHO1k3XS/+CQjQ2ZcGiZIkHV+9xAdqC2NKP1
	 biK/daE3+KRJwjOaNmvS81WJRzyMrm4+Pgh7mSBp/TPbB26ddX04RufsWYHbsOfmUT
	 heantcTqHpcTOJlV83rSa8sqBFE3uGowoSvxRLSLqgWJ8bvZDK6sfiCW4AO532gCrn
	 UCBWMZjxDNFzSnz22ztAa0mIlpz+qtUEHsKsSvoE8zfZ4knIaxP7oCpbh7SNTw2dJk
	 Mq71OOlL95kYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jared Holzman <jholzman@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y v2 6/7] ublk: simplify aborting ublk request
Date: Thu,  8 May 2025 12:18:25 -0400
Message-Id: <20250507084945-aa645b0881f4ce8d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507094702.73459-7-jholzman@nvidia.com>
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

The upstream commit SHA1 provided is correct: e63d2228ef831af36f963b3ab8604160cfff84c1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jared Holzman<jholzman@nvidia.com>
Commit author: Ming Lei<ming.lei@redhat.com>

Note: The patch differs from the upstream commit:
---
1:  e63d2228ef831 ! 1:  b0b649f236e0e ublk: simplify aborting ublk request
    @@ Metadata
      ## Commit message ##
         ublk: simplify aborting ublk request
     
    +    [ Upstream commit e63d2228ef831af36f963b3ab8604160cfff84c1 ]
    +
         Now ublk_abort_queue() is moved to ublk char device release handler,
         meantime our request queue is "quiesced" because either ->canceling was
         set from uring_cmd cancel function or all IOs are inflight and can't be
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

