Return-Path: <stable+bounces-229161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKnWF1JbwWlKSgQAu9opvQ
	(envelope-from <stable+bounces-229161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B497E2F63EC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E65302BB99
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7B6285072;
	Mon, 23 Mar 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjDO04eh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0F285056;
	Mon, 23 Mar 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278253; cv=none; b=jHZkp5sZl4jkxWSMBfIzONt9NZsJzYUhe3pbm2h3H6Fv5FxZmsx187nUbWa7HuJp+KFwCAZ0jqwRZXAggi27MWtOJ9dBAGOuHcurEdByKWT0bhukuTvC1AoiYHanUJ8TQDTyZeWXQY9vqL43sEyTetqUxW42nlEskySt/Q0rUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278253; c=relaxed/simple;
	bh=kwZ5sQW5MNiZrqfW4WOlSOxeIal45BGl7hoQ0bZAt6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuF57/op+OdNDad/ZN9193EaC1ZKbpixM+QXacshAgPr7l2XvnTJfnLSwMiaybU31XMluGHpwiKdFk0J3H7NZBRVeZEkGyZDmXKWYoNU/nBq3giwBk/x8ygG+Hj0r45eD7TYnaOHiojldQJg7v3axWTC97zMnvzKF9gggpCSqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjDO04eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314CFC4CEF7;
	Mon, 23 Mar 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278253;
	bh=kwZ5sQW5MNiZrqfW4WOlSOxeIal45BGl7hoQ0bZAt6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjDO04ehp6xITzDid6VGzTDKc0OEDj6qcCJh+BeJIN/TJhcTVEjz2eDmktK8o9RLz
	 GzeFUZz3W58nytJEJsCcnpO+QWRpaayz5KzEo08VhLBL2bdzBqDtq4ThOKqSQIYotP
	 GNUW37k9BIzv5RzKgrEgqYX7Rq0m8x1jME+y3Txw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Morgan <macromorgan@hotmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 232/567] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Date: Mon, 23 Mar 2026 14:42:32 +0100
Message-ID: <20260323134539.573791778@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229161-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,hotmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B497E2F63EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit dfec1c14aecee6813f9bafc7b560cc3a31d24079 ]

Add quirk for Potron SFP+ XGSPON ONU Stick (YV SFP+ONT-XGSPON).

This device uses pins 2 and 7 for UART communication, so disable
TX_FAULT and LOS. Additionally as it is an embedded system in an
SFP+ form factor provide it enough time to fully boot before we
attempt to use it.

https://www.potrontec.com/index/index/list/cat_id/2.html#11-83
https://pon.wiki/xgs-pon/ont/potron-technology/x-onu-sfpp/

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://patch.msgid.link/20250617180324.229487-1-macroalpha82@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 87d126852158 ("net: sfp: improve Huawei MA5671a fixup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index c47d7232d1c6e..6ef50d1ce2eda 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -359,6 +359,11 @@ static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
+static void sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
+{
+	sfp->state_hw_mask &= ~mask;
+}
+
 static void sfp_fixup_nokia(struct sfp *sfp)
 {
 	sfp_fixup_long_startup(sfp);
@@ -392,7 +397,19 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 	 * these are possibly used for other purposes on this
 	 * module, e.g. a serial port.
 	 */
-	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
+	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
+}
+
+static void sfp_fixup_potron(struct sfp *sfp)
+{
+	/*
+	 * The TX_FAULT and LOS pins on this device are used for serial
+	 * communication, so ignore them. Additionally, provide extra
+	 * time for this device to fully start up.
+	 */
+
+	sfp_fixup_long_startup(sfp);
+	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
 }
 
 static void sfp_fixup_rollball(struct sfp *sfp)
@@ -500,6 +517,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
+
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
-- 
2.51.0




