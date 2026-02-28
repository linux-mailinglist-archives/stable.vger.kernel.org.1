Return-Path: <stable+bounces-220632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL8bNU5Bo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:26:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB11C6FBD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3B7C341F928
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797F3E88A9;
	Sat, 28 Feb 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVs3yW2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADA3EA5B7;
	Sat, 28 Feb 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300515; cv=none; b=GcqYylLGUxJLY/jFVKL1Bqo3sGa2T5oz6nY9ENgeWZsSSlYUMuN+7cMNH6fXNh0vpm1cgRFug0t9Khw+se0uFyzV+QwAIiIrYqoDk2AsJ2stP/JGJBMjkUNQwLNUebMaXMjFv2anEVfE4CQ3WmG1QscRc/eJuh9Je6PUHriC/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300515; c=relaxed/simple;
	bh=jVAGHU9MsljkJMXVer6SXYH4Vq7rqfsrTM50qaL2KMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APWFoaC7vbhZwEm/dGMtgNunqrELdCN7BPi7pydf0dkNqyIXfDVsm8MjBrYkp5ZWovNxwNOQTFqZ+JtwWY7fwwpvpYV3idiA/9fesHZQD1Gab1VC9ex5pO4dV00hmG/tg9knwlKFQMzReUOUaqFu2feUDAms5CSYDTb0l7bpST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVs3yW2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988A4C19424;
	Sat, 28 Feb 2026 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300515;
	bh=jVAGHU9MsljkJMXVer6SXYH4Vq7rqfsrTM50qaL2KMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVs3yW2Uze3arUGlg/OhLqu4Cyl4m+RuDFZTTiimpRzPLKlJcj0n7QVqNMm2lmOT/
	 tiE0iSFBqYfPS6KAbtpOg7cBzTlHdKV5DeG1BUw7720PXEFtBG4Yl8WqOFPTZI47ov
	 8k5BF56wWr/Pl4Qy2PEweeV/kLZK3VpKK7x9uVen4Q9vY06ic0OxmfL7nqAq6AVWzP
	 YCf29vcwPm8wfDUVy6sneC9wqMwVbxCDn4tODN0sWdpi6SETNS+7a+YBT2qMXNU2mK
	 LPsZ68gB3HWwXevjdzrWSimDA4NhLzt1IpinRI6dw7uT7T8R5Xx0muXuEmKoAnt8/S
	 1HlHzbNftVjRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 553/844] ARM: omap2: Fix reference count leaks in omap_control_init()
Date: Sat, 28 Feb 2026 12:27:46 -0500
Message-ID: <20260228173244.1509663-554-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220632-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kemnade.info:email]
X-Rspamd-Queue-Id: 39CB11C6FBD
X-Rspamd-Action: no action

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
index 79860b23030de..eb6fc7c61b6e0 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -732,7 +732,7 @@ int __init omap2_control_base_init(void)
  */
 int __init omap_control_init(void)
 {
-	struct device_node *np, *scm_conf;
+	struct device_node *np, *scm_conf, *clocks_node;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
 	int ret;
@@ -753,16 +753,19 @@ int __init omap_control_init(void)
 
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
@@ -780,6 +783,9 @@ int __init omap_control_init(void)
 
 	return 0;
 
+err_put_scm_conf:
+	if (scm_conf)
+		of_node_put(scm_conf);
 of_node_put:
 	of_node_put(np);
 	return ret;
-- 
2.51.0


