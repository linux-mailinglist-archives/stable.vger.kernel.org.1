Return-Path: <stable+bounces-166943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F068DB1F772
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28533AB28E
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A6E555;
	Sun, 10 Aug 2025 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9Vx/G1s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D5EC4
	for <stable@vger.kernel.org>; Sun, 10 Aug 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786529; cv=none; b=TWfCbI+2ZPVdWbk23LQzSRz9Rb9CA84sI6V6mXY11zdK0P87NYQeRFzJmaoDRJwP53vz12Nnwv1zKmxnSHBTBd5ITKu1ohKKaBSDom/g2w9WJF1D2yecvQMN5gAzzUzpPO6i26BDhho4jygSimHTz20kIQtTG10DfYDad3An5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786529; c=relaxed/simple;
	bh=E9rKDg30s1+mfX6RKZR4mELf7SPxw1iIEv+emAHUNv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWLM2SilRMG6DaX1Evr3R5dG8M9TahaFRlvrPBGpeLOTkQEGZXJtwgcG+AKkkkZ1dP+jGExi0FMNQuQd0lQqQNjlPW/RFBIr9gMkHKrFVGc6BeQGIodPknq8SQcFO4fNN3QcPQjsBaKudl2qmngcG7xggJ0eVag5uhfmcLvW2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9Vx/G1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16277C4CEF1;
	Sun, 10 Aug 2025 00:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754786528;
	bh=E9rKDg30s1+mfX6RKZR4mELf7SPxw1iIEv+emAHUNv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9Vx/G1sIeero2Nu/OOhdQ6i569nQUFZ8jN2LgcdtxnElpb7nsJnYUlbYU3HM3OL1
	 jYyf0HVQAXKurvcCZBlsUCXRJoPfWOgT4HR0DKdo2z2MmsjlABOMVe2UhNy6Ctk7lk
	 AeHzxLdAnXoDtGA22PyNGkcbpqADmgU2JcANGgCkAcHmt36kQS+YcuHPYt1naP0RTD
	 Z+KA3vBUQ16kIL6abuzvwKrpuKNx8ud+5mW/O0WogVSoGTy5J1hu5lN6ranKEGxrDx
	 oMoEspIpvyEwQcOT+10iuXkTQChWeeKVdpjCkVkVjSUYdQpf0aWic/fvoWxgqtHWP+
	 IlTXGwE0hJQXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15, 5.10 4/6] sch_qfq: make qfq_qlen_notify() idempotent
Date: Sat,  9 Aug 2025 20:42:06 -0400
Message-Id: <1754785209-c7fbeedd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <b800f55ee493086bf95fe929027f131254f93e1d.1754751592.git.siddh.raman.pant@oracle.com>
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

The upstream commit SHA1 provided is correct: 55f9eca4bfe30a15d8656f915922e8c98b7f0728

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
1:  55f9eca4bfe3 ! 1:  a993c437857b sch_qfq: make qfq_qlen_notify() idempotent
    @@ Commit message
         Link: https://patch.msgid.link/20250403211033.166059-5-xiyou.wangcong@gmail.com
         Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 55f9eca4bfe30a15d8656f915922e8c98b7f0728)
    +    Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
     
      ## net/sched/sch_qfq.c ##
     @@ net/sched/sch_qfq.c: static void qfq_deactivate_class(struct qfq_sched *q, struct qfq_class *cl)
    @@ net/sched/sch_qfq.c: static void qfq_deactivate_class(struct qfq_sched *q, struc
      		qfq_deactivate_agg(q, agg);
      }
     @@ net/sched/sch_qfq.c: static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
    - 	gnet_stats_basic_sync_init(&cl->bstats);
    + 
      	cl->common.classid = classid;
      	cl->deficit = lmax;
     +	INIT_LIST_HEAD(&cl->alist);

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |
| 5.10                      | Success     | Success    |

