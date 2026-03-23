Return-Path: <stable+bounces-228499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB+rDypNwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F4A2F4675
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CE72303F7D0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646C3B0ACB;
	Mon, 23 Mar 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oCd9m+xi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2783AEF3F;
	Mon, 23 Mar 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275294; cv=none; b=VSfN8/hVbA36DigIzb6uZ+Z6UTU1j5x/9iMeuHh341WVWngcJT3e9g2HX9BxQcnlmePVzfzXLTwzWAOPmGc21J/aP+NbXR7HlRYdCXsA0Aw8/Uhoww48BufhcPBGOyFXBWdX4zTsfdVXitsy3Hysuv5PoyuYjF2K+0SYPhYAhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275294; c=relaxed/simple;
	bh=/uYjWrmTMpD4BGHacohfGR3alsUQhXnC5ga1bt+hWiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gqq8P5rfxNj0gShQmKHg4j/Z1n+bFbpRugavKDnxs7dyo8dP/RCKvAAw9IKVcFkXrb2tUhuUTeubOwEnDFgiUoIR5feFZ/WLi0P5TOYSm5+v9HtbBxKxuXDBYU1nBbV0qlcM4ysuqpwCUiDnJggdoqD+QF5+jnbfzQj6nsyT+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oCd9m+xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C89C2BCB3;
	Mon, 23 Mar 2026 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275294;
	bh=/uYjWrmTMpD4BGHacohfGR3alsUQhXnC5ga1bt+hWiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCd9m+xi36w3SoJuCnY/QH9wIHzJfKs7IfZWKUWcFTiYgZZhdtN/h/WNrmJEAPq3V
	 7JF+e/2FyeuSJhwnVMcYzHr9+A6cpepDTZ6QvaKv/1QisD+OoGTd7UcLnkbmbV184f
	 XHyExbJk1POi1EyZ3I47JhB6cQ0bh4OE0sBGDSu0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/460] ASoC: simple-card-utils: use __free(device_node) for device node
Date: Mon, 23 Mar 2026 14:40:40 +0100
Message-ID: <20260323134527.797956242@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228499-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E4F4A2F4675
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 419d1918105e5d9926ab02f1f834bb416dc76f65 ]

simple-card-utils handles many type of device_node, thus need to
use of_node_put() in many place. Let's use __free(device_node)
and avoid it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/87r06pfre8.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 4185b95f8a42 ("ASoC: simple-card-utils: fix graph_util_is_ports0() for DT overlays")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 44 +++++++++------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 47933afdb7261..4857ceecbdc4a 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -999,35 +999,27 @@ EXPORT_SYMBOL_GPL(graph_util_card_probe);
 
 int graph_util_is_ports0(struct device_node *np)
 {
-	struct device_node *port, *ports, *ports0, *top;
-	int ret;
+	struct device_node *parent __free(device_node) = of_get_parent(np);
+	struct device_node *port;
 
 	/* np is "endpoint" or "port" */
-	if (of_node_name_eq(np, "endpoint")) {
-		port = of_get_parent(np);
-	} else {
+	if (of_node_name_eq(np, "endpoint"))
+		port = parent;
+	else
 		port = np;
-		of_node_get(port);
-	}
-
-	ports	= of_get_parent(port);
-	top	= of_get_parent(ports);
-	ports0	= of_get_child_by_name(top, "ports");
-
-	ret = ports0 == ports;
 
-	of_node_put(port);
-	of_node_put(ports);
-	of_node_put(ports0);
-	of_node_put(top);
+	struct device_node *ports  __free(device_node) = of_get_parent(port);
+	struct device_node *top    __free(device_node) = of_get_parent(ports);
+	struct device_node *ports0 __free(device_node) = of_get_child_by_name(top, "ports");
 
-	return ret;
+	return ports0 == ports;
 }
 EXPORT_SYMBOL_GPL(graph_util_is_ports0);
 
 static int graph_get_dai_id(struct device_node *ep)
 {
-	struct device_node *node;
+	struct device_node *node __free(device_node) = of_graph_get_port_parent(ep);
+	struct device_node *port __free(device_node) = of_get_parent(ep);
 	struct device_node *endpoint;
 	struct of_endpoint info;
 	int i, id;
@@ -1050,13 +1042,10 @@ static int graph_get_dai_id(struct device_node *ep)
 		if (of_property_present(ep,   "reg"))
 			return info.id;
 
-		node = of_get_parent(ep);
-		ret = of_property_present(node, "reg");
-		of_node_put(node);
+		ret = of_property_present(port, "reg");
 		if (ret)
 			return info.port;
 	}
-	node = of_graph_get_port_parent(ep);
 
 	/*
 	 * Non HDMI sound case, counting port/endpoint on its DT
@@ -1070,8 +1059,6 @@ static int graph_get_dai_id(struct device_node *ep)
 		i++;
 	}
 
-	of_node_put(node);
-
 	if (id < 0)
 		return -ENODEV;
 
@@ -1081,7 +1068,6 @@ static int graph_get_dai_id(struct device_node *ep)
 int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 			 struct snd_soc_dai_link_component *dlc, int *is_single_link)
 {
-	struct device_node *node;
 	struct of_phandle_args args = {};
 	struct snd_soc_dai *dai;
 	int ret;
@@ -1089,7 +1075,7 @@ int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 	if (!ep)
 		return 0;
 
-	node = of_graph_get_port_parent(ep);
+	struct device_node *node __free(device_node) = of_graph_get_port_parent(ep);
 
 	/*
 	 * Try to find from DAI node
@@ -1131,10 +1117,8 @@ int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 	 *    if he unbinded CPU or Codec.
 	 */
 	ret = snd_soc_get_dlc(&args, dlc);
-	if (ret < 0) {
-		of_node_put(node);
+	if (ret < 0)
 		return ret;
-	}
 
 parse_dai_end:
 	if (is_single_link)
-- 
2.51.0




