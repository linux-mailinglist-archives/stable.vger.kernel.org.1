Return-Path: <stable+bounces-226572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC5OBoKMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:16:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5CB2AF3C0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80528317FC10
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB1F3F54CD;
	Tue, 17 Mar 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdYwqDbq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872E3F65E5;
	Tue, 17 Mar 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767286; cv=none; b=svNOP+Yv1xRMnLsuiqZoYRsAnjVHhnDGqSdNpPpRHIgdKohp2Zgee7cFmY0NXZHG6qNrmGuWiHGqIMxYLv6xdeZVfdR5vqnSTQHl78kJ+edwaIl4u2AxW7mqGLIjQfR6cKfwsz4D34SlZ01IV8AVpE1U2JrK2rOahVP3TPlui6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767286; c=relaxed/simple;
	bh=udPCMbVi5E4u5CNMlysqBAj4DKHZDn+qe4enQarmbwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4YtnkMKxxz7E6L1/5YleWCp+GfQ9yvJ4vvY27S9WjmVqXZDzRDdBn+ihR0O7BgITcbETIcSP1zNfiex+be1hiHyMnmpdU8skzBWHp6EeInH/19pmnVWLrnU88zMEwCRafmEOd8HomjFhcOdvERGCK9nl1EnVVmvS5CSvbLVTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdYwqDbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C36C2BC86;
	Tue, 17 Mar 2026 17:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767285;
	bh=udPCMbVi5E4u5CNMlysqBAj4DKHZDn+qe4enQarmbwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdYwqDbqgywNc9QgLti4pBKt+LIYyLoTI1NavfYby1Qq/TYj9ZbXXEiGieoLGV3n4
	 PaJFCqqCzzS9uGsAMlUpH1b0+h6/YTILuAMAtMrv4TfQ/40urz2xGnGez+khC+YOxH
	 69Bzpi/hYZDJhcB6B/zxXfnm7KxE6iuMwDHniFm0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sen Wang <sen@ti.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/333] ASoC: simple-card-utils: fix graph_util_is_ports0() for DT overlays
Date: Tue, 17 Mar 2026 17:31:23 +0100
Message-ID: <20260317163001.371565222@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226572-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.1:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,renesas.com:email]
X-Rspamd-Queue-Id: 6B5CB2AF3C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sen Wang <sen@ti.com>

[ Upstream commit 4185b95f8a42d92d68c49289b4644546b51e252b ]

graph_util_is_ports0() identifies DPCM front-end (ports@0) vs back-end
(ports@1) by calling of_get_child_by_name() to find the first "ports"
child and comparing pointers. This relies on child iteration order
matching DTS source order.

When the DPCM topology comes from a DT overlay, __of_attach_node()
inserts new children at the head of the sibling list, reversing the
order. of_get_child_by_name() then returns ports@1 instead of ports@0,
causing all front-end links to be classified as back-ends. The card
registers with no PCM devices.

Fix this by matching the unit address directly from the node name
instead of relying on sibling order.

Fixes: 92939252458f ("ASoC: simple-card-utils: add asoc_graph_is_ports0()")
Signed-off-by: Sen Wang <sen@ti.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/20260309042109.2576612-1-sen@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index bdc02e85b089f..9e5be0eaa77f3 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1038,11 +1038,15 @@ int graph_util_is_ports0(struct device_node *np)
 	else
 		port = np;
 
-	struct device_node *ports  __free(device_node) = of_get_parent(port);
-	struct device_node *top    __free(device_node) = of_get_parent(ports);
-	struct device_node *ports0 __free(device_node) = of_get_child_by_name(top, "ports");
+	struct device_node *ports __free(device_node) = of_get_parent(port);
+	const char *at = strchr(kbasename(ports->full_name), '@');
 
-	return ports0 == ports;
+	/*
+	 * Since child iteration order may differ
+	 * between a base DT and DT overlays,
+	 * string match "ports" or "ports@0" in the node name instead.
+	 */
+	return !at || !strcmp(at, "@0");
 }
 EXPORT_SYMBOL_GPL(graph_util_is_ports0);
 
-- 
2.51.0




