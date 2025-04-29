Return-Path: <stable+bounces-138001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C67EAA161E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68E716CC95
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ABE2512DE;
	Tue, 29 Apr 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kn5oKyPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49EF23E340;
	Tue, 29 Apr 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947798; cv=none; b=EvvJcPdzsPi2Hf1E1wXsDZ+lLrQR5UduEexk69SMWFosDW3bxF/UKP2CoscSqWTfd+HxJNuhqUU5JEKsHinHNJsCfJlPk9VkshA2lMuGmhrSolHIivyCvhg3gi7XTjkadg9C1LP3U/8+lJdMxtHivBnEDkNG7ibOaU48sJOWfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947798; c=relaxed/simple;
	bh=USOZX0tpI2ZMmuIiibumQPk6/73eEMX2HOxSE6buXu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebtMtJtp81Nu3D/B2TiM2AuYXHUUAvEHHl6LNLDjDTDY0H6cBg3iuyY9wQ9XQxJhphneZF9igBHCrQ/8ozIw3ejySUediscQZjSp+x5UsPI6bc77KgCXo6dJP7RRB6YxJUfsZNvZeovXpU3mP8t18CFZVLygw7//3EBPAuiVjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kn5oKyPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA571C4CEE9;
	Tue, 29 Apr 2025 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947798;
	bh=USOZX0tpI2ZMmuIiibumQPk6/73eEMX2HOxSE6buXu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kn5oKyPoe2TJBUs2c/k2iE6lySPZHfnODn9gLZ0NuCRHPIrgIgBgXwr0EN5KmbdxH
	 uIon/UYmgJts1RRhvSFpXFnzwa0GyvBG4rTSD+nlqTl7G0kJimdeje31pODXLHRQQl
	 X0RE59VKGJEJuWIld+nsRZ/eGYdyTtdod7u+XDFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerrard Tai <gerrard.tai@starlabs.sg>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 076/280] net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
Date: Tue, 29 Apr 2025 18:40:17 +0200
Message-ID: <20250429161118.218553672@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 6ccbda44e2cc3d26fd22af54c650d6d5d801addf ]

Similarly to the previous patch, we need to safe guard hfsc_dequeue()
too. But for this one, we don't have a reliable reproducer.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20250417184732.943057-3-xiyou.wangcong@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_hfsc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index e730d3f791c24..5bb4ab9941d6e 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1637,10 +1637,16 @@ hfsc_dequeue(struct Qdisc *sch)
 		if (cl->qdisc->q.qlen != 0) {
 			/* update ed */
 			next_len = qdisc_peek_len(cl->qdisc);
-			if (realtime)
-				update_ed(cl, next_len);
-			else
-				update_d(cl, next_len);
+			/* Check queue length again since some qdisc implementations
+			 * (e.g., netem/codel) might empty the queue during the peek
+			 * operation.
+			 */
+			if (cl->qdisc->q.qlen != 0) {
+				if (realtime)
+					update_ed(cl, next_len);
+				else
+					update_d(cl, next_len);
+			}
 		} else {
 			/* the class becomes passive */
 			eltree_remove(cl);
-- 
2.39.5




