Return-Path: <stable+bounces-220743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLdHLuRBo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:28:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC61C7092
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E56230C2EE9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34D4025C2;
	Sat, 28 Feb 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsvOd+vj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A0F4025B9;
	Sat, 28 Feb 2026 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300623; cv=none; b=JJaP6DYt5HLfhtkDWeo8ZKxFqlhi58ICUvma3rDwLjUoDgL0WF7+leKm3r/fH62EHybHTEpWPrwYyeidp7RznTF3KIr49u6W+aqxmgjBw7fr9Zp+S5zOZ/ICXMAmUY4lBgWi+mIWTj9RaqMAlYXrjdo/kT9wjPpWtMq9mW0z/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300623; c=relaxed/simple;
	bh=YwH7ocqVR6BTEcFleyAorSaH1+d3lxPTj54krC2x6Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9dxBwmOk2fag3ue2+IFlCGuQjenqht4qAukzK7nkzvZ0/om84VeQ6mDI4M3MiPnc5/sQTn5L3uUf8Lv6FHQynt1oCxJ5jMeiwE+qt+29+Znla+3xI+IDVaDn8tlBVTXr8u0bf1qrfAHnhAr0uPTnIadiFW55tw62fykn1gSENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsvOd+vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E507DC19424;
	Sat, 28 Feb 2026 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300623;
	bh=YwH7ocqVR6BTEcFleyAorSaH1+d3lxPTj54krC2x6Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsvOd+vjt7it8W4yzZyNoXnifjUrr/XWWoTCIB4VDNQMBamRoMjCeaWSBmHY8BPTB
	 RPlnKE5MKh1qSx/F+rvKf0FhUoXmmCyCUu+9SsY+1/aTxVZgl4/1scBnDP8scis1rW
	 NX0/GwIdKjgzt+OvaQPLl3UTW5YPZ/Dw7P+4r4pSPBAYX9Z9sPjhUKJ2kFbkz6uRQP
	 3dGux9SV8QL/Jgn4xDzicvHHzbx54sEWBqrI8eQFd6Z++dK91All9AqMaOV8T+3wmb
	 s9NUsp/tI/lI4GzB2jkJOjPIZemSJH1bvoQd9ngOcdf5dM/o/02W5oaiJC6b+D0zAo
	 ktgfrVqVbPKhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 664/844] mfd: qcom-pm8xxx: Fix OF populate on driver rebind
Date: Sat, 28 Feb 2026 12:29:37 -0500
Message-ID: <20260228173244.1509663-665-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220743-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63BC61C7092
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 27a8acea47a93fea6ad0e2df4c20a9b51490e4d9 ]

Since commit c6e126de43e7 ("of: Keep track of populated platform
devices") child devices will not be created by of_platform_populate()
if the devices had previously been deregistered individually so that the
OF_POPULATED flag is still set in the corresponding OF nodes.

Switch to using of_platform_depopulate() instead of open coding so that
the child devices are created if the driver is rebound.

Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: stable@vger.kernel.org	# 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20251219110947.24101-1-johan@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/qcom-pm8xxx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 1149f7102a365..0cf374c015ce7 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -577,17 +577,11 @@ static int pm8xxx_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int pm8xxx_remove_child(struct device *dev, void *unused)
-{
-	platform_device_unregister(to_platform_device(dev));
-	return 0;
-}
-
 static void pm8xxx_remove(struct platform_device *pdev)
 {
 	struct pm_irq_chip *chip = platform_get_drvdata(pdev);
 
-	device_for_each_child(&pdev->dev, NULL, pm8xxx_remove_child);
+	of_platform_depopulate(&pdev->dev);
 	irq_domain_remove(chip->irqdomain);
 }
 
-- 
2.51.0


