Return-Path: <stable+bounces-245212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB2WOCTZAWrPlQEAu9opvQ
	(envelope-from <stable+bounces-245212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:27:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DCC50EDC9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97534301EFB5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D923E5EEB;
	Mon, 11 May 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="KDUQomt2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F273D9028
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505623; cv=none; b=GoXmrfFWIKmNkHg6eCoVDrYoUEZsU6d54IrNoeSLXQZoZrPXuieFyg0K0FPDl0e0Z+nAtMs1YfdJn5iNWQGB4aZoNt8Lz1pLx14vNOVyUu+VrxWAM+A6q5fP13YmA4kCLqEXT6hGk0FoTJsUTE2qRxbufhqEyuMGYgAsuunlrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505623; c=relaxed/simple;
	bh=m1VjibQSABnFB/aAZeh4bSs2jBj8wTT8H75h7ENkOLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nn5OPujGISLoswWDsdRpb7t3mETx/4V7T3A+iEdkIiST4+ybJV2AEMhdjy0YBrb2kZVmrCCZ6kf7ylaSWSh8GoFY+NjBOQ+xoq1A6rItH5KRs5LRI4Yg88qahYJWNPpu79W6wxV90wofR50d5QpVnwYNKOSrFb8psuJkczQ/EDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=KDUQomt2; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7de4ed0593fso2262557a34.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505620; x=1779110420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsS9z79IwAtzZWEYeAgqMXVuQT538ECls8A8mbDl7mo=;
        b=KDUQomt2bojFNR2HlpHQw9tToz6nHS4nomAj0KPgTlVlOGdcQmJw5UbErGKhp8kzDP
         +SqSuJUBe+/1PLgcArErUfumTDQorNJbqSwHeCuHqrCU0Y4SlLsMZV4U+vnXSZeWwFrA
         3tuyfBwi6ZWfD+a8nDA1hXUPhPChit2yG5eWnJTUYL8rJKZrRee3lzKlPd8g+FyulQoF
         vF0QMSP36oXkwqL5FqvchMPOrcaElHs/HLsLi7Py3/OLAqRmjzBUAPrmlhwwOlUo8QqB
         TjYvSVQiPqLIzd+iGv7lq6vzPjDLv8buoAviynUdV16txRtb5M1AyIWMaqN21oO8fWkg
         HYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505620; x=1779110420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LsS9z79IwAtzZWEYeAgqMXVuQT538ECls8A8mbDl7mo=;
        b=i4smQFfh5ycex77dlHSFnTKSpNNk9xX831XAU7ei2E2owFi8ZBUHAFsyRqV0Br5Jai
         u88rsUjGtJU9Sg2F1jPoziZ0wpF5JeCjhTwNI/WchCPzrbHBZrCky7C5Gx43ICRSIM4f
         3DJav8Vj+06MIL8Cp4DXI7C+qwaDA4oEq+KDjcS9cSwr4hPkRsM7SHIsXcAPbLPc/fLQ
         sv+BxRd8N89KuQLJZVWn+C4sADaQo2TGVLO4Mr6qmB3efKSFvNn42P2YVxky4809kXNi
         y4uXeJeIPWNUjcBwBZTF+f/q1dlPoMzpApgvFa6a2A5ZU/Zu/CLbfLem8/AKn6r+gAQB
         3vlg==
X-Forwarded-Encrypted: i=1; AFNElJ9D+zBrz4NVqA3Uzj47rTsiakBgA7pLwaxrZj5n9RKbCgaszgPF/VeTmkmEoLf5SNQ8cZ5kd5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7F0kZ7l9zWPtqneeyw7+Qnvr/mbjX/e1zqJWb4bqxERbIWCj
	sRUQIEYRltz9fCM86jb8nf6ilhcoaxLWktxqd8fguKQ3MnbBoBwRgQq7VLUzdfahFMepNvIqxCL
	1hSbZ
X-Gm-Gg: Acq92OEqZ2j+ppTyYcTfRSv8U5ME9syLvu/4DN5t6fL1N0+Ww8O+TIeB8y8Uto5WQmy
	wpmZJtppGQxd//jtlmLtyK/5+NWxAmefSykdqBmAqC/D5NELLVk8BGyP9OPXVcUG4dvJ+DYtaYr
	G2w/RuD4JzvsKL9Hk4nIAJVRNQV8IBw0wY+MLek8pKvwTqwQfEIOi51dWOYhd7/yUvnAT4lZYYR
	6ngzlWQsXIOQF13i/R65QnKtGS7sCauWZeF76NcLgn0J68tIP5hGXB8ZWcjUPqUiDASO5/aCTL9
	55omI9quVblpmX3FzzhoBrETbkctLejy6BpHUNBwnPT5pLKWLAYyAjEFWDcTgTl3XvCJsdsOv+B
	p3oEJl1hnHx5ieIIBWPBgs5KGAO0b72vas8yKB7e2bxdH5GPdu6NZZQfnVgpm+HWb/ct8a4JN2+
	gPaibHp1ifi5UeFsBCiggbfVTztUTDdin6f8PV5VVXvf++MyY21mYufg68eGND+B9R61mF33TWo
	d8=
X-Received: by 2002:a05:6830:2b29:b0:7d7:4ee9:c39a with SMTP id 46e09a7af769-7e1dee2db81mr14331525a34.4.1778505620682;
        Mon, 11 May 2026 06:20:20 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7e367d8ffb7sm6884199a34.22.2026.05.11.06.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:20:20 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.10.y v3 3/4] ipmi:ssif: Remove unnecessary indention
Date: Mon, 11 May 2026 08:19:41 -0500
Message-ID: <20260511132012.1831026-4-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132012.1831026-1-corey@minyard.net>
References: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
 <20260511132012.1831026-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26DCC50EDC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245212-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,minyard.net:email,minyard.net:mid,minyard.net:dkim]
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


