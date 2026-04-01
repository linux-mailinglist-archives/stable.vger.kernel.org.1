Return-Path: <stable+bounces-232863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHHXGzWLzWnFegYAu9opvQ
	(envelope-from <stable+bounces-232863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:16:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C5B3808B3
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEC1303799D
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411253793B6;
	Wed,  1 Apr 2026 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHaFj7JZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967E1E834E
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077986; cv=none; b=karn3keVCld9CBshujrlG42tJ+xW99zrnMky/JWq6OgQ4OsGzShEMYJNhdsWqozat4cFiiQ0y8ph/du6UJeFXDYMlO3vMrfM5H8yu/ecfcUcLzniyUC08OyewD7/kKguhQXhLHPZ9L9dE+nJzKz4v1uLrAqwP+5oqOPtsm222yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077986; c=relaxed/simple;
	bh=rWObApzxfsdYvn3ws+PEoX4lER4tZ5DfEe0xfzAjRHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j141RpsL9CwKbythz9FaMkVdM3jQpcmeccbCWBA3eu79ZvwCgdcxvfpcBlRlJ8/GYY6oI1CTAjcMco0xh0kllNoxrZI3yBjzHIiSiMDGtifP2l5REsINgaOJPt4mQgpIHg3kgFCIR10ZgxM2jFz6YKxVhIjUWvKcyAkSu+0UKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHaFj7JZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fb14227cso1772395e9.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775077983; x=1775682783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6R/1hrVhj9KAXqORtdAULWzq8bCV8VcI7fbOEm9lpFM=;
        b=GHaFj7JZPLxZJDiXu+hLbT5w4yQHcz8imF0lTw9yW72SIX3OY1ZHruhKYbrM0QV0eI
         DmLKs4EwDsopb2iDbg/ospLQ++TQQMqeYFN7MFPqHDkTI/kVTLtnuIiV0EVwFO3z4zy9
         e+Ovxyv3y6h1TLdGrakN5WgNPQekdRUoHD+tPNeW/f2+E8qkl9FIBpkW2GeUjuW9/Np7
         3E7iFM1ngCTDpydbgh7jCKUW0YRKPpfe5SEd39zb5zoaaOMQNOIgfRXKyn22WqSPZ/nJ
         mVLLe2R0HpUSzfnPgJ02HMcZw+KumJEDj+Ki+3M+nrOopX062URepvcYQ/GCxRpxfYeq
         C9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077983; x=1775682783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R/1hrVhj9KAXqORtdAULWzq8bCV8VcI7fbOEm9lpFM=;
        b=lbLkZ+Fj+YPKQXMXYev+lUjMmFy187YEAPu+FiTwQSwSE0WDB5W4dWPlnR7SfiGtjK
         11yvon4+wGUfNPayR8NQRzwTyfx3CK+HmmYacqwyzcirRrvYtAs5RRC1XWzQsjS+7KwQ
         6jsbPiUGzSy+q510+pQPBmEe93luMSvCzWbrd9/ZOLHuoMRY0ChpaGx6bOqVfxMOiA3h
         +tt6Od55edRLmiXF+uxpnirDEpesBUzOB+e3w2Adp4FFhOA5aVR/F4z6anbQpkCnfzBo
         Ly7LaLnz9ZhkqTd8t06Md8796zH73Ox5+waV8+RYfQme5waih/7aj1UvtnM8LaPsmo/v
         kZVg==
X-Forwarded-Encrypted: i=1; AJvYcCULXhP4Y+XYdGvPv05cP0BzMdxzc/o4daCAmo+cPiT5PR3o2IoYu3oqd/SX3DzGjfd9YqnxPBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEs2j4wpP7+WtyEaLQ/bufXNN+gKgIrUTQi9lGAbn6bkUiL3Kr
	E1EAigQl0KpaAE4ZpvlzIzq+Vz9siUjeUFaqLh1nS4Nnj9qjRhaz9y4T
X-Gm-Gg: ATEYQzzWOD8B1eEl3KkgPElFosP/PTQWsW5uN4tpdeMDq/7oAdgORoVstp5yVT5qkr5
	ZXD6UDLy38CL4bpnIjYyKen71ZcD8L0Qfe/t7BiuipjJ9xazSoahjOjkrzA4ozSDU5J8Ja6gCmZ
	sg9tljvlQGMGxeoBjWCnCQvs79/cVAxxXsFE9Dd4vrQ4TSAaTccfzeEyJfgbQfJYodWtRDndq0S
	QFunSIlfItkXZcz6a1U25llBWa/UOpV048mKV4oybkWwlLt4pKG3gOj++u2zinTpbQIfMj0Osnc
	VduaROulQwdmX2Wc0fD6O3n8LXJzMs6FGSffPuPfL3elmfdRDX/E90mwJkOF69HjEqYqLwGBNcC
	UhHtQqF/Bk278bWaFYdxi3CnQA6EYB1jXrLLaM2Pe90rGIO7lnroMtlDwvZ4HNUadtzMyPLzvtK
	SMNotvbW42n/vB+NgMBCzrltWFe8PNk4BfFqK6WL4t1Uk3RTxtKL0knLktOypV4gANvZO9+koGQ
	3u4Vy4Q4BCV
X-Received: by 2002:a05:600c:3515:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4888359cee3mr92672475e9.16.1775077982748;
        Wed, 01 Apr 2026 14:13:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm142004575e9.1.2026.04.01.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:13:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vince Bridgers <vbridgers2013@gmail.com>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
Date: Wed,  1 Apr 2026 22:12:18 +0100
Message-ID: <20260401211218.279185-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[altera.com,lunn.ch,google.com,kernel.org,redhat.com,gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232863-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1C5B3808B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dma_map_single() fails in tse_start_xmit(), the function returns
NETDEV_TX_OK without freeing the skb. Since NETDEV_TX_OK tells the
stack the packet was consumed, the skb is never freed, leaking memory
on every DMA mapping failure.

Add dev_kfree_skb_any() before returning to properly free the skb.

Fixes: bbd2190ce96d ("Altera TSE: Add main and header file for Altera Ethernet Driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 4342e2d026f8..9eed0be4411e 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -570,6 +570,7 @@ static netdev_tx_t tse_start_xmit(struct sk_buff *skb, struct net_device *dev)
 				  DMA_TO_DEVICE);
 	if (dma_mapping_error(priv->device, dma_addr)) {
 		netdev_err(priv->dev, "%s: DMA mapping error\n", __func__);
+		dev_kfree_skb_any(skb);
 		ret = NETDEV_TX_OK;
 		goto out;
 	}
-- 
2.53.0


