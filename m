Return-Path: <stable+bounces-245204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCbfKFXWAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:15:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5541850EAB5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 757643017BC5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC023DDDB3;
	Mon, 11 May 2026 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="VPLyUhar"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB31D54FA
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505075; cv=none; b=nS8YSjG2387hAfT7Z1CdwxMGDuqTwXTL0vCMO3ejXQhGTFTFEefRAXzhNFhrp4olIN0RseMvEY32I+UTO0lVUM6HUsUbTn2wo5Sa6IkUSvUXJjaQyFXAlEsMUooptcuImWAUg4FRXuUwfWajyUUolYx5KJv2n1LLyw9IhZ/bz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505075; c=relaxed/simple;
	bh=m1VjibQSABnFB/aAZeh4bSs2jBj8wTT8H75h7ENkOLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZU0iMw99hkidcB4mJ53IREVHS4cr5xWoPOIWrw0U6sQZPTpqwzsnkpyaOFcuEvP8yiG4ou9zGySKymCRGxWcXd9Klnawy6gdcNj0qsBuSuQO2o58nIjslH+kToSSOmJ7ADtaM6tffPM5jhOyWseXyFRQn/6rzhqtOrJJCCZ+5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=VPLyUhar; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7de4ed0593fso2256482a34.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505071; x=1779109871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsS9z79IwAtzZWEYeAgqMXVuQT538ECls8A8mbDl7mo=;
        b=VPLyUhar/rpxFPlEtaXoWLFQxwgBnKfXseXI3tv6MglxkwGQj3Sbr9KvVhxIux2gmF
         ToeFGSxGONdBvGIiBVXcgD1DBR4APRPvefA+6ZI+EMMAfyWN++GX+Eq2ckA/dDah/QjE
         /uMfCUXJxScP+Cqw9nJ4TLzcWk1rfV6PkQDg+o3b5Md+fRjmCckUECsytDAiRFVTwg3k
         P7GV5Du5GBVisAR+N2T/M5DjVrbN7UDHI3i2InY4A13sd9LijyMJ7UIvJtv61RtHdZlQ
         QvPLfOof3uLHKAhAeRwuQ4cdy2twiJOGfucvObdtZ7EHZPH2VjwTe7cwFA8C07OPXyVr
         1x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505071; x=1779109871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LsS9z79IwAtzZWEYeAgqMXVuQT538ECls8A8mbDl7mo=;
        b=sPYye03U5aDoKKu0freoO58eNM1qDlnqFLH4ABZStwDfGek7N17q9RmlOKOVujp4Nx
         ohI4k0+ptIsUr7eeQdFeRvtKlLALq+/P16VJTzFD9eTKy20QkD+og+usN3ZAkMtu5AvU
         iotw4X7Kywh2z4cZ4jR0uIfHxopXkz/OH1YCNJj5Q5/NBmDTdU4EolzYS1hbWLe6vYnp
         GIuWWJ734H/bRTcPrFB9/Pa4jjYcD7eJ1WlWwBfcAXS64JOjTz4IvrGqk0n+0Goak2Au
         8qQ0lC929Vj61wVl156TJYR6zsaoxuGOM2uEPg+t4xmNZt2QEkdIYcLTGRui4P8X8eXq
         GQhA==
X-Forwarded-Encrypted: i=1; AFNElJ8FfA+OopLqJjycY7bAMSTVFgHSJHyiO/hu2gm/s8SitoQi7kqS/uOiYCmnpeiYRdRsi/ZKR/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUo2urKWQ361RF10EySy1PJjJHgE1t5MjweBV7M/T7QvOXFcx
	r9oLzzUGQNwHMuOdgJ1WEIxVbmoI05+bCgFJfGHklZdlVoV9EM20FY6OcSm+vMJyfQ8=
X-Gm-Gg: Acq92OGUUicBt8KPKqMpqrsYCuyDup2Cj44pvzvHI/+xRIhzso4PcJbiPNDpzi4O2r4
	BYSg3Mm4C9TMCks1Haejpc5QN+2dGlwwKVa5w7ORGhN6B4eauxTSejzLh1ZqEWIfzNkgukjjAuz
	0SJge7Dwrhot8Jv4qWp1qyWGJAaoXc5l8TNha1Q0pk+BZWcCqrBnOfX6I+oTUtU6jA/fY6CWuhG
	BXpbFkz5Zn3zuoSX6t9ikJ7scXQ2jTVszEHUAGf3ZgvufYkklB0tmS2Ljt7BZa7TrBzTxkf26dJ
	8tguEJEvpyYeART93s5FrBlxp6Cqd3nxZAVcilev7dTYRTMmYsdfjcr3LbCm2Vlw0iaD/kFbZHG
	A3DiJXZnC/pbd09obGaJasxWRJBtGZf+WKgIKbrVyMkgCnDtzKlIS8P4PVJGJHGTu2Uk8/hZk19
	CFt46E8yvecDnQSU94eDcuizSO0ORdfwABVKPMYFNTyVsDQpMAw8eEMV/zCaleYm+OhPAFptKJb
	Mo=
X-Received: by 2002:a05:6830:d81:b0:7de:b878:3106 with SMTP id 46e09a7af769-7e1dee98fdemr13132683a34.7.1778505071471;
        Mon, 11 May 2026 06:11:11 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7e367d5061csm6872140a34.15.2026.05.11.06.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:11:11 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.15.y v3 3/4] ipmi:ssif: Remove unnecessary indention
Date: Mon, 11 May 2026 08:09:25 -0500
Message-ID: <20260511131100.1772190-4-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511131100.1772190-1-corey@minyard.net>
References: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
 <20260511131100.1772190-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5541850EAB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245204-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:mid,minyard.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A section was in {} that didn't need to be, move the variable
definition to the top and set th eindentino properly.

Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_ssif.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index b884bfae7fa6..c973c0d92319 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1675,6 +1675,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int               len;
 	int               i;
 	u8		  slave_addr = 0;
+	unsigned int      thread_num;
 	struct ssif_addr_info *addr_info = NULL;
 
 	mutex_lock(&ssif_infos_mutex);
@@ -1883,22 +1884,17 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
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


