Return-Path: <stable+bounces-242436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE+/OaSx9GnVDgIAu9opvQ
	(envelope-from <stable+bounces-242436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DBC4ACF47
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA053028ED5
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DF03BE62A;
	Fri,  1 May 2026 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="mcZYGxPs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100583BED79
	for <stable@vger.kernel.org>; Fri,  1 May 2026 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643816; cv=none; b=Kv6UnZNeqi1YNOhcu0mA572/7EggG72n1jWMszsLbff0ceF0KxZQmvKWvtBa0DXGARK8HnzmhsQ7YJEN3Pzo2bL2wZthylR/JwMPFQ6vfMlv9CD/XzJuknng/xYJTuHhqOP/fIzUeBUe8yZMxB0uvFLgfKyli8WJ7g3D2D+ugOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643816; c=relaxed/simple;
	bh=UTkHqHXi5PRPrMe7ObCzsa8AZJcsbOalIO0VS0C+xL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfmuySE9f2fQ0Dk/lNtfG0Y1Nowcl0nCs1KUqErFYpJUBpb8MqDRGR38WOlJWDwwqGnaSYURR6pCX1jpsvOrtkKQUzBxttbRHa3xOcWMXPqQ65vrg6/SH60VMvvtcWOmMU94uA9l5e56rbRadTkkg++mEMcunynHC4dKpASCEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=mcZYGxPs; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de7c57b52cso1601292a34.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777643814; x=1778248614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvhMP2HnlhPPLWxtbPpcjbr2l/7oE9QyCeWzbHmTOT8=;
        b=mcZYGxPsAvN49HiHNq+75ZeT0PfuPaC1xfyToNvSew517iCy8IkZhkwyjS2D9yCP/V
         uukL6y/y29QCtPzAX2C9uZSRf2+aHJD/IvVG8oQxm4+lNxaX0IUoiMW5ClfslE1/I7qE
         wGgO2y2KQzqUCaIU2hxCrQdM8crl01fBlbAJ2bngsvqDm3jL0DJUu3WahJYBFXuQmdt5
         QKTS0Mb0XSEUACqRkrqVWXy5EtkcvwSFUsbyA+2eqQ4bqAoxJHUc7DmMnGkD29vVdr7M
         Vus3ICGSNa4i6d7O5tV1CaLcWRv1RgkWoBfrdfGGzqRyKoIshdodjGlp05hO4fEkRcn3
         A0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777643814; x=1778248614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KvhMP2HnlhPPLWxtbPpcjbr2l/7oE9QyCeWzbHmTOT8=;
        b=fvziIsSLiSL1PAH+vsbC11n9OUy9c4CAMDeqQmbNwwzpXumePmZ5/gNvN55FYl37GA
         jK58+4VEoY8izzAmFexS5130quYWAXD9WAAdlJ6hZLlE3U0bwM9EtPukp7UHnWPqtq95
         MJWmxsjhqiR6c6xg+pQkGG5YrhkEaT71ggKV1+FdUQja1+sRp4M/RpQeFgHCmKZ95U2c
         7yGQOXBKcHVD7XrufJIXjObe9ffYuB0TT2Fwv77iIUOzJqvrif2YIAgSeh9Ig4YhN0Ut
         j0e3toBjbPrtWNY1q0yVaZo+7QbgNua+JwtxqaqoTH8mOOMi4cd188rHqJXZ5JIq+qfy
         821Q==
X-Gm-Message-State: AOJu0YwOo36dV6r2ca3aZJPGLlsN7pvXe1GIoQf3q5pBLU9/Mnstm1kR
	INIvPTzg1ol/1dhX0QVkPoM7DFOO/sqtJy8DlI+Ew9INxg+opjiZcpcIPxp09odaSt0wcNrOeNm
	eDiRq
X-Gm-Gg: AeBDievQD32rh5iUnOpKWMx9G3KUEWxzIVWatZbAo9AYth7A7Oy1goPXHQVyhRpjhui
	sJ60i4enbO6WTX/RzfpLnVSlR7IosaKROsCg+SHX6CuufWIsT7sjaFSyFdjAcBz1HWkaQKi3iTT
	ykVEqnJ7P7W03hXkZhPG4UO2A37LJBon+MHO6GJmw6N52Zlx03+EKrndFPZ4Jio+9eljJR3ANPh
	eSeb+z82C44xDsSHX6DV6NsU21tdHLRFRhaPkTmSoR09WYb9U4Jfg/pt6yV8lRYiPMPpHAP/tQt
	P3RypJxqK5KD8AvZEhr15g7Mj2QbEaKLlXSFOPJko9m7bz/g6Lm1QeR3hGgyC3gx7xHbMFqP32a
	5B0qWzN8iIeXh+c+gTA3yv0K75Ak9K7vIENJ7hsS/nm7JHqNPEoEGupqBL+G69O0sw4EoEzvlc7
	cdV4OsUTQRjYanUyvdSShG806ITMtM6ege4sdXm4mxahsnvSkU3/XYhYFOEk/GCw3HGTv/s0ITK
	FlI36pyxAEiJ2p3
X-Received: by 2002:a05:6830:258a:b0:7dc:da40:77d1 with SMTP id 46e09a7af769-7deba396fcdmr4359744a34.26.1777643813924;
        Fri, 01 May 2026 06:56:53 -0700 (PDT)
Received: from localhost ([47.184.181.198])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7deca824746sm2055441a34.11.2026.05.01.06.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 06:56:53 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 6.12.y 2/2] ipmi:ssif: Clean up kthread on errors
Date: Fri,  1 May 2026 08:56:49 -0500
Message-ID: <20260501135649.672621-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501135649.672621-1-corey@minyard.net>
References: <2026050146-duckbill-exile-3382@gregkh>
 <20260501135649.672621-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52DBC4ACF47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242436-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:dkim,minyard.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
index cce4d9c00566..347446b165a9 100644
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
@@ -1916,6 +1918,15 @@ static int ssif_probe(struct i2c_client *client)
 
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


