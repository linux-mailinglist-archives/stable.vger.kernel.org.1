Return-Path: <stable+bounces-250766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HydKZD3DWpd5AUAu9opvQ
	(envelope-from <stable+bounces-250766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:04:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FBA595347
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23038358D048
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010A3DC4DA;
	Wed, 20 May 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7cwZ8Ml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202127E045;
	Wed, 20 May 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296261; cv=none; b=tjwNnAKXuliyZsyiOOJjjE/a+1aVqiR46kpvx2M3b1drl7CH/CH/GXA+RZ7d0+3smrUj7fpoqZE/7CwSqplpKFCHdXcq3f9nZ81Ik3nGHVGHFlTpVHrp6QRpUOznsoPvIVn9W0gXJ7n/hFW9agK8tgbEy4f9CeEu+BGxoqo7W1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296261; c=relaxed/simple;
	bh=YA/Q/MnB+BbtLl5EzWbFwbNBJs4qhmoDTc79qcZ9uYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZszsW5Sl/XfBqu91xAoTZ9QMHD5kfpjfILg1LhEIw3nZYvgzMNCqA2neeXk8ynYJ7kYDsCq4im3eRDU2yEXbmOH3UkyhSmQ/36FM7bS+xK+rUerkuX2pe3w7xcERACeYOqN/qiUrqmz7kBsM8g8DO8gdZmvvgYdHrZyV5G4nEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7cwZ8Ml; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043781F000E9;
	Wed, 20 May 2026 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296260;
	bh=NmWkiWeSrusF9ZDvoz0aEkpz1sW/OsFGdaawBTWIXck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7cwZ8MliuUDLGM+CXm/6yfyNuxfDGQwDl69atiBwnjDDBgar85g6BueakF1MsTJi
	 vt0EYTg2FzcS+FetfTGsXTOZfFI+901YHjw4skxIUQceTFSizPxtysO/bs7PM0pCdP
	 t/uoZlT11blskOf1qH+GwTXp4VPkJT3jD2xqO6Pc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan ODonoghue <bod@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0730/1146] clk: qcom: gdsc: Fix error path on registration of multiple pm subdomains
Date: Wed, 20 May 2026 18:16:20 +0200
Message-ID: <20260520162204.727177293@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250766-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,linaro.org:email,qualcomm.com:email]
X-Rspamd-Queue-Id: E0FBA595347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 16ba98dace9e7cfe25ad8a314e34befacd91f86f ]

Some pm subdomains may be left in added to a parent domain state, if
gdsc_add_subdomain_list() function fails in the middle and bails from
a GDSC power domain controller registration out.

Fixes: b489235b4dc0 ("clk: qcom: Support attaching GDSCs to multiple parents")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Link: https://lore.kernel.org/r/20260328012619.832770-1-vladimir.zapolskiy@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gdsc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 7deabf8400cf6..95aa071202455 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -518,10 +518,20 @@ static int gdsc_add_subdomain_list(struct dev_pm_domain_list *pd_list,
 
 		ret = pm_genpd_add_subdomain(genpd, subdomain);
 		if (ret)
-			return ret;
+			goto remove_added_subdomains;
 	}
 
 	return 0;
+
+remove_added_subdomains:
+	for (i--; i >= 0; i--) {
+		struct device *dev = pd_list->pd_devs[i];
+		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+
+		pm_genpd_remove_subdomain(genpd, subdomain);
+	}
+
+	return ret;
 }
 
 static void gdsc_remove_subdomain_list(struct dev_pm_domain_list *pd_list,
-- 
2.53.0




