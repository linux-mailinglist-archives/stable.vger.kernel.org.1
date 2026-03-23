Return-Path: <stable+bounces-229143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEYnE45ewWmHSgQAu9opvQ
	(envelope-from <stable+bounces-229143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:38:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571C2F69FE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB0C73139E07
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880BF279DB3;
	Mon, 23 Mar 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2bYtqdBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5102798EA;
	Mon, 23 Mar 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278197; cv=none; b=mMWTfTYneFqbINRBefoOiTgcnUbPqnb2rz8tvU0g8KpMLh62nGlJPMU3Y4x/CtLEW0ypjxoOJI4i48f++7oUeJcie9k/bQ44D07Pbv8NwsbVhV1NqrsfpXVoxn1+d+qNPwYlZJwgMXuoZvgfrrdVJnBBfqaMQnjlJ7xHzNqQPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278197; c=relaxed/simple;
	bh=P6YGhTtD41UAIaoikQdVPPwdyPSHuAkFBxIfdOZNlAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuNY8UDfqDlNNkv+9BtKOMu3021yUr0eSqBOUuKoUGX9CxREN50Swwx9idRmp/TgEKiLrCl5QvDZhZfL2MulNfyhiZqFlYcEIsCB/yknF3kHUqlmfvujvjgGi4Ypi8D+3Au5I1GQepdvEjfqsSU9ZZQRhCR2BV7bGMM/1DT4kcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2bYtqdBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC5EC4CEF7;
	Mon, 23 Mar 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278197;
	bh=P6YGhTtD41UAIaoikQdVPPwdyPSHuAkFBxIfdOZNlAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2bYtqdBMfX5cYfapbE8jFfKNJWStwddv0k7KbucSC3d1bEHJsIR2qBMWHpyjdcq/b
	 wx3ewes0Hx0ExXgGIkcIf5l2OVHsp9r2yxZIXdrafBwfOEwrBy2W1tkrESpmyH/JXV
	 PbesxKkeKZeDcFcMAU6GgNd/lNTZme5+RWR8y+xk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sen Wang <sen@ti.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 229/567] ASoC: simple-card-utils: fix graph_util_is_ports0() for DT overlays
Date: Mon, 23 Mar 2026 14:42:29 +0100
Message-ID: <20260323134539.500208745@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229143-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3571C2F69FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 9ef3e69683271..86ccd044b93c4 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -997,11 +997,15 @@ int asoc_graph_is_ports0(struct device_node *np)
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
 EXPORT_SYMBOL_GPL(asoc_graph_is_ports0);
 
-- 
2.51.0




