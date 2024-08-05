Return-Path: <stable+bounces-65434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B8948115
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA441F212F7
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8269178CDF;
	Mon,  5 Aug 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzG+n4wY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD7178CC5;
	Mon,  5 Aug 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880701; cv=none; b=g3EfW5DWtS2l9V3iVOpNaPNo4kplU0vZB0V6e4fcUMg4lJ0gYSZD+bk3Bdnl8kEDyuTKAMQ55D4qqN5zzWXww49vtuk+eHacIqS5HmB1BUufjRytFJdQU66tYA2ZTIeCOsl0yYmj/Qo0A4eoO5PVP2ac43K1L7aXG7fbUJkVTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880701; c=relaxed/simple;
	bh=xBTX0nsqSZKq03J1AoMBXer2WviaQP7T3jueQEcAQ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPo2eamaiiVE81oXS8ddNIzS7kMdjrEDyc/oGLGou83NakWSIyVpptU84cD+NDEUrJm6wGU9VbhnWDmqU+TaS1NXP0guZNzqwsSpM7wPu3nE8uu5t1SN5gxOGlf7RzBeBXP/jdGj3gJTnDmnR4JjGvYi4DLupRSIydgub9o80x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzG+n4wY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8C9C4AF0C;
	Mon,  5 Aug 2024 17:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880701;
	bh=xBTX0nsqSZKq03J1AoMBXer2WviaQP7T3jueQEcAQ6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzG+n4wY1KEA1G4E6FaQfVfhmjHlHVVMvDztKQNHFCF8Mel1++pprBURxij5BsINQ
	 LlNvuK8Y9x0c/w8oLzV9513ngCmoaGXzKfopYWdYw5+x7M4fNQX8Ygw7aQrLe2fkU3
	 L0nDbc7B8T/m/BFuq/AJIQnF77U10KtKOj/L7z7ymJ3afS9599djF/KFU9ANS+f54z
	 FyZqBI85nmvdmctLyWns91R7YD7Md3x5VzD78UTwBEOLSwKnglXBWMUafvlRVsEU8U
	 UnP5f6UisFqFLe+wrrHH3vB2EDwJrNmk7cWOSmlSzGhXmwMH672zQMQ0N0z7fG3SGr
	 pUvVu2eWyZs9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/15] ALSA: seq: ump: Explicitly reset RPN with Null RPN
Date: Mon,  5 Aug 2024 13:57:10 -0400
Message-ID: <20240805175736.3252615-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175736.3252615-1-sashal@kernel.org>
References: <20240805175736.3252615-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.44
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 98ea612dd1150adb61cd2a0e93875e1cc77e6b87 ]

RPN with 127:127 is treated as a Null RPN, just to reset the
parameters, and it's not translated to MIDI2.  Although the current
code can work as is in most cases, better to implement the RPN reset
explicitly for Null message.

Link: https://patch.msgid.link/20240731130528.12600-6-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_ump_convert.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index b4d78710966dd..3d266f301deee 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -789,6 +789,15 @@ static int paf_ev_to_ump_midi2(const struct snd_seq_event *event,
 	return 1;
 }
 
+static void reset_rpn(struct ump_cvt_to_ump_bank *cc)
+{
+	cc->rpn_set = 0;
+	cc->nrpn_set = 0;
+	cc->cc_rpn_msb = cc->cc_rpn_lsb = 0;
+	cc->cc_data_msb = cc->cc_data_lsb = 0;
+	cc->cc_data_msb_set = cc->cc_data_lsb_set = 0;
+}
+
 /* set up the MIDI2 RPN/NRPN packet data from the parsed info */
 static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
 		    union snd_ump_midi2_msg *data,
@@ -817,11 +826,7 @@ static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
 					     cc->cc_data_lsb);
 	data->rpn.channel = channel;
 
-	cc->rpn_set = 0;
-	cc->nrpn_set = 0;
-	cc->cc_rpn_msb = cc->cc_rpn_lsb = 0;
-	cc->cc_data_msb = cc->cc_data_lsb = 0;
-	cc->cc_data_msb_set = cc->cc_data_lsb_set = 0;
+	reset_rpn(cc);
 	return 1;
 }
 
@@ -843,11 +848,15 @@ static int cc_ev_to_ump_midi2(const struct snd_seq_event *event,
 		ret = fill_rpn(cc, data, channel, true);
 		cc->rpn_set = 1;
 		cc->cc_rpn_msb = val;
+		if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
+			reset_rpn(cc);
 		return ret;
 	case UMP_CC_RPN_LSB:
 		ret = fill_rpn(cc, data, channel, true);
 		cc->rpn_set = 1;
 		cc->cc_rpn_lsb = val;
+		if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
+			reset_rpn(cc);
 		return ret;
 	case UMP_CC_NRPN_MSB:
 		ret = fill_rpn(cc, data, channel, true);
@@ -961,6 +970,8 @@ static int ctrl14_ev_to_ump_midi2(const struct snd_seq_event *event,
 		cc->cc_rpn_msb = msb;
 		cc->cc_rpn_lsb = lsb;
 		cc->rpn_set = 1;
+		if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
+			reset_rpn(cc);
 		return ret;
 	case UMP_CC_NRPN_MSB:
 	case UMP_CC_NRPN_LSB:
-- 
2.43.0


