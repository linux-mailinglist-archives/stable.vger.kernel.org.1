Return-Path: <stable+bounces-242444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLT0BZq29GmvDwIAu9opvQ
	(envelope-from <stable+bounces-242444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:20:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032E4AD2CA
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9FDC301A158
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6C3C7E1B;
	Fri,  1 May 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="Jdzt5UmN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D043C5DB8
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645203; cv=none; b=pLVUiYhWxt9IdgXLSLVAbTbdwrgsp1tJZAk6ouV49Bam9GH958ntsvVhBS29bTHAEcbTb9pY97P/LlxRKDyQ+9mgDCsJ4zO4ZeU56CzALmdT41LNqqvfM35Mk2S6GTq+EUGsDqMRBsjb4QA+bTLso7WkaBT2NQN40gD+xR1CqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645203; c=relaxed/simple;
	bh=29HUNRp0M2ETGC3aEldBnyC3LxQBOj1cSUZygHjVgjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL4dqTEKrmVqJzQCYpkuT6SOUL4YNOEMALwhQUqVOYe7sYvyk+l2c2EKF8WWiM7t1yyVlwjnZQzqjl6A9x2RVUFQrwmjKUFXqELwZjiyE+10QROCxyCx0ReyfWRLCFz1VH55PwzMOmGDfoGSf9c1aaYv2xx6Y+RSCq9IoSZySoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=Jdzt5UmN; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-682fce74c06so1719020eaf.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777645201; x=1778250001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpEk+/ujUftVZncWNtnaBqVGI6YFlM8DgSUpzXeg+6E=;
        b=Jdzt5UmNgQiYXdBmcZ6q0dGANNAwAv64296IecMJNTHFcVhdgJs1Bp1r63qhFEsKOU
         jfs6oW17fQj64quV+6es73AlqxaKyIhRwWdPy/yMFhRs4uVKgy8qIFp8LhpOyowssDg/
         WY9iU7Ahov3c06W0KoO8Z/7pKwcgidTgE9tn3o0bZOxp02u+xjMRaM/mVpHZuL8swnXs
         bw7bbrQ5NhrdT+88meuxFKwbTw8mc1PB4zmDnHHT+5rqPd2tHJeJFwjU43qNptdha8oJ
         UCKp7agIF71XkjwmqYhZDiQv+deihjFRZrf99NXXks2/tDPJBs/59gf8ZB9T72CGwReB
         eHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645201; x=1778250001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KpEk+/ujUftVZncWNtnaBqVGI6YFlM8DgSUpzXeg+6E=;
        b=TmKcYrO06ng9lOIU67YcCuoRXG2AXIqws9uD1UlqSjZ0AsXTCgW1PlJ3XPM694X8/t
         EjBdxX0pY9IMIO8dF+2Nu1e70LRiiVgAUgK8GXgjVFKXQErvQpDKlXXw6v8cIj24ObBh
         PphGXtSJeTuaEnsEXn0+QCnGiwYvkEfrA7T/fWw0hMarKs2fpynasYYz9PN3FmWf17Zp
         QwLLjUBUeeD96EsB3nMjulK7oOzfpgY8Z47HsyYbq7b88zeGhN/z1VOafNHn4wAHLIXo
         OVzojMkz2bKyatry4n1sSi62duk+z30MOLpwMnTcKKhT8qbOGwUnsfQM4Bqx+Qwhq9s8
         OuMg==
X-Gm-Message-State: AOJu0YwSGDw8pqwMpgeVVahRfcxHXKwSSTqbYDI7JhVJzTQzZqWdBn+K
	jmQY+TeleGA0TiuY17tsSRPYRA4l6RJAUExkn1XoaXQxjOasDYkXFRRH8QJXrYGgH2RgjckOgnN
	VF6IO
X-Gm-Gg: AeBDieug7C8AvS1JHZ8QSNYk8/y8jZkm3PjaXT53RORV9XGbVVAObUjbpAqOlpfD9eu
	n4ODrhlXWIXXe9DZRV5ZW4Vp+vW3MU93l+c3fvb1ZayY8VKMJ5GBGHRVOPl78TsVPB6EnvjLODR
	P2oVHf9p4/WkI8NCi3DC+T2x6yv+hgfUNYEQJ5qqZbmsyVuxQGV5PV+1w5Uk11GLmxramLVM8VD
	pwy4U1B3PJGXdDrXf6Zo46rEjDuwS6MTxGRq6P0xBeSjHn51pi4V/L18/bhuW7qy29mQnZzXu1A
	sMNbdXFR9udWFyvEaH8dYBoD1DTsfSsiUHq9YSCI3xliD/l2tfkSB6x10HR9AUlXhja968VDrjQ
	zURO2JgZz6+FXa2yrnnpRm5JosEUOtriLCNMSF4Tkc2mTLnWKfKYmSyaOy18eA8ZdkZc3kXyQCQ
	0VK8FmpN5xmrbF9mJ0WknDOrvhbQublPtX9TqqO1G+lYLuGSKLS/5dccfloCaXo3jKxQCC+kyVq
	bitOkcbKUojmMU3
X-Received: by 2002:a05:6820:1987:b0:696:6f8d:bb7a with SMTP id 006d021491bc7-6968bcc3f99mr1422662eaf.58.1777645201206;
        Fri, 01 May 2026 07:20:01 -0700 (PDT)
Received: from localhost ([47.184.181.198])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-69689479359sm1597422eaf.7.2026.05.01.07.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:20:00 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 6.1.y 2/2] ipmi:ssif: Clean up kthread on errors
Date: Fri,  1 May 2026 09:19:53 -0500
Message-ID: <20260501141953.781781-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501141953.781781-1-corey@minyard.net>
References: <2026050147-trio-dangling-a9ed@gregkh>
 <20260501141953.781781-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8032E4AD2CA
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-242444-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hdu.edu.cn:email,minyard.net:email,minyard.net:dkim,minyard.net:mid]

If an error occurs after the ssif kthread is created, but before the
main IPMI code starts the ssif interface, the ssif kthread will not
be stopped.

So make sure the kthread is stopped on an error condition if it is
running.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Reported-by: Li Xiao <<252270051@hdu.edu.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Li Xiao <252270051@hdu.edu.cn>
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4)
---
 drivers/char/ipmi/ipmi_ssif.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index fbc870ffff6a..4d68c7a451ba 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1268,8 +1268,10 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread)
+	if (ssif_info->thread) {
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
+	}
 }
 
 static void ssif_remove(struct i2c_client *client)
@@ -1897,6 +1899,15 @@ static int ssif_probe(struct i2c_client *client)
 
  out:
 	if (rv) {
+		/*
+		 * If ipmi_register_smi() starts the interface, it will
+		 * call shutdown and that will free the thread and set
+		 * it to NULL.  Otherwise it must be freed here.
+		 */
+		if (ssif_info->thread) {
+			kthread_stop(ssif_info->thread);
+			ssif_info->thread = NULL;
+		}
 		if (addr_info)
 			addr_info->client = NULL;
 
-- 
2.43.0


