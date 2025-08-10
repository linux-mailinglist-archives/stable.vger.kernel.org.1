Return-Path: <stable+bounces-166944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9152B1F773
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84761898785
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946DE555;
	Sun, 10 Aug 2025 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWuo/4qj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F2EC4
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786531; cv=none; b=albyBgVJDid4BdXiObdnsTNRKXaH6YtBIYAR1V4f0JpQpjiO/LlBUlRKGP7/81Xz3VxR7Bo31I49hOLd/x0KPMsyX7Vpi+j0S9SAFpD6QIHfrisEe8bJNBQWH+RAF5cgP0fIhReb9Z+cpKU3Umx2HAhKY+AmOI3aqxLd0IEOKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786531; c=relaxed/simple;
	bh=Fu6BmxKFkwXanw1LMsCWX+VUEYuDF/A6FMdBudbEBT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvDtcIoqSd1m/NqkvdHlPOSYbR7mqDcY7nVXUEvmiYM7UJwr0WhS3QXXa5Z82hlOHDTbQ66pptEjvu86z3jg0Vl2GQ7iA/XP3cNZ1iBaMr0ptyo3iPViWTEW5jN7vDa+hmFxSE3v4FOzOKOGxEseAuKtGxPslmeKuAH0hRuc+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWuo/4qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7520C4CEE7;
	Sun, 10 Aug 2025 00:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754786531;
	bh=Fu6BmxKFkwXanw1LMsCWX+VUEYuDF/A6FMdBudbEBT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWuo/4qjgwyUg2D7BkwRfZFN5kfg29KvtnniA07ONbLrfuC27zGOEZX7CBtMp4YBv
	 Hz3qmMDrx8JIBUBzdSN+b4WsZocuR86ng6sP6nS0P1I4QZIKDfCHhKDoGUfR1/wBB6
	 IyEyDpAKTanVdBX69X7jugHTLcf+QQJCT1QPrMZ9zQaTgeiVtq7M+Fmrx1MNkU0lHz
	 Lu9tlEhGoekSYQ52opXG4rDzX29eC8P1wus9aqKWH4E0l1jty0f83Z9pYtFZa789po
	 ob/CWcUVUMiAK6c02bqRf9uKxeTiv9EurF5sd9Sid3otsvRc1eJp4kFaP9hdHdu1iZ
	 4EFSciBtJEZvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15, 5.10 5/6] codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
Date: Sat,  9 Aug 2025 20:42:09 -0400
Message-Id: <1754785316-b594c9dd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <6dfef48374451b97f3a7c63230862b0ee15fdc3f.1754751592.git.siddh.raman.pant@oracle.com>
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

The upstream commit SHA1 provided is correct: 342debc12183b51773b3345ba267e9263bdfaaef

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Commit author: Cong Wang <xiyou.wangcong@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  342debc12183 ! 1:  86b332340fc7 codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
    @@ Commit message
         Link: https://patch.msgid.link/20250403211636.166257-1-xiyou.wangcong@gmail.com
         Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 342debc12183b51773b3345ba267e9263bdfaaef)
    +    Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
     
      ## net/sched/sch_codel.c ##
     @@ net/sched/sch_codel.c: static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |
| 5.10                      | Success     | Success    |

