Return-Path: <stable+bounces-227826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIjdCH7qv2l0/wMAu9opvQ
	(envelope-from <stable+bounces-227826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:11:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3FF2E959A
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8D58300DA72
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785B2EC553;
	Sun, 22 Mar 2026 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aoBPG9Q1"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376C2E2665;
	Sun, 22 Mar 2026 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774185080; cv=none; b=EFCY1KnKTpLHNf9qNnkCxsmry3JlnkQ9110E8L6H6NjwG6Hy5m7OqNSfwJ4fE3UxJU8paPRrnV22fHjvPEi6oKlxxF2vYdRKU/uL6yTevnGz87kLMuwdob8KnxrkyozVn1b2g4Nq5uuFTruTc0hdHTXynLgWbtXmzZ3Yzwtuqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774185080; c=relaxed/simple;
	bh=L06mMv13leSJidJpgulaO5FBALi9cUTwx4gGFd0q7as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElZdKpakd9WxPYcfxlCXYojK/eWW8i0WWof9MFTWS8NiQvF7MemM8zTv3KW55m9KrQqGZBsGBEnL4c72rqG7it9CKgV04r6AdfeWtVkhsK0LxjQ0UEy7ovAkJIxygfLU7km5Z6CE9p1v7tYvO9HFYLAvbVWqXLkagv/cr0A8zJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aoBPG9Q1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB8E220B710C;
	Sun, 22 Mar 2026 06:11:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB8E220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774185067;
	bh=TnvIecdWPOnc/JdZh2X2csrYBPQtgwy00+VNBTpbbfU=;
	h=From:To:Cc:Subject:Date:From;
	b=aoBPG9Q1b3b0vm51kmGXY5j0baDy/VH1glvCjgjObRIaN9Bgj3miWHd+RvrDbA+fO
	 3l7Fyn+ECkMx8waAmtkUmRy+M4KqW2a2868ZCkN02iLSowXYFOEAHZ4Mvc/tvn9QhG
	 qxSgwKawewNpqzbvkuQdNqFj+of7y4Pqa+I5/9CU=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: ptsm@linux.microsoft.com,
	shubhrajyoti.datta@amd.com,
	bp@alien8.de,
	tony.luck@intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/5] EDAC/versalnet: Fix teardown ordering in mc_remove()
Date: Sun, 22 Mar 2026 06:11:07 -0700
Message-ID: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-227826-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8E3FF2E959A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The teardown sequence in mc_remove() does not mirror the reverse of the
initialization order in mc_probe(). In particular,
unregister_rpmsg_driver() is called before remove_versalnet(), and
cdx_mcdi_finish() is called after rproc_shutdown().

Reorder mc_remove() to reverse the probe initialization sequence,
consistent with the probe error-unwind paths.

Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Cc: stable@vger.kernel.org
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/edac/versalnet_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 0b47ed7fed63..f70243bc8a7a 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -954,10 +954,10 @@ static void mc_remove(struct platform_device *pdev)
 {
 	struct mc_priv *priv = platform_get_drvdata(pdev);
 
-	unregister_rpmsg_driver(&amd_rpmsg_driver);
 	remove_versalnet(priv);
-	rproc_shutdown(priv->mcdi->r5_rproc);
 	cdx_mcdi_finish(priv->mcdi);
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+	rproc_shutdown(priv->mcdi->r5_rproc);
 }
 
 static const struct of_device_id amd_edac_match[] = {
-- 
2.49.0


