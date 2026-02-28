Return-Path: <stable+bounces-220268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLsKMeIyo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FACD1C5C02
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C271F3133546
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FA037F06F;
	Sat, 28 Feb 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cooa/S5v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3437F065;
	Sat, 28 Feb 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300171; cv=none; b=XOrxNoWaRhaSEn+Bv+AHMzbj35gDIAxYEmwrQvd9wvoeW9HF16BBzhwa8LtkSPGoCYrA7t/tbaQCFhRHMr7JDCvyW912vAyBIC3b5FF0g+Fi1K5dEYOxI5Q49PeN0uZSC5RUMyVIvC6xI0l5wmaj3dc74Xd0MC2XcntLlrW6lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300171; c=relaxed/simple;
	bh=odQ+4/bj/EP9KkzmwwS1nhiZpaJpBM5UhNg2PTpCOCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdlcnmqhlVgAZtfo3/10ZZe7tRiwkhTERIbsggp/Pnjo1JTbsgaUdim1AVwFvnHpHTPAL51d1yD050cqYK5bQQweI1QMFsSIkrJYPPaMXxat2P+ZYawSO9QF7lw2dHxAIEe4R9g+9cjeHf86K+KgHfc2VPwE9vZQHcish7FTE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cooa/S5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE98C19424;
	Sat, 28 Feb 2026 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300171;
	bh=odQ+4/bj/EP9KkzmwwS1nhiZpaJpBM5UhNg2PTpCOCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cooa/S5v8iJJNuC9cbTFwNfJlgJkCN9TFxK3Y4hM0usXiAx6sARwAOH3ccV8jjRBy
	 6hu9rrZygQvGjUGDEJEfwm+tgNGwISoukCHrBBqrX4ZQ7sTxrzT3nzVZ6H1XEy46Va
	 DIJb686yFyLFShDZjra2m9tDrRZR6xynkz49TlbnwLa0NZEl4MUaGB6I2s9kHxcEHE
	 mmjtoF7kiG64pzyOybOGsuC+bQjmIrqOzyTZsemlVofqWl727lIVwLOc64WXhLfwU8
	 69uyPGjWnmWF5cf1SiKx+oZASo0dX4MP1FVkLf1DjfaeAvSIUOdWOZQ6eF9GJh5Heu
	 4OAaAaDWvJVdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: fenugrec <fenugrec@mail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 190/844] ALSA: usb-audio: presonus s18xx uses little-endian
Date: Sat, 28 Feb 2026 12:21:43 -0500
Message-ID: <20260228173244.1509663-191-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mail.com,suse.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220268-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FACD1C5C02
X-Rspamd-Action: no action

From: fenugrec <fenugrec@mail.com>

[ Upstream commit 3ce03297baff0ba116769044e4594fb324d4a551 ]

Use __le32 types for USB control transfers

Signed-off-by: fenugrec <fenugrec@mail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260111-preso_clean1-v2-1-44b4e5129a75@mail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_s1810c.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/usb/mixer_s1810c.c b/sound/usb/mixer_s1810c.c
index 6e09e074c0e7f..93510aa0dc5ef 100644
--- a/sound/usb/mixer_s1810c.c
+++ b/sound/usb/mixer_s1810c.c
@@ -82,13 +82,13 @@
  * mixer and output but a different set for device.
  */
 struct s1810c_ctl_packet {
-	u32 a;
-	u32 b;
-	u32 fixed1;
-	u32 fixed2;
-	u32 c;
-	u32 d;
-	u32 e;
+	__le32 a;
+	__le32 b;
+	__le32 fixed1;
+	__le32 fixed2;
+	__le32 c;
+	__le32 d;
+	__le32 e;
 };
 
 #define SC1810C_CTL_LINE_SW	0
@@ -118,7 +118,7 @@ struct s1810c_ctl_packet {
  * being zero and different f1/f2.
  */
 struct s1810c_state_packet {
-	u32 fields[63];
+	__le32 fields[63];
 };
 
 #define SC1810C_STATE_48V_SW	58
@@ -140,14 +140,14 @@ snd_s1810c_send_ctl_packet(struct usb_device *dev, u32 a,
 	struct s1810c_ctl_packet pkt = { 0 };
 	int ret = 0;
 
-	pkt.fixed1 = SC1810C_CMD_F1;
-	pkt.fixed2 = SC1810C_CMD_F2;
+	pkt.fixed1 = __cpu_to_le32(SC1810C_CMD_F1);
+	pkt.fixed2 = __cpu_to_le32(SC1810C_CMD_F2);
 
-	pkt.a = a;
-	pkt.b = b;
-	pkt.c = c;
-	pkt.d = d;
-	pkt.e = e;
+	pkt.a = __cpu_to_le32(a);
+	pkt.b = __cpu_to_le32(b);
+	pkt.c = __cpu_to_le32(c);
+	pkt.d = __cpu_to_le32(d);
+	pkt.e = __cpu_to_le32(e);
 
 	ret = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			      SC1810C_CMD_REQ,
@@ -176,8 +176,8 @@ snd_sc1810c_get_status_field(struct usb_device *dev,
 	struct s1810c_state_packet pkt_in = { { 0 } };
 	int ret = 0;
 
-	pkt_out.fields[SC1810C_STATE_F1_IDX] = SC1810C_SET_STATE_F1;
-	pkt_out.fields[SC1810C_STATE_F2_IDX] = SC1810C_SET_STATE_F2;
+	pkt_out.fields[SC1810C_STATE_F1_IDX] = __cpu_to_le32(SC1810C_SET_STATE_F1);
+	pkt_out.fields[SC1810C_STATE_F2_IDX] = __cpu_to_le32(SC1810C_SET_STATE_F2);
 	ret = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			      SC1810C_SET_STATE_REQ,
 			      SC1810C_SET_STATE_REQTYPE,
@@ -197,7 +197,7 @@ snd_sc1810c_get_status_field(struct usb_device *dev,
 		return ret;
 	}
 
-	(*field) = pkt_in.fields[field_idx];
+	(*field) = __le32_to_cpu(pkt_in.fields[field_idx]);
 	(*seqnum)++;
 	return 0;
 }
-- 
2.51.0


