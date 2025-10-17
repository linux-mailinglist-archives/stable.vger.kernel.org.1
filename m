Return-Path: <stable+bounces-187483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F8CBEA465
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A111A63A31
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A41C330B2E;
	Fri, 17 Oct 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YKS6eIKm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56077330B0C;
	Fri, 17 Oct 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716201; cv=none; b=mBYlXcqqoKv8kL0+N7LQE4/4rdtYq8R5Z3NMrAfIbtfN9J1qSlYRBM/wZR6h9X37etDfJSHku/q3HqKM+oIfESeJN6h1H1bxTaH2nvn/44Xc9RjIS//whbnZS0Kz6J+ElvBZcMFssO6e4FXZFUg0OXPmMmslcuSPmnl+po/zLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716201; c=relaxed/simple;
	bh=J2NYzIGkNnCekAoEWsR9yadPdFTadGAb/6cihk5/IUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcjNpgcymN01Qf6xdDMIqVX4vDofp0DruunRkMcm0gY3nTvij9BPsUi0C7l4VydBPLLP1Bp5wzN/OwbihYG2JRhrEwZzfBRXe828ooNjH3ROStDP6wDueru0ihzEa2M7tmFYSQEAVTX4PapAy80M94/HWAU4AY472WMq9J4fp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YKS6eIKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D4DC4CEE7;
	Fri, 17 Oct 2025 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716201;
	bh=J2NYzIGkNnCekAoEWsR9yadPdFTadGAb/6cihk5/IUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKS6eIKmF7ETcBpEpU48VUR/N91Q2C7FZG6LGBkQcFG6vJrjQxaqRDjQX17kkgsHg
	 4BLZWZQY0jHWsafmbnmGJ/AoAqkhvlBhB5nkOtKJoRQmz96zS0HmMClaf3203VByOa
	 4B0HHWUzcSxGhpCUlrxb8W+oTc2YYlO34/aWUaZ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 076/276] RDMA/cm: Rate limit destroy CM ID timeout error message
Date: Fri, 17 Oct 2025 16:52:49 +0200
Message-ID: <20251017145145.261699840@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Håkon Bugge <haakon.bugge@oracle.com>

[ Upstream commit 2bbe1255fcf19c5eb300efb6cb5ad98d66fdae2e ]

When the destroy CM ID timeout kicks in, you typically get a storm of
them which creates a log flooding. Hence, change pr_err() to
pr_err_ratelimited() in cm_destroy_id_wait_timeout().

Fixes: 96d9cbe2f2ff ("RDMA/cm: add timeout to cm_destroy_id wait")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Link: https://patch.msgid.link/20250912100525.531102-1-haakon.bugge@oracle.com
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 96e00e86ebbf6..5dc864cec9f83 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1039,8 +1039,8 @@ static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id,
 	struct cm_id_private *cm_id_priv;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	pr_err("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
-	       cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
+	pr_err_ratelimited("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
+			   cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
 }
 
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
-- 
2.51.0




