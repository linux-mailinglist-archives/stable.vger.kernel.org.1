Return-Path: <stable+bounces-218532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDDiLO5SnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1292D18F5F3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51CE630FF3C4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84F423D7CF;
	Wed, 25 Feb 2026 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rhfJD92w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2718B0A;
	Wed, 25 Feb 2026 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983369; cv=none; b=KgK9RbGbTl1RChN14+dbbjLSgTFk3xabOGdoPSd//n1FFMmWAQ3Ee5nZSkrxznjLfgsH1NjQFAMyEGNLipaGzy90IIkB+oWWOFJozZ4v2J8eG4lyA/vAei5yOQe79GlMrr80hRj1njhBwU6mjlJwGxLfbjuntdPLpmUCW4K4CSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983369; c=relaxed/simple;
	bh=KRpKMMmnWv7KZsmlzjDyxjkxbv5H7YPS7QZw+PnV3KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8oRYvwvjcmVfeFE7jsXOmWrGUYB6QwwoaDpPjeO5vHp39s5I0JRAAnRWwRJgSrK4Scz4FwUDn3ETBwd/2z53RNmP4ay7LrhBQ3/4t841cDJaTLdgAWJYTVC5ajjz7yP+IULWds1pd1H4G1vfx9FAN19uDmDIeHCnCPQ+gQqbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rhfJD92w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F37C116D0;
	Wed, 25 Feb 2026 01:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983369;
	bh=KRpKMMmnWv7KZsmlzjDyxjkxbv5H7YPS7QZw+PnV3KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhfJD92wqyYoWQcgq0zLRvi9xVjluHglPoqcaqkHe5YNQ7ncvzKVRqV664QGrbDeK
	 uAXRyak8fzHMIxftADdUeDAmrFxK4RNQZnDCMZF9+DMtyED+MKQ1iUIuReID52hOF5
	 A2gdBhFG7KIswqCSR6GH5npSB2ql4xfxTlf5eN78=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Val Packett <val@packett.cool>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 495/781] power: supply: qcom_battmgr: Recognize "LiP" as lithium-polymer
Date: Tue, 24 Feb 2026 17:20:04 -0800
Message-ID: <20260225012411.950133243@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218532-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[packett.cool:email,qualcomm.com:email,msgid.link:url,collabora.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1292D18F5F3
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

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
index c8028606bba00..80572ee945b4f 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1240,7 +1240,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
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




