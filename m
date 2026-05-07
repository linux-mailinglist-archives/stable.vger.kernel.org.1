Return-Path: <stable+bounces-244544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CYZ1N1Jo/GnzPgAAu9opvQ
	(envelope-from <stable+bounces-244544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:24:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BC4E6B78
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 12:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7079C300E00E
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE303E8681;
	Thu,  7 May 2026 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Loxs/puL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362C3E867F
	for <stable@vger.kernel.org>; Thu,  7 May 2026 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149455; cv=none; b=i2w9Xouw3Kl2q4jg1LrG5HeVLabdih1gRuN8HEB3Me9WkuQDw/4MptuoVwpAEjYVeQndZBqyYsBHuA62tchdVheppD1RKKl/ITnoGjSXGfZfIxa/4iY5LYz921Zxzq3fAgcH1kZcT2CRepY/G12ORTeJaIB7qx4ZnO8Cu44wCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149455; c=relaxed/simple;
	bh=qLTF1WB3xmzh7bEUEyRQRD/zX51a7lEIoU+qYAB/deE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZfsBHVO5PaeCUYv8wneUXL+WHGrz18jN8dso2Jb6prbR+o8GweJgJXeuF7kSJ5nMqiwJlogo134VBlUtJP3WL/1H9rvp+HsreqXkWGEcQLgmouw0rZU7qjHjJB2h+iwu8aoWH1QAj4qBjCfywYcRSoKD8yP9mEygyqbqN03ShgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Loxs/puL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B00C2BCB2;
	Thu,  7 May 2026 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778149455;
	bh=qLTF1WB3xmzh7bEUEyRQRD/zX51a7lEIoU+qYAB/deE=;
	h=Subject:To:Cc:From:Date:From;
	b=Loxs/puLnna2k9W2Gepez4Pxz9h6DtrhamFwreQHVnFaS23IbJAbPOu5+1QUbWtE+
	 Q1wDn/M51I2GNlI0qr1Qw5xZeYUSSrb6V8sOplAh3jYNZZG1G/q0MP+6aIGmP2WdkV
	 PK4oXlo2I+Xkbr35rnwbLi10dn+XquI3Mz4hA3UY=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7925: fix incorrect TLV length in CLC command" failed to apply to 6.12-stable tree
To: quan.zhou@mediatek.com,nbd@nbd.name,sean.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 07 May 2026 12:24:13 +0200
Message-ID: <2026050712-unicorn-patrol-23a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 845BC4E6B78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244544-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,mediatek.com:email,nbd.name:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 62e037aa8cf5a69b7ea63336705a35c897b9db2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050712-unicorn-patrol-23a0@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62e037aa8cf5a69b7ea63336705a35c897b9db2b Mon Sep 17 00:00:00 2001
From: Quan Zhou <quan.zhou@mediatek.com>
Date: Wed, 25 Feb 2026 17:47:22 +0800
Subject: [PATCH] wifi: mt76: mt7925: fix incorrect TLV length in CLC command

The previous implementation of __mt7925_mcu_set_clc() set the TLV length
field (.len) incorrectly during CLC command construction. The length was
initialized as sizeof(req) - 4, regardless of the actual segment length.
This could cause the WiFi firmware to misinterpret the command payload,
resulting in command execution errors.

This patch moves the TLV length assignment to after the segment is
selected, and sets .len to sizeof(req) + seg->len - 4, matching the
actual command content. This ensures the firmware receives the
correct TLV length and parses the command properly.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Acked-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/f56ae0e705774dfa8aab3b99e5bbdc92cd93523e.1772011204.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1379bf6a26b5..abcdd0e0b3b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3380,7 +3380,6 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		u8 rsvd[64];
 	} __packed req = {
 		.tag = cpu_to_le16(0x3),
-		.len = cpu_to_le16(sizeof(req) - 4),
 
 		.idx = idx,
 		.env = env_cap,
@@ -3409,6 +3408,7 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		memcpy(req.type, rule->type, 2);
 
 		req.size = cpu_to_le16(seg->len);
+		req.len = cpu_to_le16(sizeof(req) + seg->len - 4);
 		dev->phy.clc_chan_conf = clc->ver == 1 ? 0xff : rule->flag;
 		skb = __mt76_mcu_msg_alloc(&dev->mt76, &req,
 					   le16_to_cpu(req.size) + sizeof(req),


