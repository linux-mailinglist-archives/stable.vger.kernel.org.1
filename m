Return-Path: <stable+bounces-248415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INN5ON9MB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:42:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A38553C29
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 027F2325D249
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9032F3F86FF;
	Fri, 15 May 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="IqmTzATq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199513BB116
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861678; cv=none; b=KIUtDDK5Phzm6dxQGhXYGfWJf9DnshyXAddAoRNRdu8PpIOy9enPl7RQckQf+xLAWdgdyIzG5PYWgP2EcOwg/BUVR/hb1dYMpF4De62LY1+kuOQcOzhOgysaIbLT4sgf3tKbwIM0sdn6zSf7o2r5AIfN9DZFU0Q2v0QHEuvXXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861678; c=relaxed/simple;
	bh=YkkXsOGp3WBkYNynTiJLLkR5cJ0ZLNsgfo6RAAXRzi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzRZZxcuMyhz4oeXMI5qKeem7uvPoxqBznBen6F0+4ynKeigjIuiemOcxcvSADVH2DQ1PaPqqYS5rgt1ZJYyJRsYLZweW0LQax2PKwisHdkRUM22gop4PMBmrK4xHNzXWpnpEhed4vWdoFZGZ604XePQMCTbq+lmAkAxAuv7OW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=IqmTzATq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dcdd1b492eso1496009a34.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778861676; x=1779466476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I+oE/4M7ThZPHkfUNgTGXJUQ5bMmCeqi2xI7cTgVrQ=;
        b=IqmTzATqySXODeHcEmJdA/ABY2xijE57lpe4gqF4NjJQkiSb/10OU4mvpT2t9K85Nv
         7ztQrvKp0GLJI9WtPvI9utsdOlKtawmwE21zwGjaGYby8lk0h7IXUG10957qm6+ZxkNS
         NvYr9k/W2rtrLT1sgHVIuiO12siL5nPshXT+6jpvBn1gxFDTn0l0vp20sGRq0Puq8pmZ
         voyhNDgPEeyTqLmqXUNdNwWZhJGLTI42tc4ZQd0QBSXuD3z/a8itGhcwnNoxgrBCjyuT
         vfIl/jgNF9vRBBLk/pZzrg3QyiM2RBAGx4HyxX3brnrz/c9jusIusNAhKihEjBbK4Q2d
         tAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861676; x=1779466476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/I+oE/4M7ThZPHkfUNgTGXJUQ5bMmCeqi2xI7cTgVrQ=;
        b=c4JIk7MVlm7uVU04R0MTPR/AlfR5Ptn2iThzntlJKVz68rapyF7KdsY5lja8GHalZ0
         myrTr92FIQfchPEl/fwfb0LEmUhCrCxUrxwMC77UwvjC8nHjYwrSaak3qXnS3itYdNd7
         j0rTxZP/FgNyBfJlddhVnz59P2rbMaMP5d+xKpo62dmKc1TAd5cWklL8JPI56F7rwwL1
         EnJZZwkbUacFkoVDScDQBHqHrwXZbBhPVcUbilDuaPNhfk3iTX3R0fydysrx5sDJAfNg
         O1yqMt4tPB8CVwfE9XuI5b0oE9F9AJkQbu4NWw+saoSHCAgjNjZjVjLGB/yETiAuRfji
         2vyw==
X-Gm-Message-State: AOJu0YxgKrfmpkeB8vaWD4gpQ/bEQibGanfBl4g+bQ4X7mZZfHf+7zDI
	xT9Lx4imvMTj0iktN2GQEQxGJbKa9uEaGDZ+0I4VBTyugUUFAM9cY/6wuR3nylCPf2AaNGS8RaS
	jbm81
X-Gm-Gg: Acq92OGEeJz6Eu9KCWFu5dEgr4Z4SI9G6NW8k/cMC+cywTwUVUhe39PRS58gsipaIQN
	7mL/JmiG1t/IiC4LvIN1W5/opbvu325CRWluUgnMMjCWx+P0+In4HvubJTaqm6fVDn1xItSxmAs
	44ZFEeBNQRALA9YSlBZFh2QVZpmcSUiRHOiT34U9L2ZKrG1FYP0xB9fS6irdXq9g9oro1x5bwxS
	x9NBXSY+1L7i47Tvm/Th3/exTlUrONxhg1jIA2xKdoQAMmF8Qe+hvIIhnOV10l1Oj52Fgo8ys5n
	p3RUBOpCWVGFwuGB/ugWwsGbMazRQhm5clM4hQoVMkl7Sf/2UYEZY0YrDhtIJuN2TAchD1Psc5t
	lc6LJhMDRV2ty1qIcxEK+Ggy37KSGxdrnj1wiUALZjD6Ac+Iy6PLvfj9i5NMFBzuMUVlYYBKSDZ
	F/+fc4vNpm0ulpe6C0G+fH4NKpEkS0iTD8UMB5raq50p5t4AQA6VAt+nAZ0ZvjVuyIGWvZdDejg
	N6g
X-Received: by 2002:a05:6830:631b:b0:7d7:dcbb:280b with SMTP id 46e09a7af769-7e49a881a10mr2879544a34.1.1778861676028;
        Fri, 15 May 2026 09:14:36 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:5de0:f9c5:a427:bb0])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7e55bc111d6sm1676291a34.19.2026.05.15.09.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:14:35 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.1.y 1/2] ipmi:ssif: Remove unnecessary indention
Date: Fri, 15 May 2026 11:14:27 -0500
Message-ID: <20260515161428.2163036-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026051541-deflate-babbling-1b5b@gregkh>
References: <2026051541-deflate-babbling-1b5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88A38553C29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248415-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
(cherry picked from commit 91eb7ec7261254b6875909df767185838598e21e)
---
 drivers/char/ipmi/ipmi_ssif.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 248459f97c67..7c5a9c83afe2 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1653,6 +1653,7 @@ static int ssif_probe(struct i2c_client *client)
 	int               len = 0;
 	int               i;
 	u8		  slave_addr = 0;
+	unsigned int      thread_num;
 	struct ssif_addr_info *addr_info = NULL;
 
 	mutex_lock(&ssif_infos_mutex);
@@ -1861,22 +1862,17 @@ static int ssif_probe(struct i2c_client *client)
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


