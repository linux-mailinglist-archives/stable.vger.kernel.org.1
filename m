Return-Path: <stable+bounces-166941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417DFB1F770
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C035C3A803F
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC660EAE7;
	Sun, 10 Aug 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQHNgNyx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465CD531
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786523; cv=none; b=bcK082skHzsotbN/ewUpO+T54r0gTGmRIpkxafepChRQmx/H+Bvb3fqUF2fzR+zTUpL/ROUFoXLUQL3EfKbSnDWsKlgfgyVs8N+G7I6vKxJcgCGb1Z5Gwmp26yIgxqNRR9ugDZzH9OwaKOF3GTMH6FdRcbzSnLsmiMgu2C4MZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786523; c=relaxed/simple;
	bh=6kkS9NjWODsJvJBx9SBvlvWKQh3M3eb6rV/+lWEezDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEiqTOty96CMMC02KvhygjBbPtWdYz4koMxpqJuMGodAMAGFhY+H37PEAR4uZbwivufdFbxYfOE/sfEmDeVu5qTptEtjoJP+K8f9CwAw3gb1xaAtZ4UX2W42Upg/DaQwFhJmKteoncIWuve0eGdnJmKBCp9iuUOYktqFPggQSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQHNgNyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9924C4CEE7;
	Sun, 10 Aug 2025 00:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754786523;
	bh=6kkS9NjWODsJvJBx9SBvlvWKQh3M3eb6rV/+lWEezDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQHNgNyxkEn0RL4Ocdh3KbhLi4Sn8kHRVE4cnZv7nA+WExj0hcSQAY43OeoBFETUg
	 3QAG9oZlpPwkojmDloLSZ4gGrM0A5aZ+o2gq++zuExVyYzo7W1B84cN6OZOIRDuiEJ
	 UgtFGWbszY523iqwykhLRJBK9OWAz12H8gPHECdtR3KR8Z6EHh8d0DPI8Yjr6wIizs
	 XV+i8O4m3Pop+T5C+A3hextVd85bPRQ3kTRzkwLCFwH6YEBsNZ1QpkODfEh9Uq/7D+
	 JURwPQaT+lv07OC16j0nm471MXDbtDW42OKdM60yX/u+5eHw880tH/uo1ggn93RIMb
	 bQGFOU8pRGcVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15, 5.10 3/6] sch_hfsc: make hfsc_qlen_notify() idempotent
Date: Sat,  9 Aug 2025 20:42:00 -0400
Message-Id: <1754785100-720cef81@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <8f1d425178ad93064465e15c68b38890b10b5814.1754751592.git.siddh.raman.pant@oracle.com>
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

The upstream commit SHA1 provided is correct: 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb

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
1:  51eb3b65544c ! 1:  28c329d90074 sch_hfsc: make hfsc_qlen_notify() idempotent
    @@ Commit message
         Link: https://patch.msgid.link/20250403211033.166059-4-xiyou.wangcong@gmail.com
         Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb)
    +    Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
     
      ## net/sched/sch_hfsc.c ##
     @@ net/sched/sch_hfsc.c: eltree_insert(struct hfsc_class *cl)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |
| 5.10                      | Success     | Success    |

