Return-Path: <stable+bounces-246399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF7MMYJuA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:16:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0E527343
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A54E3168958
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4934405B;
	Tue, 12 May 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ui1z67Y5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4833EDE55;
	Tue, 12 May 2026 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609125; cv=none; b=jXo6vBfRyk7ypGfzJDmzypyhWHFSl9hGxVimwoW9Zn9BnOU3HWFApGL8cmXDE/AUqtSJosSVvmIXvjj8vYktone4m/+406L9yDPn/GTtV1LVLka4DTOBfgPEZQlkAH+fWm5yensX1bxhY/gQ98QjD+INQKQeuI3xwWLvhNDORPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609125; c=relaxed/simple;
	bh=g8UkUuH3Tshb4iLpF9B4B7YHUEDz3P6/hwRFdyEMsvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6AqSRuDkWP8avPlVbAyDLy87i7Sh6o0+AFHibQgnjLst0xooDaYaYXLeBrRnl5KKQVq3gad8NH2oxXtCk04ifEG7sWjvokhRuX87B+ju+Vq1DdWWXDSnHgpLTo3Vrs9/LIlpEsD0l7VkGCCKex8wenfYaNtSgRQBfDNTdwp0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ui1z67Y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFE8C2BCB0;
	Tue, 12 May 2026 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609125;
	bh=g8UkUuH3Tshb4iLpF9B4B7YHUEDz3P6/hwRFdyEMsvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ui1z67Y5aqpLhQYf/BSnM2Bd4z1Bv0ZY2juNfYoc4J+3+IiFNnkagyw1Vd8283h9a
	 SNM8/yV2ld+XtkHm57wxng+mkhGyJ0aVmTYO3eqEr9FqFj1AzIfWxwGLGP2P7PyXZn
	 CmZU13u5VHhg/WsWfN6BTq+Q1IxlxIU/Mc2CxxeE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 7.0 023/307] wifi: mt76: mt7925: fix incorrect length field in txpower command
Date: Tue, 12 May 2026 19:36:58 +0200
Message-ID: <20260512173940.617004647@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 61D0E527343
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246399-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nbd.name:email,msgid.link:url,mediatek.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

commit ccb186326bb6b7f20d77982f855568e7087ad0d7 upstream.

Set `tx_power_tlv->len` to `msg_len` instead of `sizeof(*tx_power_tlv)`
to ensure the correct message length is sent to firmware.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250908072526.1833938-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3727,7 +3727,7 @@ mt7925_mcu_rate_txpower_band(struct mt76
 		memcpy(tx_power_tlv->alpha2, dev->alpha2, sizeof(dev->alpha2));
 		tx_power_tlv->n_chan = num_ch;
 		tx_power_tlv->tag = cpu_to_le16(0x1);
-		tx_power_tlv->len = cpu_to_le16(sizeof(*tx_power_tlv));
+		tx_power_tlv->len = cpu_to_le16(msg_len);
 
 		switch (band) {
 		case NL80211_BAND_2GHZ:



