Return-Path: <stable+bounces-166892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBC7B1F0AF
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 00:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616F3722478
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A82750E9;
	Fri,  8 Aug 2025 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O//1k3IH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55D2676C2
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692330; cv=none; b=Sp1gd+YaLB4vqQS+uSg1YuHu7Eke71NDg7VapuKHTZ3Td/z1lKmfj5I0/wVGo33Qmhv87tpmhEv11DHYmMQ3rI9cC9iBV4169KK8RQBxPyoUidPY5+kP/yFDOCXEGKIwCzfv7keoMhAfpggXGolwXFGGVHk0Wmj9lI9HjNMrsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692330; c=relaxed/simple;
	bh=yrAAGPnaLyUlh000ltfTZE0h/nVVwIO/MNNeXfMsIYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhnpGtWI+3jWG6jJqcKL7yeOyxOHHhP1DzbZrjT2X6vXCe6dmnmOH8fF22DKhvQqaL7RBDsBNtyhsCpWZYYTtMZmWeSNS31r697Wub4DpnecAWTQmH+HAGxZ2PF4FsbDJl9pMffk4YbTb7c7UHfeS5NMLvH6QRbt4i1AMm21Bhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O//1k3IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC707C4CEF1;
	Fri,  8 Aug 2025 22:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754692329;
	bh=yrAAGPnaLyUlh000ltfTZE0h/nVVwIO/MNNeXfMsIYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O//1k3IHMqg8rAzv3MGyDUjkMlGvRqhvE6pzMyJmg/QNNfGtzkyYm6SBXW6YduKnu
	 iitIUTup7txt2BmUOjkzLZ6wQ3MU0WsBXx1fRYdK9c8+UoqxA1kBsgZ/M6GXyrykxM
	 Px+DACVIk6V048xxYwvyWqXErGpVdUk3WG7CShb4ZLb+P528GEVXywzwhOduAljMai
	 +3IsTxAIyaSFOmnedZAdAuHmToBiOT5M4eX0klwSZZIv3yRzeEwiq4m4dG34l3wbGz
	 IJkg+G7YUZtCtdu2FbRmcaPjSmQ9cxnGFHNk2Kt2A4YOFOhHkmfGZPwTHAQj160Cf2
	 BkS0Dhq9sFKfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4 2/4] sch_hfsc: make hfsc_qlen_notify() idempotent
Date: Fri,  8 Aug 2025 18:32:07 -0400
Message-Id: <1754674821-d140af9f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <a67f2f17755345d4b95b0602706dcba079fe302b.1754661108.git.siddh.raman.pant@oracle.com>
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
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  51eb3b65544c ! 1:  e56f0757d100 sch_hfsc: make hfsc_qlen_notify() idempotent
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
| 5.4                       | Success     | Success    |

