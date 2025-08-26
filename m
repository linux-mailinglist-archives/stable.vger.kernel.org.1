Return-Path: <stable+bounces-173723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFFB35E85
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B9561CA3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDA2284678;
	Tue, 26 Aug 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRViIRR9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD9200112;
	Tue, 26 Aug 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208989; cv=none; b=XeLHCwyEGu/WuCUSb5LhvsoKDqTqfamDgYdsvxRBbqCQglK2pma0Kp1Q8nTfANNn4Zb5LuWaC7Elbluhlv/AdyY+TyxQwzV7kMQg9Lsd0MZmdvlcQbWe20M0p4qzHVy7N0B9uE7g0Ag29SOwKsuoT/RVbprApy/eY4lLTFtUiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208989; c=relaxed/simple;
	bh=QCw1jTK37eysK0+2Nqvrx86Gk1wi2fgNOgFrSHak4uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOQu+M7qFilJ8gqXH2VUaHLVuFWcdNeRKZDZjozV/48BF/NAXQm9WrEKQAameTpXL7qd0AQxPckELFfttDiX4nzLGtDMYmK/Nc5Z7YRIKLK5oHtQlIgNNKXPYRzcS9+2FnM9umOG2jIiFxXMBSMFidsjmNNQDVCEgBwIzgABHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kRViIRR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446D7C4CEF4;
	Tue, 26 Aug 2025 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208989;
	bh=QCw1jTK37eysK0+2Nqvrx86Gk1wi2fgNOgFrSHak4uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRViIRR9MbCX+fOx/1fgPC7Mzr9k/Yp4zB3rXCFabrnxwM2AIAt9UCFkCuDRX4LlU
	 pwrMLcpqrg05YqOe05aGLNj/BOlAJpsezatxTf4V02HgMpYkZm3hfVeCPVBeMXpdzs
	 vDQ6IphCpiPgClEi2OSvmNajNXiTWZkBjJPrxK4M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 308/322] net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate
Date: Tue, 26 Aug 2025 13:12:03 +0200
Message-ID: <20250826110923.498136499@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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
index 1021681a5718..2c13de8bf16f 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -592,7 +592,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_class *cl, s64 *diff)
  */
 static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(cl->level || !cl->leaf.q || !cl->leaf.q->q.qlen);
+	WARN_ON(cl->level || !cl->leaf.q);
 
 	if (!cl->prio_activity) {
 		cl->prio_activity = 1 << cl->prio;
-- 
2.50.1




