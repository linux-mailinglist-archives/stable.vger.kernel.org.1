Return-Path: <stable+bounces-226490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GosHDGKuWkjJwIAu9opvQ
	(envelope-from <stable+bounces-226490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E602AEF78
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A68A3046D06
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F993E3DB1;
	Tue, 17 Mar 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esl+ESg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCE357A4A;
	Tue, 17 Mar 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766943; cv=none; b=JNvR0liPZMmKJ9PtqXMFRXEG5MnWlM+5UMFSpUSSAEShq5wjWdcmXsr5TPtRjhO+HhFvaJvukL96HaiE4ILHlXw+++0UTm2oFiBYb8nYWBHJHLTjVw9jOAE6Rgz2/gJLFFdrx9TK/dx6upOwK1G8whv4kWtxxtf4y/KZx2ZTeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766943; c=relaxed/simple;
	bh=9h895qrXNQ5zgMf0dUQKkcwliwh1cfOKOEPn0ourV7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTiGhA2S3MG92rz7y25tDxT6WO6semym1KYivpn7NeZwWbxiDAnpHHcfP4TmsNVirrf9vGW+b70q2cds06lBOdE9fy1FTS0X/Cr/r6NGDF/mUq5QTVVnkukfQ9tYIv1LWVJXh/aXTmaJ+PXbV8Fm6bxj3cMC7h8rEJSn3Ji1aWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esl+ESg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CE5C4CEF7;
	Tue, 17 Mar 2026 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766943;
	bh=9h895qrXNQ5zgMf0dUQKkcwliwh1cfOKOEPn0ourV7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esl+ESg3EaoapOL3Rz2Bk9I4tL4axHkKadn32n4+bBIjE2mVxKP/4NOek5905q1AP
	 eHFYQ46lkdbEv9yBa4Pqb7zIO8hWZ/bdU5e5H1y6vlcDbGl3pLXIPuxn5DC7Isv69i
	 958xqCk2AW1ooOdbpoQDj+gex7SSU3xMiUiC34qc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 357/378] iio: imu: inv_icm45600: fix regulator put warning when probe fails
Date: Tue, 17 Mar 2026 17:35:14 +0100
Message-ID: <20260317163020.116793975@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226490-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tdk.com:email]
X-Rspamd-Queue-Id: 26E602AEF78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

commit 2617595538be8a2f270ad13fccb9f56007b292d7 upstream.

When the driver probe fails we encounter a regulator put warning
because vddio regulator is not stopped before release. The issue
comes from pm_runtime not already setup when core probe fails and
the vddio regulator disable callback is called.

Fix the issue by setting pm_runtime active early before vddio
regulator resource cleanup. This requires to cut pm_runtime
set_active and enable in 2 function calls.

Fixes: 7ff021a3faca ("iio: imu: inv_icm45600: add new inv_icm45600 driver")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index e4638926a10c..d49053161a65 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -744,6 +744,11 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
 	 */
 	fsleep(5 * USEC_PER_MSEC);
 
+	/* set pm_runtime active early for disable vddio resource cleanup */
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
 	ret = inv_icm45600_enable_regulator_vddio(st);
 	if (ret)
 		return ret;
@@ -776,7 +781,7 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
 	if (ret)
 		return ret;
 
-	ret = devm_pm_runtime_set_active_enabled(dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
-- 
2.53.0




