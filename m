Return-Path: <stable+bounces-236162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBs/KzMT3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:00:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC393EE40C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6A283017243
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B623C39A;
	Mon, 13 Apr 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlwGmBRN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5761BF33
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096034; cv=none; b=CBlPprhJ9ExS8JHqzSkVfHOirY3kB74yIvWfyg+WfHtwpYoOMWvvfKM/p1ziSTKi7CvtCUBQTBSjH4t0en7jAuA4nTpRUtwpuY+4XoJiAoBT3DqrhAAS+QM24miz5WkKQuxHqrEjeaB+f+NeOCXWyjcKZAx0eSeQ7giyteGh1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096034; c=relaxed/simple;
	bh=GgZjLCH0gg3qwca6WYNfwT2avfhsGUzd4ibPnd9l4+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbTJ8KgMNIlRg3Pb888o4RbMvO4MRyNohymH9pCw8S3rC0nvf2UKMGuve8bpCCQQrgiZlG3rg1C8DDowskGQ3UoBJJp7f6/UTb4vIQu9k/C+2Evzz7kGq8GMLcFLTpcx63sTJV99Qpja38SKuSp3mc+vh+t8SoSbzh0Kxosoqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlwGmBRN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so2880750a91.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776096032; x=1776700832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiAoS81dXNfOGTcC/4JRvudQMKnDPM9FaJDmTN5qYwA=;
        b=XlwGmBRNAVZXbUVw3ATUe+NcuN2efiVDCytUOwuPfVXAlytXuI8nfXOc/Us8+grXOP
         rxt2Q/MJTcIYZ6I+tQj+CEbjQO5fGK3PKa/oOXBRk19o6oad7uMBv52T803/6LXwW7LX
         7NcXccEA+0DjIwMqXU+CV+JXzoO4anFBTyNgtQlXp3zcQ1znG9EWrQrWXfLONTzmgZN3
         Dg7qZvp0iBG2dw+E4PFudeMiRVzQnoo19MmVqBt0hFjhnt7b8T0cpjwtFp5JEFUn76vm
         8CF2hXOJUg2ZxuAkxRPj49SRrtgs0ElIvD0ajuUvbvfusR46alRAZIXEe7MTokrqNcZ9
         YGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776096032; x=1776700832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiAoS81dXNfOGTcC/4JRvudQMKnDPM9FaJDmTN5qYwA=;
        b=JCH9yvVDVP/2mg2L+e0HIYsAgAtI/nnBHTogO2nyFWiegRE/bVEmWe2bTNTMvBdhQK
         P4gB9ZtpzaxOFkUP+lZkicBmaJboEBA82wAblvFnvinNq6qCr22i4dAB5LO1nsCBwyK5
         4eubxba/zue82yHhButJPHjcqDfP639j/GWOv5/k1SEfQevXPKOpczZAtnDLgxwxfG+3
         W+60LxfdelXKlNB+/p4ghx/ie4Ldyu4UQ8X3ia++PuJH21qZ5i81KYQF3/I3rYPexYVo
         NQojfCOWCiJPUAO/btnOAZKgaiuBmOZvhQy5lWW4k5hW2szQWIKx1GahDkGy8HfUuUp4
         avpw==
X-Gm-Message-State: AOJu0YzM3W64dC6sfRpdAbPUSX+TD3vuchn3n0ZLfFOxLeguzEU3Nrnp
	2Q7+6EOEyU6tPihuy1jXKq69bjFFW3/5LkfJSDMqT9FE9yoyTBP6v2cX
X-Gm-Gg: AeBDietuui2LYkp4nTLp08MJhvScScVGPUxjAchGzArOmoanNigKI4OPDpLsm1QlxyQ
	o5qGHSvGjm3oEUVaceSirF+muvmcVO+WuEZgIjKXF93V/PRxDK1gF3jk5irXRClaINdjf2ilhG3
	BO6uwG2h/1rBSxQqXm6n4kKXioWr9/DZE6CHrNxZ2Sb446Ympga5U73PNX5p9UW9sdwcFr6Ftp8
	ebyCAEZsHaUY7LmAAX9ZR21NWsp4+Mry2dhGRe2M4PBhRZD6xoHI6Z8awCpJdqalYwQyxWqLvbl
	rvvj47yhLKZ9GfkfMUpaps8M64AHHWIxzmyPqU1+kKkvmXERiGYEnpVMY5JX0z3u6/Pxqzh8JbT
	Lr0XWr1X9q7P0lqDsrtdslXFImApCLTN0PzpjJExJeodcUHPVuR/ObIr0qzqnbloJzBPbIfPTB2
	56F3zxL7RZGArPdo2b7appg2Czg/3v3s0=
X-Received: by 2002:a17:90b:1d8a:b0:35e:30bc:96ed with SMTP id 98e67ed59e1d1-35e42781abdmr14244297a91.10.1776096031284;
        Mon, 13 Apr 2026 09:00:31 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:edd0:8593:d07a:ab64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb37d6e36sm4778211a91.16.2026.04.13.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:00:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] eisa: virtual_root: fix reference leak on platform_device_register() failure
Date: Tue, 14 Apr 2026 00:00:15 +0800
Message-ID: <20260413160015.3061010-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236162-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AC393EE40C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

virtual_eisa_root_init() returns immediately when
platform_device_register(&eisa_root_dev) fails.

The call flow is:

  virtual_eisa_root_init()
    -> platform_device_register(&eisa_root_dev)
         -> device_initialize(&eisa_root_dev.dev)
         -> platform_device_add(&eisa_root_dev)

If platform_device_add() fails, virtual_eisa_root_init() returns the
error directly without dropping the device reference acquired by
device_initialize(), leading to a reference leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by calling platform_device_put()
when platform_device_register() fails.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/eisa/virtual_root.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/eisa/virtual_root.c b/drivers/eisa/virtual_root.c
index cd9515d9d8f0..93261d2e3532 100644
--- a/drivers/eisa/virtual_root.c
+++ b/drivers/eisa/virtual_root.c
@@ -50,8 +50,11 @@ static int __init virtual_eisa_root_init (void)
 {
 	int r;
 
-	if ((r = platform_device_register (&eisa_root_dev)))
+	r = platform_device_register(&eisa_root_dev);
+	if (r) {
+		platform_device_put(&eisa_root_dev);
 		return r;
+	}
 
 	eisa_bus_root.force_probe = force_probe;
 
-- 
2.43.0


