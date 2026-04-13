Return-Path: <stable+bounces-236094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMtDOIX43GnLYgkAu9opvQ
	(envelope-from <stable+bounces-236094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDC3ED047
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C51E3091C88
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6173CE4A0;
	Mon, 13 Apr 2026 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlW24X3j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3343CE499
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088752; cv=none; b=RDCkcmmQyGoW566U2tWNfuM/qImR9ZrxukvGilccBp+m5TO1XAYiilT/9P1nA7vF8/pmJ2qm6KCXUGbPU/bwSIPvBgrolSgRH6KutbIgaK58HnZ2LPQ6yhzZkRs3UZJREbcX4yg5aO0yK4zFBO0Jv0e6RXNHyW+lg939XAiscsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088752; c=relaxed/simple;
	bh=E1bWdw6PJOytikD+btPKFm6ySZ2cUlj2DalItE7SZlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZA9dKbyNa0hedmEk3ew9Axn6ArFmgf4dNChbpWQwrih6yfURQuxIfb99f1QwUcUk/oiei8pnk1ppYyzUPW5y4x0uQPU0wVorBNO7elN8bMSdSx4LaHZydqSGlkwHBUXoev67S7FzchjWkJv0Elyz/h1EwehX1IlvQxHIFJhF5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlW24X3j; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab46931cf1so26292605ad.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776088751; x=1776693551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S8FhF3uUQSDunhYBQX60vlfAQkaL9E0JASzbAwhTGYQ=;
        b=KlW24X3jwf21cRZVq/u0f+l27OFoD4psjxZu2WegsPAuyeGHJoql+LQ5IxeMLzZ+qv
         RAP7nLhtObAJ6hFdv3sRWOnj62GCxHLGMN/Xl+gU/hPuHrfh5u82jYXVWkZZNXdMFVmV
         vuddY/+6+bCBbOLlY9913paHGaXVl7K5Vr7++B7N2z1vRP8HVVGVk2E8erkOCQDpZYNX
         NcfvByerGOx8D4REVu/s8H7ohnfSJy8NwAfo6iXtpgCpcvP8chVcJ4B7wrMR3+ebPe47
         MHA2yD2G0SURJzhkaDB7pSlvTc+dQpwKZ8EPGMgXWNEp8/C0uIBFSC8IgeArUM8IEIZb
         krYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776088751; x=1776693551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8FhF3uUQSDunhYBQX60vlfAQkaL9E0JASzbAwhTGYQ=;
        b=ct7tNTsHMYdWIFyeT+SxaJSXzdiQelNzHpjcASFBUPouqeWOcnBJQYdM3NUe7atCBE
         qlG51BqB6M1/Yb9ibguZf3yXXobvpJScxq3JoI5ucV3MvifP+ixSh2gv+yl1YrNVZPgV
         mg0pFYkF2hnWWHoMhBMCo41Os8y6FeoYgWPZ8LiQeDMRW086tF7KYvTslczVKmLj5iam
         f/Uit+q7IuF7XoySO9rJ6YqjCnIpf6ewy9w+QDpF+cXl2ajE5Wal+lC0ar1aCeKRUX8T
         6o/rkFJkNOalTPPXnM0jNUtFGDVzbTAn5K/Q9Z4rSimUIxxTwpC3Ga90ZB0jqqijL1xD
         S4wg==
X-Forwarded-Encrypted: i=1; AFNElJ/CGeB0hPKgOVpOV13frMQZnU33glBsFRMaembAM6qBrVHCPDVMyrfASFB/A2DHOWjGxpP+MOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2dg7afrB28r5OosyVd47aLIgbCsFl8rNCnCRviZqeGDnC5rc
	lEkBL/pnnmKc4tbuR0sQek3sJMrj2e53780diG0KNJB/Thef+7s1G79M
X-Gm-Gg: AeBDiev2rx3GmfTkVb60YNcPJAMaZevn3fbWy9n70S+UBI2C4p03TBkJTIz5uP2nERZ
	6YcMfl5Sy1fzY8O9f3TOeCDx2ksEk5wDQbwGd3RCRA1iwXz2OA5L0nXBW59YtNYp5LDvO+vDyqm
	R84RPNmq7c19AnJCKlBzcZGpOgqXrqoNzzKqJgc5eC/lr228E8Fb2w6UIL0vSF6YAAI54GQswGf
	FXPUebfUBjFYuIKHCsYZZtI9ILfka/5MIXNVEwU1ozRZlsUivKxE/PNhdpzPw3SZk/XyfarzInB
	FU1YrT7m1F4gOnU1usMESEtVcJntx+Lj8E8y8fzXiibRzy+9wUtsGBrzn2DDLCWxW0ZtzB/6MSz
	dbrYyv0sJbaej/8GLfqPaDd27vTvevXqaeL9ZppOZCTbeupr8pgn+VP4dG6W0SWDc7Qeh4ihkGP
	F7HpWj8GpLb5opvWKeu14krSYEsIYSvAw=
X-Received: by 2002:a17:902:8489:b0:2b2:ec33:cf15 with SMTP id d9443c01a7336-2b2ec33d1b3mr34560675ad.7.1776088750988;
        Mon, 13 Apr 2026 06:59:10 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd6b1csm114842725ad.22.2026.04.13.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:59:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: Fix refcount leak in channel register error path
Date: Mon, 13 Apr 2026 21:58:57 +0800
Message-ID: <20260413135857.2898676-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-236094-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58CDC3ED047
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_register(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In __dma_async_device_channel_register(), if device_register() fails,
the error path frees chan->dev directly instead of releasing the device
reference with put_device(). This bypasses the normal device lifetime
rules and may leave the reference count of the embedded struct device
unbalanced, resulting in a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device() in the device_register() failure path and
let chan_dev_release() handle the final cleanup.

Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/dma/dmaengine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..6bb1212ae0e1 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1111,8 +1111,12 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 
  err_out_ida:
 	ida_free(&device->chan_ida, chan->chan_id);
+	put_device(&chan->dev->device);
+	chan->dev = NULL;
+	goto err_free_local;
  err_free_dev:
 	kfree(chan->dev);
+	chan->dev = NULL;
  err_free_local:
 	free_percpu(chan->local);
 	chan->local = NULL;
-- 
2.43.0


