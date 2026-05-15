Return-Path: <stable+bounces-248206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMOqGwZLB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0A05537B0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE9C23199279
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE73F44CD;
	Fri, 15 May 2026 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="crq9587g"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46E3E7BC4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861146; cv=none; b=lFJObcj8jpXMS/ThecE9M9t1njUDoEWMFVdcq3IMgmCjGtGlcbMujIDsBXRrH8CrOVuqzKARY1J+LfLKKwVg+AH/A5L+wYA7G3ThFMCSmAfSOBVUgDTP2DUl9hsJGXI/WyAefC1lfFs/UHVUtJbOlYxzzdIF9Fgx045nEb+ih58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861146; c=relaxed/simple;
	bh=S7nmW61H9+nMxuW+0n6xzgniZ1tS2NmdwakFLGWr4JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmhkT9yobSqp7RTzaShOw3E78ubc5T2j4OrmIFZsXJeoEzzvxFEcv/Y+mkELIA05MSQrWwQWByFaOHewpXSmM4iBMHSR/0uYOhKfmX6CdLzOoFz72SKloQhKpoNCmZstrD3PyUQCJ2Nf5XjLO7B2vEH5hLBMNoT1muje3PkVjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=crq9587g; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbca22dbfeso5414205a34.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778861144; x=1779465944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNmnNWwYNlq1+0WNVpHNbEcI1Ifa9h4My5Raio47HEY=;
        b=crq9587gFc7ToU/CjwxZVJ4JCgHvVj1JlO6DiUZkgTEM9LNLjxZczOIw/ifexD1iHU
         p0RbbgdqOk3hsf/XB2XHvhxtpPSnaXA317xZ/X1P6/6SzvV4s1jyJvWc9txKufK+qzQM
         WyG9/KVleNYkCvaBWy/Af0/XbovlzKAiT4afE00pNvc4FtSWTgMDW3NSMr8Ir2e9YDsN
         4T+k88ibS5gTIVzCS3tWKqiP3hqAhOfihVZW2jov2yscgL3TQ4xvurb1lMfsizgUtKBb
         uuV8l9QGrwAuzLgZhaPDUbzKYsTtTMITRO9eMBcSit0NFG6hr38d51Cxj9sssUWVTtsS
         apZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861144; x=1779465944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gNmnNWwYNlq1+0WNVpHNbEcI1Ifa9h4My5Raio47HEY=;
        b=W6ZBRjc5+HFws+fGg/bN3YhvM3RWi4UYvXdV/WJ7Fdy4w7HaXIr//7D8XA13Bp+AeH
         J1Q83FByz79zPvAsSFQt0CzSVe/e3QGI1Vs1Fn98PizUon/hk1KCRf9owsH4ArOXKkOY
         ccuq/HLBcczqvfC5jq0reKhyBTVPoG/KmB4iQyUhOJPoK3YKjQM5/2Nq+1rd3A0S/1kk
         563WM00W9vWKeNM6WbniWabyC2l2DhwIRMtGPNP7BPdzACx7ADHKvSjMkOY8v5lOq1go
         lTq0Ur9mgcpOlainM3VZBzyDgLQv7tl8RWjfnYZVpCPDEpi3yD1/shbKFZ+IGAJ5NCYF
         AKpA==
X-Gm-Message-State: AOJu0Yx1C6UDV2ucPZMUQYQLukDrCW0flwNrsBEUTgo4/rja6WMkUWNX
	GcbtQhf0k2VeREZRrGvSj+t1yuntcp0NdFC99hy+oIQ69EBfdwk402ONKnwAC0grvnaw+58x9su
	OFUnH
X-Gm-Gg: Acq92OH/YI29ICGtqVkjl0sgvzlH8kXamwC3/AsxVbhw2AUdyAhSvPbeXiC/0Og1Cp9
	AS3pkrrlVMV4c2kzj49gaKmJ1tgQMIsfInKmiqpzDJQVx7xfZgWsYhp/ylVo9v/b12G9C46EwED
	YQNk2EHtEVwP3axHN54wu4u3TvrJfFLdH20lTs5WHKYqzoElvtar+TdXEHZ2rHqI791wpxbt2ey
	QH1Z2kX6FHwazin/zcQsiKxSVDq7dTmWjCYKptF4MmdFYWGfFjvZD6+dU+ZmfYUggWhKAP0PUm1
	PkVuoUoMVQd5CC7S8Ae0GPu2Ry9UiY/folTQMAdcPawXOUbboQ5R181JohreHMwYZqfyHzgKfCA
	nwx0P5XyfqzVqJrgo8gFm2zYE7U0/ZtENKnlzWdl7t1WQXttIgNVp63Krf/Gff9DlekkqmWQNcs
	2I5tjc2+qZVtCL59CWkFc6Igsqm+ggVmrKkZljAhAmzzJhMwfs5M8mG4m9u6VKoc0SknXIaOxoL
	8Rm
X-Received: by 2002:a05:6830:6408:b0:7dc:c7aa:22c7 with SMTP id 46e09a7af769-7e4de65c157mr2762889a34.0.1778861143470;
        Fri, 15 May 2026 09:05:43 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:5de0:f9c5:a427:bb0])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7e55bbd1a20sm1672924a34.14.2026.05.15.09.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:05:43 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.6.y 1/2] ipmi:ssif: Remove unnecessary indention
Date: Fri, 15 May 2026 11:04:20 -0500
Message-ID: <20260515160422.2057506-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026051540-path-mulled-0e19@gregkh>
References: <2026051540-path-mulled-0e19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A0A05537B0
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
	TAGGED_FROM(0.00)[bounces-248206-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:mid,minyard.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A section was in {} that didn't need to be, move the variable
definition to the top and set th eindentino properly.

Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit 91eb7ec7261254b6875909df767185838598e21e)
---
 drivers/char/ipmi/ipmi_ssif.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index df8dd50b4cbe..6ded3e51ff8b 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1650,6 +1650,7 @@ static int ssif_probe(struct i2c_client *client)
 	int               len = 0;
 	int               i;
 	u8		  slave_addr = 0;
+	unsigned int      thread_num;
 	struct ssif_addr_info *addr_info = NULL;
 
 	mutex_lock(&ssif_infos_mutex);
@@ -1858,22 +1859,17 @@ static int ssif_probe(struct i2c_client *client)
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


