Return-Path: <stable+bounces-242435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BnULSyx9GmmDgIAu9opvQ
	(envelope-from <stable+bounces-242435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:57:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ABC4ACECF
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B12030074DA
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5B3BED26;
	Fri,  1 May 2026 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="R7RHGuCe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312E3BED56
	for <stable@vger.kernel.org>; Fri,  1 May 2026 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643814; cv=none; b=UKZoKBFPVdNrSPpPUazt7oD/7USHkh1OqaOSn0scL2yS4TdtFaFJ/VH/b6oyRj58JqImjcwtgkOk0oENFyjxn8qAwESlAzSkJ/gfHHFzIAJ49PL1eMvLx7vmDZfzASRvqoWO/cfoFBeOjhLnZpOOkyXJlJyvbRNXH1xdMzyBxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643814; c=relaxed/simple;
	bh=DIaWdVQRqq/Gy8m3nq/8GCD62mjXlhTYsd0K/3UuEJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVYn6vvtnG9lO0TgDXG8oLBX/aRWOAonUFmp/FnIB4bEhdPPN6vCAtD7zhGwzyse+GOS8kYMQOkoezmnvOzpemn4CVgS2I7ZFvGbNjap0u+axSBGh9cMMER3FnKjLgnJHxWdIMfXlDo64zOw2P0VJAE46q0LjHExWDGyMDb5PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=R7RHGuCe; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dca4debedaso1903946a34.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777643812; x=1778248612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxCzoa4VuYlaGPtD/KtGccEX67mFRlT1IibhBT9hKVY=;
        b=R7RHGuCeWRWrkEjwAuwkiX0YpDawKNLvSWnjb4sq7F296SysVg3slE+GTM8rsxH6H/
         ZCs1gduakjHu4sJ87QEQjmrxCyOPgrclS4ttHedZSKxhdALlqMUcRFl7n2rE+aiC8Q10
         ZIgCXQe/6yP0GTqdcuKEf17MDtUX6RjZBdYrvRuQ48Rw9/mL0xoLqgb9CyC2c+6L23C1
         yLQzBGLKTRBofAHQ6vCQUyc6JjH7S6sxRuffzdl8XFPGn4s7iYIMKgD8FngpjHsvA+4F
         aG3IhatCelD1ZxNLNy3vjwLmDQOOfpyt16OvM0Hp1N8NZu090lPBraQX0sgs+2t1CcOa
         Q7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777643812; x=1778248612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rxCzoa4VuYlaGPtD/KtGccEX67mFRlT1IibhBT9hKVY=;
        b=ga4SH4eP4GLeLC8DHEJL3pZgmaMq0E2qS9j7hm9Nnby70UIYd4/KjSfj/EUS0cwIEn
         SbpeEqQqBoNOEjwykrmkLdfai3RRbcyjlG0FDqOjJgEbChwMRSz8TZCtBnCT63FyYDT/
         VHCC2cCUBijlcGH3wznb0/mUI1MtzxiXI/EfTCbuc2zTanXAvufMu3M0PO6hP+id4+Us
         Gj/OjqCcQllvQk58WmuYf5Dx1Us5vLeOjOQKUay2Od64SN9B3eWD9uoT3igHt89sNjEh
         0W0qfA4WvTKhbNAdaHWd6z7vEEhmjRcsy23UkWAMPU5/1Z80I3AuHo1z0xvAwof7czLs
         YP8w==
X-Gm-Message-State: AOJu0YxvML91P7rWRMbO/nGVw3+On8Ll667bYvb/ko+JXHlmccTjHQj7
	J8wIbUF3xuctz3dfpdQZgVwRalUE+e2MIxefZ58sfTlFuC9ZtaOVXAu40yrg3IWPhO0ZIrMzT05
	oM6N4
X-Gm-Gg: AeBDiet0Yw+FB6MjJi+NGXtVC2+GJEJ9e15QGlqu1wVWvmx8ClzVwAzIzaKS6lBat84
	igDy9i9QFMVH2O3CweRukEMRImWqVJWTHvYdD/enzDf37vO50uwDj7fsIK2OyyIZjMJTx7nGIPP
	N/ikTa1eVH/hXLnOHtldrKkxcdy0KBUvAVOjTlc0ilAMN4uERdHBGTszbQBK+u1WTH6DKwSfVS/
	iHkp3j1a1/RVMLa4L1AfdGLEwU+0SsGRfsL0CAMZepvYtG9cNGbu2wqNMjZCKVihz1TTiynSxsU
	PuaYiShXf/E4+uTG2Txo2qDwfWU12o2fME8YbFfeHufZ+AAWxLlvLErDhvmm4dSbGGn4rRYqC5Y
	9Dt59sbkNqP2nCYv5ljZ+doHNs7C3vlW2F76b5onUqifHz7ucCsQkkOh28+B1NIVLLq/+50dwns
	amjs1mMc1U+w6ZUO83BwW/Gx+qnxvsAnAD3r0gJhhUScxbVY4YLgRIMAVdASezeAKtsPPBuIdur
	POarkUXcOykMP4D
X-Received: by 2002:a05:6830:6a94:b0:7dc:e38b:d9c1 with SMTP id 46e09a7af769-7ded0a60eeemr1565426a34.13.1777643812347;
        Fri, 01 May 2026 06:56:52 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7deca7f46e7sm2290895a34.8.2026.05.01.06.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 06:56:51 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 6.12.y 1/2] ipmi:ssif: Fix a shutdown race
Date: Fri,  1 May 2026 08:56:48 -0500
Message-ID: <20260501135649.672621-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050146-duckbill-exile-3382@gregkh>
References: <2026050146-duckbill-exile-3382@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2ABC4ACECF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242435-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mvista.com:email,minyard.net:dkim,minyard.net:mid]

It was possible for the SSIF thread to stop and quit before the
kthread_stop() call because ssif->stopping was set before the
stop.  So only exit the SSIF thread is kthread_should_stop()
returns true.

There is no need to wake the thread, as the wait will be interrupted
by kthread_stop().

Signed-off-by: Corey Minyard <cminyard@mvista.com>
(cherry picked from commit 6bd0eb6d759b9a22c5509ea04e19c2e8407ba418)
---
 drivers/char/ipmi/ipmi_ssif.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index d04b391048fb..cce4d9c00566 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -481,8 +481,6 @@ static int ipmi_ssif_thread(void *data)
 		/* Wait for something to do */
 		result = wait_for_completion_interruptible(
 						&ssif_info->wake_thread);
-		if (ssif_info->stopping)
-			break;
 		if (result == -ERESTARTSYS)
 			continue;
 		init_completion(&ssif_info->wake_thread);
@@ -1270,10 +1268,8 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread) {
-		complete(&ssif_info->wake_thread);
+	if (ssif_info->thread)
 		kthread_stop(ssif_info->thread);
-	}
 }
 
 static void ssif_remove(struct i2c_client *client)
-- 
2.43.0


