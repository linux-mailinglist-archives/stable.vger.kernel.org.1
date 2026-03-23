Return-Path: <stable+bounces-228255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGTGGKxRwWnqSAQAu9opvQ
	(envelope-from <stable+bounces-228255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:43:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D59672F5121
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C9231F2301
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81333B8BB2;
	Mon, 23 Mar 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CoYDYRVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5F3B895A;
	Mon, 23 Mar 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274596; cv=none; b=jKzxTzmaHHeJNMlmabqnx5lLmo0yWD0ddfDALbG8xTW5cpJJhve4ntVnFLTPwWx/2sYwnksQTB5h4zyi6eJyDPnI8EA7bsA2kiUM7m1syZXurMfCzfXMMQZ6yCo6yQah2Z/8tri4oHoDVucYVL5kP02kl7bBxw4V6ncA7ibwcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274596; c=relaxed/simple;
	bh=Lc8NcHtdFmPJ9mUVMaoIyjQvJ3bxQCXI7jZ0fm1MoUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntq5ABpoTUld9jlJp/csfqUdIJbuoXpwYfn0rtVExL5mSZvDExARGukHy9I/eEgBukLA0GUVPpbUVtma9E25NTFn8hcERNxYTKsiQ5x4v2OlBtnzr1rEpOp8AEtvyoOVFqgtltbwQ2/W331d17CR3rllXTf7QgyPBtD6GS71xUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CoYDYRVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C51C2BC9E;
	Mon, 23 Mar 2026 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274596;
	bh=Lc8NcHtdFmPJ9mUVMaoIyjQvJ3bxQCXI7jZ0fm1MoUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoYDYRVt01WY9sjFGhpnU9hLoJaX6MYVHIEEgi+dGVF9+k7R9oMtY2Y7Xtt05n94P
	 F7YSSYzXFsO/aFZcObEbNmKyceotIfW5IacjN61BLt8zrD61yW+KP0NEQmoi0/XExH
	 GYgBceNFDwIYkR1GVRAxsg2jUzJXEth9LI1Y+uK8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Corey Minyard <corey@minyard.net>,
	Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 048/212] ipmi: Consolidate the run to completion checking for xmit msgs lock
Date: Mon, 23 Mar 2026 14:44:29 +0100
Message-ID: <20260323134505.290032736@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228255-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D59672F5121
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

[ Upstream commit 1d90e6c1a56f6ab83e5c9d30ded19e7ac8155713 ]

It made things hard to read, move the check to a function.

Signed-off-by: Corey Minyard <corey@minyard.net>
Reviewed-by: Breno Leitao <leitao@debian.org>
Stable-dep-of: 62cd145453d5 ("ipmi:msghandler: Handle error returns from the SMI sender")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_msghandler.c |   42 ++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -602,6 +602,22 @@ static int __ipmi_bmc_register(struct ip
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
@@ -1878,11 +1894,9 @@ static void smi_send(struct ipmi_smi *in
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
@@ -4822,8 +4836,7 @@ static void smi_work(struct work_struct
 	 * message delivery.
 	 */
 restart:
-	if (!run_to_completion)
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	ipmi_lock_xmit_msgs(intf, run_to_completion, &flags);
 	if (intf->curr_msg == NULL && !intf->in_shutdown) {
 		struct list_head *entry = NULL;
 
@@ -4839,8 +4852,7 @@ restart:
 			intf->curr_msg = newmsg;
 		}
 	}
-	if (!run_to_completion)
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+	ipmi_unlock_xmit_msgs(intf, run_to_completion, &flags);
 
 	if (newmsg) {
 		cc = intf->handlers->sender(intf->send_info, newmsg);
@@ -4848,13 +4860,9 @@ restart:
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
@@ -4924,16 +4932,14 @@ void ipmi_smi_msg_received(struct ipmi_s
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



