Return-Path: <stable+bounces-236008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN20Dd7a3GlwXgkAu9opvQ
	(envelope-from <stable+bounces-236008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:00:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E39DE3EBA82
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CC90301875E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8E3C141F;
	Mon, 13 Apr 2026 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAHT55EH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A83BE640
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081603; cv=none; b=BLc1XzYBSqD1JayH7PEdB3nWX04MaXbMTz6Zv2MaJq2Rict7OsIXWwA5juBEalj1vLDgAfVfIicuQLgNmjs/N4GQw15HJGK+dK7i3bMkiHZMFzySxHuD9fd2xGaM1MfkriEC0vQnvo03B6nchO7hLSOU1+uyyE+EK0Fj0LcyMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081603; c=relaxed/simple;
	bh=6fwLwWNLs1EfDGkdX3ygPgU9zxnBYk06z+iVq0IN+O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RE3VFpqnEYeicND35rNJ+FZGnhj0JKjBfibkcWZXahLtdATeh5cKwaAgFEtSmkMW5ZMaXzEusoSb/B7kLYY2ilPwGNRWOvWblSFbGhRJkfdYJjukZfte5eR2m0yI/uz4TLU9TuDmfuMYVlWso6RrxL1nn4hzUfVU5szeo1351N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAHT55EH; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76c60c7502so1643767a12.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776081601; x=1776686401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3u8EWySsHMnJmBCST1Ast9PFMWGZFxzWnCzXib4HbCo=;
        b=NAHT55EHxxUmHG/sJlomRZbP0jXVWEoeLLns7CAvoZO44nWxqhs5W5BX0SY3kRD2H3
         O49mfKq0AWmi+Bi++aHzN43uOhduJvfmphxi9ECZ8kQ82EdVP3Oe2Of2rK+vkYeHHPxE
         hazlMwpVkhOUmSVJlNvFfZEpbetmvBLPKCdpN2GOgbL6sw5jmBE90L/24IGY0h3DoPXi
         kMTfkhbF/pNu6AaYVsFl8ck0H+92Ug1Hg7lAUbWZEEUIzqfEqXpKop9w2G1otQ5ykJii
         FLxP7ZuKWSUwgD/zqLBmRbH3rWYyIe8+oCO/G914GU2/fmQgKNT2X35kqZgPZ9uVD7Ub
         2feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081601; x=1776686401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u8EWySsHMnJmBCST1Ast9PFMWGZFxzWnCzXib4HbCo=;
        b=DRQJpNsszFQK+xnAOSDEVdkEALwdJKZGpC702swi5dDFu3GpuIzGY8QbOPMyV/xowW
         ZhQ/Te7o8oPWodmi30+maap9dCUDXyrcFFDObKlk9VsV4uCOYdCS6KrA64AQ5Ie5wfNs
         BWaG+XKHcPAoUstvGgfNuHrVdqeU9azmGutvnHiI1S0TX7CLVLCQAw9BBrgEQYlJujd7
         2yNjSNnE/wf6nV53G5Zvar5hAnpeom7VB9mWEn525YaloxAIHwUi1bg5Q0zRNfJfsI1e
         oxxKQde17nC0AnnqV9LqSH9ZaPJko0HKNrd61lmtEpVWa6h+MqFRoEu1vQ/jxgLt1Q87
         u8ww==
X-Forwarded-Encrypted: i=1; AFNElJ+Sk6q8hVPX0fa8tRoUwlg0QILLfNc04K3c3gtcBiOk4j/8Ap3JrrgiIigH0Zb1Oxi24/BeIW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rbwNFEnvamrsulbQpwk5Ru9EJqxKlhApCtV61pXE8ivN3wg3
	Mgrh7+VP8koxf51GgfFYpoyKU3Z8WpV/LVuUYcy2SSRnhpH4NVPbE+LaeKPILnfTc0w=
X-Gm-Gg: AeBDieuoTOq2RVCdFH80lgMpFh4uCL/2lUI/+Ap+7J8XAMsc324tsvMMUPJ6YRB08c8
	AKPjVF5U5WXiRUDR1fKqvqLwTA7RG56geUT58FJ+KqQhPBWAiVQkfkTwygLcOwlskuwjtdKhIGk
	zBmTFRsQJ0sNhySgsl2mTTuFWdplWyV2+4i3Tcad3Zlw5zNbItv57chWffmmhWfvuGonuPEDZPu
	D+iYzonNruyX3vQPnOVA/6mqiQbRVStcqoLIvRYdwR1/GssdtGUf0BdKuwdqUXSUAbHOvNuG4Hy
	VmaKQMGbNdM29gyGxPAE7C/psN8Dn/GZbT/Mtz5VKkJafohIcwf8mrPY5jOBZtDktzCrtzRK8Gr
	waf1+y/tJzhquTEfqeXBnLFsPvz5Oo1izuGQ9xBvj52YsfBeg3j0WCSqPzXaFfMcFTYx8Yk1UNS
	lcbk6XVROu6JhMCIKT6ozUvPEJy0aa6tg=
X-Received: by 2002:a05:6a20:e212:b0:39f:48fe:830b with SMTP id adf61e73a8af0-39fc95aa2d7mr17020912637.30.1776081601292;
        Mon, 13 Apr 2026 05:00:01 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:db27:7a46:955d:48f7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7944cd52d0sm764199a12.21.2026.04.13.04.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:00:00 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Roland Dreier <roland@purestorage.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] IB/mlx4: Fix refcount leak in add_port() error path
Date: Mon, 13 Apr 2026 19:59:48 +0800
Message-ID: <20260413115949.2799399-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-236008-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E39DE3EBA82
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

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using kobject_put(&p->kobj) in the kobject_init_and_add()
failure path.

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

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


