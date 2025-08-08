Return-Path: <stable+bounces-166893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C68B1F0B0
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 00:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0369F1C2834F
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 22:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1942750FC;
	Fri,  8 Aug 2025 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syQXyaq5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241B2750EF
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692332; cv=none; b=pOgg4GpiRl7KENCi6STGmZrXvR72DyechdD49XLowiSuwHjUf7etk61bejjV1ETyDp/LLTgXF7bMKfbOJ8PMS4yed19NSh1ngjXYgxxLrB98QsPBxQ/IK7hEBFmVhonHfRDhBZ6bydfixkNOMcYm9Fq/iKfxHG+OtpaHllVojt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692332; c=relaxed/simple;
	bh=DWYTMafIfQeEzkJk2VVodkRBh0EE4E0P1D2an3L2ZuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbeX2MKRU/6ZH0a7wmM8ESJDYgxJ+k+Oy+BC4N/qxvi2rKsRawOr0q9Pk7jExbbeEpo94+x6yNaKzVuujtmLeua4yUEaoxilMcWKKbHCKPiRtz8MLNFNFagR8wCnU0t/c+Im1LZO2vqnhRLZ5Nc+F1DnRsrsD12yFXjFfETi1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syQXyaq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AC3C4CEF6;
	Fri,  8 Aug 2025 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754692331;
	bh=DWYTMafIfQeEzkJk2VVodkRBh0EE4E0P1D2an3L2ZuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syQXyaq5FWp7T2/BUUh3uH2HgfmEROTgRpJWQqCiHeCV0++avucMR37yuBHtOR7Np
	 zLARbVOVTc7SSdd4qA8hgx4aH1Z8MP1eQMc5/lp3HhbCIAUDkEsy2HcRXjvo0wGV94
	 OFzEzEUPqsphu96mcg5vDc0tE2tsAbrxBoIqE3F4kedYmwrbiaUWEi4x5y3Ci1aiCD
	 f0AROvRm4XvEkw7hXjXQkCk0hNQ+PyZiqb4DWpqpPyOL3yi2TmnU6oU9gFQdMLhSDO
	 oT5hi1dmMVegVnpwfr6cSIfgCnZOufqXGpjvViR5q454BInbjSrG12aBzmg3sDb+JZ
	 k+tykOBQRD6GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4 1/4] sch_drr: make drr_qlen_notify() idempotent
Date: Fri,  8 Aug 2025 18:32:09 -0400
Message-Id: <1754674672-0de994e0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <128b6759dd8c93a79e0c7fadd1ec75a9d666b7e9.1754661108.git.siddh.raman.pant@oracle.com>
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

The upstream commit SHA1 provided is correct: df008598b3a00be02a8051fde89ca0fbc416bd55

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Commit author: Cong Wang <xiyou.wangcong@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  df008598b3a0 ! 1:  33accb73dca5 sch_drr: make drr_qlen_notify() idempotent
    @@ Commit message
         Link: https://patch.msgid.link/20250403211033.166059-3-xiyou.wangcong@gmail.com
         Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit df008598b3a00be02a8051fde89ca0fbc416bd55)
    +    Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
     
      ## net/sched/sch_drr.c ##
     @@ net/sched/sch_drr.c: static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
    + 	if (cl == NULL)
      		return -ENOBUFS;
      
    - 	gnet_stats_basic_sync_init(&cl->bstats);
     +	INIT_LIST_HEAD(&cl->alist);
      	cl->common.classid = classid;
      	cl->quantum	   = quantum;

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

