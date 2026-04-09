Return-Path: <stable+bounces-235370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHaxKbx812mXOggAu9opvQ
	(envelope-from <stable+bounces-235370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:17:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B953C9165
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25EC730088AF
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F1B37F726;
	Thu,  9 Apr 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GXXs4T50"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D8337BA6;
	Thu,  9 Apr 2026 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729849; cv=none; b=me8IaJ8K3FwO8fnYnCwbM6cTbRUOz+0Refol/6Pd+/9r8gdek7DEWdtURvTkNWYWtbaLGfwPZafd5eooKpXS8tZnyvRMIVFsch7vcaMyDBd3y8xYe5PxYLGverh/20VPYC2HkNjGNcrKrHcujI5uaWiaRMrqJxVr7jP6Ib1V8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729849; c=relaxed/simple;
	bh=KySF69LyBKmwDZslGztLAE/n7m7sD4hKpo9NRPs20k4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=IPacpUBzzfaXY3/Fc/v2287bdmSLnC8S2PUoPk9A8geLSgmlBA44niQO5+DKFphA5jg7uCSgK/0pXlnifC1Z7IIrZr0Kw7VExsCyzcpb5JFRV0pIbzeQE1welcK/xWQP67lP874S/YeKSNIxzCn+1x0mf4MO9oA7diHXZj1MN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GXXs4T50; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1775729837;
	bh=ZaKEtSMcngZyofrlhdgGbsQ/k4IGJI+r4wLNMyOtReI=;
	h=From:To:Cc:Subject:Date;
	b=GXXs4T506YIlt69fU6DY8vaQJGopPLs8Xq0VJAhZpVEUq4JOrXBItLi6S/tVC26rR
	 c2zLvXn/D5l8DruoTlwpb2HUmGcS9X7y1+StJRnuq/pSZpg29cf9H5cJHw5bgROnI2
	 X0aPYTUZQ+amS+A0Nek1JsLfZ9V1YjGsCC5GwPEg=
Received: from Ubuntu24 ([2409:8a00:dd3:9760:baed:a55c:3f15:41bf])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 373A96F1; Thu, 09 Apr 2026 18:13:51 +0800
X-QQ-mid: xmsmtpt1775729631tbohmvy3b
Message-ID: <tencent_EDD6D47C38490A59EFE3E8C0343684D27A0A@qq.com>
X-QQ-XMAILINFO: MLDapaiELEXYEqOFiml+kc6o3iu/EVLCzUueqAjaC09bIrCPWdAkgAAPKC7zyK
	 GHeJY66xPsnqNoiBfdS1bijYyuDJ96i5lQ88GyVhMQa6GV8oBRp3IP7Lo8BUeo8buFf4Da0P8gYa
	 lnQtQy5IGkiTuT9FRoB3jg5dS07Jee3BetqnUfcODIxI0x7OdOo2z19Dj/V497h0NREeiWBt3+t6
	 yvSWM25BuZz4WMPiRcsbTJWqeOGH73Ox3mkAX6XcbMYZFSyxh17UMI89nCkNebWBOt34qtGClgL/
	 ONtZd+TPkkurqTjWEwFu9TCoohlfQ8sOfFfLStrdnS1A1W80THukLC6EeN1o3EZObYjissS2VueK
	 KG/afLxsxcqQLuUiwvuqzhegeuik+36IgIaCk/eKz11W4figuXKjDzjKQOotpcyWeaVHoc1s/z9T
	 j9HnyCqBcpDw6UQ+uB7xUgDliFkgNWgBP+0Gb/YPl0kgHkmYP0mbGqAAHQCQW5M1b47fkfToOXXb
	 T0mWc3xt3jpPm6CgP+EKGpDxCeA7GGxrvLIOkwrQh/UJYLqrRXBfCQkPJCYh460QkDSql9sQsIg5
	 yrCrbHlxGIf+srNdVMZT4nEe1ORkalsai+DlXWaIY2oQW1Tm+xRVt8S8+2E0UAQnCnC/AARa/k8l
	 FdOiwyH/ACHbGlSqi3guyZMPg1t5FfBEHIVp3UrzqCWT7VpmAZbIDJx5Hxs4hTdcy3XfTT4ovGjr
	 nkK3ls1qt5FcUe/iTvgDZ9vcrkrLDbbyY953kJ2lsZ6Hb0+FLmazANi8nQgsaTnT+BqPjvfCwDvE
	 lUl4YXdAJTMVZl8/E1aKucWT4hgn9MbEGOiedgueCO0kK693mMC1KNAHOTAnY0iqHct1vVlKg45y
	 3J/dGw4GE+aCRvv+SUWYJL7j9ZaO+3ufm5bCmUx9Ia6CllTOFb5ZUgV8jj7++rX3n5wts8forwoM
	 hFvXHdFk6tSXqYa2jI9krkC9FIH542xgKZJeEAGRNU/D8CqOFxTov33h707pxsOeQ9WfriCAYon5
	 DE7wMkPF6F1U5E+nXS4NmhfxXo2pTteEYKGM26dJJ9CR6IhBQkQRn/t1ei4NjnpVPIddHu8kxzS3
	 NWLAe3O6wRydTTwGsYHM8DjPw4UNPt8BjzqiUsjCWxf6luOw7mOQja8yLugEEocge3Xxh8/9M8L6
	 jCICkxHcFbRjcFaVK+PlCRloc2FMmj3zztHOI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Subject: [PATCH 6.6.y] ASoC: simple-card-utils: Don't use __free(device_node) at graph_util_parse_dai()
Date: Thu,  9 Apr 2026 18:13:50 +0800
X-OQ-MSGID: <20260409101350.5433-1-alvalan9@foxmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-235370-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,renesas.com,banvien.com.vn,collabora.com,kernel.org,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,banvien.com.vn:email,foxmail.com:dkim,foxmail.com:email,msgid.link:url,collabora.com:email]
X-Rspamd-Queue-Id: 25B953C9165
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
[ The function asoc_graph_parse_dai() was renamed to graph_util_parse_dai() in
commit b5a95c5bf6d6 ("ASoC: simple_card_utils.h: convert not to use asoc_xxx()")
in 6.7. The fix should be applied to asoc_graph_parse_dai() instead in 6.6. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
This is to fix https://lore.kernel.org/stable/20260323134539.475007076@linuxfoundation.org/

---
 sound/soc/generic/simple-card-utils.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 86ccd044b93c..a64484fe5a28 100644
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
2.43.0


