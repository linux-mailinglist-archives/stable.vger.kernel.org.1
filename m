Return-Path: <stable+bounces-248676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC/GMoxYB2pmzgIAu9opvQ
	(envelope-from <stable+bounces-248676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:31:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D25552BB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33D8D315D299
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B9D3C76A0;
	Fri, 15 May 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="owmWTNt3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE83CB2FD
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862344; cv=none; b=Yb85HLmz0+G+QgBLAyLjFeyfzKJ9KJJJiTt8IGMQXtdyr2ugWJenHwvgNVznmVNGlQawb2f2xgBY/LneuYbM9GbTlnY1Qc/5Kpjx/ZDWqFdAnnownaunI3XTWSyMdIXr2RXZtZYeFQjz5HHa0iT6oRsZeGIENzQAkbvLfd/lFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862344; c=relaxed/simple;
	bh=GXwOY7VfcWvuc6sber8bmSrdUzlp97IgLJ/kAbmBURI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCwcI3XFU2gc2k1+p888GKidf/Fu6dxAjtBzZ1I9+mOY3difI+e2vw6++0KG8TvhNSJOqagBdU8nqGf8XZpZyDXk/YsaVcE2Bk5x8ykxtVjMHAtB//Z7zoOuW9pmmvvbUc77NezFH+We6Llz0022ONA3hyZa3QvK/FwnGJYlFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=owmWTNt3; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dcdd1b492eso1514929a34.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778862342; x=1779467142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yZD+FfEMr9LyOWaWHNwRUeTqm6rHNyodryqhK/S00A=;
        b=owmWTNt38+ZAUDxJa2EblT52Bu4NsBMw7C2oKwulkqKL+aW732jwjk78MYeDfM02sK
         4xvYQvY0Ohunu3lpHgKi8/IVsrFfoOJ5QPMLEbS1nxYiiE/V/Kv6n8ebeF3ujxELgBAA
         WppWKj2/Ugt9rxAEEXMBpr9XvSLITIEJ+UQuEcUYDBqoPgeD9A4Ee7drksFb8zF2A+JT
         3NDp6o5LAl/WCmYdjA8hri30w79uuQEEzTO9rZ9p5UIiI1uzs1hWnVbvvHiSC4TUjXUo
         xCn1r7M55T4um7pnoqO9lqbQHqgGbeKNfo2i4g8lmWW5Hkj1fUdbdnjoFJFoM+oUWmVS
         qTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862342; x=1779467142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yZD+FfEMr9LyOWaWHNwRUeTqm6rHNyodryqhK/S00A=;
        b=K1XAzgzqJp+fzRnkpZxpez1y4/UGt3ydwFP9louM/Vg5fFkyPgepKfhEVL1r67DqBI
         dBsjruVajGUl1AbxZb6NFxXtfdrm3/EFlySzGvePqtiOtkHTKjI2zF1zSxkEZY9Dg+GX
         3Io9E9/MRd3a3mM1F4Bm/P/3I+LewJJB4+Lkn08+o7pfMIPp1kxdpNbG0h7GV2I2AWVS
         GxCYhR/Kp3y//BNpxkh8cuTNYgepYGmKmTjn1W7MM1H5C+2e0099s8FruWxk/pjndvEh
         LHMcDd3MVuT6z2BYUyYAb/ba5jKgCdcqTTevVEwqWtwIXYuTG0GzAWXl8Sl7awVFhJq5
         IAuQ==
X-Gm-Message-State: AOJu0YzJwXb0XJChhtDYpnfbZFMVuiodLde4GrKW6XkVM9fYL/hxbfl+
	jPtVEnHywe6Zd58EIGeka1H9ZbK+e1mVqzx+IOapb2TfMQX15S4/DUcX0aofiOCngoiLtxXVF14
	sM2PI
X-Gm-Gg: Acq92OGJmDEvNIkbeJppLZ9s8ZTSefn3yXyGh1CH53UVlLtnG+saxBPAy8eLzBThXUS
	I6I61WonPw1QKGMR3Yp1YhkCpIAGzWojL7dMR5ORGF4AjjdAu3qmJxJJBwd+CcE82IegftaM6oB
	xpRoJBm7Dp4sTQkA4YgA5x8bj4AwMskJbcHzOOfEatPsxyrfVuQ7RQqdn2bs3/pb5LpYar2iJTQ
	RF7lGO8bxfoOJP/FPwaIi76YGVq9Ya03Wu2N3GU4fkOOox8s4lRqGU7VJzkpD/WD5TuuLPVjyqN
	M+DmGbwaUpgGV4ItGdYn0rMsoQI1ymF71+RZhJAMifkYRjvuAF1baT4eE+adZ2ENkShrEdrzcWc
	1nzwoElDcc+zq3+La7e2VKryTD23zuu8L0PMWcqrWEoCYv3lIA5/Ft/Lg0gY4x+Yu/WIMgjwIzM
	0ni4646ZO7dIk6ww9/qdwYDgOQn7GWzXDztO10ClwyHAefbk0nBKyXtW8Wu63ZejkFHiFw8wztr
	WY4
X-Received: by 2002:a9d:5381:0:b0:7dc:9908:6cba with SMTP id 46e09a7af769-7e3f1024c53mr3929955a34.6.1778862342249;
        Fri, 15 May 2026 09:25:42 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:5de0:f9c5:a427:bb0])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7e55bc13a0asm1747862a34.21.2026.05.15.09.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:25:41 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.10.y 1/2] ipmi:ssif: Remove unnecessary indention
Date: Fri, 15 May 2026 11:25:35 -0500
Message-ID: <20260515162536.2222586-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026051541-privatize-sweat-2418@gregkh>
References: <2026051541-privatize-sweat-2418@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 570D25552BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248676-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,minyard.net:email,minyard.net:mid,minyard.net:dkim]
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


