Return-Path: <stable+bounces-236385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJE3D9Ib3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:37:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCCB3EF692
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16D9830DF236
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4628B7DA;
	Mon, 13 Apr 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="koPpUHok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF926F293;
	Mon, 13 Apr 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096769; cv=none; b=pTl4vCSvNtC1zl1JWSQtq/Qc3LCOGuVbH4bGqmzo5mdWzXC7xHv7jNzdKYncIVD46Qfx1MZxbCB1cVTgI7+/w/JSZUVILGjF36QbehgJMdzqt1oF19q62pUNnT9OoVuP2NbYN4CukXxlsBEcdz9RkqpJhwtjr2zfFU5ojIDe97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096769; c=relaxed/simple;
	bh=OdoPB7ocx2r/KtkrutdvFmhCYkSEHspfl8ccs/dypNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JudLEndmhcfP3Y97hHhE//wlr98KfBvDHPp1F/+tya85V6RwDXOTFGVK80EJOyN/1WEB8c0k0qUZzd3Uj4f8NVdPTlUQKEtZ+72YDIpwWoV0Es37iskuRQa6Q5fZMRtng9oBM3VfOdVzA9DnH95Nz4kRwaJ42bOwr9/fje0SUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=koPpUHok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08010C2BCAF;
	Mon, 13 Apr 2026 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096769;
	bh=OdoPB7ocx2r/KtkrutdvFmhCYkSEHspfl8ccs/dypNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koPpUHokvEpVLZRMya686GDPbiMKED1k4l1+qKTx6cpEVsnbFV/7KRQ8SfAtsKy1t
	 g3msEfLjzhE2jICFG75uwUCEdXyOsT6iy73S/VeBiCkxzsBcDgjiL/k4xfCZ8ULxh8
	 0wOaqPN/+JUJvmIZ4GzhD3LMYWD7RNjtgx9voBGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 13/70] ASoC: simple-card-utils: Dont use __free(device_node) at graph_util_parse_dai()
Date: Mon, 13 Apr 2026 18:00:08 +0200
Message-ID: <20260413155728.683096181@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,banvien.com.vn,collabora.com,renesas.com,kernel.org,foxmail.com];
	TAGGED_FROM(0.00)[bounces-236385-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,banvien.com.vn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,renesas.com:email,foxmail.com:email]
X-Rspamd-Queue-Id: 9FCCB3EF692
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit de74ec718e0788e1998eb7289ad07970e27cae27 ]

commit 419d1918105e ("ASoC: simple-card-utils: use __free(device_node) for
device node") uses __free(device_node) for dlc->of_node, but we need to
keep it while driver is in use.

Don't use __free(device_node) in graph_util_parse_dai().

Fixes: 419d1918105e ("ASoC: simple-card-utils: use __free(device_node) for device node")
Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
Reported-by: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>
Link: https://patch.msgid.link/87eczisyhh.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index c9f92d445f4c9..0e3ae89d880e5 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1072,6 +1072,7 @@ static int graph_get_dai_id(struct device_node *ep)
 int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 			 struct snd_soc_dai_link_component *dlc, int *is_single_link)
 {
+	struct device_node *node;
 	struct of_phandle_args args = {};
 	struct snd_soc_dai *dai;
 	int ret;
@@ -1079,7 +1080,7 @@ int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 	if (!ep)
 		return 0;
 
-	struct device_node *node __free(device_node) = of_graph_get_port_parent(ep);
+	node = of_graph_get_port_parent(ep);
 
 	/*
 	 * Try to find from DAI node
@@ -1121,8 +1122,10 @@ int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 	 *    if he unbinded CPU or Codec.
 	 */
 	ret = snd_soc_get_dlc(&args, dlc);
-	if (ret < 0)
+	if (ret < 0) {
+		of_node_put(node);
 		return ret;
+	}
 
 parse_dai_end:
 	if (is_single_link)
-- 
2.53.0




