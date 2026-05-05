Return-Path: <stable+bounces-243963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEbWOeR5+Wnz8wIAu9opvQ
	(envelope-from <stable+bounces-243963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:02:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640EA4C6A4D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D45E4302A4CB
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72E33C6A2B;
	Tue,  5 May 2026 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS/YzVQ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA73C0621
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957208; cv=none; b=EJJSzUKP7QlPVhedVUDcVkb5g/uYuBEWbBgsqvfiiEzczWrLh2X1uLFCY7Sq9XNhTUaVa9zA0ljTVulGOXS6jxZYb6lVqr7JN1kEKDmCCaCkfnHgfhr1s0Qxn0Y1/wk9MHJZTBEvnBKdNdbLtP30v6ftv94D1uCg5pD5jg3sC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957208; c=relaxed/simple;
	bh=sft4S321VXYeqpilqeEW/bXaAPzvEQnvHkltC7Lc9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAwgZ+7s6B/ZkONaw0ptbSdtoHuKpuq29BwPo69Q8UxNtEL5gjDWw59234cGRU9EfhdG95Hk4/6zwCVdJN1EsgFHMDdam27K+IRysI1GRxL4PgFG7GhE5L4Dptbt5N3j12t+4KtDg++ulQmMOw6OvVPz1rIv5DxfzxQ/iJPbJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS/YzVQ3; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12dfbcc0703so5023229c88.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 22:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957206; x=1778562006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfrP/YM0+QiNPfuc4aJ75FAml9M4/b1GGe/ogCrwC90=;
        b=TS/YzVQ3KQggpsfMRejtSuYZZ4MdWX1978dKyKjVmjBuKAPo5fBzw8L1gASukjooep
         sCITxThjCXQj2RFkRsB0QzaofpSGu0s4n/qLO4ZCNO3BvnQBfy4Aib8ou/uOraHCyeNT
         eogFOIAo88vqjXVbeVQl7zg4WV8RZIbNZVKRZmxaOjZzSY36HbdrqZfFVLBlAC1nTPpP
         UQdbMhXv4+ejW46ya8YJ9QZ/KKXV5lxWRsP97o1YQ1tZdLJNicpTLBXGc15bI7emyn/7
         DdLGt3RsShJ21nJJYrZm3CNFCd+UxUHIpEb73Jw5I+JkXI0KBFSvFuJxgil1AwBwcDwq
         SxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957206; x=1778562006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfrP/YM0+QiNPfuc4aJ75FAml9M4/b1GGe/ogCrwC90=;
        b=ckxEssg0s0dmViWQF56LfnmWsxNCHsjTpfl4bHw3anKOyrU462/a6pSLiYbkEGOX+/
         thGuagqzIcVwyye1FECAPMfMCDtG+qwxpycMCHXHd2ukN8vdaqaX5HmbS2LRPffCmwQM
         cS78t7yXq5odA7tRUoFy5/kOGULMh4YLTeWuUZrrbYwXojmsh7FTXTjno8uFMnILTtyo
         /9dvZ5H7LqHrjFWqAqRkqspPSf1rgITI5tta+QvJ7y+mU26Wm9OerEwj6d/8nDAmDtHt
         WanIs1jNZwmv+Va6SfEG5MA1K5mm+RBwAWUNOuA5bSepmKRXwMRmS38KSj4ZMnkMU25U
         l7xg==
X-Forwarded-Encrypted: i=1; AFNElJ9YnIH15GOq38wTGJ433nzfiGrwgQu8UcJc1iiugX/5jG9Lnkb0bwJrqMS3xXLJHecF/BvmEBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTd4MK6zzs0lUTnXvTxxmDuw2i4rIwEflGCrPu6qTqSNijBNag
	v6KaB7TuArs/10AXBKdNsd6eEWqSZceEclBXBAuCYpWPd/tVdMJHdVWH
X-Gm-Gg: AeBDievaTH9HUXh/u0Qho/jio27izn4E+POVs2W92n11hgv2jxtPTcyOs6+Dhse2R6S
	J3z452rI+4uhwzLbQgn8yMCdyAmhaKnUKgyD+N5Rfn3XDlnc8gB5jfC0BVCbiP8akldbKqkBhkc
	JfdaZpGQQJzSRpnjnLstGABZ9OKsZA5QeJf16zm1+vsQzir/Nef+4pKGv5woMZdalubxirs8jrr
	wHMv3dCAsCbsYdWEzpkQCkXVB79ryKlHX4YcCapbOL4UiCs0zDh7Ec3xizQT/wPcU0RRQgha5Iq
	jgjNj3Pd7YBFnsClakIPy1q7F24HXFH1ZdlBOQ2T1ySZVFI7Jj61YE8AeOusQ6VnRwId/TXXUgL
	o37g9UMVe+pK3Bj0dtN6D4WV0ETBgTuXPQ1a4mBmQL+hWtqbryercL7wdgIufDfSXsYaoBvD7bV
	WkHcFPsWOzbfevF8CudACPAO+szI6hLTrFbcqmu1EchjVOH6Ax0iy9JJBbyPcVOUhM7uDntPwoG
	VSUhNe4/3JoQzFrcJYyGyn1D2wZx/LzrZTU
X-Received: by 2002:a05:7022:404:b0:12d:b7e5:a67b with SMTP id a92af1059eb24-12dfd7ca694mr6147437c88.14.1777957206409;
        Mon, 04 May 2026 22:00:06 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:05 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 06/20] Input: rmi4 - iterative IRQ handler
Date: Mon,  4 May 2026 21:59:36 -0700
Message-ID: <20260505045952.1570713-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 640EA4C6A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243963-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The current IRQ handler uses recursion to drain the attention FIFO,
which can lead to stack overflow on deep queues. Convert it to a
loop.

Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index d873c7f08e42..c2843c21f0b9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -198,24 +198,24 @@ static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
 	struct rmi4_attn_data attn_data = {0};
 	int ret, count;
 
-	count = kfifo_get(&drvdata->attn_fifo, &attn_data);
-	if (count) {
-		*(drvdata->irq_status) = attn_data.irq_status;
-		drvdata->attn_data = attn_data;
-	}
-
-	ret = rmi_process_interrupt_requests(rmi_dev);
-	if (ret)
-		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
-			"Failed to process interrupt request: %d\n", ret);
+	do {
+		count = kfifo_get(&drvdata->attn_fifo, &attn_data);
+		if (count) {
+			*drvdata->irq_status = attn_data.irq_status;
+			drvdata->attn_data = attn_data;
+		}
 
-	if (count) {
-		kfree(attn_data.data);
-		drvdata->attn_data.data = NULL;
-	}
+		ret = rmi_process_interrupt_requests(rmi_dev);
+		if (ret)
+			rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
+				"Failed to process interrupt request: %d\n",
+				ret);
 
-	if (!kfifo_is_empty(&drvdata->attn_fifo))
-		return rmi_irq_fn(irq, dev_id);
+		if (count) {
+			kfree(attn_data.data);
+			drvdata->attn_data.data = NULL;
+		}
+	} while (!kfifo_is_empty(&drvdata->attn_fifo));
 
 	return IRQ_HANDLED;
 }
-- 
2.54.0.545.g6539524ca2-goog


