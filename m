Return-Path: <stable+bounces-245211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE53GJrXAWrLlAEAu9opvQ
	(envelope-from <stable+bounces-245211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:20:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FDA50EC3D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61A063008246
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0557E3E6389;
	Mon, 11 May 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="C9ZkcVTh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65433986D
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505621; cv=none; b=K1kac313VR0YljCDOv5SuxljQuzAk0YSst5DwFv0E+BnL02qptkX4rsYXXol4ueat2dofsNHLsAXwsr/mv4Qh8bdW7Jp79yp0yvTeuA3w+yHWPHmtzDt1CGcOTB6wZklEsHKkKf/x1BbQKOI5iuFS1T8Z59nik9HJI2WcUX+QkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505621; c=relaxed/simple;
	bh=fM2wVHThmyuvqdDAm3xbAIhTgUeL9+8366+hSxDnPxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsFaJohzvySElIiZBR0LRO1YqlfbsKkB+6hkX/gaWlNX4u4bExYZ9XQfytJ0hopVTK3RIwkWISKUI9ljZ4+HHwsLDhoWSa/4SkxM1WtbfptVe3eKt1SxOpmN7NQmtFgD8YobPRxSzUOawk7D3x4QgN2euySV9j6mOo59T0fpW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=C9ZkcVTh; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbd23bc684so2526977a34.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505619; x=1779110419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZBPksVpoGJR/FPIbZEpOehFd1sUWXIinRBJVoArRm8=;
        b=C9ZkcVThffWAXitpwM/cJX2O3Y2u+rqp6hIFQm+A7+/sCLfqp3ZbVJL6o3Y9d+GwGD
         ZFvzLIHecHU5s6qjjT8QIl50gaTnm+W5Zw6dXQr15Jm/JS+Q5UdhKir0Tak0M0lG8/uR
         uJMn3lNjtS3E6tpvMoRkFWVprOXn6q38zP+xQ/MZYYqxXSrRl3BZLo4g83R5XIsMnEH4
         WqCYMJLfcS00oh+oT3US/fgovlcwB2s629OX1mMN/ZpxoWp71cQpHPTamTJeFq3jr85B
         gdHXQQt7+MrusYoqU1URvHuTO3Nkcg2iMenAVt1dTOOveOke/nk4dJBLIJhduQzad1pE
         h9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505619; x=1779110419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZBPksVpoGJR/FPIbZEpOehFd1sUWXIinRBJVoArRm8=;
        b=IXXuROiqgqlyarZGWPACu50cVYZs4NZ5OcqKihGaAPf3YLMJ3mEhtz+tlvWUxNweKT
         08q4ayH96Kb3Ox+jnfqUawVUSFFDKMcRX9PKZwtNhx9Gd3MV/rv2w0fcQKKADjh0pg2C
         oJea7WuWlmuQ6X2m0bbLVtDGnSNlw1pgI+SLwtFD+uEkIWdHpAwo04fu86u6MB9ANkDH
         e01eGgxd/fBbFs4SSOB5lpRueN+P+OBY3RtqVgw9foTHJPTZjstduhdXbFYJwpI2+Adp
         tELPUT/6sLkF9htmOK+tFXYbR2yOBr6xQI1PZg8EDFiL0RtXMScMClMBMx9zzdL86BiE
         nGAA==
X-Forwarded-Encrypted: i=1; AFNElJ9CwQdHZdlqNhNCkEdkJ2HnvW7xAkeI9sAQZtq+A2CwdzrxSMXrZoBtDk0D30plN7L7iXDAMxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzns6m6H86yPWUEiaZqr458XqACLXQ1ptKO28AlrsGk5q6AG3vS
	3+sra+N5ifWUwGuAfLOftSH8dDsq5lm1epoQO6MprYk9k/jwhEcz2IMXHqx08nhWXc8=
X-Gm-Gg: Acq92OHbNw5AYGpVRLfrwIvd2VjcuryZwJSoV3rjQbutVO8MCBxD8wEQHe2TSXf883/
	UpEBWJ5xmNhBb6eRbkK7pMg/dduutWLr/hhO2XnfMHCtA+Ezhy6DGFA2ri1CgEyQZLEeGDRYB0i
	TIhJKVS+RkMrUFs8OAFo2XTWCchdxRyb4xTwHQQgbCvfkOS04Ug024apB0juMw5Rld6/KLOTrEK
	Oy8/ELczOVq4Ga7E6wPZ5OMqieyUJchvXwR2bkKkgRWerS5x8QZ1MsZUfnbl+JFNR/l1JRHAXDY
	2CW+k8HI/T3F05wdmVP3zw8xZKibgG6TBsigqRJQu8Q1ogdcsdGzQst2whqj9UZuRDB6lqbCoI1
	oDcDYMGGFLdQ79Ob1UYt/+LgrD0b8+mpq3sF1bTRm050LIEECV2YsYRKtf/yKMwC7x6ApkW9Zbq
	zc3oxs+ZTPMmlbmWVX6XXd87TIEoZgOLJvmTxyIKeo4BHWLD4RaDWxRdtAMyMacDss3tphVT7Jw
	oc=
X-Received: by 2002:a05:6820:4df7:b0:696:77e2:a83 with SMTP id 006d021491bc7-69b36ecc0b0mr4946784eaf.53.1778505619279;
        Mon, 11 May 2026 06:20:19 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-435573e90c1sm9393510fac.16.2026.05.11.06.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:20:18 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.10.y v3 2/4] ipmi:ssif: Clean up kthread on errors
Date: Mon, 11 May 2026 08:19:40 -0500
Message-ID: <20260511132012.1831026-3-corey@minyard.net>
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
X-Rspamd-Queue-Id: E8FDA50EC3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245211-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:mid,minyard.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hdu.edu.cn:email]
X-Rspamd-Action: no action

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


