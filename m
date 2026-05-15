Return-Path: <stable+bounces-248832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEWhLhZQB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:55:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 644EC554350
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 660F930F591A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D63EFFC9;
	Fri, 15 May 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="NdQSdj/F"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25233F58EF
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862746; cv=none; b=LCv5ceIQLdvKoq/wfUFm6cGWs5EF+MLnI5iliJcFuAMJBdYxR0c2vQf6/StS38MHJ+HUkaw/aZYix9RN6R8s5rcagB59XlpiSX2nUDJkGiJx96eFj7HNv4IaeUVv/xSGaq+RJVtSNeSAqnDmiszAvGC7kJSZkzv4Tn49eYUvt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862746; c=relaxed/simple;
	bh=GXwOY7VfcWvuc6sber8bmSrdUzlp97IgLJ/kAbmBURI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdMGEp+EjzzUqFB2R7Lkp6ZNYFINLW6tEfzAyRjuAUApiZDZzbcW+HVCNcS6vD5z1cKReLfSSMbTBI52LSn0BF8zTRWEjEMsZMz+7wn/Bbv8rImDOjYcriZYYFy46Da1wru4upLXwhDgT4XV1/w2+1qT8X9297y1la0HSfUKk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=NdQSdj/F; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-435153d9b68so6103874fac.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778862744; x=1779467544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yZD+FfEMr9LyOWaWHNwRUeTqm6rHNyodryqhK/S00A=;
        b=NdQSdj/F8LoYJFzD5JoZAE8yZ5ZdGbgSuAMVbXPBK+Zn0hho56srEUksG1nPm3hbFQ
         Z+XRwfy90zhiNIEWvpvYqzyeY2ZjxTplT4wtMMjrJrwOdc7WTq0xhHEZ81xZqqAj6zQe
         f3iej6rGmpx5fBiUYmH+DjZhZC/noI2C3Tt9xvg0RZ/s83bty+kBLIqHdl/oc0Ld3P8t
         0uCyUK1KF7f4br5IeKBR4fGzV2/U5CJaEtERhqIIDtqyRtEoo7DIfDoHRRoi4dQl9VTO
         l6FQpKb/YV4s7l46JM8t74MNQpsHgLsRLenYCqmdHlf3AbRCBon0rXp05co3ujHtG6G2
         /FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862744; x=1779467544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yZD+FfEMr9LyOWaWHNwRUeTqm6rHNyodryqhK/S00A=;
        b=AOefzpjriHxSGIEz5FarPvXPnEnLvTde3iRqedVjkyMIBdiZ6y8nlf9stfjn6Pa5WK
         QDstzLD1QxA6nQ3ah/RGqEeV3V/2ZiEa/EQhmVf07qzDgGPNOfE6z796dnHL5nbW8KB2
         /cLdaoE5azYgh/1eZFDOljhG/vZ5iR5KCOW4PT5P6q1BSaPWZQqundMJv0+6k8XhYlZ/
         V8mPhjUeH3DoXoyb+EmTdD5Y8k5xslGMhiiknwWQ95hPHSJVqXkeARXIyiNFeMKVz57S
         WHG9rJVHvhT5i656c7uAp3+LvI/XllCVQaQ0Qa5npAxeEv4at9MCrad7NQIG4hWdLPfv
         E1PA==
X-Gm-Message-State: AOJu0YztuP2N2fkdDFpIojXnAE9+C19i+fM2CoTOXemaITaL3X4GcVp7
	lH/7RXOYZTU8DhrDfeDtl9+b81Ydt3LI1fw6kipxuLfY57t09rjDBxqTdT21BgaFpSqAXteXM9H
	ryxIF
X-Gm-Gg: Acq92OGywbtYvb74/tXx36RYz7bfiALjLLRC4ixil1a60LPbyNg/QdkEGgwC12Hq74H
	LdcBXRoTUEsTE0r8TgvpfmKtxkq76qRgatdodgci/xF8ZdHYQDBPpyx0LFMS7Opgi6hB+xHyZcq
	L1RPuDUXjAg9HXX/41LcdL6u3VP4a7ojRCDjokPR0gsebmkZTHRCELXKpP7GiDYx4fSubGsKMrV
	OdXiV5f/xXPojWdhmVE7/s1y/wYGrNoDe1JdVO6KJye3g5/5CSI38LsqZHTCewagozJUwQSUwYQ
	VEobBG00NgnWbyUtR9tGDuep9Bk57q/HzG/ru/wtSr6iSzp5w5dyS+eSB0qw10AHokmY38Xfv8a
	Fe3Yue7PSQNYjc556zsG+u9O0MDv9GPmTcgeweR/Bq3qzLjZkl0GHKGhOP18otgorTjm0oepXTh
	nEe1iGm3e+O8bUIEgWE/eI88JAOHQl0LT/+Lc/5TrCS9O8dv8vdTKXpMSY94DV1donfjAvdFjoX
	Q/6
X-Received: by 2002:a05:6870:3343:b0:439:f6d8:459e with SMTP id 586e51a60fabf-43a2dd8f096mr3240208fac.31.1778862743569;
        Fri, 15 May 2026 09:32:23 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:5de0:f9c5:a427:bb0])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-439fc54217esm4347097fac.13.2026.05.15.09.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:32:23 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.15.y 1/2] ipmi:ssif: Remove unnecessary indention
Date: Fri, 15 May 2026 11:32:18 -0500
Message-ID: <20260515163219.2279960-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026051541-going-septic-6fe5@gregkh>
References: <2026051541-going-septic-6fe5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 644EC554350
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248832-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,minyard.net:email,minyard.net:mid,minyard.net:dkim]
X-Rspamd-Action: no action

A section was in {} that didn't need to be, move the variable
definition to the top and set th eindentino properly.

Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit 91eb7ec7261254b6875909df767185838598e21e)
---
 drivers/char/ipmi/ipmi_ssif.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 30f757249c5c..266a5f223739 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1664,6 +1664,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int               len;
 	int               i;
 	u8		  slave_addr = 0;
+	unsigned int      thread_num;
 	struct ssif_addr_info *addr_info = NULL;
 
 	mutex_lock(&ssif_infos_mutex);
@@ -1872,22 +1873,17 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
-- 
2.43.0


