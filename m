Return-Path: <stable+bounces-220459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHrNBNI2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A631C61FC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1E5E30A59E9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD273BA256;
	Sat, 28 Feb 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSTqe6Ro"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B833ADB2;
	Sat, 28 Feb 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300347; cv=none; b=llW3b9rH3RWHXJKW3zIouAJQBtUlNB64Nt5PpOJ9hzD3Zc62M2ef3ZwkOzq+RWBc7+6yzAuK+YGJ2+PvdMqzreyOGmDFj6H69lUuC+iVE8UQUNw61Zid77GMkw4VkZ/YsZKGKQCbRcoRzHQYTyzpNsqGv4HtYorRZI9hTDVcfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300347; c=relaxed/simple;
	bh=eD98eyXOyek+cKc6dwkZtVgNb4YCbeFxdh7tKmVmhy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMCs7oJHvhyxYWQWHfYgpGAzo5kyan2iLu51oTRuTOEsZyTcCa+UznNDmqy65AmfnmU91YZgb6ntvxJt6u+zPSt5o4mL26IJIsz5SgfE8V7ehCvSBXkMQErkjWg60F6EQmxU8aNju8VmS0ezVjm1Ta3cSXVHPlGZetSBe4miXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSTqe6Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630CCC19425;
	Sat, 28 Feb 2026 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300347;
	bh=eD98eyXOyek+cKc6dwkZtVgNb4YCbeFxdh7tKmVmhy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSTqe6RoM4NQlLzkUete474UIQrHQrRI7BRZ3XS0Bb6FRunV411B/RBZcRYhQNO7p
	 hnAwdwSKwjBsSESEUG/S1kfKlfLEer3hdzojLqeG2ICOfnzQgzWhLnWXQ1lEHtp7vq
	 Uun6IATPXXUH13tsPqGToJKC/S5UdncqQupUBAmQ7hM/EluPTkfDyNO2bQjn3uEc24
	 TsOSC1uPdEPpUMo2Fm/zUsv/QhLhLp2pg5EHwNeeyziWFIX+aYkhevHxiS5LzVCIWA
	 HT/guySpcmhtzlNAnkay9ds7hyPzBR/38ZJ3+UlfyIccDmoejdtWtwk+04wa62YUq/
	 Gq6VcnckiMMQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liang Jie <liangjie@lixiang.com>,
	fanggeng <fanggeng@lixiang.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 380/844] pinctrl: mediatek: make devm allocations safer and clearer in mtk_eint_do_init()
Date: Sat, 28 Feb 2026 12:24:53 -0500
Message-ID: <20260228173244.1509663-381-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220459-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 70A631C61FC
X-Rspamd-Action: no action

From: Liang Jie <liangjie@lixiang.com>

[ Upstream commit 255b721c96046d4c57fa2268e4c72607868ce91f ]

mtk_eint_do_init() allocates several pointer arrays which are then
populated in a per-instance loop and freed on error. The arrays are
currently allocated with devm_kmalloc(), so their entries are left
uninitialised until the per-instance allocations succeed.

On a failure in the middle of the loop, the error path iterates over
the full nbase range and calls devm_kfree() on each element. For
indices which were never initialised, the corresponding array entries
contain stack garbage. If any of those happen to be non-zero,
devm_kfree() will pass them to devres_destroy(), which will WARN
because there is no matching devm_kmalloc() resource for such bogus
pointers.

Improve the robustness and readability by:

  - Using devm_kcalloc() for the pointer arrays so that all entries
    start as NULL, ensuring that only genuinely initialised elements
    may be freed and preventing spurious WARN_ON()s in the error path.
  - Switching the allocations to sizeof(*ptr) / sizeof(**ptr) forms,
    avoiding hard-coded element types and making the code more resilient
    to future type changes.
  - Dropping the redundant NULL checks before devm_kfree(), as
    devm_kfree() safely handles NULL pointers.

The functional behaviour in the successful initialisation path remains
unchanged, while the error handling becomes simpler and less
error-prone.

Reviewed-by: fanggeng <fanggeng@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/mtk-eint.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index c8c5097c11c4d..2a3c04eedc5f3 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -544,24 +544,32 @@ int mtk_eint_do_init(struct mtk_eint *eint, struct mtk_eint_pin *eint_pin)
 		}
 	}
 
-	eint->pin_list = devm_kmalloc(eint->dev, eint->nbase * sizeof(u16 *), GFP_KERNEL);
+	eint->pin_list = devm_kcalloc(eint->dev, eint->nbase,
+				      sizeof(*eint->pin_list), GFP_KERNEL);
 	if (!eint->pin_list)
 		goto err_pin_list;
 
-	eint->wake_mask = devm_kmalloc(eint->dev, eint->nbase * sizeof(u32 *), GFP_KERNEL);
+	eint->wake_mask = devm_kcalloc(eint->dev, eint->nbase,
+				       sizeof(*eint->wake_mask), GFP_KERNEL);
 	if (!eint->wake_mask)
 		goto err_wake_mask;
 
-	eint->cur_mask = devm_kmalloc(eint->dev, eint->nbase * sizeof(u32 *), GFP_KERNEL);
+	eint->cur_mask = devm_kcalloc(eint->dev, eint->nbase,
+				      sizeof(*eint->cur_mask), GFP_KERNEL);
 	if (!eint->cur_mask)
 		goto err_cur_mask;
 
 	for (i = 0; i < eint->nbase; i++) {
-		eint->pin_list[i] = devm_kzalloc(eint->dev, eint->base_pin_num[i] * sizeof(u16),
+		eint->pin_list[i] = devm_kzalloc(eint->dev,
+						 eint->base_pin_num[i] * sizeof(**eint->pin_list),
 						 GFP_KERNEL);
 		port = DIV_ROUND_UP(eint->base_pin_num[i], 32);
-		eint->wake_mask[i] = devm_kzalloc(eint->dev, port * sizeof(u32), GFP_KERNEL);
-		eint->cur_mask[i] = devm_kzalloc(eint->dev, port * sizeof(u32), GFP_KERNEL);
+		eint->wake_mask[i] = devm_kzalloc(eint->dev,
+						  port * sizeof(**eint->wake_mask),
+						  GFP_KERNEL);
+		eint->cur_mask[i] = devm_kzalloc(eint->dev,
+						 port * sizeof(**eint->cur_mask),
+						 GFP_KERNEL);
 		if (!eint->pin_list[i] || !eint->wake_mask[i] || !eint->cur_mask[i])
 			goto err_eint;
 	}
@@ -597,12 +605,9 @@ int mtk_eint_do_init(struct mtk_eint *eint, struct mtk_eint_pin *eint_pin)
 
 err_eint:
 	for (i = 0; i < eint->nbase; i++) {
-		if (eint->cur_mask[i])
-			devm_kfree(eint->dev, eint->cur_mask[i]);
-		if (eint->wake_mask[i])
-			devm_kfree(eint->dev, eint->wake_mask[i]);
-		if (eint->pin_list[i])
-			devm_kfree(eint->dev, eint->pin_list[i]);
+		devm_kfree(eint->dev, eint->cur_mask[i]);
+		devm_kfree(eint->dev, eint->wake_mask[i]);
+		devm_kfree(eint->dev, eint->pin_list[i]);
 	}
 	devm_kfree(eint->dev, eint->cur_mask);
 err_cur_mask:
-- 
2.51.0


