Return-Path: <stable+bounces-219303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMkdBHGdnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:57:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F81929C7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AA32303B2D1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DD2D94AF;
	Wed, 25 Feb 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQuSnrTM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232E2FFFB6;
	Wed, 25 Feb 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002627; cv=none; b=VJccdnO/EG2VtX7sznU+YgoKwdJSHP+FJzI7by4DoOEqVJSHLnvACN61rE9vAWiqE9DBOHrcAvEcVApkcAMDvz5ZTDERXiOGvyPztRwighGiem2HY7zT9br8ml4FNbaR75EFy2SKQkUKj07ZuPE3cJfwoqduQ+as5Xb7j+trIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002627; c=relaxed/simple;
	bh=hIS7d0dErC/+aWpe7Azq+GW1c5eVrqCjBPodVwIC+HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDJL/m0MXiouhk1wDwfj013EVzpQMwDrqs4VgKYV1ipEBN2U+zI9G2Uh5xmFeQEEjVtQuZZVodmpvVnrT3PI0uIOBdQ88RDa/n/SEwD2V12Skrp0WQSJAgyJWTsWDCnKOpTvnc0FgwxJFDcsq2W+4PQogyZXTHezwt4GzdtA4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQuSnrTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBA2C116D0;
	Wed, 25 Feb 2026 06:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002627;
	bh=hIS7d0dErC/+aWpe7Azq+GW1c5eVrqCjBPodVwIC+HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQuSnrTMwlBgzVJbeFIGK2NoW5miXG44JcpebE+kx3/e8UcfxF1fmNG56RMuNFKaW
	 uDJCXJPm27lW3Kfi0Aku0Ua2Z7wKxP0wc2oK8v4dIi3PVmp0aSEWawZCWKjhHK/REb
	 M/vpOlkovLL8tWNAebBOBM9KHNTUpSrz6Z6ibYSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Val Packett <val@packett.cool>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 388/641] power: supply: qcom_battmgr: Recognize "LiP" as lithium-polymer
Date: Tue, 24 Feb 2026 17:21:54 -0800
Message-ID: <20260225012357.983964944@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219303-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 867F81929C7
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Val Packett <val@packett.cool>

[ Upstream commit c655f45480637aee326b5bd96488d35ab90db2b0 ]

On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
for the battery chemistry type, but only all-uppercase "LIP" was being
recognized. Add the CamelCase variant to the check to fix the "Unknown
battery technology" warning.

Fixes: 202ac22b8e2e ("power: supply: qcom_battmgr: Add lithium-polymer entry")
Signed-off-by: Val Packett <val@packett.cool>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://patch.msgid.link/20260120235831.479038-1-val@packett.cool
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_battmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index e6f01e0122e1c..ff77dba29a3ef 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1244,7 +1244,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
 	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
 	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
-	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
+	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN) ||
+	    !strncmp(chemistry, "LiP", BATTMGR_CHEMISTRY_LEN))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
 
 	pr_err("Unknown battery technology '%s'\n", chemistry);
-- 
2.51.0




