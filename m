Return-Path: <stable+bounces-39104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A108A11EF
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FF71C20C79
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB79146A8D;
	Thu, 11 Apr 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HoubHLN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6613BC33;
	Thu, 11 Apr 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832528; cv=none; b=IHg24+/LNttzX0abuP41fyRr/U8h6JxgX/ANRxwdKVbEv7FEcSIMsoJofgomfwGROO7OTXMuyqVXVustV8Fo2HQgsdo1W7BOsoPCIV67toxeTHbSMMhxmEHID8hVwiNpWcpt5Z8c2kWcRsVP0rqQEIkcQsGxlT1W+QMILRguGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832528; c=relaxed/simple;
	bh=/DnUPXsMOIfdeh12fAtmVLDjxKLidX7M/b4j+BDIFP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLQ5iR3p32l39Ozli7JaliWCC7cfAgnbL80eLjIQJa6W5aHTy/xW5/p18R7SXlE+yoEk0uLH4aDLy0EEdr6d5sL57xedU1jtye+xDSP8l7rNpMb2I1+p1mw9jO9Ksq0FfOvAHkvMNiKiz/6DKbPe5ZksGhBLPIxh0EyP+yaVqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HoubHLN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137CEC433C7;
	Thu, 11 Apr 2024 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832528;
	bh=/DnUPXsMOIfdeh12fAtmVLDjxKLidX7M/b4j+BDIFP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HoubHLN2I5KK/mHwRo0nFAiJIpqECxWWx59G3OYbJT4A6Yam1LHPdjLsx5m3848u7
	 WtLeeGPWIgxJEji53qQp6ka33f6meU3rwbr+eDhYkmqCloZJ+EgEpb69bddwYQ83ea
	 NrHfpg65CoDMrHcSNLCpufbLgiEPebCyxVBXJ5BE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 40/83] ALSA: firewire-lib: handle quirk to calculate payload quadlets as data block counter
Date: Thu, 11 Apr 2024 11:57:12 +0200
Message-ID: <20240411095413.889911949@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
References: <20240411095412.671665933@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit 4a486439d2ca85752c46711f373b6ddc107bb35d ]

Miglia Harmony Audio (OXFW970) has a quirk to put the number of
accumulated quadlets in CIP payload into the dbc field of CIP header.

This commit handles the quirk in the packet processing layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20240218074128.95210-4-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/amdtp-stream.c | 12 ++++++++----
 sound/firewire/amdtp-stream.h |  4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f8b644cb9157a..8753125683692 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -771,10 +771,14 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 	} else {
 		unsigned int dbc_interval;
 
-		if (*data_blocks > 0 && s->ctx_data.tx.dbc_interval > 0)
-			dbc_interval = s->ctx_data.tx.dbc_interval;
-		else
-			dbc_interval = *data_blocks;
+		if (!(s->flags & CIP_DBC_IS_PAYLOAD_QUADLETS)) {
+			if (*data_blocks > 0 && s->ctx_data.tx.dbc_interval > 0)
+				dbc_interval = s->ctx_data.tx.dbc_interval;
+			else
+				dbc_interval = *data_blocks;
+		} else {
+			dbc_interval = payload_length / sizeof(__be32);
+		}
 
 		lost = dbc != ((*data_block_counter + dbc_interval) & 0xff);
 	}
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 1f957c946c956..cf9ab347277f2 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -37,6 +37,9 @@
  *	the value of current SYT_INTERVAL; e.g. initial value is not zero.
  * @CIP_UNAWARE_SYT: For outgoing packet, the value in SYT field of CIP is 0xffff.
  *	For incoming packet, the value in SYT field of CIP is not handled.
+ * @CIP_DBC_IS_PAYLOAD_QUADLETS: Available for incoming packet, and only effective with
+ *	CIP_DBC_IS_END_EVENT flag. The value of dbc field is the number of accumulated quadlets
+ *	in CIP payload, instead of the number of accumulated data blocks.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -51,6 +54,7 @@ enum cip_flags {
 	CIP_NO_HEADER		= 0x100,
 	CIP_UNALIGHED_DBC	= 0x200,
 	CIP_UNAWARE_SYT		= 0x400,
+	CIP_DBC_IS_PAYLOAD_QUADLETS = 0x800,
 };
 
 /**
-- 
2.43.0




