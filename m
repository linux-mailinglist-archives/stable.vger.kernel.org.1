Return-Path: <stable+bounces-227828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOFuC7bqv2my/wMAu9opvQ
	(envelope-from <stable+bounces-227828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:12:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 819312E95DD
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E512C301829A
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE692ED846;
	Sun, 22 Mar 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="crTq4xIH"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BA2EC08C;
	Sun, 22 Mar 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774185101; cv=none; b=aHP7r5Y5rzWpjX4cYTnZA4jxwzABWZUG0dhspBw8DxhoAlMhLnEgLpDsqrQaXrER9mpTgG5ZJaZQ4fUdagVO/vOhK8tVpkv5dd7y4qcN9gu2JknUayp6A1s8e6B20HULEMNNazLIZjYHbIHdWBsFyTB9QRJtnBK0wMvH3DIojEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774185101; c=relaxed/simple;
	bh=+1TufV+wOOI00ZAe8M1oG1mr3Nnz0dnFcfKwxAEQeO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4SDHqRCPYOUuCnhx1s7ieG+UpjGhMq76DMrJ5cJ0FjjugB3pmY5ZziiT6uguqETQx2sLh0pWaQdiauJ6VZC6S0rLFJQIrukQxv91h6/D8w3h/FkUBYIOE+XSW0e3dR0uwOyWyiB40l3n6PDxIM3Gt+w9pQaeySko/qhYAUuJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=crTq4xIH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD43420B7128;
	Sun, 22 Mar 2026 06:11:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD43420B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774185099;
	bh=m88l9njESPglZaDdttc1e20/fYvuMVOS3zuvnOSKxN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crTq4xIHeCkznzmEtET6EHHiUe7bO95YjTvIK2CAXu/XQDFsA0sIn4YhbXY95drqW
	 DWPIkU3MmpgIxNVDKyZlG+5YjEgCqMNSwrA1jb2xTGMeQH+P8AfW0sJSVWtUSFG78a
	 NfdtjAElcLcTbmy+IaRH7Tm/lcm6UDHoqOfu0n30=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: ptsm@linux.microsoft.com,
	shubhrajyoti.datta@amd.com,
	bp@alien8.de,
	tony.luck@intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/5] EDAC/versalnet: Fix memory leak in remove and probe error paths
Date: Sun, 22 Mar 2026 06:11:39 -0700
Message-ID: <20260322131139.1684716-1-ptsm@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-227828-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 819312E95DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mcdi object allocated using kzalloc() in the setup_mcdi() is not
freed in the remove path or in probe's error handling path leading to
memory leak. Fix the memory leak by freeing the allocated memory.

Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Cc: stable@vger.kernel.org
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/edac/versalnet_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 28f5036f381c..acd51b492772 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -937,6 +937,7 @@ static int mc_probe(struct platform_device *pdev)
 
 err_init:
 	cdx_mcdi_finish(priv->mcdi);
+	kfree(priv->mcdi);
 
 err_unreg:
 	unregister_rpmsg_driver(&amd_rpmsg_driver);
@@ -959,6 +960,7 @@ static void mc_remove(struct platform_device *pdev)
 	unregister_rpmsg_driver(&amd_rpmsg_driver);
 	rproc_shutdown(priv->mcdi->r5_rproc);
 	rproc_put(priv->mcdi->r5_rproc);
+	kfree(priv->mcdi);
 }
 
 static const struct of_device_id amd_edac_match[] = {
-- 
2.49.0


