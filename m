Return-Path: <stable+bounces-230816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PT/ILnA9yGkgiwUAu9opvQ
	(envelope-from <stable+bounces-230816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 21:43:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E3534FF0C
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 21:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A7F53015D31
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73513590A8;
	Sat, 28 Mar 2026 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8DRqWk1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C43491C4
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774730604; cv=none; b=kOiWNH94uYdoL6yn7/bnX4iSBPTFsD/xA0TPAmLJKtxVYfqpF9JjWAJvR10gcO3JVvmEvDbfLZonmgUn0q0khH0RLoOjLlReY+CIbz7M0kGDMEjaJv0b0u6KLOOIzNQRrVLtnPzKd5Xxx9HMwuzgM+IJBCTJAYu9NqEUz7MxG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774730604; c=relaxed/simple;
	bh=+EX5095f1L67iD8d4OUekG+X9JM3DOBgBP6fl+h7c8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P+YjG3SJXsMjUo0ozLLehjzXYqq3EulgwbQKxcHUzr+f3dtNc9ygOzrOH1pXgufGo9tEqu7X9WxsTgM9AA4RHtZt9tk35ER0BL8eTs1xJ1r6rE1k4RAEwu3XhFcjRv9hi7CDujaCBwgR3ZR+T6EtInpTtEfECasEKPf1Ke4q4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8DRqWk1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48538c5956bso31619595e9.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774730602; x=1775335402; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKX+S1We1s3caipzPcYGWRj3v8GHW7uxnmBU1rD2O0M=;
        b=T8DRqWk1KPib1f0c8WrM6HRacctIXr+jlZlotmaptfspY1eUWhTDSbGJJmAeEF9Awt
         0sypFZZDl/fW5isEJV2jxaI2G8xchUEICMzBWeWqsGxGaLWcGdD+c5y2954DozgMrPe3
         HdXYw50Klo4lWvmTJpv2ifS1oj2/xEY2bQQsoDbGLLmgWClA+F+4I0WrCB6BQRl1vaX8
         S4pVn6JMvsBKK7244YH53v2tT4G21so3faMg/pVFuDnq/dPWPsPm/Qon8v767Ou/m7gl
         YkC14fQsQElHL40l72VJUChy4m/gwTixipe/o4KNVAP0Hs8Dj/MGqEA8AkuK2nvc11/Y
         Cacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774730602; x=1775335402;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKX+S1We1s3caipzPcYGWRj3v8GHW7uxnmBU1rD2O0M=;
        b=HB1yYAujdh+AeAJM/7k4sM55jZKk1PbPMdNAVtKNYDZ/nZlwofR4M1lz9y6+mh7bvY
         tflCIQTFM/czyfq6InEfGk4KncOaaUT1l7UYo8HDTTNLD+saWK2xtyFr4TF2U2uA2O18
         tR7Eiqt0s+1SpNYI6+K54FCV5MGUytQ1nL9+5dhHvOlEWvk2h9Lnasf4rOqF0Q0sVAzS
         0+1pXHBPG3DeOHiLRTNlFlspbHSyyys6Ne7wbM/6+FD5ht3wyn6voOcaR1pxPLT2m+Cd
         uSk628uJo2iHPbO5LtTexDmwqMkuzMj4y6AI02q0QLkszlWX7QKWPaBc00eV85X3dW9c
         RufA==
X-Forwarded-Encrypted: i=1; AJvYcCUyQZcpHksodWBci/UOf6bgXkpb4cDEx5s9a3SGgo9Z9KrzDkH4ba2EjF2GaTWJHJP9BaRcQFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJ9co3rBm2jJ7Sb7U1r6bwXpjE7zAsvjnmjkkBlLMfSARfCnC
	8c8d+7Takp4y1edSbd3w5N9sEhgNEP4d4jRlUy3Qg9sX3MfeEtbMpQEH
X-Gm-Gg: ATEYQzyk+RfwuKlP4+hpcZJ14Uk+WA8zoUtzZQOjYdrdDz2i+N0dOa/WZgrZ/SE0G/w
	Dm76YJnci6qjBFCMrFGw1IjfuOG8wbuPQtfCL7aOlVcQKVkMQ4B+RE3jVTJvs3tf3P+51amOnjO
	cWvazr14G5Ts5TOLHveFLx2CRdFFWipVT3CyX9d+ELBOQUAxqy6+MxPbssVxQZ56Ljwiae3VrJQ
	qM+BVyn9wcnh5rjR3+MJIuOf1Fgd9KRYoofAT1WnlynVkEvj6DWydfZQRZ4N1zk4E6qtivOKuD9
	hezdxCwB7/MA88tKqLVASNhtfH/oB1ibLJ3qh44FQiyN3dh+ZN57gHdT57oPYxGrDIf9g1QPdFs
	DYpUCkcPO8vPPMefvzHIHL3EF5egbZQRU8Wu0nI3CfiaV5b+jKW1glHcqSpJFf04oayGSg8xbiw
	sVKlKmaMujIjVA6PeNIKYCww/b9LJBMULG3hH7C/5zLfEutzSTHJv8tRsFpspsDQe1O+wVKxEtl
	KDhK8TMNI3Prh568uPd4G7WMw==
X-Received: by 2002:a05:600c:4e0b:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-487290a9254mr102394915e9.1.1774730601395;
        Sat, 28 Mar 2026 13:43:21 -0700 (PDT)
Received: from [127.0.1.1] (93-140-187-240.adsl.net.t-com.hr. [93.140.187.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730628efasm109519825e9.5.2026.03.28.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:43:20 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 28 Mar 2026 21:42:16 +0100
Subject: [PATCH] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MT3eySFCMLA0PdglzdtMwKXUPzVAtzQ9M0i2RjcyWgpoKiVKAw2MD
 o2NpaAFlB42dgAAAA
X-Change-ID: 20260314-ktd2801-pm-fix-17e8715f8c37
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=duje@dujemihanovic.xyz; s=20260328; h=from:subject:message-id;
 bh=ZxchMbxwniYIWnT9R7/2Td04/zp5hTI04KiKc8j4Q4g=;
 b=owGbwMvMwCW2z0j3+uHIyKOMp9WSGDJP2KbHtWVJlUzc/WPZVv0I27N23+16d3Wnzf39bl7+j
 oXvMxyyO0pZGMS4GGTFFFmYl8pd4ksNn+hQZJsEM4eVCWQIAxenAEzkQATDX5FW8dMPdCXrznXM
 nLJB0ap+xqH2987aWyZUy7s4d+8MS2dkmPQxZZOGwjfGGCXuy282TzVXupY8dWbx9jULg9O4epL
 nMAEA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=9BD463017690089DAA8DC266275F544B3B1B4792
X-Spamd-Result: default: False [-1.54 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230816-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,gmx.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dujemihanovic32@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dujemihanovic.xyz:email,dujemihanovic.xyz:mid]
X-Rspamd-Queue-Id: 27E3534FF0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Duje Mihanović <duje@dujemihanovic.xyz>

Boards using this backlight chip do not power the backlight off on
suspend. Enable BL_CORE_SUSPENDRESUME so the chip gets powered off by
the backlight core on suspend.

Tested on samsung,coreprimevelte.

Cc: stable@vger.kernel.org # v6.19
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 drivers/video/backlight/ktd2801-backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
index 17eac1b3bce4..1b1307e03b20 100644
--- a/drivers/video/backlight/ktd2801-backlight.c
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -53,6 +53,7 @@ static int ktd2801_update_status(struct backlight_device *bd)
 }
 
 static const struct backlight_ops ktd2801_backlight_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
 	.update_status = ktd2801_update_status,
 };
 

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260314-ktd2801-pm-fix-17e8715f8c37

Best regards,
--  
Duje Mihanović <duje@dujemihanovic.xyz>


