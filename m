Return-Path: <stable+bounces-236565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGCDJnkb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C453EF599
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03F3530142AC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C71302146;
	Mon, 13 Apr 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YbwTJZMc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2B2F8BC3;
	Mon, 13 Apr 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097234; cv=none; b=qjQj+tVQeIJy5FZ0dKOUQGR7cPv4tGM1TY+3xtEn8WPF5NR8wZgq2BMQNCpTu/e+0y2seKKd+nVHIXFK8AfOFftZZdpgJ6VS4XIMPABZX5WDGVmNpvaD5IPx/eEF3Z6NUheFLzxCnerR11JByr39qXkN/VIVowbwoyYnF2QgWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097234; c=relaxed/simple;
	bh=hyiK9Emd3xtPkYTH8sPqGNEKEvOQWbWcAUo53RbQmZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NykhOetA3iErhdDrwAhr/ePp5LP4wMDgk+7eSt5m4lnlD9xbsllKkIoMsh6+CXz6NUOYccQGQF1c4GNWRMPUvWLC2vd0D4kIW4pHwCr1pVGyFgrvVmLpheC5AwE6yA4wBxKS9KC5TNyiKbLlj16YvxhGhzKqN5NQmkGeOFlaOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YbwTJZMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A2CC2BCAF;
	Mon, 13 Apr 2026 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097234;
	bh=hyiK9Emd3xtPkYTH8sPqGNEKEvOQWbWcAUo53RbQmZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbwTJZMcUhKxnQtCkp7hWFs++kdW5lUCEw7fTXeRxDpJcltPk5lA6HsvPLvcnFxDR
	 p8h/NeE5fzS80qe3Xv30xEhW1c/o4iVlvZ8B1Ga4AX/TWJeDY9m28ecCks8rs5AAju
	 3UxLpGeg8/FSLN+mQaI/hsqKAMoRXAA5eqWcTGK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 015/570] ARM: omap2: Fix reference count leaks in omap_control_init()
Date: Mon, 13 Apr 2026 17:52:26 +0200
Message-ID: <20260413155830.985978948@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236565-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,kemnade.info:email]
X-Rspamd-Queue-Id: 65C453EF599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 93a04ab480c8bbcb7d9004be139c538c8a0c1bc8 ]

The of_get_child_by_name() function increments the reference count
of child nodes, causing multiple reference leaks in omap_control_init():

1. scm_conf node never released in normal/error paths
2. clocks node leak when checking existence
3. Missing scm_conf release before np in error paths

Fix these leaks by adding proper of_node_put() calls and separate error
handling.

Fixes: e5b635742e98 ("ARM: OMAP2+: control: add syscon support for register accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://patch.msgid.link/20251217142122.1861292-1-vulab@iscas.ac.cn
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/control.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index c514a96022699..9042bbfaeb072 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -793,7 +793,7 @@ int __init omap2_control_base_init(void)
  */
 int __init omap_control_init(void)
 {
-	struct device_node *np, *scm_conf;
+	struct device_node *np, *scm_conf, *clocks_node;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
 	int ret;
@@ -814,16 +814,19 @@ int __init omap_control_init(void)
 
 			if (IS_ERR(syscon)) {
 				ret = PTR_ERR(syscon);
-				goto of_node_put;
+				goto err_put_scm_conf;
 			}
 
-			if (of_get_child_by_name(scm_conf, "clocks")) {
+			clocks_node = of_get_child_by_name(scm_conf, "clocks");
+			if (clocks_node) {
+				of_node_put(clocks_node);
 				ret = omap2_clk_provider_init(scm_conf,
 							      data->index,
 							      syscon, NULL);
 				if (ret)
-					goto of_node_put;
+					goto err_put_scm_conf;
 			}
+			of_node_put(scm_conf);
 		} else {
 			/* No scm_conf found, direct access */
 			ret = omap2_clk_provider_init(np, data->index, NULL,
@@ -841,6 +844,9 @@ int __init omap_control_init(void)
 
 	return 0;
 
+err_put_scm_conf:
+	if (scm_conf)
+		of_node_put(scm_conf);
 of_node_put:
 	of_node_put(np);
 	return ret;
-- 
2.51.0




