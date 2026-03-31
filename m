Return-Path: <stable+bounces-231892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K+0LBH9y2naNAYAu9opvQ
	(envelope-from <stable+bounces-231892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:57:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B47136D879
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF66311292A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E6F426680;
	Tue, 31 Mar 2026 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cz2gDpDu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE253425CE0;
	Tue, 31 Mar 2026 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975337; cv=none; b=GDjdlYlIRzwOdlkUZDq84JB3W5JDJescEcFEBuV8b8Wrvj/KGtGrUuDPuOSRxDtYBy/BA2P6n8HSrljyF9uCjeOJcSfI6husOoLIl4MlG4B4aUxvn/wJkCxwWySX9VOYbj2dWyTXsLsX6MU/7Pjw4uG7ox36AIiLYmNJILDGt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975337; c=relaxed/simple;
	bh=96vsvhEGJgO02jChbanOi6jfvxovR4puirS5oEo0P6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFZQkZ4s0Ha7gu5DkOB9sYPObQrziBhgbMBcNYF+WEISTIUqAxucUu8TWBUyPG6Fr/Je8f/CulCyHtn5wAG5U6UZLcrZWVXNopeWTbU0LVP6A2+soqYw1yUOf0HYpYBBLPghAxgdSCmOozxRLqDbiXksrbqgC9Zj52IC5NW8UP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cz2gDpDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89356C19423;
	Tue, 31 Mar 2026 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975336;
	bh=96vsvhEGJgO02jChbanOi6jfvxovR4puirS5oEo0P6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cz2gDpDuZRR7/0lMSAs+LfvXM2q5xbH/F9kTH/S4Vu1ZTPsOoypVjCuoaGOBf2BNP
	 W3ydu7tQp6T5XJS/221QsHAq746FTrZmEgeMQ50WA1iDs/kWRzvtTgFS/LLkx3lnN+
	 UI9QTfyVjcdGhRy0yWZWYY8OEv9gtAb/5BVeJ3w8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bin Du <bin.du@amd.com>,
	Pratap Nirujogi <pratap.nirujogi@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.19 255/342] i2c: designware: amdisp: Fix resume-probe race condition issue
Date: Tue, 31 Mar 2026 18:21:28 +0200
Message-ID: <20260331161808.337979638@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231892-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3B47136D879
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pratap Nirujogi <pratap.nirujogi@amd.com>

commit e2f1ada8e089dd5a331bcd8b88125ae2af8d188f upstream.

Identified resume-probe race condition in kernel v7.0 with the commit
38fa29b01a6a ("i2c: designware: Combine the init functions"),but this
issue existed from the beginning though not detected.

The amdisp i2c device requires ISP to be in power-on state for probe
to succeed. To meet this requirement, this device is added to genpd
to control ISP power using runtime PM. The pm_runtime_get_sync() called
before i2c_dw_probe() triggers PM resume, which powers on ISP and also
invokes the amdisp i2c runtime resume before the probe completes resulting
in this race condition and a NULL dereferencing issue in v7.0

Fix this race condition by using the genpd APIs directly during probe:
  - Call dev_pm_genpd_resume() to Power ON ISP before probe
  - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
  - Set the device to suspended state with pm_runtime_set_suspended()
  - Enable runtime PM only after the device is fully initialized

Fixes: d6263c468a761 ("i2c: amd-isp: Add ISP i2c-designware driver")
Co-developed-by: Bin Du <bin.du@amd.com>
Signed-off-by: Bin Du <bin.du@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: <stable@vger.kernel.org> # v6.16+
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260320201302.3490570-1-pratap.nirujogi@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-designware-amdisp.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/amd/isp4_misc.h>
 
@@ -82,22 +83,20 @@ static int amd_isp_dw_i2c_plat_probe(str
 	if (isp_i2c_dev->shared_with_punit)
 		pm_runtime_get_noresume(&pdev->dev);
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-
+	dev_pm_genpd_resume(&pdev->dev);
 	ret = i2c_dw_probe(isp_i2c_dev);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "i2c_dw_probe failed\n");
 		goto error_release_rpm;
 	}
-
-	pm_runtime_put_sync(&pdev->dev);
+	dev_pm_genpd_suspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	return 0;
 
 error_release_rpm:
 	amd_isp_dw_i2c_plat_pm_cleanup(isp_i2c_dev);
-	pm_runtime_put_sync(&pdev->dev);
 	return ret;
 }
 



