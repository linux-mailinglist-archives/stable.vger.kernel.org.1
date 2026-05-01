Return-Path: <stable+bounces-242465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIdRCSjT9GkYFQIAu9opvQ
	(envelope-from <stable+bounces-242465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:22:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893F74AE104
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52719300A8D2
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB353F9F34;
	Fri,  1 May 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="ZbuchkBd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E93DE422
	for <stable@vger.kernel.org>; Fri,  1 May 2026 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652511; cv=none; b=FHhtzC3KaB1QSAIFChQ2YcTez1QbkNJxLkSROWqeJg8bVsB1vMmWeztOZWcbpcnPf4I+vVieu4FhAhfFlFDX9cKXK6che338PtaqHacjYSlaDVCEsy7CN+wfgoYj4N6y6zSkEoLQgywlm6bpl6t5pqsIf5mh/TEE8WQMxV/LI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652511; c=relaxed/simple;
	bh=dT+z375Ml9f+UCl0AsnQLq8Jov4Yf++kdW9fdTvlid8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrWMn1PcGRni1Fd71aTmOTxSmzLD+Xw8KACNnMFs8Lu6OMj0JBj4ZDR32UqtF5c8B6MTG7uc1fNrHsxlKpa8Wwe7mHPrrTCcBoj4v+3dcHP4E1oK0OO19HrbtyIhrSEQQiqusheOpyqp1r63SGPEp6oYk4QCQLvNsBQFt647y4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=ZbuchkBd; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7de7c57b52cso1708882a34.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777652498; x=1778257298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FxWbgP6MY+kpukIVmClSKvKLr5wRhVO2bQL8mGRpxg=;
        b=ZbuchkBdQ8QpsKsEzmgyP3i/bKXmjwi7gkPVcI7Kn3tfKuaI0G/JajPDjVhWrvGqyx
         ibpiFOFFwWVdcKuE9s2o6QZSJDW1PxmNhWIfITLdT0sUcDQ9uhfzbfMEHRJ7cc9mJdWQ
         XZ4mN5BqHBf+24m+EXVPb5BFTm14t4XxQhb7eSkLOR89fAoPoc7XBMCljSnISdW3ySMW
         jXsT6QR/Q9/846/5IAzQEwq3cVecQBoBIokg5FpLCgULJLmJsLnBet9GChEucxqSSKdH
         jVbBK3+mIlzmXh0/Q8vIDUsLB6RswNwRnzo1T2AarpZvpwwlk7YKquoAipz6C2gLbEXH
         LTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777652498; x=1778257298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9FxWbgP6MY+kpukIVmClSKvKLr5wRhVO2bQL8mGRpxg=;
        b=daPhTBwve+fDIyj4ihBKVBjHbcdapJHDgfkQnjwtZnI5f+DfeyXEV3C4NZhAOHoY4A
         d4X6H0cJ3ZAhC1pLGH2PlG57y02MC3jt4vwekCgCwaAeVdbXSu9qxbGTezJfRm/GgYax
         KrAPdu6t5O+4hdhbapiu1Snbi7rfA43dxqNS0mraVlkQWBETLa1km21670PgyhAwJSzB
         Vz3Ygim+wySRU1v/SMTAykNY3A2NiFhJzUcs6NmvmwFSXO6CAG0ZjhA90Hk8BInFIDrG
         xWbpJPxJm383V8flrIlE41YlSrhVyr4hW6h5OSjjUGpmV4+2qGSZWPvNO1W8IMbANZRp
         XmtQ==
X-Gm-Message-State: AOJu0YxvokbrxPtqwB5PQuRWkSaiZOc4mERaoomn/a4ENQjyeE5PPB3b
	01AkUCHk/7n+NMOgqj9bRzs8L8rtG8PfRO2TEa+ZeTaOlzaAHZL4q+dTBlFaWe8zTVDubnxNiVq
	DpcAC
X-Gm-Gg: AeBDietGrKehEuwvXUM9OES1LaIfsXmGo0oRBrUv+gm00Z2I/XVFhKECGqO8JGKfvQF
	11GsG1saYhP3m3KCOlCDqV1cUS04Luv/azTc8KylU4Hy65akxEolrg1/gphhdCFqXI5OIMnUWU5
	K81CctpTEfelgqzDFnevpv/JlDv/GnY2lPGGsYaTyeOXWs4oapW/pEwZ66jRWtEh2tja+ILIfIX
	ReDHP+BgvNqr8WJb4HVAF67FibMfOfVXiglr4N6sHm5uQDpsau9Hb8IQxKEBsLYno9hQwOG13l7
	gZhxNeXlSYhGwKI81SgFdZ+u1fdi/WviIJyLBieS8UdvvDbUOBQomVIgxhY2K990B5TQtkwOJ/m
	wj9F+AmpMwTFXA/GA+NWCKRh0ON/TRv+v9xbeM+R0q/AsvSvqFal2O7AyE6V9+621Y8eKdDdMTw
	SZKF77Wj3JxBeb5saTEBPpCbeSzX684xdgYgQaHUdhWVNjyZP9XZdHL2a1QsV3WWXPQuU/s31Uq
	QdCfIao+s/GxVS3
X-Received: by 2002:a05:6830:2690:b0:7dc:cd0b:58ac with SMTP id 46e09a7af769-7dee1273965mr143080a34.9.1777652497907;
        Fri, 01 May 2026 09:21:37 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7decac83da2sm2305532a34.20.2026.05.01.09.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 09:21:37 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.10.y] ipmi:ssif: Fix a thread shutdown issue
Date: Fri,  1 May 2026 11:20:52 -0500
Message-ID: <20260501162131.1165570-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050148-irregular-kite-7f24@gregkh>
References: <2026050148-irregular-kite-7f24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 893F74AE104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242465-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The kthread used by ssif had a shutdown issue that was fixed by
6bd0eb6d759b ("ipmi:ssif: Fix a shutdown race").  That was backported to
an older kernel in the process of fixing another issue,
2105b70be84d ("ipmi:ssif: Clean up kthread on errors") as it would
not have worked correctly without the shutdown race fix.

Kernel version 6.1 has a fix to kthread stop to cause interruptible
waits to return -ERESTARTSYS on a stop.  This has not been backported
to older kernels, and that would probably be a bad idea.  But not
having this means that the completion in the SSIF driver will
not wake up on kthread_stop(), thus the driver hangs on unload.

We can't cause the interrupt before calling kthread_stop() because
the task stop bit need to be set before causing the interrupt.

So re-introduce the code removed by 6bd0eb6d759b ("ipmi:ssif: Fix a
shutdown race") but add a wait at the end of the thread so it
doesn't exit until kthread_should_stop() is set.

Fixes: 6bd0eb6d759b ("ipmi:ssif: Fix a shutdown race")
Signed-off-by: Corey Minyard <corey@minyard.net>
---
I realized I hadn't done an unload test on this on the older kernels.
But why wouldn't that work?  Well, it didn't.  One more patch for this
on top of the previous two.  Sorry :(.

 drivers/char/ipmi/ipmi_ssif.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index ce0f20cac88d..b884bfae7fa6 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -487,6 +487,8 @@ static int ipmi_ssif_thread(void *data)
 		/* Wait for something to do */
 		result = wait_for_completion_interruptible(
 						&ssif_info->wake_thread);
+		if (ssif_info->stopping)
+			break;
 		if (result == -ERESTARTSYS)
 			continue;
 		init_completion(&ssif_info->wake_thread);
@@ -511,6 +513,16 @@ static int ipmi_ssif_thread(void *data)
 		}
 	}
 
+	/*
+	 * The thread can break out of the loop if stopping is set,
+	 * and this can be before kthread_stop() gets called and thus
+	 * kthread_should_stop() will not be set.  This can cause
+	 * spinning calling this function and other bad things.  So
+	 * wait for kthread_should_stop() to be set.
+	 */
+	while (!kthread_should_stop())
+		msleep_interruptible(1);
+
 	return 0;
 }
 
@@ -1278,6 +1290,7 @@ static void shutdown_ssif(void *send_info)
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
 	if (ssif_info->thread) {
+		complete(&ssif_info->wake_thread);
 		kthread_stop(ssif_info->thread);
 		ssif_info->thread = NULL;
 	}
@@ -1916,6 +1929,8 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		 * it to NULL.  Otherwise it must be freed here.
 		 */
 		if (ssif_info->thread) {
+			ssif_info->stopping = true;
+			complete(&ssif_info->wake_thread);
 			kthread_stop(ssif_info->thread);
 			ssif_info->thread = NULL;
 		}
-- 
2.43.0


