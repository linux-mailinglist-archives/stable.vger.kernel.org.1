Return-Path: <stable+bounces-220424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G2iM3o2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 530BB1C615B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41088320AAC3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED83B1AF5;
	Sat, 28 Feb 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJkgRSOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD823B235B;
	Sat, 28 Feb 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300314; cv=none; b=o2xCLLFH7+S+3cWcfh1fgtkrUbmf8KYRaMfKKS5VfWUin3zrr/3UfonE7Xt7otn69HukguwxVqXlVCzPv/7ReCagoLVyaY97QrJOCR5htGQFkiFu6fwlNoJiDiCfuUZsGzpzm1P5O8YPfB4pwwbASZ7hI7Kz4+bs2kdUf027sdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300314; c=relaxed/simple;
	bh=Y/2l9a0EImw5OUV5SkHz9FR6Z5JnzcIkAUrT03bJTLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSHowOrUoqnZocieOif8kMDNzBVK3grqBmQv8CSAYf3QHxvGItiJjZbF2aHlNfEk4NQkf43/tGyyICwyAHktNiBWI5v1nU5ICi7aO0mVL35/kht0TKSc8j3TqFoO3qPIiplcHV6Rpu8sxlN+A4ncFh1QogoKug+D7gxVx2KViDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJkgRSOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEADC19425;
	Sat, 28 Feb 2026 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300314;
	bh=Y/2l9a0EImw5OUV5SkHz9FR6Z5JnzcIkAUrT03bJTLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJkgRSOD2g9hSp+3Ba2ycLYQwlBig1sOKnfV590KRLs7bmeLJNpX74EzAPMZ0WQ5i
	 ponS3RlV8AQGh9hIat7Uz3QwAArOXO8jmA/FFHxhJHdGRkZkDtsNkJnEjNPsfDaAiO
	 SjaihvrGCROw0EJL0OYKX6mUB892yNwuHjGuVSnZq7V62jBk7uEnYfMdG1h7gQaRzy
	 9ckCKQL+CzWXKmFe8S9TztvXsWkMbIut00i5nsb4FDY/LdFB2GIapMbAgeFdJX3c+7
	 8JV3Sbp1KppcImU30PPuJQONQABo1fRnzy5JYUKULW/A7y2cogcbmaNWOjFRavSFAU
	 Ebka6C+XcIdxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Longfang Liu <liulongfang@huawei.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 345/844] hisi_acc_vfio_pci: update status after RAS error
Date: Sat, 28 Feb 2026 12:24:18 -0500
Message-ID: <20260228173244.1509663-346-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220424-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 530BB1C615B
X-Rspamd-Action: no action

From: Longfang Liu <liulongfang@huawei.com>

[ Upstream commit 8be14dd48dfee0df91e511acceb4beeb2461a083 ]

After a RAS error occurs on the accelerator device, the accelerator
device will be reset. The live migration state will be abnormal
after reset, and the original state needs to be restored during
the reset process.
Therefore, reset processing needs to be performed in a live
migration scenario.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Link: https://lore.kernel.org/r/20260122020205.2884497-3-liulongfang@huawei.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 2b8ac97cef2d2..e61df3fe0db99 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1215,8 +1215,7 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
 	if (hisi_acc_vdev->set_reset_flag)
 		clear_bit(QM_RESETTING, &qm->misc_ctl);
 
-	if (hisi_acc_vdev->core_device.vdev.migration_flags !=
-				VFIO_MIGRATION_STOP_COPY)
+	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
 		return;
 
 	mutex_lock(&hisi_acc_vdev->state_mutex);
-- 
2.51.0


