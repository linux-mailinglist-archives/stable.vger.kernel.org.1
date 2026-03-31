Return-Path: <stable+bounces-232452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDH2HtgAzGkoNQYAu9opvQ
	(envelope-from <stable+bounces-232452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:14:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE136E3E4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02E3A30B2B8B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765023019D6;
	Tue, 31 Mar 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QbZUswe4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A42E1C7C;
	Tue, 31 Mar 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976784; cv=none; b=dfVknqZPR/Cjki+Tx7Oa5t5PPN4249OP5JKfN7et2/wDjn+XQOhg/0L0qHu3uRMppAK52A6oIxRkq7sclR4f2f6aAwNzN/lLuYqXpz+nYOtBIlZq5PTQoxEGcwk6qEnm5MAFA+vuKjbuzBpgH52nSD/dCr1x5D0q5n15S4qK6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976784; c=relaxed/simple;
	bh=Ux/GIHzvFMYNG/brA++zdcGhq7OhXd5uQ37bIBOdu44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmB64lA6wJficu//tKyiiVj1YaMYFzC879VDvr3vOP7K16H1KPgO/CZcuS9bwcHtcyzq6Ohjzhms2I/HC2aVNFxeraKOllm3FvfsrCb0zVmb0c7EnyvfRR0jlO3CJ1DQh3X4SJGzAoZSB3DHro7JnWgmv52K99+9/lp884HdJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QbZUswe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2723C19423;
	Tue, 31 Mar 2026 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976784;
	bh=Ux/GIHzvFMYNG/brA++zdcGhq7OhXd5uQ37bIBOdu44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbZUswe4PXxx1zLcIX36KGbGBFsV6KSHQNP+FhR2UYGLrJciaVepQB+UTAG91Xk6f
	 Srh+DDtyEt0fPMZSJqMWFmWvatYG6Yf/jMz7YSLlNdGz8/N4RRGdiG7rS9hjqOM38V
	 Ilw+FGmTNcKMYW1YcJmCBYvZEMjVZZ3/vjXd+OVY=
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
Subject: [PATCH 6.18 226/309] i2c: designware: amdisp: Fix resume-probe race condition issue
Date: Tue, 31 Mar 2026 18:22:09 +0200
Message-ID: <20260331161801.765485957@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232452-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 48DE136E3E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
 



