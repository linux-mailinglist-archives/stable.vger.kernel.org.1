Return-Path: <stable+bounces-244194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAQiKNwH+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:08:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342C4CFF47
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67EA230418BC
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42B480DC9;
	Tue,  5 May 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWmSfV2B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4139480DD2
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993532; cv=none; b=C1Zw4Mj1p0eRIRyXQ9nAfQWTOOgrWPILB1q1w43pTx8fOWjKFB3IHeUTRHi1PZ9/Qaz/SR2J9dXMxiHS3UQjq3ZgF1BygZBlexk/OwTD9WVY5zBhkfppYes+PoYgcGNbBVWRfvj1Cc8uoxP6CcRKBhm/SrOhfxDnJRoor9C2Cc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993532; c=relaxed/simple;
	bh=nel41D7/iSYikgPOWSHl22uvoq9mZoR7XVauvIj0kKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugD+C6WfH54znmczTCfmhyaY6k0fI9peOo6oHhVxqzJw2VTrjqJJxQwPU3TPFd4QqHo5EzYpFt3FL38025gOqgVZGPRrb1dvduRlDXP5MOBTjqMaz68CwIgFRcSJ9g1GwyxNsHTKt56C8cMPL8kSXWYvTha+fWrekq3HjjdAsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWmSfV2B; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-364d72f2986so3826671a91.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777993530; x=1778598330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nsydoNz+n1aoj4WKwfkkcVBLiH1l+lQ2IFQLRuoD3ew=;
        b=XWmSfV2BGq0NXdjANpOiqtlneTcjf8fefEDTupVfghGAuW6qMquwkInC57YoiSp4mJ
         PcbzlPLC9/vNo9TwkaCDNUNX36v6L4YU5Se1bPyFWZsfoxlQuVt+amnvBuycUXBSjfXr
         XjOCt64p8AbMprjhlYJIlx8TUf2vpXj3QbdNqz4/nnm2Sg9s9ZGZ6cjk2OUUDvhs6tsr
         V+Hvyx7xDaPgWqlj7guNFRNpZ2yUUoLglLzneK1sd+eF4jp8PZP6vYAT14jBG2PhT0P3
         afN/3s2RdCJKYC13ht2GnPLrmx+5OescbxqV6FYPSjvA5WoLECdMWFXBxTbxG9/ZQOh3
         LLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993530; x=1778598330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsydoNz+n1aoj4WKwfkkcVBLiH1l+lQ2IFQLRuoD3ew=;
        b=WbKU5nwfycxxXEqO+mHIN/WOQPdoXaPoNy1lp5QMbje+fgZeWSGxj5ZkKNuBGnu/cW
         FEQF79bm4ANSF25nsJ0/HMjfll3BsPhc0/I6dFzyOlG+wLOzzlHkv+6rS1X2fp1lVuZr
         v7y9CsASWibPqqasr5KX+GkKTZvgUA3Zd/9ERYgijwoDgmU2KX/5+qR7kF3NaqaoAWkk
         5xS0nESfi0qrEngYySGBK93UCdM8k2I6iAFpddfB5wkHJo6Ao3DrTQqrpsRf7FnhnKvs
         GCanR6HUUhap88Ds4rFqEwrSITPJdK3TpJSOFR40M0UQIvtqICSVrIxs8uH08iaue+nQ
         SCjA==
X-Forwarded-Encrypted: i=1; AFNElJ95P5hLk1XHUlePsLDWVx4MRm8FJ1zjgJlBqZgI4yv5OHyKwEulkaGZ/iigymNSdYDmdYMmWz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5k5xslq21z3whExirVv3Ysf7+R7IbLdfA9lHnzF1vJT13SZE
	U4mWXTdfYqmWF9+iqFGOS1AQIjjCbD0e33qdjKsT5uRkwsul8Lbzlj0j
X-Gm-Gg: AeBDievHVeeQPVJfh0TLRnaBqlWoaJgvYgSoigoQNLeHITLBelTpuuK4/uB83ISzzkS
	DUwzEe7AMsLWbURQcfA5+XQnJyL+SNBFqt8q7soN1fi4wSqFX1W3GAC3zwO0yr4ntlUDclmvWYm
	rVbylZriUQ0LxkeuCEoSLvLdX5Q0Fepnr7TlPaqpK5wKJ2aa6lOCV6rBdKQCe2rpuKzH/YDEdse
	iUTk6vdpxsbGUQhZtfdFFeEULjmYmepOv5XDVupRCZWgIe4KZ7/jXQOGdeBZsKeC8zcONkCNEoS
	yR1XOlZG4a1uV6VRJtf165uHn1/BRWz57GkblEC4P+r/+y0uraTYq+hbBwZlUTm5kLAiws/N4jg
	8pnXRSnOL20g/2jltjS+anlEi9uGgOLO6ea6ohx3Gsue+dVciKQAlf50Anc6vk4B9ASbaUjcf/p
	8TniSCue5uWdw2afWM
X-Received: by 2002:a17:90b:5543:b0:35d:a6eb:197f with SMTP id 98e67ed59e1d1-3650cb89b02mr13768708a91.0.1777993530069;
        Tue, 05 May 2026 08:05:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36575df7ab8sm2136973a91.1.2026.05.05.08.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:05:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] uio: uio_pci_generic_sva: fix double free of devm_kzalloc() memory
Date: Tue,  5 May 2026 23:02:56 +0800
Message-ID: <20260505150256.614071-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6342C4CFF47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244194-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

uio_pci_sva allocates struct uio_pci_sva_dev with devm_kzalloc() in
probe(), but then calls kfree(udev) both on the probe() error path
(label out_free) and again in remove().

Because devm_kzalloc() allocations are devres-managed and are freed
automatically when the device is detached (including after a failing
probe() and during driver unbind), the explicit kfree() can lead to a
double free.

If probe() fails after devm_kzalloc(), the error path frees udev and
devres cleanup will free it again when the core unwinds the partially
bound device. On normal driver removal, remove() frees udev and devres
will free it again when the device is detached.

This issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix by removing the manual kfree() calls
and dropping the now-unused label.

Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v5:
  - Remove the now-unused udev variable from remove().

v4:
  - Add description of how the issue was found and tested.

v3:
  - Add changelog below the --- line describing changes since v2.

v2:
  - Reflow commit message to keep lines within 75 characters.

 drivers/uio/uio_pci_generic_sva.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
index 4a46acd994a8..d05ef77f7e32 100644
--- a/drivers/uio/uio_pci_generic_sva.c
+++ b/drivers/uio/uio_pci_generic_sva.c
@@ -129,15 +129,13 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = devm_uio_register_device(&pdev->dev, &udev->info);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register uio device\n");
-		goto out_free;
+		goto out_disable;
 	}
 
 	pci_set_drvdata(pdev, udev);
 
 	return 0;
 
-out_free:
-	kfree(udev);
 out_disable:
 	pci_disable_device(pdev);
 
@@ -146,11 +144,8 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void remove(struct pci_dev *pdev)
 {
-	struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	kfree(udev);
 }
 
 static ssize_t pasid_show(struct device *dev,
-- 
2.43.0


