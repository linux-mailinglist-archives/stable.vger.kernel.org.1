Return-Path: <stable+bounces-244923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L2PLTfn/mlLzAAAu9opvQ
	(envelope-from <stable+bounces-244923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:50:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E54FE947
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B208A3038A4C
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E537AA98;
	Sat,  9 May 2026 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cjiy2h1F"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E827384230;
	Sat,  9 May 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312945; cv=none; b=ILjvbiOXkjsDW2G4dElG5bPF8DuJ+VzdkbIa7BT2ypzyWg3yAdnhSC3A0lCKhyPnzZXoJGN0ctp5yFQBi1bb/4YL7elkaD5Dbe3UTB/XqGatVC1PYon1xBEp/HSJoC3zlRHZ4sIW6GAu3+AdAvfUwlSPtyaDjG3l05P6NbGw2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312945; c=relaxed/simple;
	bh=80jBPLvtM9TjXxDnzYvOCYyYk/9aipkDSiSmqSsZs3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr/7rnfHvoStasIdmRlWg0mfdDwr64VzL4GWuTSjMbr4dIAixX84ABY6u0ZVFidf9X/uX3IoBuG4nuEHxsjK8RP6nSrJCcQ2zPrZSL/2IHuCdazFQO1GI3ZPxjguZXM/Pd46Oirt36nIl7sV8HfFyhXPs9lFAR3qNbgnm3h7ouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cjiy2h1F; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9C
	R6iIFB5mrmZQwIQIg22hDKvdy6PY+gAgCT0th2C/U=; b=Cjiy2h1FZB9rhAY9LY
	vuTSDBtkaj7K5rLy7Nrf+ZhXxKiKLu6x5tWEP2420aG3YzrfWpExPwduXwmmcT7S
	oQTp5G39YXYaP+kTE+4CYN0Cl8n+8WWEs8iZMk4bjKXbYaQtuNtZfZg8EX0FZehp
	f8j4OBadg7RVbLNomxSCbWELE=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3vx7H5v5pPBpuAQ--.62799S3;
	Sat, 09 May 2026 15:48:28 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	jetlan9@163.com
Subject: [PATCH 6.6.y v2 1/2] dmaengine: idxd: Fix crash when the event log is disabled
Date: Sat,  9 May 2026 15:48:21 +0800
Message-ID: <20260509074822.2587-2-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509074822.2587-1-jetlan9@163.com>
References: <20260509074822.2587-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vx7H5v5pPBpuAQ--.62799S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF13XFyUXrWkuw4ruFy3Arb_yoW8Wr45pF
	45Ga4Ykryqgry3uw4UXF1I9FnxuF4vy3yFgrW7t3sI9FyfAF95WFWftFyjg3y5ArZ3GFW5
	XasIq3y0gF4UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEt8nUUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6w0Hz2n+5s2AOwAA3p
X-Rspamd-Queue-Id: 1F4E54FE947
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244923-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 52d2edea0d63c935e82631e4b9e4a94eccf97b5b ]

If reporting errors to the event log is not supported by the hardware,
and an error that causes Function Level Reset (FLR) is received, the
driver will try to restore the event log even if it was not allocated.

Also, only try to free the event log if it was properly allocated.

Fixes: 6078a315aec1 ("dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-2-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Only the idxd_device_evl_free() NULL check portion was backported in v6.6.
idxd_device_config_restore() does not exist in v6.6. It was introduced 
in 6.14. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/dma/idxd/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 44bbeb3acd14..e769e1f0d28b 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -810,6 +810,9 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_evl *evl = idxd->evl;
 
+	if (!evl)
+		return;
+
 	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
 	if (!gencfg.evl_en)
 		return;
-- 
2.43.0


