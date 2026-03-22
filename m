Return-Path: <stable+bounces-227830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLx7Mv/qv2my/wMAu9opvQ
	(envelope-from <stable+bounces-227830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:13:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5652E95FC
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D99D030269ED
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9659F2F12CE;
	Sun, 22 Mar 2026 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R65anVT5"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519222EAB72;
	Sun, 22 Mar 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774185111; cv=none; b=oSD1v7PkLOHKmLN5BA0bn7df1wmUhwZARb3zv2QNJtBGAFEqi+dQdX2wmNE4z9wzaWItenBf8t5JQjeLY7hei0hR9kTlLN57rZ3nnBV2LqbmYBXB8JSdrYLJmoWFvUTIBmt+bdYq6DeOnSHQ2q4mWmoXTxNZnI+5cYc8EHsmGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774185111; c=relaxed/simple;
	bh=XFBzyNHO0rvoBArV4mhU4c1nqKKNBxVUYP7xbf1rpTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtWiKmTxhXFCM1d7YFrZAyACEWKQjPeSdtTfUVQ691EVvbUUifZzN9KQkoJeF2M8qgYieqcknh7Dim9NyobP1UDG5vk7s7xGm/vR13BX7yWDxz81KpLJ09szkS9YaT4Ncch/HImBhx51ACt4/JznLd+81CjrZr2CdaVJg38XCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R65anVT5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C91F820B7128;
	Sun, 22 Mar 2026 06:11:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C91F820B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774185109;
	bh=ocyEm7WS8jTD7BYGdRkpkFKVoDvTJEuDspiSXUm105A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R65anVT5i/I6cmXq4gxSsFSC420LKgmbLexmy8RAH/s9GgFp1a8yhJDYROgbP4r2m
	 tapezZtMuBdMZIZGNSDQ6Xvd0WVQrReojaTgyLIlYc7gd/lhtM3/gqJb6MlyQ1/e5T
	 6wPLqIlBP3Bp6FoBOtGnYIQYfkVxxrlU4Af0ZOjs=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: ptsm@linux.microsoft.com,
	shubhrajyoti.datta@amd.com,
	bp@alien8.de,
	tony.luck@intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5/5] EDAC/versalnet: Fix device name memory leak
Date: Sun, 22 Mar 2026 06:11:49 -0700
Message-ID: <20260322131149.1684771-1-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
References: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-227830-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 4D5652E95FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The device name allocated via kzalloc() in init_one_mc() is assigned to
dev->init_name but never freed on the normal removal path.
device_register() copies init_name and then sets dev->init_name to NULL,
so the name pointer becomes unreachable from the device. Thus leaking
memory.

Track the name pointer in mc_priv and free it in remove_one_mc().

Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Cc: stable@vger.kernel.org
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/edac/versalnet_edac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 6463e88ed3d3..17a5c8f416b9 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -158,6 +158,7 @@ struct mc_priv {
 	u32 regs[REG_MAX];
 	u32 adec[ADEC_MAX];
 	struct mem_ctl_info *mci[NUM_CONTROLLERS];
+	char *mci_name[NUM_CONTROLLERS];
 	struct rpmsg_endpoint *ept;
 	struct cdx_mcdi *mcdi;
 };
@@ -765,11 +766,14 @@ static void versal_edac_release(struct device *dev)
 static void remove_one_mc(struct mc_priv *priv, int i)
 {
 	struct mem_ctl_info *mci;
+	char *mci_name;
 
 	mci = priv->mci[i];
 	device_unregister(mci->pdev);
 	edac_mc_del_mc(mci->pdev);
 	edac_mc_free(mci);
+	mci_name = priv->mci_name[i];
+	kfree(mci_name);
 }
 
 static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
@@ -848,6 +852,7 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	}
 
 	priv->mci[i] = mci;
+	priv->mci_name[i] = name;
 	priv->dwidth = dt;
 
 	platform_set_drvdata(pdev, priv);
-- 
2.49.0


