Return-Path: <stable+bounces-262000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fe9EDiKWJmqiZAIAu9opvQ
	(envelope-from <stable+bounces-262000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 12:14:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3FA654ECD
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 12:14:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=AecYL2CS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262000-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262000-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FC1530B32B4
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA13E00B0;
	Mon,  8 Jun 2026 09:56:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409843D5642;
	Mon,  8 Jun 2026 09:55:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912564; cv=none; b=pTUkgaoALl3YCPdyFClz9gjZGLfXflhBUL+WoxmMD4Cd7z59zlAN5+ZgJocJrysLeT3HmTTyD4kBToFadwzf8uYMOEfWlLzpi8p9dPhQqCJyYCCDVcEtW4JUKk5tdPECB+gF88F5Omenr++uE68HYFrriHe6pg2JlFYnw/alEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912564; c=relaxed/simple;
	bh=eMgZiBOsnR3wR7NDtJ6EOYmABtOASjamlUAo08G14os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKxOSUIO6HbiY87OAH36EVB9e3nej+YFk0lGjQhlgSF/BkNvDmU5xMbhfsjITD5Z99ZsemkSDXBk6rHJE37qZCrLaO5jV52ueTFce6lPDZ/NladKsUzvJZg+irGaKs4qBgdtXbQOtjPhadqk7E68raVkLEF7rnguAdLjE6Jb4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AecYL2CS; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=30
	97WF1F3hjJ4ahSFgOI68/cOQpi7YtvaeCdDcz9ua8=; b=AecYL2CSDlIYOXPmpL
	q4iSM/rC/ckZhd6UPopwVlht3l1IY9kjXWymmNRpSxWFmcUIa4c68jVkrgHKHSTu
	rq6h5vSYslAc1zwXbMpjupu2eIMKTlq3wIklrfnNSCQ1JrDjdXz3lyh51PGIm0pK
	Zy+nlNdOBs5tUvIjWFPqRu5hU=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnY4iTkSZqkkwDCQ--.63974S2;
	Mon, 08 Jun 2026 17:55:34 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] dmaengine: idxd: Fix not releasing workqueue on .release()
Date: Mon,  8 Jun 2026 17:55:10 +0800
Message-ID: <20260608095510.97742-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnY4iTkSZqkkwDCQ--.63974S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DGF17JF1rCrW5KFyDKFg_yoW5JrW8pr
	47JFW5W34xJr9xK3W7XF18Wry5Ga1Sy3yfurWxWw15uFW5Za4UX34ftFWj93s8JrZ5WF4a
	qF90q3s5XF48KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWE_ZUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7BetdmomkZeaawAA3b
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262000-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vinicius.gomes@intel.com,m:dave.jiang@intel.com,m:vkoul@kernel.org,m:jetlan9@163.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B3FA654ECD

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 3d33de353b1ff9023d5ec73b9becf80ea87af695 ]

The workqueue associated with an DSA/IAA device is not released when
the object is freed.

Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-7-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Remove destroy_workqueue(idxd->wq) from the function idxd_remove() to
avoid the workqueue is released twice. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
On 6.1.x, destroy_workqueue(idxd->wq) is still called directly in
idxd_remove(). Applying the upstream patch as-is would cause a double
destroy:
once in idxd_remove() and again in idxd_conf_device_release() when
put_device() triggers the release callback.

Resolution: In addition to adding destroy_workqueue(idxd->wq) to
idxd_conf_device_release(), the call was removed from idxd_remove().
This is safe because idxd_remove() ends with
put_device(idxd_confdev(idxd)) which drops the last reference and
triggers idxd_conf_device_release(), where the workqueue is now destroyed.

---
 drivers/dma/idxd/init.c  | 1 -
 drivers/dma/idxd/sysfs.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 6059ffc08eac..2880a0b0f5e6 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -813,7 +813,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	if (device_user_pasid_enabled(idxd))
 		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 	pci_disable_device(pdev);
-	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
 }
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 0689464c4816..ea222e1654ab 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1663,6 +1663,7 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
+	destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);
-- 
2.43.0


