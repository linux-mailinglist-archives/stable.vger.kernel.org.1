Return-Path: <stable+bounces-236089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCIWApDy3GnZYQkAu9opvQ
	(envelope-from <stable+bounces-236089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:41:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FAD3ECA7F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21DFB3015A71
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80373CD8C8;
	Mon, 13 Apr 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j21TxMxD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C843CD8B7
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087684; cv=none; b=ih5nFP+2YYSfcrfQEwa4aoQmFUEn0L6+PTi1rPLshQeI5G1Gz3Yz1e//OH7BxEC9RKdrzCSkVjkVjTVo9oiyu5Wp+5A4oIWBjtIMez4JKZrNLpBsPiig33MTig/TuwhMnjFLS55Sa32Sw7CExPhujB0xId87CEyW2bOua2Czgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087684; c=relaxed/simple;
	bh=lKjh2VoQZiyO8SauvRfoqvhKvOTpAYyrbd+624DOWYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDy3AsuL1B1w5ItlHLQgNjkeBpIgARTujXQcX78gKg8dnxpwrqD0me75/Quepmv9fv5e+B4O7yZuwpAGPevH96zhAmK9DPC/W2f4yY+ESJG7CWwyD+c2jXwbx9Vbz0UqZSmgijVykZjr85uQ/MgfEUhvs/LhV4PuKpOVCHhf4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j21TxMxD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76c067bc51so1564751a12.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087681; x=1776692481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Okx6V7j8TV1N3MeUy+n26P/+RkIW771eIesahlBsPI=;
        b=j21TxMxDbc0GgSit9+dqLLFqThkv3Jj7jcLerteA0yOxdmsraKygnbyQc0JslyXf8m
         Bx87FKW4oEfZnJEJRz7OhKlFrB7gqtQJLvrZFkVX0i6ySADK9hQen7X08NsEE4wHUCMJ
         gk4kDViJgUi51aOtSFk1z08osbHbwNwVCx2NUsyEhMBbqLo3+MAf43/xK7vlK5X+lmJH
         krj8MrnBHvHq4sQs3i1t0ROme15+raCW9lo4am9JVp5tV9NvdrCe9c9Xrls2hm+1WJ3g
         jT6tCvb2XbaYrZgOA3MSf6r9jcLli/WbMHa/jURlSLmHbl1SDNffBeTZrRPBHv4eofFh
         o9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087681; x=1776692481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Okx6V7j8TV1N3MeUy+n26P/+RkIW771eIesahlBsPI=;
        b=sA6lJ5aMQQ0CmojW4K/hUWSfEMK81lO4HBP2iBN2deRjB8WkoC1vCbO81+nkk97SIH
         DhPVkoxXhMQRYSUuYPI+2M4A/8hvkxiIbNzkHmw+Hg1eDm/yaqZ0sLIKS8QS2FcR3IpK
         8csWnTF4zE7Y+uC06zIQSqPkUnfssMy58q8n8483gaOG02mllvBibIzxY/JDbLOG8O2+
         KXKuZX9tul1ACn5Qyo9WgqYKM051PsvjbUt7Ph/y/BKjVJeEsD+jzjjjIWn4jBLkfkBh
         mD9cWF3hHrHjCffiiiioMGEpFFsozbCHcKK9/Gdb+mXDkEMuMelkbbiXulnKfaEg/4eT
         tRJw==
X-Forwarded-Encrypted: i=1; AFNElJ8TbOr6BnG737RxywKVe0991U9GPOqbhLhKiZtggBayJ919HdH8YJDeZod9GD6YgkhD+dwIY5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbzEjmEcvQwd3oY0ucMzPjYvONGv7pEBtWSGxF9wRZkkSSJvd
	Wh4Zy47969aDsD+yzi1mwsLP9EmvCl8pthIUEbPHoGRMcgjj3xYlJ77k
X-Gm-Gg: AeBDiesQ0x8TviVMfMNy+7JsF3/kTqvaOsMPgeM7SXRl4UJmll4OOEauj9UAdxls4fx
	6y2uTNajJ75BQsTHYYX+ho2bSDM63rE2xDbRwDh9tJ7YPk8JGgbMnnaUXd18OiutiKAtaYEENoK
	tRap1UDnOzeT31HYbUiTdyzX3QYL79PuhEKIFWYu5FDaR2bnnVXZz+Qu+0imV9friQiM9qc9a6Y
	oaWy8z5+Rwie3Y2iHICVxpqcLOhB1D1QZz9LfrZKJnx9cXFkPpdodeg2HCkXMqXmB/th159n/qj
	fDKtakZu8yVIh7H2OosfyXTVL3L3RvIQwn7brmFFs4rxOH9fcquhZHPRQCZHPrjZ3AkoASY5uU9
	YbwJWuYb8TBir1Zl2frgh3m2DFxzhiuF0LZcNIDC8P+BJqKnb86igE+W4Nd3Lk8FPLb1TNH0HKX
	wo/P1yRKkkAL9bPMbFb/gG/FOG63Ef0Hk=
X-Received: by 2002:a05:6a20:3d85:b0:39f:d71d:4e84 with SMTP id adf61e73a8af0-39fe40521bfmr15421807637.51.1776087681339;
        Mon, 13 Apr 2026 06:41:21 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm9924360a12.28.2026.04.13.06.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:41:21 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] driver core: Fix refcount leak in node_init_node_access() error path
Date: Mon, 13 Apr 2026 21:41:09 +0800
Message-ID: <20260413134109.2848329-1-lgs201920130244@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236089-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 76FAD3ECA7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_register(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In node_init_node_access(), if device_register() fails, the error path
frees access_node directly instead of releasing the device reference
with put_device(). This bypasses the normal device lifetime rules and
may leave the reference count of the embedded struct device unbalanced,
resulting in a refcount leak and potentially leading to a use-after-free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device(dev) in the device_register() failure path
and let node_access_release() handle the final cleanup.

Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/base/node.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 00cf4532f121..2b19959a374c 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -171,13 +171,13 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 		goto free;
 
 	if (device_register(dev))
-		goto free_name;
+		goto put_device;
 
 	pm_runtime_no_callbacks(dev);
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
-free_name:
-	kfree_const(dev->kobj.name);
+put_device:
+	put_device(dev);
 free:
 	kfree(access_node);
 	return NULL;
-- 
2.43.0


