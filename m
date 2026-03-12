Return-Path: <stable+bounces-225004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIkyKgAfs2l/SQAAu9opvQ
	(envelope-from <stable+bounces-225004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:16:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E21278AD1
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 746F13012BC8
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC727281D;
	Thu, 12 Mar 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mjVAz2kM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCC1FE451;
	Thu, 12 Mar 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346556; cv=none; b=eYDZvvPeTmNJdcfApS6gV9c6awKcNFb7m2xtkIp+NfqS3EmRRQglxtF/SYZoJxGzY5tY/6eB/qASmwqfS0wsQsQCFmRJmcEg6FQJnrPS0gzrVeidiLSUhnh0Vcc2qv4gYtclhqrxmWXK/H2HvfbNJsSmgnFAXmT2TExJBl8elL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346556; c=relaxed/simple;
	bh=XlmTbaloZPBGJjZSIWYbqPHurro3lHiZWf7/GTdHi4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ak1zkET25L3OCI14+8wU+omE9egrRnIq2KoXRlfP3J1KbZalba2RUDAPP6/714YyiRLoo5k3hrW6PN3O3XRIhF0FN1l6zawD9W2fqXETZKTSzXOIBMPq62FxcT016i6NdRyR9xSk+orlrby5Uk+0rMmioKi6LQgNIP5RbZO77hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mjVAz2kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC056C4CEF7;
	Thu, 12 Mar 2026 20:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346556;
	bh=XlmTbaloZPBGJjZSIWYbqPHurro3lHiZWf7/GTdHi4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjVAz2kMnyDpy95sc7LUjv09HOuk/e3uO1cnADBTZESoV06ffhn71Jo5cjXFXsGQO
	 N4nHcWIvsPX8nEzzD3jZ7NVriCiO1xVoS2WA5iSxhI/PxjvhXipWdrqm6cDraNPfM5
	 rUX9whCDTBPGibdkAeRl0JsxsspNUQXjxDBa2PRc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 070/265] mailbox: Use guard/scoped_guard for con_mutex
Date: Thu, 12 Mar 2026 21:07:37 +0100
Message-ID: <20260312201020.742632950@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225004-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,nxp.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 52E21278AD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 16da9a653c5bf5d97fb296420899fe9735aa9c3c ]

Use guard and scoped_guard for con_mutex to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Stable-dep-of: fcd7f96c7836 ("mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox.c | 61 +++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4c27de9514e55..7dcbca48d1a0f 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -6,6 +6,7 @@
  * Author: Jassi Brar <jassisinghbrar@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -370,13 +371,9 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
  */
 int mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 {
-	int ret;
-
-	mutex_lock(&con_mutex);
-	ret = __mbox_bind_client(chan, cl);
-	mutex_unlock(&con_mutex);
+	guard(mutex)(&con_mutex);
 
-	return ret;
+	return __mbox_bind_client(chan, cl);
 }
 EXPORT_SYMBOL_GPL(mbox_bind_client);
 
@@ -417,28 +414,25 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 		return ERR_PTR(ret);
 	}
 
-	mutex_lock(&con_mutex);
+	scoped_guard(mutex, &con_mutex) {
+		chan = ERR_PTR(-EPROBE_DEFER);
+		list_for_each_entry(mbox, &mbox_cons, node)
+			if (mbox->dev->of_node == spec.np) {
+				chan = mbox->of_xlate(mbox, &spec);
+				if (!IS_ERR(chan))
+					break;
+			}
 
-	chan = ERR_PTR(-EPROBE_DEFER);
-	list_for_each_entry(mbox, &mbox_cons, node)
-		if (mbox->dev->of_node == spec.np) {
-			chan = mbox->of_xlate(mbox, &spec);
-			if (!IS_ERR(chan))
-				break;
-		}
+		of_node_put(spec.np);
 
-	of_node_put(spec.np);
+		if (IS_ERR(chan))
+			return chan;
 
-	if (IS_ERR(chan)) {
-		mutex_unlock(&con_mutex);
-		return chan;
+		ret = __mbox_bind_client(chan, cl);
+		if (ret)
+			chan = ERR_PTR(ret);
 	}
 
-	ret = __mbox_bind_client(chan, cl);
-	if (ret)
-		chan = ERR_PTR(ret);
-
-	mutex_unlock(&con_mutex);
 	return chan;
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel);
@@ -549,9 +543,8 @@ int mbox_controller_register(struct mbox_controller *mbox)
 	if (!mbox->of_xlate)
 		mbox->of_xlate = of_mbox_index_xlate;
 
-	mutex_lock(&con_mutex);
-	list_add_tail(&mbox->node, &mbox_cons);
-	mutex_unlock(&con_mutex);
+	scoped_guard(mutex, &con_mutex)
+		list_add_tail(&mbox->node, &mbox_cons);
 
 	return 0;
 }
@@ -568,17 +561,15 @@ void mbox_controller_unregister(struct mbox_controller *mbox)
 	if (!mbox)
 		return;
 
-	mutex_lock(&con_mutex);
-
-	list_del(&mbox->node);
+	scoped_guard(mutex, &con_mutex) {
+		list_del(&mbox->node);
 
-	for (i = 0; i < mbox->num_chans; i++)
-		mbox_free_channel(&mbox->chans[i]);
+		for (i = 0; i < mbox->num_chans; i++)
+			mbox_free_channel(&mbox->chans[i]);
 
-	if (mbox->txdone_poll)
-		hrtimer_cancel(&mbox->poll_hrt);
-
-	mutex_unlock(&con_mutex);
+		if (mbox->txdone_poll)
+			hrtimer_cancel(&mbox->poll_hrt);
+	}
 }
 EXPORT_SYMBOL_GPL(mbox_controller_unregister);
 
-- 
2.51.0




