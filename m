Return-Path: <stable+bounces-235369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHT/J3t912m7OwgAu9opvQ
	(envelope-from <stable+bounces-235369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:20:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1894F3C91AB
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FCDE303FDDF
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441D3859C3;
	Thu,  9 Apr 2026 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="e/bUTZJE"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AF339853;
	Thu,  9 Apr 2026 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729825; cv=none; b=bFLueV6fIpdj0n2G0ZHxfgQ4e2ikD9GawpHyZE1rquIoJKkX/OJO1tcXMdrM3J+qXnNhIoB1VFbmb0h8O9BnRN/gKhfWtV3M5xFMnAjE6ZXtLeiYu9UONhzRWXcswot3IAf+M4fKH1MSjh/9BZhl/XorE3DiDGi90lxKJf7TGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729825; c=relaxed/simple;
	bh=vWRfl8NRp67rzaNRDSDRUpSv5dSaWFZ0K4DW/1hu2Pc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=S0DNRCA5Cw6xnErskjcZKO88rWBUc55L+Db3e7V4poPrOqjzZB5FktBZo1Y6UPxc00lFj/fK2uMn08E+CntgWiYh4eh1meCmCYk4KOn2o3s+NGQCRtvUjADuEnUsBrb6gx+GTAdA0UFLkDaIlmkkbMUWM1w/FlHtmcFlDI4zMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=e/bUTZJE; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1775729812;
	bh=tV03/7YCAXQsRNozGR83z4lHbyp1GVcRvhin27blcNU=;
	h=From:To:Cc:Subject:Date;
	b=e/bUTZJEltPIJy/0hkExDhYc1FypDhy/lCev6/E+zFG/YJNVkX7RKChM2o7XXSNFj
	 U1I9C/AJGvUjPzGcHKW0rReBuiwMPHP55LuJamJbOiZNxw4DuuQZwp6dQ8y8QTPgCj
	 nKWcRQXYytEv4aF5Zb7xYjWyE4veY7oG02rV4W+0=
Received: from Ubuntu24 ([2409:8a00:dd3:9760:baed:a55c:3f15:41bf])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 34C1DAD0; Thu, 09 Apr 2026 18:13:12 +0800
X-QQ-mid: xmsmtpt1775729592tkfblr1z8
Message-ID: <tencent_AA2EB4CA35C01F96927CD6FA388430ED0D08@qq.com>
X-QQ-XMAILINFO: Mzcurg9uYAemwCaMO3HU8HCQ2/t9BKdZA0GrPZrnPOkzeAFeuW87jRpXaHcqad
	 AyEhmfYkTXbcBurwApgcxVSkgp+ritwggpJx22X4ycUV/teEpESvAbF2niJeZTIxhpTk1SwQdhrC
	 QRXWNKhRlRtADU4mmZCXjSyGfEzyX5sHSC8jt2NwiCXaHVWyOwVj3j0sr5bEY0n5ZI4NQX0l4Cjl
	 0euVBWYIDxqdFBqu8ERTaVmcesaUhldlNUaHrfd9GKy0wfzuK0CFB4hleRfI1asWWNt2wa4Mp9tn
	 7hsJggsZ0kAfeOGL9A3QMX/2v/eTwwX5tv2fEKM0UDqZX6ClalORxslvrKbdhvFF6u+r/bdHb/nN
	 jAmOgFeLkB4360scAxpsYmTul9YPGCnM4A2bUAm3RMjrCpl8zoyi9/RgpMQnnVfGizkdqbJXunWL
	 8oAC+KfUuI6fUOrkDmdbYsr6eR1gO2CMNiBRR5S4ceUbxLery7UK8Jehru09uOH0LLLSEF/G0eEI
	 9frBC3eWehfIpfgWKioPBzo4+/uPfP35E//IeH5diKPQ+c/22Cn0h2yBJucxj5cQAILSUBsRcRo7
	 YR1tG0C6owmToUPw2pVwhEC1p4yj+ZHEQVZr63JL7BRidSGHp/wKdV2HhBPZxADoRehc6fy3xULF
	 Dcfgs6m8UkgBC61d0SJXBASUvZ+zUc8IgclBHbbPUwZwJ/Jh6gopHEvQYOUrWujaE7ZHGn9B48Po
	 dHZDJTkgTF1fmVVlLLuFEAYZdzjez5fLzokldZ9OCTwrRIQRksBa05jpH/Ft+Msybkt6oE2i2mtg
	 Utks+U0aALaF1U+5nQIG8qdULAntEARGKNaD7JRpZkI9/Yxgvv+4NY2LdteQjbEjh6OlrrQswENi
	 1eXizTkztWLFY9NiocPkYOawd9L3Vuewgk7hZCe/TGLYItgDKHpyQGUqoik5R2DXXHCJeI+5HvuE
	 sLinb686R9isfarvymXHsabeyMpCdfwupO2bf5N0Z+NVBBXlYsdZIqEtDo7gAA2dzdjzEyJwdmAY
	 /6XqTjvcJgoQSYYgAX8rkH2Yz2KH31r0mKhX+hwkC2Rv0jK5iZQIjl6U+6NEHR6Fjg+aSAKH3WTf
	 vq/ZvAAefUi6lp0islOI8MMlWX5g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12.y] ASoC: simple-card-utils: Don't use __free(device_node) at graph_util_parse_dai()
Date: Thu,  9 Apr 2026 18:12:56 +0800
X-OQ-MSGID: <20260409101256.5410-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-235369-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,renesas.com,banvien.com.vn,collabora.com,kernel.org,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,foxmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,banvien.com.vn:email,msgid.link:url,qq.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 1894F3C91AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
This is to fix https://lore.kernel.org/stable/20260323134527.797956242@linuxfoundation.org/

---
 sound/soc/generic/simple-card-utils.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index c9f92d445f4c..0e3ae89d880e 100644
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
2.43.0


