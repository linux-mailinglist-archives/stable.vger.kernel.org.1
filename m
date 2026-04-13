Return-Path: <stable+bounces-236411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDFdOq8Y3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:24:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEB63EED23
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CC6730364B8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961B24E4AF;
	Mon, 13 Apr 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3TVkWTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B626E6F8;
	Mon, 13 Apr 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096836; cv=none; b=c7G8KZWrut2XDtgWE0SyqESYENEObG0k9KEKIdmVTuWO7LX4TlXdxoWIoSQwZvyq+5Hs4uV5xiDfiU+cQL4IoVfL+i5yZ2+zcL6C4+4E4xJvJj7wCgTTxzLwiGAAWUoobPglfKBtDGdgrhdCptrcxuH1RKzrHF7xBjMmeQSJpYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096836; c=relaxed/simple;
	bh=f9/C9+K4CR8znCB2RHqGsLgvICFWQy0eaCXb3y/WrEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyPZQJmiM4CiBWCjc7f/pYuN38QaHIAY7/mBsmewAOhjvdZiRq0+I0wh8d/BSDvveA7hfYP4E271OJYvBbipruCq529gjOyeL47DOrTgfoYyciwoqfx3HBrjpfxHjFeNQgw5VmLAdZFDGDCwLrctI/ICTycWuokdx1XwaRm2U/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K3TVkWTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C75C2BCAF;
	Mon, 13 Apr 2026 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096836;
	bh=f9/C9+K4CR8znCB2RHqGsLgvICFWQy0eaCXb3y/WrEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3TVkWTX+0Io5umqeA+2OyAh70mX36Sh4Pa0Q3AshCgC7Sgvde56nG3j7Pkd4+NqL
	 5xVpLvt2Z2bo+DJLkineP6rvPnAFD/mKaomf1pwbRWrReK2hckxaW5nNfpXuVAFEt8
	 U+NLblgQyK504lBfOWXrP/qDUXmiBWdae7aX/ubE=
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
Subject: [PATCH 6.6 11/50] ASoC: simple-card-utils: Dont use __free(device_node) at graph_util_parse_dai()
Date: Mon, 13 Apr 2026 18:00:38 +0200
Message-ID: <20260413155724.929646352@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,banvien.com.vn,collabora.com,renesas.com,kernel.org,foxmail.com];
	TAGGED_FROM(0.00)[bounces-236411-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,banvien.com.vn:email]
X-Rspamd-Queue-Id: 6EEB63EED23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
[ The function asoc_graph_parse_dai() was renamed to graph_util_parse_dai() in
commit b5a95c5bf6d6 ("ASoC: simple_card_utils.h: convert not to use asoc_xxx()")
in 6.7. The fix should be applied to asoc_graph_parse_dai() instead in 6.6. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 86ccd044b93c4..a64484fe5a284 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1061,6 +1061,7 @@ static int graph_get_dai_id(struct device_node *ep)
 int asoc_graph_parse_dai(struct device *dev, struct device_node *ep,
 			 struct snd_soc_dai_link_component *dlc, int *is_single_link)
 {
+	struct device_node *node;
 	struct of_phandle_args args = {};
 	struct snd_soc_dai *dai;
 	int ret;
@@ -1068,7 +1069,7 @@ int asoc_graph_parse_dai(struct device *dev, struct device_node *ep,
 	if (!ep)
 		return 0;
 
-	struct device_node *node __free(device_node) = of_graph_get_port_parent(ep);
+	node = of_graph_get_port_parent(ep);
 
 	/*
 	 * Try to find from DAI node
@@ -1110,8 +1111,10 @@ int asoc_graph_parse_dai(struct device *dev, struct device_node *ep,
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




