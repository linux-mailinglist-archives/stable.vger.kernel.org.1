Return-Path: <stable+bounces-210209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7FFD397C1
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 610793001828
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82822B8C5;
	Sun, 18 Jan 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QaaTQpI7"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C822652D
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768752985; cv=none; b=V5m0BTU+mLQjUORPk9q1NAnFznTbA5AtlxlPFTK4bl1kk6f8GP/gH4Xxr0TbcaLASkDWDTlJqiqfsEVALahn5w5OBGCdQSs8/u8LxdC/dBLfm7nX4hfvZSa4S3l3uF8T27S1jqmIcsW0/lkuPWP68gygrEimrzuFZVOM/iMKpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768752985; c=relaxed/simple;
	bh=WShuIAPyE68nfy0UjiL2DWEKFe79X2KK4RQCP1VjDNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsTkw0UF38NPZv4UO1pxuluCy0nCHUQRJz2GrkIjrmuWIf4eAdUUzqid8UufwzQ4OBaM65QFzc9epbO715X6yhOlZqqYhBx3n376x3lgmog6U1ZJ3sBTHwd590Y6L6yvQh/6gP7OuvKGvJzYT309egbKcu+NEWjsSD8uHg/cmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QaaTQpI7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768752982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T65OoKpCdEFFVP2+DiaAhKdFuag7lvxT1ZvELnGzBuM=;
	b=QaaTQpI7xNuksLfCVIXEbWERu4VfCtboEZpuLTLhQhW8yyecLZ9cRKRRqke6VUGsPprvQE
	/cYusvTj6yhK+bWdHHDRIzr+F957lDFPK/l9bjSoVIGD4430Y8aMlfOatOZjPL8OwBGd1M
	M/OvwmXA5Iu1jdBIU2qAGLg448XkXAc=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.6 1/3] net: napi_schedule_rps() cleanup
Date: Mon, 19 Jan 2026 00:15:44 +0800
Message-Id: <72f1345baff9fe5a296915d4b5a7a18bd304df68.1768751557.git.wen.yang@linux.dev>
In-Reply-To: <cover.1768751557.git.wen.yang@linux.dev>
References: <cover.1768751557.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Eric Dumazet <edumazet@google.com>

commit 8fcb76b934daff12cde76adeab3d502eeb0734b1 upstream.

napi_schedule_rps() return value is ignored, remove it.

Change the comment to clarify the intent.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 114fc8bc37f8..e35f41e75bdd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4684,11 +4684,18 @@ static void trigger_rx_softirq(void *data)
 }
 
 /*
- * Check if this softnet_data structure is another cpu one
- * If yes, queue it to our IPI list and return 1
- * If no, return 0
+ * After we queued a packet into sd->input_pkt_queue,
+ * we need to make sure this queue is serviced soon.
+ *
+ * - If this is another cpu queue, link it to our rps_ipi_list,
+ *   and make sure we will process rps_ipi_list from net_rx_action().
+ *   As we do not know yet if we are called from net_rx_action(),
+ *   we have to raise NET_RX_SOFTIRQ. This might change in the future.
+ *
+ * - If this is our own queue, NAPI schedule our backlog.
+ *   Note that this also raises NET_RX_SOFTIRQ.
  */
-static int napi_schedule_rps(struct softnet_data *sd)
+static void napi_schedule_rps(struct softnet_data *sd)
 {
 	struct softnet_data *mysd = this_cpu_ptr(&softnet_data);
 
@@ -4698,11 +4705,10 @@ static int napi_schedule_rps(struct softnet_data *sd)
 		mysd->rps_ipi_list = sd;
 
 		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-		return 1;
+		return;
 	}
 #endif /* CONFIG_RPS */
 	__napi_schedule_irqoff(&mysd->backlog);
-	return 0;
 }
 
 #ifdef CONFIG_NET_FLOW_LIMIT
-- 
2.25.1


