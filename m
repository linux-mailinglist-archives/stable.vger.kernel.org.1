Return-Path: <stable+bounces-264561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KWazF9l5MWpPkQUAu9opvQ
	(envelope-from <stable+bounces-264561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:29:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A6692205
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ybGlp4oy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264561-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264561-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB2D031E082E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2546AEFE;
	Tue, 16 Jun 2026 16:16:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12646AEC5;
	Tue, 16 Jun 2026 16:16:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626572; cv=none; b=HF5IhdbkEp+4UcwIRcGbo3z4siHAEzzRI8cEAU6NvFKvOtQftZEKjmwth7V0jkzb6zXFMJPA612UUL7btzzEuZ/XFdqJ19yyXJ0CNQsvZNfnKGF1JIK+AAzLbYnE255qCRLVF0VCpGKI2avb/1uToVCq3kJpQreWqBpPNVtw47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626572; c=relaxed/simple;
	bh=qOsDPODkGuhc7gXVWEn/jKxELWILilzz4xhnPkagiO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9bcmbT5h29o07qQPGj0Kr5D8qzcSuhQ842+Mp6/2HEHT7317TJ7gKP1uTPPIqeBS4v0jRck/9g/fenSNMZeHCGWdclmTBd8zm76VmrlvoQr1gO1wSaL0A91uVqFKVFcWhneTlMXyIdimH+fXHHLWjuvnlwj2/BRPTRyKYsOvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ybGlp4oy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705E11F000E9;
	Tue, 16 Jun 2026 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626571;
	bh=WuLFu2Em77kD037ZCBfD7aXM6TrrzgbBMTIHDiPw53A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ybGlp4oyHRPSMj8uK0+j5DPKivJEdF7XCr7eLaCQD4RN69t8yrNx0NEx+NsTbvFwj
	 UVgoKBWoZ6PfrjXS+JgnzdVfdPQlUJZyqQdLizxYPy5hBC69qpkx0HpGZxRo/b9KES
	 gC3tqUx7q/xa2sGdC+9K8ORtI5DxHj/h8tL0u0os=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 013/261] soc: qcom: ice: Return -ENODEV if the ICE platform device is not found
Date: Tue, 16 Jun 2026 20:27:31 +0530
Message-ID: <20260616145045.627932380@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264561-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sumit.garg@oss.qualcomm.com,m:manivannan.sadhasivam@oss.qualcomm.com,m:andersson@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E45A6692205

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit 5a4dc805a80e6fe303d6a4748cd451ea15987ffd ]

By the time the consumer driver calls devm_of_qcom_ice_get(), all the
platform devices for ICE nodes would've been created by
of_platform_default_populate().

So for the absence of any platform device, -ENODEV should not returned, not
-EPROBE_DEFER.

Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com> # OP-TEE as TZ
Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260518-qcom-ice-fix-v7-2-2a595382185b@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/ice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 9d89bfc50e8b86..66b64509347a64 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -301,7 +301,7 @@ struct qcom_ice *of_qcom_ice_get(struct device *dev)
 	pdev = of_find_device_by_node(node);
 	if (!pdev) {
 		dev_err(dev, "Cannot find device node %s\n", node->name);
-		return ERR_PTR(-EPROBE_DEFER);
+		return ERR_PTR(-ENODEV);
 	}
 
 	ice = platform_get_drvdata(pdev);
-- 
2.53.0




