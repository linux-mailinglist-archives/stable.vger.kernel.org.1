Return-Path: <stable+bounces-228426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBIRJr1NwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:27:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3810D2F483D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42B1E30D0BC0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8BC3ACA68;
	Mon, 23 Mar 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zaULGoMd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436BC3AEF3F;
	Mon, 23 Mar 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275094; cv=none; b=dVOlmR2Jj8DExHkx2bNy89QAqCFEycWC/l+iZitV76yZ+GQKFIBWg7ezxt1dlwiUoP7ZVnKTdapcFnZcsyDJyQO5HsPzm1WMcZT+81Yb7TFZqb595+hvdRpJt0LNATrp6NJAOlaFuRN2Fr/PZDzyYnS3LnxtYK8RXzX9wG5h8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275094; c=relaxed/simple;
	bh=vQAtLb22AFsx56keQYyzrh8bBq1oI2dQO+bLNyHvvts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTBSsYcznxAanm7Uh0XWmxgxX6otg5k94dgqtoX5jFxsouA8QptnBJUAFt/IdWFZGQvAuSo8AJ2tT+tt8ONCWHAYsmDXY5DcRHeMSWi+0ZSXv6zVh8i8xZ6Wp6KCujX0fHeAd+7RAROW3Q3sTWx+0NBcJDlvnm+1/bTGKnK/H7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zaULGoMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E90C4CEF7;
	Mon, 23 Mar 2026 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275094;
	bh=vQAtLb22AFsx56keQYyzrh8bBq1oI2dQO+bLNyHvvts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zaULGoMdEl9wE5iP31olHqB6FZ434q1qyZ2PkWFx8cp1mngA6Jedi/QXaQaSSXVtZ
	 Vf0W/6r1ZvPD13iCaaWBE+0iEVcBkyA7NjQNQZNxniGsfC4JHCeGTGnMNCceDo6M/v
	 X7+q+OJ1OaeKRsxfVAr23EU/Qw/GdXzR7dAw1PXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Anas Iqbal <mohd.abd.6602@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 177/212] net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths
Date: Mon, 23 Mar 2026 14:46:38 +0100
Message-ID: <20260323134509.354777265@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,broadcom.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228426-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3810D2F483D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anas Iqbal <mohd.abd.6602@gmail.com>

[ Upstream commit b48731849609cbd8c53785a48976850b443153fd ]

Smatch reports:
drivers/net/dsa/bcm_sf2.c:997 bcm_sf2_sw_resume() warn:
'priv->clk' from clk_prepare_enable() not released on lines: 983,990.

The clock enabled by clk_prepare_enable() in bcm_sf2_sw_resume()
is not released if bcm_sf2_sw_rst() or bcm_sf2_cfp_resume() fails.

Add the missing clk_disable_unprepare() calls in the error paths
to properly release the clock resource.

Fixes: e9ec5c3bd238 ("net: dsa: bcm_sf2: request and handle clocks")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
Link: https://patch.msgid.link/20260318084212.1287-1-mohd.abd.6602@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 960685596093b..de3efa3ce9a75 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -980,15 +980,19 @@ static int bcm_sf2_sw_resume(struct dsa_switch *ds)
 	ret = bcm_sf2_sw_rst(priv);
 	if (ret) {
 		pr_err("%s: failed to software reset switch\n", __func__);
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
 	}
 
 	bcm_sf2_crossbar_setup(priv);
 
 	ret = bcm_sf2_cfp_resume(ds);
-	if (ret)
+	if (ret) {
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
-
+	}
 	if (priv->hw_params.num_gphy == 1)
 		bcm_sf2_gphy_enable_set(ds, true);
 
-- 
2.51.0




