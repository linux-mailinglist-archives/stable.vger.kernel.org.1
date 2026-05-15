Return-Path: <stable+bounces-248312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD/XFcNJB2rqwgIAu9opvQ
	(envelope-from <stable+bounces-248312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:28:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D450553429
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32B4530356AC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996AC48AE18;
	Fri, 15 May 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gv4XEjRc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C923BB116;
	Fri, 15 May 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861410; cv=none; b=Dh7wPjzBUjtgz9iYDgVB5VBZCaRjlkaiDB9JT1l3IVBvks75R8cSh0D1TUt1CDyB2RnSZA4FaBUBqtSn7HtWDlmd7uCLkvMCNnfZHE/PZtsKSEArzfqHW3JCmoLBgDtmjGUlHcROW2UYfiH/8qSebESg6UEhCyOOk7ZLfTt9OZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861410; c=relaxed/simple;
	bh=4otF4xXDaXoBYADaYdbH40vRjFgDDa0v/7jy68nHnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0G4lYeqiSJY/xGAqdT2EpTYTGuMro09FkHL93E2zo4rAPj5arA78CP7cONtGaOFJ9xiYbkmuy6iAFDPNsMoEy1/hKxfhiwzmqvwiIbg/6PvbkzuylQzB0MNcbI+xOsvPsjADh4wKlqOjieo8y/HxivGItOTVFQUra1deJ97iAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gv4XEjRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCF3C2BCB0;
	Fri, 15 May 2026 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861410;
	bh=4otF4xXDaXoBYADaYdbH40vRjFgDDa0v/7jy68nHnzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gv4XEjRcHT3UcksfquvCGgkdfLy8w+p2TucZOEn0HFqttZkSCDsRx5nuwrwWnk/Dk
	 hORd76ZTrAL8utUGvUFFNB3Ous94GVimo1SnkMJnWesaeDYZCZd0F5tDdRiqLCiNqB
	 DyoAPIj8U6QENUIUkm3VnqyZqNwS9uZb95nF5g+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.6 318/474] media: i2c: imx412: Assert reset GPIO during probe
Date: Fri, 15 May 2026 17:47:07 +0200
Message-ID: <20260515154721.892742999@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 0D450553429
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248312-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

commit 8467c5ff5acae28513bc1e0af535e06b41b04344 upstream.

Assert the reset GPIO before first power up. This avoids a mismatch where
the first power up (when the reset GPIO defaults deasserted) differs from
subsequent cycles.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Fixes: 9214e86c0cc1 ("media: i2c: Add imx412 camera sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/imx412.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/imx412.c
+++ b/drivers/media/i2c/imx412.c
@@ -934,7 +934,7 @@ static int imx412_parse_hw_config(struct
 
 	/* Request optional reset pin */
 	imx412->reset_gpio = devm_gpiod_get_optional(imx412->dev, "reset",
-						     GPIOD_OUT_LOW);
+						     GPIOD_OUT_HIGH);
 	if (IS_ERR(imx412->reset_gpio)) {
 		dev_err(imx412->dev, "failed to get reset gpio %ld\n",
 			PTR_ERR(imx412->reset_gpio));



