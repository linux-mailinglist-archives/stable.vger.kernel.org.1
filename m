Return-Path: <stable+bounces-235698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPTID4gR2mlAyQgAu9opvQ
	(envelope-from <stable+bounces-235698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:16:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B23DF21A
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2558A3017C39
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338AB2E542C;
	Sat, 11 Apr 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH3weYPj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD323EA92
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775899006; cv=none; b=LYMgmnmdEIb2OgUZMqXrJpZgxxTWlRK9Pjf+xocPLPzE/NY9fuhxZKwvwQrOQ3Ix+icwYQvSjigIa3RG9CE1utRhLAYqhzl+QuxPyrr0CN7y5nKXY+GvoLrRkzdmfP7HvkVWSkygwp8hGD6r9suU8F4bmsAtyojPuOcBRJvzRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775899006; c=relaxed/simple;
	bh=4cJBpCDiEBe7qt7GJPuMpwIfRIEI0o7LsoLWIcKcUEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hya766577TuQ8oT3tCSABHf6orFwFaWJnAnTd38FqFM2YDatnwiwMditphsnDR11gY39X28hlpkSQ5/eJl9Dwp6F6qUwf87m9egVZt7NOScqUPZnxz1I1V2xWMTKdRw0NG7yEpF8ot/ol5IQJmGhLDqS/+/FNrp7s5iAcv8OWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH3weYPj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so1033852a12.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775899004; x=1776503804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee1xBpF696KRQU5YuPaGT3opYPvf2ZuzXEPOX6aVSzc=;
        b=iH3weYPjRPO1VQjlmSazAUImG/kOpk8MJEJMKg0OVtPJEmd/NSuCaOXA8giuQHEN2L
         8FLLa8n9ue7tPJOwvj2o3iZcfOqYdhzQk7T9yU+dQXLTU/uxDrGnSGNOOv1oEZVB2V3E
         AenMFvVWBK9Lp/de25tCpXpHSdqMgHC+RVyNMjR5cA2uJr+QSSgWA3o2cOk3NPbSN899
         WohGt71nbnWfAAX6w+OqijmrO0XISlP4hAS9/l1A97XjmgqArQ7ANtXJHjAx/kMBcwxF
         X4iAheCQwqL1OgGD9Sm+BfVsEsj6j9n4f0eiAJXSYyL0Q69N53l6WjA3OwZrGsXHoUwl
         c5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775899004; x=1776503804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee1xBpF696KRQU5YuPaGT3opYPvf2ZuzXEPOX6aVSzc=;
        b=JQxoks1nTF1r8C78SI8xBKjoYYPGZ02oG9A5dGwR8iMK+yVor1BfYrqIsxv/2nlKAU
         UBF3fwhj5DMYa/no/6yw/N7Gj0DdoVRz4yiPmMPofzp7kp8Z1F2hmVj+ozFrx4aY4Cbw
         OPQ1JhV6yt8TZQBAiSd1rLIgoxV5GRKg4jQpndrAB7hf2EVq+L6hNR5TVtuVLORnLLqb
         RKt/V0wazHYAP6dsrwjvHdGauRILJ7ITHh3X9wngU8lPcrnv5TUPiD4mIH1IUF4msryF
         JrpbDRspokg6wbtHRjKkvn25uJqY1jJ6ZzCiRdnYu2jORpwvvQ6MetR+88S/dRS1HAPf
         Gofg==
X-Forwarded-Encrypted: i=1; AJvYcCVEAnhArVSvYR0+FAZx/hnj15OKMDLS54VqLw7yRiiUoR2kjIoqk7wykTnLGUh4G/N2eW859Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUgrqEvpXyqhGP0jifxoOtEIdc8vxBWJ6qBWbcojq0gJ9LWx+
	NCSqWfTscpTyiltEPrVlZiVLH2GNL7NJHDVJKBDMOPflOqm2HAOTyeQj
X-Gm-Gg: AeBDietKRJUmIkMENdF2wkS/HefRPCF+X+vViHfwudsdhBV2l1S6aW3IRkLVbVvtvyg
	Ob9gvsjCaGCLRGIGMCLjNFI0l2ZFdEi+gS0HzvQGGvSEUiXovYU3gTtQE06MatPfbzMoBeDsafB
	qZi4uG+mGunfaXQinTDcHFbgnyZxlOGq2aoXfHp1UmAxjBMxabxDGTsgKNEaKoAEEzTJ2PprjdA
	X9JqAcaCWSVQqJpdZADA42Vd2IrN4Sl8C0exBftPPbeY1u7Uxn4J59fWoVeAa/m7Bk2xMbQSwNU
	6gFW0wrBBDuFhMkgOVOsX/AQMYlKeidZJecGyrLsQZPO44EASAQ1GtZD016eb4il1+93KT3uKNB
	CbvHzoqQZ5CR9IGRc8bxSXO5T2S3FhwCllTT5oFdsizWqYvRf7QIevgqX+8iuThYO6NW3pJz94U
	stNNDs65te7bFS2QM1wtIx1A==
X-Received: by 2002:a05:6a20:9155:b0:398:79a8:a303 with SMTP id adf61e73a8af0-39fe3c1a654mr7200265637.2.1775899004214;
        Sat, 11 Apr 2026 02:16:44 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b62c2sm5362693b3a.38.2026.04.11.02.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 02:16:43 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] IB/mlx4: Fix refcount leak in add_port() error path
Date: Sat, 11 Apr 2026 17:16:26 +0800
Message-ID: <20260411091626.2141130-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235698-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE6B23DF21A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In add_port(), if kobject_init_and_add() fails, the error path frees p
directly instead of releasing the kobject reference with kobject_put().
This may leave the reference count of the embedded struct kobject
unbalanced, resulting in a refcount leak and potentially leading to a
use-after-free.

Fix this by using kobject_put(&p->kobj) in the kobject_init_and_add()
failure path.

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/infiniband/hw/mlx4/sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index 88f534cf690e..15b36b9e4bd6 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -642,7 +642,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 				   kobject_get(dev->dev_ports_parent[slave]),
 				   "%d", port_num);
 	if (ret)
-		goto err_alloc;
+		goto err_kobj;
 
 	p->pkey_group.name  = "pkey_idx";
 	p->pkey_group.attrs =
@@ -689,6 +689,11 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 	kobject_put(dev->dev_ports_parent[slave]);
 	kfree(p);
 	return ret;
+
+err_kobj:
+	kobject_put(&p->kobj);
+	return ret;
+
 }
 
 static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
-- 
2.43.0


