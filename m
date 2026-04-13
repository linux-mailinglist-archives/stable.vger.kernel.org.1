Return-Path: <stable+bounces-236132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I0HCVII3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:14:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFA3EDC7E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CC33300E2AB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D123E0C66;
	Mon, 13 Apr 2026 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfh2DF49"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7F3BF688
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093256; cv=none; b=jUI8gn8VGUP8KCI7/eESGDDeHe6U1ItDRVCoJLtq1KlyzRFzg+PTE2zUfQVLlO6zXAvadEXSirQNRoG9xibwcy+nb9Eh54+rkwZkNRgZgCpU6SI2IBE6eN/C1Z05k93OwcIpm+D4DfrwRoT2An1lC7PtdhOPfjV+3vKRSK8uoww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093256; c=relaxed/simple;
	bh=wLnKz0lTNl3u6Hc5SEDvuWJmbFpREBwXZsvmW+L1huQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVLDKWiLw0+r3x7seP5T/lGyp5MRcXWRO25vhH9OxAze04IaOR5Q9g/hafN+y3MCGRBLKY/aFLybdbKK+1T24Odwrn4zUcB9T6Rrk8JK8OdA/qt03Jkp2JPTV7jIW0nLTgACWVD2W5EmA322zwvQktl5USGEhnoB7itKhe9pwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfh2DF49; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9382e59c0eso816760766b.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776093252; x=1776698052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=siLykDQuPSI0K3YOTzdJt9UJ6NmzQ8lrmgay3bCveqg=;
        b=jfh2DF495sMJ8Sn3lOZni2srcAzTGOqLtu5IdKOVuvDouo/mORVthzQU5VwmN+5Cuc
         9Rlxv1EZ/2XTHZ9NxH5eRNZLrPA9hvKdW37zxOM+CubqP+1c8MjOscDIaL2D6oCBKgdP
         KjmgfZrXqHtxZpsoHVG/jlFgm1I8QJVIVJBf/L5oPDh1FDdFNXSWyeJdkEnw3i3eHftl
         FkXQLzc6kiW3mZPfg6khe9Pf5hiOx6K+PPVD2fa3RmkCj2/rtCB91YLAzd2D9kBAteBu
         lk5XKXNjnkZywsOCnZBb6Jgy3KyiAvOiivsLJ3g4B/MW2mHBfzyd30YgxOZ9zWHuaxoG
         YRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776093252; x=1776698052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siLykDQuPSI0K3YOTzdJt9UJ6NmzQ8lrmgay3bCveqg=;
        b=hApnGlU8L3HwDn2qce+owfKKi+uVORF0fMt8TwpAY9UlTLLX2oT2RMu1xW1BtKuNFq
         V5LJk1bNVAMK9m6r05xWsTJhe3ZB489c/NiwJCgITnSEAUUITT5rbddxecrhjXVdcLEy
         D7aKvQO6WQEg4/l4sP4TtiC5cM81zqll5VW7+JmtlTpBubm14+ikuA4C1lnXXgWOUlp6
         hoUeWplnceNXdZWP3fo1AIb9MT7LLMHlLL3FXWE6A28u1++0Skb2P+5TN37VMjw1edfS
         VZiKzc+upkuelOtZhAsxfE6ONjsguMmVYRenp2mEQc1Hm8/svLudbRHil0BF5pV/yutl
         tvLg==
X-Forwarded-Encrypted: i=1; AFNElJ/jp6bJjbAzlTVXP6cDskBxsYYURXXnQWktCJdzpR8KNvXV78mxGpIu4MFlEOIGoG+WzzzFMTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfZ+l6UIwzbFbudXUQm6wmUvWqjcpAy2wgDBcwOaquWavo3xh
	4NKhmsneLyLxGsWARMhuC/UAmrqQrrJlxJeR+d0oCOqW/3h0w5H5PHKZ
X-Gm-Gg: AeBDietpl4JBLDtmGOIR741bA4lFTfblrD3jGLIQuSWO59fbWky6I4oHNXv9o3qjndN
	9jMxuL39DBFebYUqC2svoKGmKk9c9bXSk9n+Zp3AYwglvcLd85VBsp8WdN+md1miVjgFFc0H5ks
	A95z8OEdNfN98zsuv2IJtMt8CoSnHsxhpmLU68G+F5DGBYcStIVsptmIFwGVk6ZsiDaoEzxXgzy
	opO6Uj+cmJuCptGhKuDuaK8Qwqi5VPI2+6I/yuIzDtuIgDQVP9XqQOV80IM5H28u7UCYNXWgxuJ
	poGgN3zSffEsSEEsDTvgeX8wWFg8ec/nl27G2RNd8LSnTk03EdqDIVUkecQwrMmBXq8tmmRr3dn
	WUX3y8KUibmzwBAwi3lFT11Htgzn8O/omKKXvsvmjjzPT9SZ8Z7DFwiOB+IJ6GGe5AXInl76I40
	hYzc0K9G6wJIfvduS05QuJKbHTBq2Xrnpgm4zJyBWcJMU+6fNwl1jYtsWyITML9J0rxNfZABPbc
	l8i9GQNH+25XWo7eI/OmfNLUvUfeGZwQBIcrpfY8hDA59z0xffKGe7fSXNfP//+0iN+pVd7VAZU
	JVO2F4Bjr0JHUAdT
X-Received: by 2002:a17:907:8e16:b0:b9d:6cef:95fc with SMTP id a640c23a62f3a-b9d7267e295mr773185066b.35.1776093252053;
        Mon, 13 Apr 2026 08:14:12 -0700 (PDT)
Received: from ahossu.residents.sin.openfiber.nl ([88.202.160.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6dfd77dfsm323472966b.18.2026.04.13.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:14:11 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	bingbu.cao@intel.com,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	error27@gmail.com,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v3] staging: media: ipu7: fix double-free and use-after-free in error paths
Date: Mon, 13 Apr 2026 17:12:44 +0200
Message-ID: <20260413151244.612492-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-236132-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,linuxfoundation.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85BFA3EDC7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In both ipu7_isys_init() and ipu7_psys_init(), pdata is allocated and
then passed to ipu7_bus_initialize_device(), which stores it in
adev->pdata. The ipu7_bus_release() function frees adev->pdata when the
device's reference count drops to zero.

Two error paths incorrectly call kfree(pdata) after the device teardown
has already freed it:

1. When ipu7_mmu_init() fails: put_device() is called, which drops the
   reference count to zero and triggers ipu7_bus_release() ->
   kfree(pdata). The subsequent kfree(pdata) is a double-free.

2. When ipu7_bus_add_device() fails: it calls auxiliary_device_uninit()
   internally, which calls put_device() -> ipu7_bus_release() ->
   kfree(pdata). The subsequent kfree(pdata) is again a double-free.

Note that the kfree(pdata) when ipu7_bus_initialize_device() itself
fails is correct, because in that case auxiliary_device_init() failed
and the release function was never set up, so pdata must be freed
manually.

Additionally, the error code was not saved before calling put_device(),
causing ERR_CAST() to dereference the already-freed adev pointer when
constructing the return value. Fix this by saving the error from
dev_err_probe() before put_device() and returning ERR_PTR() instead.

Remove the redundant kfree(pdata) calls and fix the use-after-free in
the return values of the two affected error paths.

Fixes: b7fe4c0019b1 ("media: staging/ipu7: add Intel IPU7 PCI device driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
v3:
 - Add Cc: stable@vger.kernel.org (Media CI)

v2:
 - Add Fixes tag (Dan Carpenter)
 - Save error before put_device() to avoid use-after-free in ERR_CAST()
   return value; use ERR_PTR(ret) instead (Dan Carpenter)
 - Apply same fix to ipu7_psys_init() (Dan Carpenter)

 drivers/staging/media/ipu7/ipu7.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/media/ipu7/ipu7.c b/drivers/staging/media/ipu7/ipu7.c
index c771e763f8c5..310e3f24e571 100644
--- a/drivers/staging/media/ipu7/ipu7.c
+++ b/drivers/staging/media/ipu7/ipu7.c
@@ -2169,21 +2169,18 @@ ipu7_isys_init(struct pci_dev *pdev, struct device *parent,
 	isys_adev->mmu = ipu7_mmu_init(dev, base, ISYS_MMID,
 				       &ipdata->hw_variant);
 	if (IS_ERR(isys_adev->mmu)) {
-		dev_err_probe(dev, PTR_ERR(isys_adev->mmu),
-			      "ipu7_mmu_init(isys_adev->mmu) failed\n");
+		ret = dev_err_probe(dev, PTR_ERR(isys_adev->mmu),
+				    "ipu7_mmu_init(isys_adev->mmu) failed\n");
 		put_device(&isys_adev->auxdev.dev);
-		kfree(pdata);
-		return ERR_CAST(isys_adev->mmu);
+		return ERR_PTR(ret);
 	}
 
 	isys_adev->mmu->dev = &isys_adev->auxdev.dev;
 	isys_adev->subsys = IPU_IS;
 
 	ret = ipu7_bus_add_device(isys_adev);
-	if (ret) {
-		kfree(pdata);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return isys_adev;
 }
@@ -2216,21 +2213,18 @@ ipu7_psys_init(struct pci_dev *pdev, struct device *parent,
 	psys_adev->mmu = ipu7_mmu_init(&pdev->dev, base, PSYS_MMID,
 				       &ipdata->hw_variant);
 	if (IS_ERR(psys_adev->mmu)) {
-		dev_err_probe(&pdev->dev, PTR_ERR(psys_adev->mmu),
-			      "ipu7_mmu_init(psys_adev->mmu) failed\n");
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(psys_adev->mmu),
+				    "ipu7_mmu_init(psys_adev->mmu) failed\n");
 		put_device(&psys_adev->auxdev.dev);
-		kfree(pdata);
-		return ERR_CAST(psys_adev->mmu);
+		return ERR_PTR(ret);
 	}
 
 	psys_adev->mmu->dev = &psys_adev->auxdev.dev;
 	psys_adev->subsys = IPU_PS;
 
 	ret = ipu7_bus_add_device(psys_adev);
-	if (ret) {
-		kfree(pdata);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return psys_adev;
 }
-- 
2.53.0


