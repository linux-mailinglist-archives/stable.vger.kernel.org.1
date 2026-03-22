Return-Path: <stable+bounces-227827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHj8CpPqv2my/wMAu9opvQ
	(envelope-from <stable+bounces-227827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:11:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6052E95B2
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BD8B3005325
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0362EDD7D;
	Sun, 22 Mar 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jimqgr/z"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BACA2EBB84;
	Sun, 22 Mar 2026 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774185096; cv=none; b=lDc7PiWwc1/ZgfbZa3DgPxUtUJ/7+mTqzpOubk/qp+/MLeiR8qFnO6cgUA0YJ0aXvwQcy5ylIE+VmNib9Ny99GxJg100jh4aFgwT9J/KshaaY6F/hhvzdm5L+f1UzetkIrzUolxPOBdNkW3rJqIeNgbRnetTQsNH/+irC2BFrto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774185096; c=relaxed/simple;
	bh=XFjVRNgzpZgvpiPQDIRXVNNJCSTD4bfEKUaHKJv78pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMmhSYybk1gFRJMfRck8a1G+J+HokSpEtOOzqipPCtZEb671d3LO4vFZMre+1iKuJuaw+OZ/XIzbrC67Zt+u356yXNrcwWdV9abtK50tTqZQb3zhSHjgmzQn6L4u4zGdtQa67Ud8ye/4qbcu3R34LOcVTfI8Xvri4fBNXqTLgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jimqgr/z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8FCE320B7128;
	Sun, 22 Mar 2026 06:11:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FCE320B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774185094;
	bh=+Boc9fiv2GO4Tut+9hzh6BerPuKZZ3SkpCXGRgMoJCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jimqgr/z/wedRXVtpToJiQjshkFrnDiXfoNTFAnoM5tz2NgV0XRKCyIi8tC/KC5KC
	 WxTtxHmBOEZyYvVzgO0n2lJHgHlYmDexoX5A0N8dNestyB2eqYQLZDt2TkzmI/+/YK
	 p3U9iJwuL6ivu6iA1CEjbbgsR1kBe/Fh6+4vP8TI=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: ptsm@linux.microsoft.com,
	shubhrajyoti.datta@amd.com,
	bp@alien8.de,
	tony.luck@intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/5] EDAC/versalnet: Release reference to remoteproc device in remove
Date: Sun, 22 Mar 2026 06:11:34 -0700
Message-ID: <20260322131134.1684691-1-ptsm@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-227827-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 2E6052E95B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The rproc reference acquired via rproc_get_by_phandle() during probe
is not released in mc_remove(), causing a reference count leak. Add
the missing rproc_put() call.

Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Cc: stable@vger.kernel.org
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/edac/versalnet_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index f70243bc8a7a..28f5036f381c 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -958,6 +958,7 @@ static void mc_remove(struct platform_device *pdev)
 	cdx_mcdi_finish(priv->mcdi);
 	unregister_rpmsg_driver(&amd_rpmsg_driver);
 	rproc_shutdown(priv->mcdi->r5_rproc);
+	rproc_put(priv->mcdi->r5_rproc);
 }
 
 static const struct of_device_id amd_edac_match[] = {
-- 
2.49.0


