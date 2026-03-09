Return-Path: <stable+bounces-223495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPS+KKhjrmlbCwIAu9opvQ
	(envelope-from <stable+bounces-223495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 07:07:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25010234157
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 07:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70135300D47E
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 06:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46F34F255;
	Mon,  9 Mar 2026 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaI9+fpB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7426E709
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036415; cv=none; b=JjN9Xb0ltXHLRe4ADVrD9kL5C1uzR6533xSdlKuDiZokggqiCrEtvPtgeZOEwGU0/z3kDpTe1y7l+RSsqeI1RKv95zBlZ//nQ+cx1qQhwDANETKCfHBffRknQX4hHovQD6Yv1mcUZrodqsD1KvuFgZixecwcGNKxmymDrC77f9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036415; c=relaxed/simple;
	bh=Lp+ftsTxOLed5B9S0H9PbQXH/8y95LLE6h5SJsWG9fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A869eruOvWdLGnfQCg7fCHpMFBviBlkTfD4vDbbrfL3D0UKlttMSI/8CtpdTdjfZOhTYnORq7h0UCbrEBYuJU4NwE2zyLFxj7NNLb/iLDqL85e2kT9pwBf66a6RjuFHjzASEnKlPvXJ7TKcFmeYp+BELw9LnUw4pMuIEx4dzQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaI9+fpB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae8979dbb2so13468945ad.3
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773036413; x=1773641213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWFv1BB7FN3hcOOghSBDtnN98xOSLiQpa+eHf8S5Tyg=;
        b=LaI9+fpBmE9o2zOMOVVZYM8u01MaRAm5/GjsIMxia2JOuezVbc8zwcjUU21L5w78GN
         ysYDS/M3R/Kjr9AbndhuFEicpG3otn4ZjeGqt+YQXPp7YZGTYwC9VWueZDwlrCZFPxoP
         24ZK9qfTSbJzJ81ifoBz1KkCcLHaOyRnzLZdvbEMYb7eyNI+j0BYZ67w3Q/l5i40M+NY
         boOdqS5j6eqOeTZSxM+hXO0IkkLeKn9xdeA3b2yU5gLX/7qCl383xDW0vNEqptETMTSB
         ds0JI6oC5NtmSLWheE0I4GMKL5PpeLJ9lHZXiyTBO51qru6TaKc5269orXW2uWb+BSjb
         myww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773036413; x=1773641213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWFv1BB7FN3hcOOghSBDtnN98xOSLiQpa+eHf8S5Tyg=;
        b=ZBi9/kvjRH6S2+ElZecvyPj2TqMu1kklQe345WbO4zGg/OkA99E2dBCRT+U82XspOc
         1cQG1X4rElorUxOl/cJLm5RRWXqA/OVd62UFAc5RfNuVpAd0gssu5ngs13Fu7Nz15gZ7
         Gz+h0UlUFxfrBHAKDZGgnDOnk9k+Z1wMOqct1KMj3oeA5uRYi57S1LW5rx2C0957Nk9k
         wJ+OAvLqN7kC9jTaEb1n1LAk17zZ66Qfyvv/QzlIhdKAOmABmqObSEGrP/Fa8o81qQCn
         CBMLeQU4zQdA5XMNeQ+Z3Gi2xKEkiidbQKNeljZTdpLhxRHV/hjZ8Y7BIZrezdttCyj8
         ZnKw==
X-Forwarded-Encrypted: i=1; AJvYcCV7yq29Th6cfKKIDHCTWG8k6IwdhnpHmJKZDLOK7R2G6w51UsT4/s5GH2m+nMKfEnwLFgvePzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iQHD0eTF9fKsKUIIcYrSOotJDj4yZy/5a/hOgUxxN7lxsHnJ
	px05bEA3RybM/xkX3KwcG+RLtX1hxQ2o3LNONSMuQIBHd7CZFv6bQ1Dx
X-Gm-Gg: ATEYQzzB+ybxTQrd8f9Z2Dt/7q5OoS+Dd3AF4mymPRJAI7F0yDeBQnAyhu2kwuXtKLA
	3aW+aaEVlHMnTAYAXAeTTBuQRz5j16A1KHQYHEGGDrrjzZARzDfspMf3ytGs92082hzGyMKVbrz
	h5a8Khoqur49o3G9lIfVmsQusvMVxluWFVDNtFAJ9T/FURcIUehh2xhTyJnK1gkmCFDq2mnQLPY
	QZ1jgPFph99xTyaTb/5yjAmTNqRF8QxTgWk2Z1WmXBGWkZPnUsWz2jzSZNv6G9qtW331uLQ3oMQ
	K6rqnaNDFB/3R+AAjbKNNl17h58ZNT/1hDHA6v8B3MONuedw1lwja9ccoTrUjkBipQ5jdt3hacr
	Gz1B+9/n8RZq1KxqtwFaDKMmOXJ43atxxn/QeFzSRN4qWhez41JHiGl9OSwkSwcgnscrlitUFVY
	iJ3qDMIklNq4X4gB8UBGQmlXh3MynfHX0Pf2okLlZtlAV2wFNbr7qZPlY=
X-Received: by 2002:a17:902:f70a:b0:2ae:7f4a:8e2e with SMTP id d9443c01a7336-2ae82530c7amr95865405ad.52.1773036412848;
        Sun, 08 Mar 2026 23:06:52 -0700 (PDT)
Received: from localhost.localdomain ([119.204.109.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57b1fsm133043635ad.12.2026.03.08.23.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 23:06:52 -0700 (PDT)
From: James Kim <james010kim@gmail.com>
To: robert.jarzmik@free.fr,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	James Kim <james010kim@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: docg3: fix use-after-free in docg3_release()
Date: Mon,  9 Mar 2026 15:05:12 +0900
Message-ID: <20260309060512.3634570-1-james010kim@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25010234157
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223495-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[free.fr,bootlin.com,nod.at,ti.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james010kim@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In docg3_release(), the docg3 pointer is obtained from
cascade->floors[0]->priv before the loop that calls
doc_release_device() on each floor. doc_release_device() frees the
docg3 struct via kfree(docg3) at line 1881. After the loop,
docg3->cascade->bch dereferences the already-freed pointer.

Fix this by accessing cascade->bch directly, which is equivalent
since docg3->cascade points back to the same cascade struct, and
is already available as a local variable. This also removes the
now-unused docg3 local variable.

Fixes: c8ae3f744ddc ("lib/bch: Rework a little bit the exported function names")
Cc: stable@vger.kernel.org
Signed-off-by: James Kim <james010kim@gmail.com>
---
 drivers/mtd/devices/docg3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 33050a2a80f7..603fd0efc2ea 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -2049,7 +2049,6 @@ static int __init docg3_probe(struct platform_device *pdev)
 static void docg3_release(struct platform_device *pdev)
 {
 	struct docg3_cascade *cascade = platform_get_drvdata(pdev);
-	struct docg3 *docg3 = cascade->floors[0]->priv;
 	int floor;
 
 	doc_unregister_sysfs(pdev, cascade);
@@ -2057,7 +2056,7 @@ static void docg3_release(struct platform_device *pdev)
 		if (cascade->floors[floor])
 			doc_release_device(cascade->floors[floor]);
 
-	bch_free(docg3->cascade->bch);
+	bch_free(cascade->bch);
 }
 
 #ifdef CONFIG_OF
-- 
2.43.0


