Return-Path: <stable+bounces-244296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO/UCoGl+mm7QwMAu9opvQ
	(envelope-from <stable+bounces-244296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 04:20:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9CB4D59D7
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 04:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F4D93020D59
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B584A201278;
	Wed,  6 May 2026 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="I2Q+ehHc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED03D544
	for <stable@vger.kernel.org>; Wed,  6 May 2026 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034045; cv=none; b=Xtp+Q9zH68XVvMZcdt9mKEr/5xAF4N8C1dmmQMhQ2Rl7s+NX6a1QQ1igEWKvf/+N9Gu9VmeFAHebNeog8AuHev0rtau35auV06eCwqrLhQSvPK50Xd30UnqNsXaz90m7BnT7uTOS70Niz51nrKCEnE9mGF6iDMritvM2WHLx2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034045; c=relaxed/simple;
	bh=Qub8W5DOuGrPZBNbmzaxGwvAExMQ3iX7VoPqndSPXk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owduaSMUFyKtTRKUb21LyocPT9jEmG91gQ313/oSZTDBaKA8942ZBXguQxogdWla4LpaTJQBHrv4pxf99Ca2xDudyQEQUk/L0hDpqqbTY3vFOpOfcFE87q7Wv4/yRpLqKa3iGAcMIU8aD2SDU6a0du1SuijXow71x4BN+1aQ0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=I2Q+ehHc; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso5194928a34.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778034042; x=1778638842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJQM2X8ovb1SBk8hlI549WELVH79VMa9uCDGa279uNs=;
        b=I2Q+ehHczgN/Tls5bXWtPT2ii9m349y1jHmItVD3RdN2rRaU4/7nOyJviidBeBNq+i
         ZCwPsxMx/ZexhNzqhJTHccMwXTMuMPz8RJ5haZ6AY8G5tOz9ZrOsq+SrrGCo3ls/2hjF
         Iab3bxi6vWFOLTZfeMaCHwKhqCmrtXqaaeTZGLYcyppfKUiJxu0svv4RSU49wjgl9cK0
         KWe28Sy1olIOy6Onr3kJgnzV7mcaeH2GICxtA4dbwxQyGht/aeWQ06DzVhnzmsDcCB8d
         /ZVLqtx/GvRUaqL3ANBznOdYBGYfR9Ozckagh5gvhYcl0Ek6ftllDvLdRRoWk01ejs7B
         9+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778034042; x=1778638842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJQM2X8ovb1SBk8hlI549WELVH79VMa9uCDGa279uNs=;
        b=Sz76xplc3zeoToZBLGWfxFLFKRuB+13134j3IPIttRPgt9uIB7jrBA9IHzfy8xzKCQ
         +Z+CqLeTfC4dg2IYWwWLd59KjVfESFWhVZ46zJOTGgc/dHzGeZWtaCqdZHLWXiBxPTdU
         KqAJhjDA2vwPa+BENYLuVi7GTFRZvVAPAsGEg2hwdJKwISUJvjcBFemMbupXK6K3rqTz
         g3BBh0Ia/rEbjwUZGxJ2Gkf9EOCbKWC5Ckz0gHCVuc2YPscTgAdaQUWfHg/KmZdJjUc/
         e1ut3uegAlu9jxWrGtaJw3xvHzNmVsKgxv9M/xxgToDMmE5ryy6LUtgIucXG8VvvpLJ1
         mgWw==
X-Gm-Message-State: AOJu0YwbX0Btt39SQHeKsMZdu02A5Zs7JpvNitptoFk962zaz6ONgaa/
	V7171D5nEtMwCcvGbnM4J8ppUfVCkcXh4Z3EIn8jhjqB05ufXLiEpnZHbLW8u8DsYWA0YCKHmH/
	gt/wN
X-Gm-Gg: AeBDievWlqkIouwhY/95PyY95kXVYtOVJ2XMgvGVg88Ebmb794MvIdydWpjBkEe4Gm3
	ZT71IIPKmqmCPYgdvk+D8a0oSCo7Dv7ACcyNR47akxI+Dq5B9HrOyUMHCeix0R8bLCJI2lhIFBW
	RaLazmmDY0ulhFD/i9RBriqwJWYTj8EhkuD5o06TqfuRVTqCQp+A/08jFUShYsGJsCPwd5mANj8
	JXrESvAgi1tQppMhqD775FIm9SJCHEVpSXy1yjszdeq3aUd/PxMo2y1xov6zdpK6hV+DXMkRoJR
	QzkJzxs7ugmSedAEOKFcJqfxEpfof7Cz1/7DA0gJeEf7gPOqgcr7kC/HF038dq/nAfpzqsmZH6Z
	pQczvcQIFC2B6I2eSxj680O1y11qUO9N7j4gX0YHz8CNeMknNpGKIog1a8OXJk66DeuUILt4J2V
	cQSArkUqUOxNYoKGwdgeEOeahQgbfpaN+8rxgG1vuTBPofOo+DVL/SJQWNDE2ewzLC+qok/L3Ra
	pVn3tX7v6zEM/wLt+/53sF/
X-Received: by 2002:a05:6830:378e:b0:7de:49c0:a752 with SMTP id 46e09a7af769-7e1df26c2d2mr780543a34.27.1778034042213;
        Tue, 05 May 2026 19:20:42 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4a29:1d2:a1fb:6ae])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7deced80854sm10880769a34.18.2026.05.05.19.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 19:20:41 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 5.15.y] ipmi:ssif: Clean up kthread on errors
Date: Tue,  5 May 2026 21:18:27 -0500
Message-ID: <20260506022034.1469433-1-corey@minyard.net>
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
X-Rspamd-Queue-Id: 7D9CB4D59D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244296-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,minyard.net:email,minyard.net:dkim,minyard.net:mid]

If an error occurs after the ssif kthread is created, but before the
main IPMI code starts the ssif interface, the ssif kthread will not
be stopped.

So make sure the kthread is stopped on an error condition if it is
running.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Reported-by: Li Xiao <<252270051@hdu.edu.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Li Xiao <252270051@hdu.edu.cn>
[Adjusted for stopping flag and complete operation still being present.]
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4)
---
Version 2 of this patch, not taking a patch and then doing the fix
for it later, but just doing the patch.  The fix for setting the
thread to NULL on an ERR_PTR() error return is already in the main
kernel and should be coming to stable.

 drivers/char/ipmi/ipmi_ssif.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 430302d2da6e..b884bfae7fa6 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1292,6 +1292,7 @@ static void shutdown_ssif(void *send_info)
 	if (ssif_info->thread) {
 		complete(&ssif_info->wake_thread);
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
 	}
 }
 
@@ -1922,6 +1923,17 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
  out:
 	if (rv) {
+		/*
+		 * If ipmi_register_smi() starts the interface, it will
+		 * call shutdown and that will free the thread and set
+		 * it to NULL.  Otherwise it must be freed here.
+		 */
+		if (ssif_info->thread) {
+			ssif_info->stopping = true;
+			complete(&ssif_info->wake_thread);
+			kthread_stop(ssif_info->thread);
+			ssif_info->thread = NULL;
+		}
 		if (addr_info)
 			addr_info->client = NULL;
 
-- 
2.43.0


