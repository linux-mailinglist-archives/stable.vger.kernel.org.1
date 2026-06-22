Return-Path: <stable+bounces-267639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +kUFIlwCOWpzlQcAu9opvQ
	(envelope-from <stable+bounces-267639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:37:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F076AE4E0
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:37:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=lHoTu4bc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267639-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267639-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20F17307BF25
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34C39C006;
	Mon, 22 Jun 2026 09:32:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2439D6FD;
	Mon, 22 Jun 2026 09:31:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120721; cv=none; b=Oj82Li8f2zcZeWLx5vc0W37vPF42FSbwvXaBvEX6aScTJevhULp1YYr8m2JfKcBrljxmcFPv1UrE7Ka/vNhBmQf0RWffIIQUKtHAutcRQGLWmIm0UUnvKzVC+9BvML3gXHufUxMcXKM2gCg6KfRa/hrZ/ZZapMI7ntqfyje931Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120721; c=relaxed/simple;
	bh=FKc2SrzAap8kCeUfWLH+dp5oozb8HCbZwsYL/n8/vB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpiuQn+y7JF50zQT+ZMw57NM2EPer7TxmqMvoFud/340DvlGWd36mXnb/h3mClN/A6KaZ67ReA8dFvoCmfdrw5W3Qb2Vs99i4fzpJTlQbeGUu+Q8kNodoz9nwb8hm/vN/AxEpD4Fzmb+1WurHG5tvbdJ6gDDtJblDfGsvKtAeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lHoTu4bc; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=F6
	43udD+I2EbhSBnHb9DPRMM81MefYnLwXaGGR11J2o=; b=lHoTu4bctzIY7g+7kk
	PlaVuHKba1/zlQmi03OECMd8EyABnjftK5W/kJGZO11I/ioPW11114O3M1Te6hXM
	ccRxQK5pFJ3s2eFPPhhykM0DuLdFIYeOy/0Mv3Q25oc4/FiyhpA2VIFEuk/jkZ4j
	kz1pWNH04e6fXaYM+qAmHfOc4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX6rr1ADlqtrcPDw--.54368S2;
	Mon, 22 Jun 2026 17:31:34 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: bhelgaas@google.com,
	aduyck@mirantis.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/IOV: Drop device reference on sriov_init() failure
Date: Mon, 22 Jun 2026 17:31:32 +0800
Message-Id: <20260622093132.910859-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCX6rr1ADlqtrcPDw--.54368S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF15ur4rCw48Ww43XF1fJFb_yoWfKFbE9w
	10yr97Aa1jkF1kKw1YkF1SvrWSk3WDXa92grW0ga4fGFy3Zr4vvry5Z395G3W8Ww4fuF98
	Aw1qkF1UC34xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuCJPUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RcmlGo5APdsdwAA33
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
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:aduyck@mirantis.com,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267639-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[163.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0F076AE4E0

sriov_init() takes a reference to another PF device with pci_dev_get()
when an existing PF is found on the bus. If compute_max_vf_buses() fails
afterwards, the error path clears dev->sriov and frees the pci_sriov
structure, but does not drop that reference.

Release iov->dev before freeing iov on the error path, matching the
cleanup done by sriov_release().

Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..1a55863fa7a0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -905,6 +905,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	return 0;
 
 fail_max_buses:
+	if (iov->dev != dev)
+		pci_dev_put(iov->dev);
 	dev->sriov = NULL;
 	dev->is_physfn = 0;
 failed:
-- 
2.25.1


