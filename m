Return-Path: <stable+bounces-268446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nMEuCzUoPWpkyAgAu9opvQ
	(envelope-from <stable+bounces-268446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E046C5ECE
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zgj6Mb8x;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268446-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268446-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EBF7300B192
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79F32D94AF;
	Thu, 25 Jun 2026 13:08:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D152D060D;
	Thu, 25 Jun 2026 13:07:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392880; cv=none; b=cyocGGkr5DqQU6rh3FBJCUt07WyFaUnfvcspR+5C7dGxG1ZQ0l/xpmUH5ZY+DulSsJy1wc6NT3cr83Ry4rwESQIz4sAShDsGeKgg862kDc0VsAGmwgabYcvxG+5AB0jZQez8ADOjTvwrx2iSWQ8pcyskxC0I3KPZchHCtiAAGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392880; c=relaxed/simple;
	bh=V8ULyRPJAhmwNwtQ4DZuOENoigpH332yK2p+ZimXwSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjtEZKxlL1mmOnjMq5qx6by0JIn9Hm1XQ652Zx9c+7KL5/JV42psnkvfax367BugWktBKuKteEWX76Z5WeBYnAorIPLjkxQYjpxH0K2U4kIssDr1hrl8rGpKN/9sT44Z2mwJ7npwqD9j/KHeQrfdW31r2zSokpiRcXrW4wkaUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zgj6Mb8x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154E81F000E9;
	Thu, 25 Jun 2026 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392879;
	bh=Wjc9YGEjbG58PPBAhoM+aVkoM1qGMQ5dev9QtNU6zs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zgj6Mb8xCaeO85EvjFs8Jl8nR5iHjCQzwV5QbLAhipSo8M+Ri4EVQJOzpKNlLB9Ch
	 Rlf/XQ44VkWuNvO1tHhDFBpWBI1V8tYR5QpBy7glWq1xC55JN9BButfjaavn1chPNc
	 rnHUPRmd5Ur7JYbO04u6r4ukOa7mQ6p4keLH7TE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.18 51/60] Input: rmi4 - iterative IRQ handler
Date: Thu, 25 Jun 2026 14:03:36 +0100
Message-ID: <20260625125653.192425947@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268446-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dmitry.torokhov@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3E046C5ECE

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit b6ca982afd0e8fbcbb340092d3c6d3b4a217686c upstream.

The current IRQ handler uses recursion to drain the attention FIFO,
which can lead to stack overflow on deep queues. Convert it to a
loop.

Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Link: https://patch.msgid.link/20260505045952.1570713-6-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/rmi4/rmi_driver.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -198,24 +198,24 @@ static irqreturn_t rmi_irq_fn(int irq, v
 	struct rmi4_attn_data attn_data = {0};
 	int ret, count;
 
-	count = kfifo_get(&drvdata->attn_fifo, &attn_data);
-	if (count) {
-		*(drvdata->irq_status) = attn_data.irq_status;
-		drvdata->attn_data = attn_data;
-	}
+	do {
+		count = kfifo_get(&drvdata->attn_fifo, &attn_data);
+		if (count) {
+			*drvdata->irq_status = attn_data.irq_status;
+			drvdata->attn_data = attn_data;
+		}
 
-	ret = rmi_process_interrupt_requests(rmi_dev);
-	if (ret)
-		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
-			"Failed to process interrupt request: %d\n", ret);
+		ret = rmi_process_interrupt_requests(rmi_dev);
+		if (ret)
+			rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
+				"Failed to process interrupt request: %d\n",
+				ret);
 
-	if (count) {
-		kfree(attn_data.data);
-		drvdata->attn_data.data = NULL;
-	}
-
-	if (!kfifo_is_empty(&drvdata->attn_fifo))
-		return rmi_irq_fn(irq, dev_id);
+		if (count) {
+			kfree(attn_data.data);
+			drvdata->attn_data.data = NULL;
+		}
+	} while (!kfifo_is_empty(&drvdata->attn_fifo));
 
 	return IRQ_HANDLED;
 }



