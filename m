Return-Path: <stable+bounces-265782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +5KWBQyQMWovmwUAu9opvQ
	(envelope-from <stable+bounces-265782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:03:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627F8693C4B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:03:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uM5cALDc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265782-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265782-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A46833170639
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3853CF97E;
	Tue, 16 Jun 2026 18:02:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAE352007;
	Tue, 16 Jun 2026 18:02:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632953; cv=none; b=F0GmiGGxnCpItN7dxPlGs0rT/KGI6PnSBbKWpH5G+S6apwckzCB3SG7TJOn4vjjRnCh6+XroUJiuYgaLDrMRSyv5OpG7khla5xpFdthc+PDBbui8vo/OXAEy3uyja0dSgNNSlR3iYwU1jjvdr0RDdaKgsA6QFObF08y5Mz6O2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632953; c=relaxed/simple;
	bh=fVhKCgtkrbtUlGLhkCAvq1UXy6e35m9skgLvYyyn0Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zh1rlUFN/EoPYeJjEWFWVbnCCWwZyDaBAuaeyqIQgv8tjPB+2TwcBQ0Yvgsu23rFRfcNciM3w0iCKNd/qK0aIIMbdHHcOnXMu0Xvqz8XfIwsWqRv3yTOUjrNSjKW0udAI5t60VjZ8bfNsHU3lE3leqI4966wfg3pTHInIYVenLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uM5cALDc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE2B1F000E9;
	Tue, 16 Jun 2026 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632952;
	bh=/dJi4s0oZdZaG5JvOtT9H+6tExV/GKrV4qVEgRECHWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uM5cALDcCBlwN4nrj0+4YMWfxl4w6eqeWTLZs9ZSF01U05U3Pl76rITTihQ3mdpvx
	 n21h7suFiL+g8z2HOWvT7FOobIhpSOIhkR7wVsrA4Q5j8z1ls7QEiihkcEAYV4BfF8
	 LmOrY8CPn1JmUKGD9+GhCDy3aPt7dhk4NH3nU5I0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.1 507/522] ipmi:ssif: Remove unnecessary indention
Date: Tue, 16 Jun 2026 20:30:54 +0530
Message-ID: <20260616145149.470087171@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265782-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:corey@minyard.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,minyard.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 627F8693C4B

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

commit 91eb7ec7261254b6875909df767185838598e21e upstream.

A section was in {} that didn't need to be, move the variable
definition to the top and set th eindentino properly.

Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_ssif.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1670,6 +1670,7 @@ static int ssif_probe(struct i2c_client
 	int               len = 0;
 	int               i;
 	u8		  slave_addr = 0;
+	unsigned int      thread_num;
 	struct ssif_addr_info *addr_info = NULL;
 
 	mutex_lock(&ssif_infos_mutex);
@@ -1878,22 +1879,17 @@ static int ssif_probe(struct i2c_client
 	ssif_info->handlers.request_events = request_events;
 	ssif_info->handlers.set_need_watch = ssif_set_need_watch;
 
-	{
-		unsigned int thread_num;
-
-		thread_num = ((i2c_adapter_id(ssif_info->client->adapter)
-			       << 8) |
-			      ssif_info->client->addr);
-		init_completion(&ssif_info->wake_thread);
-		ssif_info->thread = kthread_run(ipmi_ssif_thread, ssif_info,
-					       "kssif%4.4x", thread_num);
-		if (IS_ERR(ssif_info->thread)) {
-			rv = PTR_ERR(ssif_info->thread);
-			dev_notice(&ssif_info->client->dev,
-				   "Could not start kernel thread: error %d\n",
-				   rv);
-			goto out;
-		}
+	thread_num = ((i2c_adapter_id(ssif_info->client->adapter) << 8) |
+		      ssif_info->client->addr);
+	init_completion(&ssif_info->wake_thread);
+	ssif_info->thread = kthread_run(ipmi_ssif_thread, ssif_info,
+					"kssif%4.4x", thread_num);
+	if (IS_ERR(ssif_info->thread)) {
+		rv = PTR_ERR(ssif_info->thread);
+		dev_notice(&ssif_info->client->dev,
+			   "Could not start kernel thread: error %d\n",
+			   rv);
+		goto out;
 	}
 
 	dev_set_drvdata(&ssif_info->client->dev, ssif_info);



