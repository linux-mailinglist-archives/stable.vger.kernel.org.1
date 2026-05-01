Return-Path: <stable+bounces-242445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFQ5ClS49GkuEAIAu9opvQ
	(envelope-from <stable+bounces-242445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:27:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781DE4AD356
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91033007348
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2694029D26E;
	Fri,  1 May 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="PoKxTEDE"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA511C84AB
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645642; cv=none; b=HVekhqg7DLkpaJ09yg2RRvxwYrk7ZLgOH9QNi42jFL6qpXa+ARWxgINMtFgm3CCtKtKG+FK9XndlhOjjEzifep2TWIRCN1M7OIvlIlXH+w8/wwWG9VxayZAlKv0EKf4+gx2ppvc+HSgCAyqPSpvItEkaYZRHZTbGe+qUy2W+rQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645642; c=relaxed/simple;
	bh=tzUv27qJf57BI8W2F8P/toFyWICC2M/3h6JmHSIb+ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDV5PuvzAHvRlqxiyn2/o00oGgzVZRr8/BL2evXN2XG23mK03ADjjHSS0B73n7bsu8oL5UXAAYxTZDQSq9OMkD6HUuLjrbM/dl2XSLLuYeXQGtlisP+62mMXPVVN7v3EmaWQVfBBM9/WokKnYzF6+c3Ztk/xoPSGSL+HTNqUZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=PoKxTEDE; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479dd56d016so1478138b6e.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777645640; x=1778250440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3RanNELOgVu3qUpfVwvN+gLyjlVMJzkyaaexBgkVjA=;
        b=PoKxTEDEjnVDKT6RyO8qP4Y+izWflQplAKJEIwoSTq/2W2HI8PFOztpoDPpR7cYIxh
         ei+N4ncOIFtpvAqy/y3ftEOCaTDg+WXyXnI3kvpteOoCMTWjPwfFjBQ6h+tpkcezbP2Z
         F9/2/B2Ta1Q4RFO3KG9AMu3ybP58yBPLBzxks9p5+f333unO6ZkSlAcbqhwJEWZVIXL6
         a0cvd3lYws9X+sQIvTAaH5zCc7PpJbWs9wbhuDtiwz/ZZYfbvtZozQH9ivndI8uSpaCv
         KGwVhLZ66mmwTOIIqqgzM7zcpAqfPh3gANHvbKRLUn8jXInarysPKComn/E6If0h+oDG
         HZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645640; x=1778250440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3RanNELOgVu3qUpfVwvN+gLyjlVMJzkyaaexBgkVjA=;
        b=DxiEPECz80xZMKhZnoCXfLbsk53W0W0ZT0sKBaCNA06tySIkZY412tHpu31Vo3hQLF
         hfV8tqSpH1i8gnLbNGMhSqiSjj0ZLnGPE6Wh3jhdkkbsPrPU7dBySbq9Ou6n9i2/TV3a
         NFzQwPLcpRkSnCdn3L74EEaWh71BoXQWKEB5+vIN4B/QLHEroGfOibrvBosnwIz+Qhrp
         DJXaiyH2ATdXghxjjerBe+p22i6FjJtV5w512occkBpJ9WBluRrIEMJjlItJOEP6euUj
         h77W7EhFwgAWvxQkclof5zn69KAF7QtN5fXwGMtLTGFqug5amChJX9zobUPDEXGqlIMK
         AEQA==
X-Gm-Message-State: AOJu0Yx6NlCxxzZQXPKhO4Au+nzzFzvMJsYanZpAZIoaZNMG/4P0NTsz
	4gqxO+kcNs3PuEC6h4wDXYsIX36GzkXgllsKxk+wcIV8FSs86pWolkeQ8DbRNFdhekOt7J65C01
	cKFz4
X-Gm-Gg: AeBDietGyF9SSQcSUaadCs4ZMbCfvlLj3N+AUscRPmWF6nFK4/3keXD7V2tErFG9Ihc
	BcvOTTPgLmxh012QFuUhbo5IcMIle3qk3zyMKU8slzaD987dw2e/N55xsRgpiQhklS15qBIl4db
	G8R+mMb8+CRPU5Mv1YXsgI7jP1KLaM80TejJHFhCnvXDB8uvSGyr9xwpNe1uh2DHaNnG07ggWj8
	n4AJCExXNGyAjrrRiDQoVoS+wgvwD85my0qFSIQvzJTXf6jwnYaVydfQcOJLlsiIndmffcFiV2c
	lKb+kZlSL1bl8+hrV4fgBt5w1y+Bx6VQ87KtV3oCN0XsKQJmSuV3d4zndNFtVLwN06ikCaDyZ0q
	qT5xqR/bzyJBXShQLuM1zoAVTIVzPAZPJ7hbmhke7VNnwinntt/XiPMNEqMrDdW7lB1u5dKuY3Y
	EWM8JCBbuXlnaEg1IvQQEOyAoJBkEwjr2nbCU5VFPfEU+O02/dWMiwlw5xff6TyRM60iPvNgnlm
	gbuDIyMtGWvpASC8dP7g+STQz4=
X-Received: by 2002:a05:6808:bc5:b0:45e:f0af:5148 with SMTP id 5614622812f47-47c5fcf056amr4201092b6e.30.1777645640580;
        Fri, 01 May 2026 07:27:20 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-43454d8ed0dsm2567076fac.17.2026.05.01.07.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:27:19 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 5.15.y 1/2] ipmi:ssif: Fix a shutdown race
Date: Fri,  1 May 2026 09:27:16 -0500
Message-ID: <20260501142717.840671-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050148-politely-tabloid-3059@gregkh>
References: <2026050148-politely-tabloid-3059@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 781DE4AD356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242445-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mvista.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,minyard.net:dkim,minyard.net:mid]

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
index 30f757249c5c..22074f23c06a 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -487,8 +487,6 @@ static int ipmi_ssif_thread(void *data)
 		/* Wait for something to do */
 		result = wait_for_completion_interruptible(
 						&ssif_info->wake_thread);
-		if (ssif_info->stopping)
-			break;
 		if (result == -ERESTARTSYS)
 			continue;
 		init_completion(&ssif_info->wake_thread);
@@ -1279,10 +1277,8 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread) {
-		complete(&ssif_info->wake_thread);
+	if (ssif_info->thread)
 		kthread_stop(ssif_info->thread);
-	}
 }
 
 static int ssif_remove(struct i2c_client *client)
-- 
2.43.0


