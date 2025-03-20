Return-Path: <stable+bounces-125692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1621A6AF68
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 21:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393D17A7DE3
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0F229B02;
	Thu, 20 Mar 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b="RZtq2Feb"
X-Original-To: stable@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22901C68B6
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504031; cv=none; b=A2D0wiCTkZcNSGS/UTFF5fmshrjHpkRijg2XfVX/sqt2VYvvEHOkQDalThkWA8Ehf+AxdBoxUIqsi7iWfBGjVtzBkBHsliGvVqB6FuEjP5S6wV3C79TBpfYLPUvoPpvn7S8d6qb9btwa4PPXL9H0liQT8xNQp2p5f2F3X6gX3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504031; c=relaxed/simple;
	bh=OYwOGCVxHfD3Facncy2Z5BmWqZzNmxM1NlJCuYfgUS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5AhPAFM+enI1WY2wYOi2FKprj0uWwnWXA23gJQY9C+BGCkKIt0o1eeQWZz+i0UlW4Kfv4MjpEumj35YKH+S/LewPXVB3Icn7xzzqHKFAQ/dVgmkjy/YU1IZ0Y2RziYMZ9LzwIyoaBv3b7GMVzuHBIE/PnMXynIWs3GZneEmKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io; spf=pass smtp.mailfrom=patcody.io; dkim=pass (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b=RZtq2Feb; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=patcody.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=patcody.io;
	s=protonmail; t=1742504016; x=1742763216;
	bh=bu/GkZMAgTrYSPXIW3+XiGbJpc6DMcnwFJCuLanXnYk=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=RZtq2FebTYalPAad6AIoa0jBdQjIUWZL96CtmGfHlhTatx1xUFH1O6tFGkffD+48u
	 tZcFSPMe8IaAw0Ad35GL/aIu3GnqnyOVvnddrxkAAJghTjoxnbTh+Lp8Jsh7JzkSqT
	 Bo3DsM/50i5QAzb8gMuZUsJJQzwOwOIlzFb0T6txtlTPiB7Cy+/BmxvvBPH/Tijq2c
	 +IwekDK1J5Ja5L114RgzM7J3/8pNHOKYoI2aSumEqR2w23xe9urhnRB3WYD9LZBsVE
	 s53AWeD/nUWmvPYU+gq6PJLS7ANI3ovhuMwt0i+QKEF2k0NGltm/QAlfAsaT/sRsvk
	 7fGZ8Hk/YL+7w==
X-Pm-Submission-Id: 4ZJd8b4zZDz4wxB8
From: Pat Cody <pat@patcody.io>
To: mingo@redhat.com
Cc: peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	riel@surriel.com,
	patcody@meta.com,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Date: Thu, 20 Mar 2025 13:53:10 -0700
Message-ID: <20250320205310.779888-1-pat@patcody.io>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pick_eevdf() can return null, resulting in a null pointer dereference
crash in pick_next_entity()

The other call site of pick_eevdf() can already handle a null pointer,
and pick_next_entity() can already return null as well. Add an extra
check to handle the null return here.

Cc: stable@vger.kernel.org
Fixes: f12e148892ed ("sched/fair: Prepare pick_next_task() for delayed dequeue")
Signed-off-by: Pat Cody <pat@patcody.io>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a553181dc764..f2157298cbce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5560,6 +5560,8 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	}
 
 	struct sched_entity *se = pick_eevdf(cfs_rq);
+	if (!se)
+		return NULL;
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
-- 
2.47.1


