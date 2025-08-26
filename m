Return-Path: <stable+bounces-176371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDFDB36CF0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994FE582DC0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB3C35AAC0;
	Tue, 26 Aug 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ToBKzqFO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F53568FD;
	Tue, 26 Aug 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219485; cv=none; b=UlRcOw+RWnFkSLoh8AAiok4INGn48vaurv0YLbQhu8DzrG6suIsJNY0Wc8j3hS/aLqbey+ua/rLNkVj4dKOpYBJ3/EHAf0roswTGwcN0sfAeP7DfEJSsgQghszr8aLwIXLjXlP7kjfdblHRC46zUP+p7yspmUy1Rq/35mOOfvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219485; c=relaxed/simple;
	bh=vFxu520HrLt9jvCCp9T9tRmAOCxLiKOFD1Vfk89weVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEmMjqek93UIsqnKV/9ElKTZ/sZn6vgabrBDFWP9m1Oko2sUheTDQlKCzo2DHg+7Xlt6y2OTDP3UQ3dfLcQJ4a1YM/zJrOekp0mY1+s1ajF1lqEkwPccYX8+kaLLOOm3w9xuAqPlG/9hnZKWEauzit94Eklr2XlrLAfL/DjrI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ToBKzqFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB93C113CF;
	Tue, 26 Aug 2025 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219484;
	bh=vFxu520HrLt9jvCCp9T9tRmAOCxLiKOFD1Vfk89weVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToBKzqFOVd7Cig1t8hZ+I9dAnPcbhnpHN3l/0To1U6ZKUrSkvgZ18AVuZjomxcRem
	 gLsaAEuM2qPbtOK0v4RN8rpHpuvAJ5lrrj8lCbWuCjsY1P5h22/6HPuhLWKS6Wg+bo
	 INpQYWE3AUMh6vco/DP0Q7NuxVZEppw/1HouIDFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 400/403] net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate
Date: Tue, 26 Aug 2025 13:12:06 +0200
Message-ID: <20250826110918.083755783@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Liu <will@willsroot.io>

[ Upstream commit 2c2192e5f9c7c2892fe2363244d1387f62710d83 ]

The WARN_ON trigger based on !cl->leaf.q->q.qlen is unnecessary in
htb_activate. htb_dequeue_tree already accounts for that scenario.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
Link: https://patch.msgid.link/20250819033632.579854-1-will@willsroot.io
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_htb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 2562219ccca4..dd5088f7bffb 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -558,7 +558,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_class *cl, s64 *diff)
  */
 static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(cl->level || !cl->leaf.q || !cl->leaf.q->q.qlen);
+	WARN_ON(cl->level || !cl->leaf.q);
 
 	if (!cl->prio_activity) {
 		cl->prio_activity = 1 << cl->prio;
-- 
2.50.1




