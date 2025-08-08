Return-Path: <stable+bounces-166890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED50B1F0AD
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 00:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760E31C28287
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A033A274FFB;
	Fri,  8 Aug 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxSm+Asf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B12676C2
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692324; cv=none; b=EIsQfa32VDBaszIO0YAbgkR1ifBN3imUsAj87OPnWlnMpkplLx+cUSUZ9NaXmg3EKiklp+jWOHdb424GG2hTa3qAmwwNEH7S9a7RvlibOj/0wd3k19RZfTbwoNBmbBWjm31Je/eLejFicOV+Zg9hEJC2Kuo2l+q0wbiMagCzoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692324; c=relaxed/simple;
	bh=LQFdzBhWtinENEEMn83ydylZD4ZlpsvvKpjdfnQ6qhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYew1siBShDqXf2SWJtNHlMlSu78ZG32tT3Le/FMgOPVgkliovXEcT5HQORcXdfISu6UsbPt01fjkCV/pc10MiBK28JX10oCQYFX48JyWobIVoniyy/vIjD/dR9SBGCsxhmElaU//1bbBKo+Yy9iFWdY2FJqaa/m5RAH1nnp4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxSm+Asf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F38BC4CEED;
	Fri,  8 Aug 2025 22:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754692324;
	bh=LQFdzBhWtinENEEMn83ydylZD4ZlpsvvKpjdfnQ6qhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxSm+AsfwZrL78Hh1ije0LVgZAIdcZvDNZAjjeswcdOQhkl6D7bX/pMzWtuRE5IEF
	 37+tyw76DpoarUi13ruFzFYO2lrr4rcybxAW5TJIWZUKLoK1oIE5aXNcKD0RwHm+UE
	 pzUj1lsFZc/zvSI1gavJyWhL44j7fjoc64FLvD23neMhfSW/ROV3JWlb1u37yp2ha3
	 XN77qbFKfZ+eTO0T2DxpCU++hMYUE/d05/1RsqmVncCPGq8MWbCwCyRgfx8ncwCAoa
	 G9WZjuPI0RQCiL6Smh5eV32n6TnT1TtB/SE55GGrfrAAYwJzIwo+vwQMh5nPTDE8rc
	 oWC7QHIEPPCoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4 3/4] sch_qfq: make qfq_qlen_notify() idempotent
Date: Fri,  8 Aug 2025 18:32:01 -0400
Message-Id: <1754674972-00ba266a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <d37d657c588b265494ab8afe030cd72b1d7fbaf2.1754661108.git.siddh.raman.pant@oracle.com>
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
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  55f9eca4bfe3 ! 1:  3d5ade16b1f2 sch_qfq: make qfq_qlen_notify() idempotent
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
| 5.4                       | Success     | Success    |

