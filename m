Return-Path: <stable+bounces-235755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALM3HyWE2mnI3QgAu9opvQ
	(envelope-from <stable+bounces-235755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:25:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134073E103E
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6CB0300BBA8
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9663B8BA5;
	Sat, 11 Apr 2026 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDheNJIF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168433BA233
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928347; cv=none; b=jAwVwenFZeUqPa3UatrSWpSrsurRVpcD6+yT1WVJoCGY++63Zzj6AhKorQLnPXIQripE0NHPcEYv3SjkgC8v+ndE0uQVHpol+8MySvgF1SZK3Coti5OJoTR5R0puhXCFXVvYe1Q4aX9rL6lGWSErxx1TUUBMRpEZU7mlmPfoBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928347; c=relaxed/simple;
	bh=cHEItWMGsxui7obTfk7zB3iBxAZVZx29TwvBEW3RklA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umcs5XQOFvglJA8TPyNI5WgdB4gBF60lrGJ32VGGA+2mQopVKfiUqErYeoUpkyxFR1JMuN8EKH+CYgsPgrHIpcd2FUrnyaLekkDYOZsBwGLCqcqoVxNTiUSc+zPWX6qEAeuB9hINmqT8IQ7mzhvCBUf8RVM6n+Y2TUanbGtiql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDheNJIF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a29e6110so34194975e9.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775928344; x=1776533144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1qlsFSO91cSuxSu+S/gRW8mV0vEe3bbJ+ZdqYahD6g=;
        b=RDheNJIF163YHMjFjOstxuFyouuxeNcCEEKQE9cBagNsYwCsf41pF+HD4UuiUJ5Ml2
         eMB+cxqFfoHHLzEiOT4DU8ghpojEufi0XUSFWD8R/2zdN3/wM0wWKNkslwxG2nMOn3E/
         bEAE7bv+tmHPSG2asgMgdgF44ZoxReS7w0PA/XEOwmKpwIcRl+96B5ZogIpTasjJgEJL
         EnYEPaVNSPBpEslxqZnL5VU4M4zByeQUca5Q9DdHPnlWUlRwZFFgBSzrDR0gmaKnIckQ
         XbIj5YxDvPAD+P5gvdfoxVkp8+qjzkC6VQe96Z44FWwv3J9MxAS1JeWgcY6KpZlB+QxT
         gD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775928344; x=1776533144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K1qlsFSO91cSuxSu+S/gRW8mV0vEe3bbJ+ZdqYahD6g=;
        b=b1w3S5geC6CI/3gjT3EP36mOuAZm/mTj5rf9n+aWf2+3RosRZBg+08jPrRoUWKNVEb
         i+T9+D2x8tacxjgvwoLeVrQNRCRBPTfsyEpcDNu8sOhFxNeu74heUZiWEGtLx+hOlUGT
         IWxrvMaLa2pk8bNrsNYp0LG/UzPZpJUwvpqV5YbdtiwyN+pFUFJS2ft48x89L1lA+dV2
         bQHKRcazZwUQjVj1VKyveKdOwmECw982Tp3hMv5QIBTExp8fPSze0XMlINhFCHoEn1Bt
         yvhTuuzHVoMpEpbhbwigLCgbqUqo0fABKn7hVWpM1REn9pImWyK/GLQadFUfA3CtZYgC
         enOQ==
X-Gm-Message-State: AOJu0YwgbhXPFr98/2P03sJ1K2p7yjFhvYUwSfDCi1Y513TIbuJQWqDk
	Uh1LhIDI6sEdZMF3oTPkg9D0Bv+65VyKZl/+DKtgnRHXReRgCHPTJ2k6ZawNigTX
X-Gm-Gg: AeBDievO08M0ebwE9IiSijd6PhBE+GkK94huK1hUziJe+RmwYzkZQge8IGDSbjPgfdh
	DXnI3WyF0dhNQszoiPkPl8pmKjxoswG0puzpJwpQ7jNSQQwDWr1GQzP94arGiQjt68kV3ch6vIY
	tVs8zmWijCL44wmbH6bSRmboBMlzi5OBNZvu3ER8NFsG6huYumY8moWbUjZCTv+VfI0JwkPkuAX
	Rs2u0igLzAKIBQgfERPqkRCYuIru4B7VfZCxSygZIdDDVECA56T2wgtrCWrIGnSYosfWwCMWQpb
	lOzGDduw/ZFN1/J8IKmuwdaGXwYoobiWKiPTEuhoKTdz0hzJoHeupMzqNwjJvRjwt9ueG2Mf50Q
	nJTDl5nyumUJbnfE6ypEMB5z9rSGiRszY5lL9lN9eA5bEuA93jzPDxtAo+1P3wNRN1bCOb5MrPc
	YmVcqs8ax6NTOJIcEbK3SwZWfO9Hg9eXwxAXOgNw8=
X-Received: by 2002:a05:600c:45cd:b0:488:a82f:bb96 with SMTP id 5b1f17b1804b1-488d68c7fc2mr86711185e9.29.1775928344407;
        Sat, 11 Apr 2026 10:25:44 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm64176515e9.5.2026.04.11.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:25:44 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 6/6] gpib; Add register and unregister calls
Date: Sat, 11 Apr 2026 19:25:11 +0200
Message-ID: <20260411172511.26546-7-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411172511.26546-1-dpenkler@gmail.com>
References: <20260411172511.26546-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235755-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 134073E103E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register the driver for new 72130 based pci_xl board type with the
common driver on module initialisation.
Unregister the driver on registration error and module exit.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/ines/ines_gpib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpib/ines/ines_gpib.c b/drivers/gpib/ines/ines_gpib.c
index af9693c33b23..3562f3184c28 100644
--- a/drivers/gpib/ines/ines_gpib.c
+++ b/drivers/gpib/ines/ines_gpib.c
@@ -1500,6 +1500,12 @@ static int __init ines_init_module(void)
 		goto err_pci_unaccel;
 	}
 
+	ret = gpib_register_driver(&ines_pci_xl_interface, THIS_MODULE);
+	if (ret) {
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
+		goto err_pci_xl;
+	}
+
 	ret = gpib_register_driver(&ines_pci_accel_interface, THIS_MODULE);
 	if (ret) {
 		pr_err("gpib_register_driver failed: error = %d\n", ret);
@@ -1554,6 +1560,8 @@ static int __init ines_init_module(void)
 	gpib_unregister_driver(&ines_pci_accel_interface);
 err_pci_accel:
 	gpib_unregister_driver(&ines_pci_unaccel_interface);
+err_pci_xl:
+	gpib_unregister_driver(&ines_pci_xl_interface);
 err_pci_unaccel:
 	gpib_unregister_driver(&ines_pci_interface);
 err_pci:
@@ -1566,6 +1574,7 @@ static void __exit ines_exit_module(void)
 {
 	gpib_unregister_driver(&ines_pci_interface);
 	gpib_unregister_driver(&ines_pci_unaccel_interface);
+	gpib_unregister_driver(&ines_pci_xl_interface);
 	gpib_unregister_driver(&ines_pci_accel_interface);
 	gpib_unregister_driver(&ines_isa_interface);
 #ifdef CONFIG_GPIB_PCMCIA
-- 
2.53.0


