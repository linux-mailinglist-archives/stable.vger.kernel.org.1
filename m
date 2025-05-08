Return-Path: <stable+bounces-142886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6F7AB0019
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386E91C078A4
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511227F4E5;
	Thu,  8 May 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0Texldw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C8C22422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721082; cv=none; b=mSR/phiJciuioFWBsNRKpDYKEB4OSi+tdcRfNHi06qS8P1i3kLIChx4a4m88qR9HiXUyQkQQkTR3QtHSy0hw9mS/HDMLjHon+kCdY3wHrKMnmWtrllyTUWAtIl2nfyHjGKIDrExhWVHcNrmxKOCnVk8tjzBUkGVdBu4L1Ezp06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721082; c=relaxed/simple;
	bh=CgGpEvVyhZUb5hjaA1DjZw0H3nlwcQy2G9FsCGROEwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usmv29BfGd7WQN4a201ZdyfQzBq4rSaNqGhLl53Fu19scyBUa8bywxo2kfhL/4PuzBXFxMIyS4Cg7ir9tGoOf3IPVh1u3r0WUWxmv8jsRQxrArCyN6H65+IRttUlyFQRB1MAfEVXDaGTtKjDS8j1AupcqwU8P6gpnFhsmk2D9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0Texldw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0DEC4CEE7;
	Thu,  8 May 2025 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721081;
	bh=CgGpEvVyhZUb5hjaA1DjZw0H3nlwcQy2G9FsCGROEwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0TexldwLoGQaEIh9JG86lV5DkN2Z6U2NCbMWaSwaZmVsyC0nAMAQgCzVMeQxE7Pv
	 dTP0rbIhwUYJzo7vnz8t5vnpLtThCjCfhnyscAdoDYsD6AX9XoA2RIapWTXZXw6JSl
	 dDc8LkQBnHBoULnc6M1oNHCaCEl4HL16IQkOTacZglEjtlBdSohwo5XjRRypJSs6Mc
	 dAkgDIrFVmiKq6QS/VZFxIAtEaY+GYJCca/i1yDzZnP6rXIasaotEkkwZN51QUyIgn
	 Ljutg8ZUDa4QKAEkeNNYiSoaAKo7z/mQ+/cmuE5O4L/pEIbW91QMh6w75vo434HTxg
	 BMBCRc9BIq0SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jared Holzman <jholzman@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y v2 5/7] ublk: remove __ublk_quiesce_dev()
Date: Thu,  8 May 2025 12:17:57 -0400
Message-Id: <20250507084702-60da01b945ef64ee@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507094702.73459-6-jholzman@nvidia.com>
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

The upstream commit SHA1 provided is correct: 736b005b413a172670711ee17cab3c8ccab83223

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jared Holzman<jholzman@nvidia.com>
Commit author: Ming Lei<ming.lei@redhat.com>

Note: The patch differs from the upstream commit:
---
1:  736b005b413a1 ! 1:  4115ef18a9595 ublk: remove __ublk_quiesce_dev()
    @@ Metadata
      ## Commit message ##
         ublk: remove __ublk_quiesce_dev()
     
    +    [ Upstream commit 736b005b413a172670711ee17cab3c8ccab83223 ]
    +
         Remove __ublk_quiesce_dev() and open code for updating device state as
         QUIESCED.
     
    @@ drivers/block/ublk_drv.c: struct ublk_params_header {
      static void ublk_stop_dev_unlocked(struct ublk_device *ub);
      static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
     -static void __ublk_quiesce_dev(struct ublk_device *ub);
    - static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
    - 		struct ublk_queue *ubq, int tag, size_t offset);
    + 
      static inline unsigned int ublk_req_build_flags(struct request *req);
    + static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
     @@ drivers/block/ublk_drv.c: static int ublk_ch_release(struct inode *inode, struct file *filp)
      		ublk_stop_dev_unlocked(ub);
      	} else {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

