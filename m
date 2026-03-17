Return-Path: <stable+bounces-226523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNW9AP6JuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6952AEEE7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92FDA3017BC6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE63F54CC;
	Tue, 17 Mar 2026 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWF+p/cA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F93F54BE
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767076; cv=none; b=qCsXTGNJsddK30jJhjHyBWVcZqYaJB4XZt2P2D3T7QsDWKC8ODnN5upVIm2WnoD5iBW/AGLL7agrYKloPQ59FY+ufFu43/0+4rc/IIOaLo2yXbpa4zEYlsba+owAY+vDyZxha73J64V3fPFf96+fZq+G+hUVT5c9SIpRcJpgcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767076; c=relaxed/simple;
	bh=KzDWJT9I0vtami5eK11RZ4h42ZQbNR9iAAlnQJT+oMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVUKWiFgmM86t+fO47zH45q+iWZFtsjoUnn28g2l5Qt498lnWybq0xxCA3xtKE5Zh+avAZouwGdhhYmJgIuKcC/qxfDdNnQiInJAMpUiheCB9j0wCoELSBkBnGdoNW3214YoEM4Cj1s4wwHmvscaISkNZDk7DugfEtUIrx5Mdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWF+p/cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3ABC19424;
	Tue, 17 Mar 2026 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767075;
	bh=KzDWJT9I0vtami5eK11RZ4h42ZQbNR9iAAlnQJT+oMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWF+p/cABVmTqJAsAYIUzQRzeEZEDY3tkCvHrzPbQNbaUNk4yPB/3zmt97LR0rRgA
	 Dz/ffRht4CJcUcLbU9XFBqzikZttLIlPYKd/bbW1lUJntC4p6fxXGmDqldIQrD3XSo
	 Li1sZmVE1iZodN1S4l2fFV9SpN7LDNQ6rw09D+Qj+n8u30lxn1aY3krgTD+LgMU3yw
	 sujPiyW4/W2rgIBhmH3r1Zt4yUVHqkSS4dgypFywRRY8kzEQY00V2rZ91Pq1hR1eEH
	 Fzbesbu9XxU0BByyt2aMaCcdWqWNbdeVqRPLcgSMOFdzZ05Zr3Icj3qBalwZdy6p9f
	 Pd+lOwSZRmy/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ipmi: Consolidate the run to completion checking for xmit msgs lock
Date: Tue, 17 Mar 2026 13:04:31 -0400
Message-ID: <20260317170432.230720-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031714-symptom-calculate-bec2@gregkh>
References: <2026031714-symptom-calculate-bec2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226523-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C6952AEEE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Corey Minyard <corey@minyard.net>

[ Upstream commit 1d90e6c1a56f6ab83e5c9d30ded19e7ac8155713 ]

It made things hard to read, move the check to a function.

Signed-off-by: Corey Minyard <corey@minyard.net>
Reviewed-by: Breno Leitao <leitao@debian.org>
Stable-dep-of: 62cd145453d5 ("ipmi:msghandler: Handle error returns from the SMI sender")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 42 ++++++++++++++++-------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 5ed8e95589fb7..44135b3a66435 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -602,6 +602,22 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 static int __scan_channels(struct ipmi_smi *intf,
 				struct ipmi_device_id *id, bool rescan);
 
+static void ipmi_lock_xmit_msgs(struct ipmi_smi *intf, int run_to_completion,
+				unsigned long *flags)
+{
+	if (run_to_completion)
+		return;
+	spin_lock_irqsave(&intf->xmit_msgs_lock, *flags);
+}
+
+static void ipmi_unlock_xmit_msgs(struct ipmi_smi *intf, int run_to_completion,
+				  unsigned long *flags)
+{
+	if (run_to_completion)
+		return;
+	spin_unlock_irqrestore(&intf->xmit_msgs_lock, *flags);
+}
+
 static void free_ipmi_user(struct kref *ref)
 {
 	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
@@ -1878,11 +1894,9 @@ static void smi_send(struct ipmi_smi *intf,
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
 	unsigned long flags = 0;
 
-	if (!run_to_completion)
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	smi_msg = smi_add_send_msg(intf, smi_msg, priority);
-	if (!run_to_completion)
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
 	if (smi_msg)
 		handlers->sender(intf->send_info, smi_msg);
@@ -4822,8 +4836,7 @@ static void smi_work(struct work_struct *t)
 	 * message delivery.
 	 */
 restart:
-	if (!run_to_completion)
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	if (intf->curr_msg == NULL && !intf->in_shutdown) {
 		struct list_head *entry = NULL;
 
@@ -4839,8 +4852,7 @@ static void smi_work(struct work_struct *t)
 			intf->curr_msg = newmsg;
 		}
 	}
-	if (!run_to_completion)
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
 	if (newmsg) {
 		cc = intf->handlers->sender(intf->send_info, newmsg);
@@ -4848,13 +4860,9 @@ static void smi_work(struct work_struct *t)
 			if (newmsg->recv_msg)
 				deliver_err_response(intf,
 						     newmsg->recv_msg, cc);
-			if (!run_to_completion)
-				spin_lock_irqsave(&intf->xmit_msgs_lock,
-						  flags);
+			ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 			intf->curr_msg = NULL;
-			if (!run_to_completion)
-				spin_unlock_irqrestore(&intf->xmit_msgs_lock,
-						       flags);
+			ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 			ipmi_free_smi_msg(newmsg);
 			newmsg = NULL;
 			goto restart;
@@ -4924,16 +4932,14 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
 		spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
 				       flags);
 
-	if (!run_to_completion)
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	/*
 	 * We can get an asynchronous event or receive message in addition
 	 * to commands we send.
 	 */
 	if (msg == intf->curr_msg)
 		intf->curr_msg = NULL;
-	if (!run_to_completion)
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
 	if (run_to_completion)
 		smi_work(&intf->smi_work);
-- 
2.51.0


