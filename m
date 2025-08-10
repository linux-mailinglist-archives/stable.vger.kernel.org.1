Return-Path: <stable+bounces-166948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D458B1F777
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5983517BB12
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B533BE555;
	Sun, 10 Aug 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBWb2u+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77538EC4
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786542; cv=none; b=RQX15w5UEU62+KoA1cv+RdM4EBPnh61XakNSDAeU1LZl6VFrcQFRiaHFdlyPcvyzob2cTkYWlZSqupJfwyfAMDpAvPTS6yoOVrdREXI9RO8k3jYvT21wGvsED9iXuycbRy1aM6hvNQCBN/ulmabX+vt9T1d8D4TcXsE6VsS/1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786542; c=relaxed/simple;
	bh=ml+vkH5ShBfOY3jBOWp0sj+mW1A3YtV+MTo8f3dolbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grF55gUTw9QbccO0eAg2jmdxsZ2JDMZ3w04DCP139zHYAS50HRfz6FJHXu1D91xgQkRB1BmuBJj36xRhxL7FiPVN1Mu4ak6fQWhXB+WdBs2ooigrOXSwp1ZiBqXRdAP7Bgezfz5efdvSY3uGq74Fk1KB5/Hy3NzZeCsNPrzWtZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBWb2u+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F82C4CEE7;
	Sun, 10 Aug 2025 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754786541;
	bh=ml+vkH5ShBfOY3jBOWp0sj+mW1A3YtV+MTo8f3dolbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBWb2u+DI8IR9qYElQ+BZjPqKmQ1e4LAzv9w6ZcaYEyEizbqW/EAFM9ZrYuqK5JB3
	 MOQtdeXHnLHL3uNQe75gQrr27zhVgFIq5VQ7kKqb3M6Jte23k3uEmjALkWYhBK7tsx
	 7AWsT/K1PE1J1S8LJOSYCHbgCSlips15svw+r9tRFvfuyp5N9tFUd24VKsMjUNHCe/
	 /iz0ls23T7Jb4alcDSb3PCfEXvuv/QTNukC4waeojQdG82+Nm08im6kgl+Mr31oJ6b
	 Wu4QV3Uz51wuXnsAiuHurR5WGjh2CKc6dzgVp3GtoY/DnghFSFwKmlJcFtx8Lexi1Q
	 PxKvkXshBI86w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	siddh.raman.pant@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15, 5.10 1/6] sch_htb: make htb_qlen_notify() idempotent
Date: Sat,  9 Aug 2025 20:42:19 -0400
Message-Id: <1754784887-d65854f8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <d8d3e034c967229486ef198ca4660f0d8bf9cdbe.1754751592.git.siddh.raman.pant@oracle.com>
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

The upstream commit SHA1 provided is correct: 5ba8b837b522d7051ef81bacf3d95383ff8edce5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Commit author: Cong Wang <xiyou.wangcong@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Found fixes commits:
376947861013 sch_htb: make htb_deactivate() idempotent

Note: The patch differs from the upstream commit:
---
1:  5ba8b837b522 ! 1:  2a0a35e37372 sch_htb: make htb_qlen_notify() idempotent
    @@ Commit message
         Link: https://patch.msgid.link/20250403211033.166059-2-xiyou.wangcong@gmail.com
         Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 5ba8b837b522d7051ef81bacf3d95383ff8edce5)
    +    Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
     
      ## net/sched/sch_htb.c ##
     @@ net/sched/sch_htb.c: static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |
| 5.10                      | Success     | Success    |

