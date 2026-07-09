Return-Path: <stable+bounces-272929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VPBOO7ulT2qslgIAu9opvQ
	(envelope-from <stable+bounces-272929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:44:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F06731B62
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:44:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Vcf2M8yn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272929-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272929-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE530309C23B
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9963D296BD2;
	Thu,  9 Jul 2026 13:31:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE91283CB5;
	Thu,  9 Jul 2026 13:31:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603891; cv=none; b=QUGwY5iPwrzdA7eiHN2Zt/pCMhiKbteQmTrGeWeen7m0CJ/yrUxj/qOe8gkb+g7znHckh5zZ2SN1ePQilIpfkxBdnJU8Y0LjfVklF5cCOjoDH/g0db2Mr9gJXJyHdrKnHpXnJqW9viOf0yUqhDwTz8M5X0WL8RZgb2CD0rhu5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603891; c=relaxed/simple;
	bh=28FI2HV+RQto7uL7vOBZUQ3tD2S865OcagwBjanwseE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nIc8uX3z6o8pDkkXSp3dHqWVCvOoSRwQ/rDu2etWKUL3MEyc15witbRqZRF25bAZKrNvHBVjBxDP0YBAaNEEUT6VHaxRxgdedZvXlv373UkGVzSdXml8nvDcMpfQ7A3rW3Fyt6L17X3W9FWBZiBXZ8sh5gCbgyd/jlhiy6bmams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vcf2M8yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC8FDC2BCB7;
	Thu,  9 Jul 2026 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783603890;
	bh=28FI2HV+RQto7uL7vOBZUQ3tD2S865OcagwBjanwseE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Vcf2M8ynpe3cb+4GqG9PhCk8FBZz8xsKHdrgyyV3RTw/BFvxJgd0KF9O8MLB3QcJA
	 IqDMBoCXOST783QPl3xEV1ZIZLfGKnSb8csbKj2I0AXVfhvfRRlYs/XRrHBTu+mvxj
	 UNlX7xeowNdrJwYZuXCWK74Lzavk2dxBRvcIQIMlJjtjkFT2A2GQP52FESMPdUaxha
	 fzuD7ZPhGzrJ7yrDiM9NumS46gfI2WDkfcLIgy/eup7LOESIULgo7cj8xEIdyN90+6
	 EETEduw+J+/8NKR+mvwFnMk4xZh553+kSulxDFuEltfHxXkT3fdCKRjcI893IyOcxl
	 vN6Ffv4IutBhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF9C43458;
	Thu,  9 Jul 2026 13:31:30 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 09 Jul 2026 16:31:29 +0300
Subject: [PATCH v2] i2c: mediatek: fix WRRD for SoCs without auto_restart
 option
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-6572-6595-i2c-v2-1-b2fb8510d1d3@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12N0QqCQBBFf0XmuQ13cjfsyf8IH9Zpyol0ZdekE
 P+91eglBi4cuPfMDJGDcIRTNkPgSaL4PgHuMqDW9TdWckkMmKPNLR6UNUdMURolSMoylVSwdek
 gbYbAV3ltvnP95fhs7kzjKlkbrcTRh/f2cNJr7+cu/tyTVlqV2hjixjnGvBqCH33fOXnsyXdQL
 8vyAXrC7/bBAAAA
X-Change-ID: 20260623-6572-6595-i2c-6ec9c4e6a6a6
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783603888; l=2133;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=5I4uNLRRu2akfikPizlAwyA4WFLdXzLI6g0+07ulnqg=;
 b=knMH5OtWF4DJGyJyp/5TwXppDN/rEXeTi+WquMx+mWXenqL3U45hmu6DwLPj1jf6sZkwwXkMG
 41rs/GAxG3jDmbD3MVx/NKtXxKLTrR01TvdgYiQGk3Zrgt8YKihoscR
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272929-lists,stable=lfdr.de,rva333.protonmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:qii.wang@mediatek.com,m:andi.shyti@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:rva333@protonmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[protonmail.com];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,gmail.com,collabora.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[rva333@protonmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,protonmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,protonmail.com:replyto,protonmail.com:mid,protonmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92F06731B62

From: Roman Vivchar <rva333@protonmail.com>

MediaTek mt65xx family SoCs have no auto restart, however, they still
support the WRRD mode in the hardware. Because auto_restart is set to 0,
the WRRD mode will be never enabled, leading to read errors.

Fix this by removing auto_restart check from the WRRD enable path.

Fixes: b49218365280 ("i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD")
Cc: stable@vger.kernel.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
This is a preparation for the mt6572/6595 upstreaming.

mt65xx family SoCs don't have auto restart, but vendor kernels keep using
WRRD mode. Lack of the WRRD mode makes i2c reads impossible from both
userspace and kernel drivers.

Without patch (mt6595, da9210 buck at 0x68):
~ # i2cget -y 1 0x68 0x00
Error: Read failed
~ # i2cget -y 1 0x68 0x01
Error: Read failed

With patch:
~ # i2cget -y 1 0x68 0x00
0x80
~ # i2cget -y 1 0x68 0x01
0x00

Same behavior observed on mt6572 devices.

This change doesn't affect SoCs with auto restart option.
---
Changes in v2:
- Add Fixes and Reviewed-by tags
- Add Cc stable
- Link to v1: https://patch.msgid.link/20260624-6572-6595-i2c-v1-1-9155cebaae20@protonmail.com
---
 drivers/i2c/busses/i2c-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 126040ca05f1..307925fb78e3 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -1258,7 +1258,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 	i2c->auto_restart = i2c->dev_comp->auto_restart;
 
 	/* checking if we can skip restart and optimize using WRRD mode */
-	if (i2c->auto_restart && num == 2) {
+	if (num == 2) {
 		if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
 		    msgs[0].addr == msgs[1].addr) {
 			i2c->auto_restart = 0;

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260623-6572-6595-i2c-6ec9c4e6a6a6

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>



