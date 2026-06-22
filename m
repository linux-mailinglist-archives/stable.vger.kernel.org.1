Return-Path: <stable+bounces-267635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QhmqCeb/OGrClAcAu9opvQ
	(envelope-from <stable+bounces-267635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:27:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 119066AE310
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:27:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=ZghvcoDL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267635-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267635-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E0A530485E8
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCDC361DC0;
	Mon, 22 Jun 2026 09:17:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4743364926;
	Mon, 22 Jun 2026 09:17:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119848; cv=none; b=cMwMd7lb8+Ek0w6wJVtdHjjzsFHDzvQLss95i6EA4X40lP/M/ZujLBDugx7NMrVIL3R3Fsa75CJDYTpVHrRzYIjfUMgr6tNagSwzInxDMGD189zIDRIbp2suvqkpJOTJFzwe2pl7Ixg5PpZm410DCZM8L4Ax2HCktEYXt2NC9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119848; c=relaxed/simple;
	bh=rgPgS+rozau0j3ArPejTT1t3tjsTz/IhrdmcUKLNNE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZB2IHFhYefi40U6lxExVwzUoPq2QFK9ISAwK+PdhW1LmrUCniRweER/WG4G0daxj82VJ+Cz8inr5Ymr72D3ccB6LS99vvEQb9kYZfE5HJwq6Qfk55Fx27MrGA2DPIEnoq8snh2DuLTWhHoXSqJ+MGjzsz0eSmbWROYc2NjnqOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZghvcoDL; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3k
	K32/vHWiIp0p2hsLBCLlspGf3JIL+RZ3PSx08mCdo=; b=ZghvcoDLz62mC2pGCi
	0fRvzNA7x7vlOXUwPvBkb2iGpJD174xmvGveeV2kdEa2X6+8NyEP8K2rUNwh8tvt
	Gnk/jxGNEX70w30vEi6KJ1ZQGMM4mL85qELfeRbFXEThffB48EL+hjK+p9zoCXqa
	8FVctT3eiKmww3P0Eq9Yo0IeQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC337Jl_Thq92UUDg--.60250S2;
	Mon, 22 Jun 2026 17:16:23 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	subhransu.s.prusty@intel.com,
	vkoul@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] AsoC: intel: sst: fix PCI device reference leak on probe failure
Date: Mon, 22 Jun 2026 17:16:20 +0800
Message-Id: <20260622091620.897478-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgC337Jl_Thq92UUDg--.60250S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkJr48ury7tF45GF1kuFg_yoW8Jw1rpa
	n7Wa9Fgr9YgFWFkayDtayxXFn5GFWYvr45Gr47Jw13uw10qrWrG3srJrWUWFW7CrW8GFyF
	qw4DtrWIvr1rKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyE_tUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QdBr2o4-WcZmgAA3P
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:cezary.rojewski@intel.com,m:liam.r.girdwood@linux.intel.com,m:peter.ujfalusi@linux.intel.com,m:yung-chuan.liao@linux.intel.com,m:kai.vehmanen@linux.intel.com,m:pierre-louis.bossart@linux.dev,m:broonie@kernel.org,m:perex@perex.cz,m:tiwai@suse.com,m:subhransu.s.prusty@intel.com,m:vkoul@kernel.org,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-267635-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 119066AE310

intel_sst_probe() takes a reference to the PCI device with pci_dev_get().
If sst_platform_get_resources() fails afterwards, the probe error path
cleans up the driver context but does not drop the PCI device reference.

Add a pci_dev_put() error path for failures after pci_dev_get().

Fixes: f533a035e4da ("ASoC: Intel: mrfld - create separate module for pci part")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 sound/soc/intel/atom/sst/sst_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
index 22ae2d22f121..44bb11c69490 100644
--- a/sound/soc/intel/atom/sst/sst_pci.c
+++ b/sound/soc/intel/atom/sst/sst_pci.c
@@ -130,13 +130,15 @@ static int intel_sst_probe(struct pci_dev *pci,
 	sst_drv_ctx->pci = pci_dev_get(pci);
 	ret = sst_platform_get_resources(sst_drv_ctx);
 	if (ret < 0)
-		goto do_free_drv_ctx;
+		goto do_put_pci;
 
 	pci_set_drvdata(pci, sst_drv_ctx);
 	sst_configure_runtime_pm(sst_drv_ctx);
 
 	return ret;
 
+do_put_pci:
+	pci_dev_put(sst_drv_ctx->pci);
 do_free_drv_ctx:
 	sst_context_cleanup(sst_drv_ctx);
 	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
-- 
2.25.1


