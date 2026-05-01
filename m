Return-Path: <stable+bounces-242446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id f125C1S49GkwEAIAu9opvQ
	(envelope-from <stable+bounces-242446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:27:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4574AD357
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34463008229
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD529D26E;
	Fri,  1 May 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="ok5hCqo2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA771C84AB
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645645; cv=none; b=q2wAjPSCJ8LK2BVshbA+zQhKbQnkGYU7MdWjCnjJEMV81D+JLKI7hFd2tTuKPib+WNAwVK1mHWboKxHNrKtV5lhaMA+QrtApX3kcMhvDbJJXcI6mWfOPSes0vQ5Uo97zWAaZxxCtzqu9w0OVS4uhrCcGuHWBIbtbTiJDktgeakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645645; c=relaxed/simple;
	bh=qFyrCnZAzSJQd0E4FJymUTI7vBnHnCzvYBPLXbpVbws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYlPxeficR5njxUuGxx1wIJkjH3pE9euxj2eTzKHPIXHyQSJFCk01Tj9faa54d7Tx6iwNDciCogqYl5qcp15RSQfyA7ovVwwnNt6GY/PlwKH+v/NEcUwkjE0N32r2obgm08sZvD3jjsSC9bRcwg+yBRC4jW/089YH2dNYaPht1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=ok5hCqo2; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47c3b830c99so1282543b6e.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777645643; x=1778250443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xee2uFjHb0bHsfIB4ny/0BgT+KquqxxQ3AdhM4LqHw0=;
        b=ok5hCqo2U/3741f/EDt1ECNGE1YOHUi0XaGPK2PNX9bYC8fUtKDX3dK8kawvlA8jPW
         8CNGXW1uzY9f3qpnIoeKKn/rX8oODEgFwoeG58k+ciP5e7w9vXin+XbaFnkpoGoe9Gts
         or3XYsXYsrMKJRuO8OXJpiK6999Zunw+jLLflwPQ/Ta1AymeThyOw+i/PDw2ge87nKsA
         7LUKMeV0pUykoN0rK4o+AQsUbpOsIYc+n+o7NvHkOvvO1+UTy+F89zUyPgiPkJK12gyy
         nOMpXtVhVTOmAIyBcWBJu7FzKxTDSSgJ9SG9kvMo4NFmuknc3SvVxrQRXgCzrOwjoKtK
         sRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645643; x=1778250443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xee2uFjHb0bHsfIB4ny/0BgT+KquqxxQ3AdhM4LqHw0=;
        b=q2zZTiduCRVhXlJ4eU7iQ24j10C0GjrVoxf9TbmCVq7Nv+/xeOL4BeXCZAj8vQehen
         xeaqoJgc3iLnLccFXZUSHYApGlzU793RAaWRPAYx04fevvmh5PcbNG/eLsI9yGdIcwNY
         Y3wx61FS6OOole3hYYXc/nfMVK5VkyPm3IRltrdcbZkbGMbRlcskuI1q71GHYICHkMxy
         ETLhJJH5mJZcCa4UpQakgoSA4pvB1YmcsrwvVWhiMnE6916QUz+2yWdjeK/QdZro19hc
         Ki6/xPji1FF9YL0cckZN/5t6e1arnp4N1mBQWIWPf+agD/YOqvxwgyPptCYnRxwHQ0UT
         SU9g==
X-Gm-Message-State: AOJu0YxBw4SM1Wvkh8GIM0uOWazxbnT6bh0CTf7H5JvfRZpmDtBKH0O/
	fmTfbBcaaa4Xwms+1UBdWarGZrQD4BwwubCxYK2CbiFQH+UZSk2nNOMu6Rl9nLVsylAIO7IsbII
	iNGBZ
X-Gm-Gg: AeBDieuNct/WZsmrzIA9lQ5SgaAly44CvSBbjQ9pLKJMKYhYIEpoqL6kn3gjpvKVep0
	3yrYdAN+s1vQLVJsAFvfaXE9uEAoqjPE6pdWVUSm+vSBjauD+GJNmkCfGeWUgvtHypwXMqFXUYk
	H9e4tgG1UzZh9q+gEpyz5iQeO6Db71/Ey+vf94UBu8ibarUgMB9RjneE4/WLrQ2mqgsYqXGMFYp
	CZg13Xvyd4p0MVSOzcI5PZsxAHfiVV8/lnvgXXTUk14vEuKayUMw2FrvdBJfhA4lGUaQQP/bubf
	ZmMqWzvEFKTBF4Nlv0827NZ/FQCNTLVuXGiKReD/TfCuCy85Qj7mU9JYsV+kSP9dVhafepd2MMA
	I0Hg+KI6E70iF3DoNM7qGhV/5eXa2aYE/FX+hk/j6ln0N1kb9UzhA3u8obiW7l5fmFFC4adHcEO
	AIGgahKjfeRbfgN8r0wiTzpSAsFw2MwS/p1FYg7yoBZ3hRhP9L+xyvBKZZK3e6xBCvcvqFeiyfS
	Cl17Sde49D4O22YTG4O5pFEYow=
X-Received: by 2002:a05:6808:178b:b0:479:d25e:906b with SMTP id 5614622812f47-47c5fb7d8ccmr3677042b6e.9.1777645642781;
        Fri, 01 May 2026 07:27:22 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-47c76400028sm1404289b6e.5.2026.05.01.07.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:27:22 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 5.15.y 2/2] ipmi:ssif: Clean up kthread on errors
Date: Fri,  1 May 2026 09:27:17 -0500
Message-ID: <20260501142717.840671-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501142717.840671-1-corey@minyard.net>
References: <2026050148-politely-tabloid-3059@gregkh>
 <20260501142717.840671-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D4574AD357
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
	TAGGED_FROM(0.00)[bounces-242446-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hdu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,minyard.net:email,minyard.net:dkim,minyard.net:mid]

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
index 22074f23c06a..ce0f20cac88d 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1277,8 +1277,10 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread)
+	if (ssif_info->thread) {
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
+	}
 }
 
 static int ssif_remove(struct i2c_client *client)
@@ -1908,6 +1910,15 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
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


