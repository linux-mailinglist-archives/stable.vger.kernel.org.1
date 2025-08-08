Return-Path: <stable+bounces-166891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B001FB1F0AE
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 00:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA297B053E
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8C27510C;
	Fri,  8 Aug 2025 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeI8nQpu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F92676C2
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692326; cv=none; b=OvUOxui1uaAH6St1iXsSJl2UHNUNsJxmYw4JyTqFegXOr57fnwMrWvZ4r+LGH6No4LM0r/ENsBFpMFlzb1ZObpKO4oe/8HOyCcBdgzRO355K7SZ5xaPse5jkMJTM0153C26A7fQe3ZMEmQrzKf4rzv/HAuG3DsHOX4dcHGLThfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692326; c=relaxed/simple;
	bh=fHUFgCPN0fsnj/q8aMRRvQiMUr7zpC1wzg4x4Y6WAMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXDGl/IUcTn+2d6BevxcGqfm957ah30FdkvbeYChTnasnt9k+iGsrsLuzUfrOiOWW/hbqC9Jnfw35wS0ztvSiACek6YjWha04mFRrZ0qtz5XKbinrUZdedPdWS3xSsMTUPCUFVPvjcs9HRPRut2FZikaidlYYFF4/byqv76P39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeI8nQpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B46FC4CEED;
	Fri,  8 Aug 2025 22:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754692326;
	bh=fHUFgCPN0fsnj/q8aMRRvQiMUr7zpC1wzg4x4Y6WAMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeI8nQpuMqSaBiHMiHteQOYCCYiUm/N7KZ2Bn96hDMZCcp6fnpXB8NApSKPupsTqH
	 s3zI6NXATetMFgQAAb6BMaJED9uMQVY6HPek+qFKHAvIOy9+ivaTPzcYY8ISzcsS5/
	 QoDFze1u1o+yBS9dOgeGHxbGFEaZb6DGIxWWaPmJF1QB+MmhAYP2/it5e6WBgSJ1Ge
	 +Aos+Sq762vnVPbhVrMjSVNiYaS8Z/YmEE1ettcim8+tscIDTyFluGf2qRwQM28/dT
	 7G2duUWXV4I2tw2YKTU8c1PJ+s/SCndMUz9LKSzajIw0nSdS0/gqUu/oYXVuSWJkfr
	 LllYnE1BvF0dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4 4/4] codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
Date: Fri,  8 Aug 2025 18:32:04 -0400
Message-Id: <1754675119-de03431f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <b7d0379dc05860dcc1b901da015897993a9ab872.1754661108.git.siddh.raman.pant@oracle.com>
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
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  342debc12183 ! 1:  800493fd9c39 codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
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
| 5.4                       | Success     | Success    |

