Return-Path: <stable+bounces-241701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FUAAMbX8GkLaQEAu9opvQ
	(envelope-from <stable+bounces-241701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:52:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDA1488451
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF21330833E9
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AE842EEBA;
	Tue, 28 Apr 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YouJ1J/B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826F42B742
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391379; cv=none; b=XDMWuzSVY5j2ywRF/c/NMB+LVlNhztcn8Rp+w6BV4GGXCTXCsFIPldkOBb4uYyf+xRORM8c6Z66HdeEblLCXYQMr18eveisiPAY414xxcYyC3jdnmx1l5kaoZz00GaqcEKRNYTGzm3kA50pWadSD0XQI1rb+oeg+JAyvZAC5QnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391379; c=relaxed/simple;
	bh=gEq1WNSpClxLJGJHfzct1aBrVImuzfvAm+8wE/BNLqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqDKg6yPsTp+mSoSSAkTXYva4om1AL2B9TSO8y3a/0yJELkNcFPNCIWGcq2lBsDeuNsBOVSRswy5RqpdcYS7gX+UgQMlh6zNAkWhH9fMbsmsaVcPyCUEYtGCplfDwMrR6kuZGGT4Aza6uFubqVfbA4U2kly1aGGqou5B3TLCubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YouJ1J/B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adff872068so56956835ad.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777391378; x=1777996178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwkwixniYzyB4iGLWVcHnfTyiUGtbDFLnU92Lc6bweo=;
        b=YouJ1J/BMRLN2JReSOGGPe2whjYVK67N8S6LyjxbqEXIkQ8L2LH5gcDGnJMBL6bykF
         xcEJi2Pv669hoBSulFjOJaIZ8n+rSeZR1vKRkJBGFdi76fAw0iJMKV2kchNMXuIkaqeE
         1eg41EU1OG28TNWsRU9Six0gymBA8Pz2ZKK++t/HS1KcV8EQDGrvVa0tDmfZgoXz2o+t
         grEOkwER4dRD1SbgaL27n7bZRdRURCoSkevtfoXWCdvLZDjI7WkWIFeO8UHhHjDLFpVy
         5G9nxWZou6HGplfMwzF0TP8v8kUmW67r3twH2RybL3QhVaQkSGBJwTUbV9UDIf/3JNMe
         ghgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391378; x=1777996178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwkwixniYzyB4iGLWVcHnfTyiUGtbDFLnU92Lc6bweo=;
        b=s60Bot1WG01UWpg3QzW70tTB87zoWB9ylCX2jaZ5IUuVSGc+lYJcA5QRdOkdceADgI
         85EkYf/vWP8Y86x4KgfM6tAuHm0qr/+t9ct5wact4yi1FxgHwke66mHZxEUUzulaIO3t
         eav71PWmaWCOpMRfDtdEh5qp6l6AHgdqVDCLpnlszBwq8f9h4StG1vbnj/+vdh3zFMxK
         xVTXEZkNubQ7boRpjrIiZ+L1pSy7ofUJJ2t1UmmxwdtYc0c3TG0Tx8XdpP/Oco3PCpfg
         CHge+G++QvEqONwTb9f9FoHkjBn8S3brEXc3fFsGcwa0BmwGftMYolGyPXqvC45Dk6d8
         MfaQ==
X-Forwarded-Encrypted: i=1; AFNElJ81AOiccOj8ZgSDCZlVcc/M5am119YQUPFxc+vD/26D6an4VyGFmhmz+zuNvwFhC6ccM622VQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfbulbDzEBpk/zWtgnwt1g8gDxIZkcJEvMW00/TxYR5WMssBi
	f3lWIclbKHCEy8MYIGZu4r6dKrNOZxF0qByspcKOtOm2wbD2DnDm1XBr
X-Gm-Gg: AeBDietaAU2fabqn+xRqDsbCaCteelqpkXh4r4Ddqb3hJVqm+Q+d7SNuQuKojdvWX6H
	pkpYEd+pluaEe1Wp5YwaNQxxPlx3CdrVEN3xkXFSi+g4gL75ZDnslv+O/gPLBY3fboq3xg0+i1b
	C7TGsizS5QPfWl/aQRB508S0uUYUT7Q9VaiFxbYlg+93fdqMok6e5paQy3m5+dJUwXc0Ur67kot
	OocgG9DAfoz8B3iLU+DvV7fV7nbzRqPNZqDN2aEFVX7nI01QrwFeY2JxOEE3DSjroZ7diEL3xP6
	JegbXhymlskheYzfqmNnMpoipZDaOteWGno8zr9f+fpAwhMAtOMcz5tsvLQOLA8YuTq2qLpsdgE
	CJnyKT9pVg8LgRbadG2K/AsVIYXam3IQ5c4v4wImzcFDqPT9finvZD3V7K3WpTOLB4IEvRd3pBB
	ay2EV5q5ik3sQPRstc
X-Received: by 2002:a17:902:b689:b0:2ae:450c:951e with SMTP id d9443c01a7336-2b97c435bc1mr23615015ad.17.1777391377862;
        Tue, 28 Apr 2026 08:49:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::5a26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aaaf65fsm30416065ad.31.2026.04.28.08.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:49:37 -0700 (PDT)
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
Subject: [PATCH v3] IB/mlx4: Fix refcount leak in add_port() error path
Date: Tue, 28 Apr 2026 23:47:16 +0800
Message-ID: <20260428154716.375069-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FDA1488451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241701-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In add_port(), if kobject_init_and_add() fails, the error path frees p
directly instead of releasing the kobject reference with kobject_put().
This may leave the reference count of the embedded struct kobject
unbalanced, resulting in a refcount leak and potentially leading to a
use-after-free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using kobject_put(&p->kobj) in the kobject_init_and_add()
failure path.

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - make mlx4_port_release() tolerate NULL attribute arrays
  - drop the parent kobject reference on the kobject_init_and_add()
    failure path before putting the embedded kobject

v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/infiniband/hw/mlx4/sysfs.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index b8fa4ecfc961..38c64b5fb23a 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -380,12 +380,17 @@ static void mlx4_port_release(struct kobject *kobj)
 	struct attribute *a;
 	int i;
 
-	for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
-		kfree(a);
-	kfree(p->pkey_group.attrs);
-	for (i = 0; (a = p->gid_group.attrs[i]); ++i)
-		kfree(a);
-	kfree(p->gid_group.attrs);
+	if (p->pkey_group.attrs) {
+		for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
+			kfree(a);
+		kfree(p->pkey_group.attrs);
+	}
+
+	if (p->gid_group.attrs) {
+		for (i = 0; (a = p->gid_group.attrs[i]); ++i)
+			kfree(a);
+		kfree(p->gid_group.attrs);
+	}
 	kfree(p);
 }
 
@@ -640,7 +645,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 				   kobject_get(dev->dev_ports_parent[slave]),
 				   "%d", port_num);
 	if (ret)
-		goto err_alloc;
+		goto err_kobj;
 
 	p->pkey_group.name  = "pkey_idx";
 	p->pkey_group.attrs =
@@ -687,6 +692,12 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
 	kobject_put(dev->dev_ports_parent[slave]);
 	kfree(p);
 	return ret;
+
+err_kobj:
+	kobject_put(dev->dev_ports_parent[slave]);
+	kobject_put(&p->kobj);
+	return ret;
+
 }
 
 static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
-- 
2.43.0


