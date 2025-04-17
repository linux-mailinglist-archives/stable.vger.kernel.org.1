Return-Path: <stable+bounces-134499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5370FA92C5E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 22:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F23A1B66654
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111F209696;
	Thu, 17 Apr 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYdpGqAx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F11FECB0
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744922614; cv=none; b=bM5C90OGDw9wPjg27jyg2mrWlnwpEZerPM5DKd86VTQT2ycvl+A5mAz2SLMOvlcv2sSYXX4M413HYwoytDpTmyDhs3TdvDIcoLWmMCNPBtfQcoMXgoa5jnpHkgt3ZRT70Na6rSllo9xZlHHbxnvRmOdY9SlCnfKk8yRuLjdWN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744922614; c=relaxed/simple;
	bh=fiSOCkZkRTdR8cHc0tvwIUCJOYyJJXWTQRwg9usydW4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gzra/+8fy5NzkDlB7sClUl4OVseBwvM5XmotZk+6WzxOMtyKw0/21dyX3f0R9kNwDSYsjKHMY8QRZIeClFvjZuzKi+LGUAHsiyun6G/bGETakJPLoKHxFE64ostkRqPUFagXd6xHFNEX2UG5oKrwf2wU7P/G88ttncr0Vw5JRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYdpGqAx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739525d4d7bso935013b3a.2
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744922611; x=1745527411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1/JDlXneWWZC3xltppKONbP6qd+NYnpw+86hE3rSx3E=;
        b=NYdpGqAxd9UAdbmpIkBFsuo0BVn9ng+hjY0WxPlWeHdeJTvNkl4RPTQH3PWro1SYLX
         SVSoKMW75o1Qn0vwFPDed5fwYxA3mLBk4SRc5eyzZgK1t4T1DrUbvZ1I3MSgBSYll5t4
         Wc07FDEbIRRNIqGbTuErWhg8jX5dSnIIlSQ5B1Qz4Vgg80h/bBDDCJ1oqEKLYNzpIVJs
         LjQvvXDltqBMViOdu07C9Ww1I8fMQ9PH0hBsrFLlWB23SrhVOZp324yyHTpTZTu2fjaE
         jmRWrgLf8vl80oIkEL0oKfn8Hqw1cwFfBN6IMs2/zUDkJZUxD32Rn/1HSdUK6t1rps4f
         bAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744922611; x=1745527411;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/JDlXneWWZC3xltppKONbP6qd+NYnpw+86hE3rSx3E=;
        b=RBurYdP6RvTdOwtJiuHiyM/fSf2EAjShb1Xkji4gmeJ40YRkCS/Z6mTMyfBpV+P3Ph
         ZAQd2AH68WF95QLRSCb4irG0prq9XVjBU9M7yJwMBWWi5NIod+kR3x6im+ZZrPTnDCCF
         FQp00UuYcNT+ZiN3s8OdbY1BWqlztAX5UW2l7Xc46P/lci7GiJ8jc+bNYiqKNgF8JFzV
         2PDN/vJuDOFBQXmPupqjXV+0z1yNsfNxKR4AlwyZEPn01WI8xz+D9FXYoQ+J452p7kPE
         iCDjKDVrZI2xpmGOvubG8YB5VMQQhkz9LU6HrnfbvvLooZotMcZUudyIr+6LgyA2/5hR
         d6cA==
X-Forwarded-Encrypted: i=1; AJvYcCXw4E26zd04eZTT0I22YJvRUPsFHSMiLwGFyhpdQVSkNLG6L8vOwJP2PqEcagipLasLrQSnnKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmNmSPwwLSQ9DzA8pBS58OMyQSOw9VvgOHRJWh6YZfZPWwqRx
	abA0e0KNkTajccXBdWxMkkMR9pfCZn5vx1SXxPxld8mWWTNv+JZnmWnoULpOe2eCKrGstUVOUyJ
	Pw8hRj0PFCjoxJx0+hBtthA==
X-Google-Smtp-Source: AGHT+IE5SL4EpeE7JzWrfRW0SmzSeYst3uO+j8/0WVfUaJZiIWtHG5ORS2tFwrnzoHakyA3sQWphmDCWJiPSdlDU8w==
X-Received: from pfbfa9.prod.google.com ([2002:a05:6a00:2d09:b0:739:9e9:feea])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e1b:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-73dc1616d31mr318317b3a.24.1744922610980;
 Thu, 17 Apr 2025 13:43:30 -0700 (PDT)
Date: Thu, 17 Apr 2025 20:43:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417204323.3902669-1-hramamurthy@google.com>
Subject: [PATCH net] gve: Add adminq lock for creating and destroying multiple queues
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pkaligineedi@google.com, willemb@google.com, ziweixiao@google.com, 
	shailend@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

The original adminq lock is only protecting the gve_adminq_execute_cmd
which is aimed for sending out single adminq command. However, there are
other callers of gve_adminq_kick_and_wait and gve_adminq_issue_cmd that
need to take the mutex lock for mutual exclusion between them, which are
creating and destroying rx/tx queues. Add the adminq lock for those
unprotected callers.

Also this patch cleans up the error handling code of
gve_adminq_destroy_tx_queue.

Cc: stable@vger.kernel.org
Fixes: 1108566ca509 ("gve: Add adminq mutex lock")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 54 ++++++++++++++------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 3e8fc33cc11f..659460812276 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -442,6 +442,8 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
 	int tail, head;
 	int i;
 
+	lockdep_assert_held(&priv->adminq_lock);
+
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head = priv->adminq_prod_cnt;
 
@@ -467,9 +469,6 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
 	return 0;
 }
 
-/* This function is not threadsafe - the caller is responsible for any
- * necessary locks.
- */
 static int gve_adminq_issue_cmd(struct gve_priv *priv,
 				union gve_adminq_command *cmd_orig)
 {
@@ -477,6 +476,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	u32 opcode;
 	u32 tail;
 
+	lockdep_assert_held(&priv->adminq_lock);
+
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 
 	// Check if next command will overflow the buffer.
@@ -709,13 +710,19 @@ int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_que
 	int err;
 	int i;
 
+	mutex_lock(&priv->adminq_lock);
+
 	for (i = start_id; i < start_id + num_queues; i++) {
 		err = gve_adminq_create_tx_queue(priv, i);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
@@ -788,19 +795,24 @@ int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues)
 	int err;
 	int i;
 
+	mutex_lock(&priv->adminq_lock);
+
 	for (i = 0; i < num_queues; i++) {
 		err = gve_adminq_create_rx_queue(priv, i);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
 {
 	union gve_adminq_command cmd;
-	int err;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode = cpu_to_be32(GVE_ADMINQ_DESTROY_TX_QUEUE);
@@ -808,11 +820,7 @@ static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
 		.queue_id = cpu_to_be32(queue_index),
 	};
 
-	err = gve_adminq_issue_cmd(priv, &cmd);
-	if (err)
-		return err;
-
-	return 0;
+	return gve_adminq_issue_cmd(priv, &cmd);
 }
 
 int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues)
@@ -820,13 +828,19 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_qu
 	int err;
 	int i;
 
+	mutex_lock(&priv->adminq_lock);
+
 	for (i = start_id; i < start_id + num_queues; i++) {
 		err = gve_adminq_destroy_tx_queue(priv, i);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static void gve_adminq_make_destroy_rx_queue_cmd(union gve_adminq_command *cmd,
@@ -861,13 +875,19 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 	int err;
 	int i;
 
+	mutex_lock(&priv->adminq_lock);
+
 	for (i = 0; i < num_queues; i++) {
 		err = gve_adminq_destroy_rx_queue(priv, i);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static void gve_set_default_desc_cnt(struct gve_priv *priv,
-- 
2.49.0.777.g153de2bbd5-goog


