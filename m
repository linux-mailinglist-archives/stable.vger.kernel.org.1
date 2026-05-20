Return-Path: <stable+bounces-252853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNjBKlUYDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-252853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:23:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3306599874
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B5A33092F26
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B5348C55;
	Wed, 20 May 2026 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndbK6lkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EA368968;
	Wed, 20 May 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301761; cv=none; b=aYeVfXRANQ+SzDvtzYvclX7WKJ1o4tf6f+RXYBUZCKaYeeTUu0VK3VpCrH3WWEn/+9bkg4VNceHKSfdY+ISNsPQWEJMOH2oGJvydnl0vUnXSVxWXL8kHncAGXyf31ZazfHJClsR1ikCqsFX0CB8440H5xinXSGoD/Tfy0/iwmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301761; c=relaxed/simple;
	bh=kzdCPZT0GIs5crRnvY9OS65yvXcP6BZcH1fU3atHKbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0MpYtZvbnSuB7PyvNaQjShMYsEohQl+mf7q8H607JJwpxN8tMM7PO1yIXVJWN/CDunpoCxZg8WGw6ZhK/r5va6H2vKtdHgBSRVAqrzJjjhGBCweVYacTFFP61UXF4gTNcYUAANCkntJRKQJ91t11DyHJArqC/0IFkJwy7GBfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndbK6lkS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C5D1F000E9;
	Wed, 20 May 2026 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301760;
	bh=zXmTh2dMU4aC6JAmo48Kxo+rRlaBuVhGFcr61vFgmDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ndbK6lkSrL6oHc6Z6iYR6ANND8XJ3lI+t4GWc07Kxvw4s/y0Cfgy1xAgVhyxYJfBT
	 bQYhSAcbxgVUeAw+AfcvgZwVILtgg+ybI9pO1gjufrT2+d/7Giw9yI8crRZvs424jZ
	 CZfop2LcqOne5d33CLyeOOQaz98tbKxqAQyPo2Jw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gopi Krishna Menon <krishnagopi487@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 011/508] thermal/drivers/spear: Fix error condition for reading st,thermal-flags
Date: Wed, 20 May 2026 18:17:14 +0200
Message-ID: <20260520162058.827468380@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252853-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,nxp.com,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Queue-Id: B3306599874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gopi Krishna Menon <krishnagopi487@gmail.com>

[ Upstream commit da2c4f332a0504d9c284e7626a561d343c8d6f57 ]

of_property_read_u32 returns 0 on success. The current check returns
-EINVAL if the property is read successfully.

Fix the check by removing ! from of_property_read_u32

Fixes: b9c7aff481f1 ("drivers/thermal/spear_thermal.c: add Device Tree probing capability")
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/20260327090526.59330-1-krishnagopi487@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/spear_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 96d99289799a1..a935002c2bdbe 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -93,7 +93,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret = 0, val;
 
-	if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {
+	if (!np || of_property_read_u32(np, "st,thermal-flags", &val)) {
 		dev_err(&pdev->dev, "Failed: DT Pdata not passed\n");
 		return -EINVAL;
 	}
-- 
2.53.0




