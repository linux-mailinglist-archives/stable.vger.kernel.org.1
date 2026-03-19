Return-Path: <stable+bounces-227248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GQOA83Fu2nEoAIAu9opvQ
	(envelope-from <stable+bounces-227248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:45:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9768B2C8F17
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746F031A511B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663237DE8C;
	Thu, 19 Mar 2026 09:36:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E23AB268
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912976; cv=none; b=XRCqbWUlkUDYQaqaA4CbBB2rfS32HL2Idl1jaPdVrhD6fcix3+9mDVpcvifXcHSiHKEOoYfcSoukDgt1InAqo9NgRabZ//TArV5YtbLaHpM+8cQ7Ey3dK2Aa6INxcWwyZVEQMuGZ+dPx6aDIM1kQtC3AiVdrVkOcyonbhoLiEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912976; c=relaxed/simple;
	bh=m8AU9YbHCXej+SKSdGs3GzysiW4jTlyz0Bb9vHcmVTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsLu6smaVxq/t+ljC4q72+uAJW8l5B6pRDiLYDikY4W0sMNoUCluzECyfOW1RNqeyqeYTTFUf+xnujiiBmynyl7p8hk4rCbtBQoOWd+TRDUY4rzYa5Gfa2/BW7A6AnCRUs7DMFKV0ohwd2z1F0aKBLItckuzACdDg0nXemTwO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003OD-Oe; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013Dc-0y;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0YRi;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:00 +0100
Subject: [PATCH 03/11] net/9p/usbg: set client to Disconnected on
 usb9pfs_disable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-3-c977a7433185@pengutronix.de>
References: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
In-Reply-To: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hyungjung Joo <jhj140711@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=m8AU9YbHCXej+SKSdGs3GzysiW4jTlyz0Bb9vHcmVTg=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OGeFFoIfyu6skOmAVIv8zLIPC2OixXRs8/M
 HCyfLb38EuJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhgAKCRC/aVhE+XH0
 q5OXD/4i2StoQqHTQLcFjy9uWad+Q4akq+NbiXpR+hAKVMZvo1NMRG6fP4p0VwTtRiSqgyl+1uB
 8kg6mfiL8fHzTKW6uuxPmGbNRplNGiAPvHLNQ3HFJ1NANliqCKcPSD9jx2r1kuYiPWAcWAa+JR3
 zNrP06zURAIQSeFK4khpHpSsGsBRaEWl89UnPet/E5hdmuZaKj+EJWEtmByJqdAn/KtTx9fw+E8
 52yZ7v7193zimjiO3j1mbR9kNzxtIj1Y5CibpuND2R7mmBOAeqzb7/KXX/uirZHqXO0xvtEo3qA
 e6PCKhXPYAd2gQu78mhuio4RIf8ezvsrjSQYY7kTso8l+2XDRc1aIsG81tUiaoNlP+XtWsyu8o6
 N7kdxLUJETi9RDQZ6zZWW5OFF1TEJ67a9/CBa7NpoworeGRKlj350UJjn9zZ5/RU8DpOny0CNYt
 ztJXre8Cv8ySRmS1nAmceg+hoEZTI3wnjuFUf+sdw0SZZ8Evofp1DIjQg9zN1Y6qU3CtWyzq+IO
 kTui0ZHID5WzzUWeWozhTFpGuqgSp/vXRwGaXB2mMfK46CnullhloED/7OVxQh9zkw/G/70Svkt
 ODES6423kxP4CW/e6U/5bAIU8uvOLn6UnbzLCs0HbWt8Qp0nDon/VcqmzV2mCHvs6+B9Qc0AP8s
 ZFON1FLEfUYCi9A==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_TO(0.00)[kernel.org,ionkov.net,codewreck.org,crudebyte.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227248-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.grzeschik@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9768B2C8F17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch is setting the client status to Disconnected, when the
client is still in use. Otherwiese a disconnected usb cable would run
any use of the mount to faults.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index fb05198dc2a7d604cfad2db26a63e40e632651a2..6ddf6886dbadd7cdfdebb96dc767874169ccb16e 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -779,7 +779,12 @@ static int usb9pfs_set_alt(struct usb_function *f,
 static void usb9pfs_disable(struct usb_function *f)
 {
 	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
+	unsigned long flags;
 
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	if (usb9pfs->client)
+		usb9pfs->client->status = Disconnected;
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 	usb9pfs_clear_tx(usb9pfs);
 }
 

-- 
2.47.3


