Return-Path: <stable+bounces-65418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17479480EB
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7945B28488E
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A7216EBE9;
	Mon,  5 Aug 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BON5cttK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE816EB63;
	Mon,  5 Aug 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880622; cv=none; b=WhOY+hOfgnkJCRGsWasImh4ugFHq0v+qsYXiYsSKMes+SkG26+lbFVGGQ9wiBP5/cmPQjdNtgiWdM6aydInas2a7/APVdexQIvPXzpCQUGQL39T5ihfv8sjzxa5/4Q+9XC1VTSM9ccE53Sd7T8awZpsFwyA7UUaScW5+Px2v8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880622; c=relaxed/simple;
	bh=n/wU2YW68muNGA7d5ai6shq3WQO2nljTYc965BpU1Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdUrCc4ACZFOlruKqaDGCuGj9XG3TmGep7iBr+7ICXWqt5wmhn/o0uwlZgski7kYo3VQxvqz34qVpDGfbBFPwOV8gPryN0MfT908paxbbYcWx3+T/SOy8IAuGtvnJK1j01RI1TFm/FSxfryooC+1QkU2EVm69/1BwSQ8cIue7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BON5cttK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95277C32782;
	Mon,  5 Aug 2024 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880622;
	bh=n/wU2YW68muNGA7d5ai6shq3WQO2nljTYc965BpU1Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BON5cttK7WTyFsHPiMSW1Vi79IC3eQyqzJoX7VRJ9UtW3qz5IWfSCnM6SSaOG6bgV
	 GYwQaf9mysghkLAtaZeY89ho5+ouzvVQRifceLTLQwNAUHMvUlF5JEenilY+KmrjxQ
	 ZO9XCTk6AmnrXUWDGL4EdUo6O6lUEd+eAcuuwNxMb8OCypWujrH0yY7faHEP6LqCrU
	 GyeujrcENEqVDij/V5aFxlkgB7/Nfi/VM/JeW5j5m32+QpeO5RLVSexDiUm3hmgbKH
	 O7esYeifBSgXHBz8K9BttJ4CFLVlYLM0H+82QL1/Jc+3ZT+itHPuHkLbh7KqusuXl/
	 kD1pd2IufjPog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 13/16] ALSA: seq: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
Date: Mon,  5 Aug 2024 13:55:45 -0400
Message-ID: <20240805175618.3249561-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175618.3249561-1-sashal@kernel.org>
References: <20240805175618.3249561-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.3
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a4ff92ff0bdd731eca9f0b50b1cbb5aba89be4b2 ]

Just like the core UMP conversion helper, we need to deal with the
partially-filled RPN/NRPN data in the sequencer UMP converter as
well.

Link: https://patch.msgid.link/20240731130528.12600-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_ump_convert.c | 74 +++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index a63005da2195d..b4d78710966dd 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -790,27 +790,39 @@ static int paf_ev_to_ump_midi2(const struct snd_seq_event *event,
 }
 
 /* set up the MIDI2 RPN/NRPN packet data from the parsed info */
-static void fill_rpn(struct ump_cvt_to_ump_bank *cc,
-		     union snd_ump_midi2_msg *data,
-		     unsigned char channel)
+static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
+		    union snd_ump_midi2_msg *data,
+		    unsigned char channel,
+		    bool flush)
 {
+	if (!(cc->cc_data_lsb_set || cc->cc_data_msb_set))
+		return 0; // skip
+	/* when not flushing, wait for complete data set */
+	if (!flush && (!cc->cc_data_lsb_set || !cc->cc_data_msb_set))
+		return 0; // skip
+
 	if (cc->rpn_set) {
 		data->rpn.status = UMP_MSG_STATUS_RPN;
 		data->rpn.bank = cc->cc_rpn_msb;
 		data->rpn.index = cc->cc_rpn_lsb;
-		cc->rpn_set = 0;
-		cc->cc_rpn_msb = cc->cc_rpn_lsb = 0;
-	} else {
+	} else if (cc->nrpn_set) {
 		data->rpn.status = UMP_MSG_STATUS_NRPN;
 		data->rpn.bank = cc->cc_nrpn_msb;
 		data->rpn.index = cc->cc_nrpn_lsb;
-		cc->nrpn_set = 0;
-		cc->cc_nrpn_msb = cc->cc_nrpn_lsb = 0;
+	} else {
+		return 0; // skip
 	}
+
 	data->rpn.data = upscale_14_to_32bit((cc->cc_data_msb << 7) |
 					     cc->cc_data_lsb);
 	data->rpn.channel = channel;
+
+	cc->rpn_set = 0;
+	cc->nrpn_set = 0;
+	cc->cc_rpn_msb = cc->cc_rpn_lsb = 0;
 	cc->cc_data_msb = cc->cc_data_lsb = 0;
+	cc->cc_data_msb_set = cc->cc_data_lsb_set = 0;
+	return 1;
 }
 
 /* convert CC event to MIDI 2.0 UMP */
@@ -823,28 +835,34 @@ static int cc_ev_to_ump_midi2(const struct snd_seq_event *event,
 	unsigned char index = event->data.control.param & 0x7f;
 	unsigned char val = event->data.control.value & 0x7f;
 	struct ump_cvt_to_ump_bank *cc = &dest_port->midi2_bank[channel];
+	int ret;
 
 	/* process special CC's (bank/rpn/nrpn) */
 	switch (index) {
 	case UMP_CC_RPN_MSB:
+		ret = fill_rpn(cc, data, channel, true);
 		cc->rpn_set = 1;
 		cc->cc_rpn_msb = val;
-		return 0; // skip
+		return ret;
 	case UMP_CC_RPN_LSB:
+		ret = fill_rpn(cc, data, channel, true);
 		cc->rpn_set = 1;
 		cc->cc_rpn_lsb = val;
-		return 0; // skip
+		return ret;
 	case UMP_CC_NRPN_MSB:
+		ret = fill_rpn(cc, data, channel, true);
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_msb = val;
-		return 0; // skip
+		return ret;
 	case UMP_CC_NRPN_LSB:
+		ret = fill_rpn(cc, data, channel, true);
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_lsb = val;
-		return 0; // skip
+		return ret;
 	case UMP_CC_DATA:
+		cc->cc_data_msb_set = 1;
 		cc->cc_data_msb = val;
-		return 0; // skip
+		return fill_rpn(cc, data, channel, false);
 	case UMP_CC_BANK_SELECT:
 		cc->bank_set = 1;
 		cc->cc_bank_msb = val;
@@ -854,11 +872,9 @@ static int cc_ev_to_ump_midi2(const struct snd_seq_event *event,
 		cc->cc_bank_lsb = val;
 		return 0; // skip
 	case UMP_CC_DATA_LSB:
+		cc->cc_data_lsb_set = 1;
 		cc->cc_data_lsb = val;
-		if (!(cc->rpn_set || cc->nrpn_set))
-			return 0; // skip
-		fill_rpn(cc, data, channel);
-		return 1;
+		return fill_rpn(cc, data, channel, false);
 	}
 
 	data->cc.status = status;
@@ -926,6 +942,7 @@ static int ctrl14_ev_to_ump_midi2(const struct snd_seq_event *event,
 	unsigned char index = event->data.control.param & 0x7f;
 	struct ump_cvt_to_ump_bank *cc = &dest_port->midi2_bank[channel];
 	unsigned char msb, lsb;
+	int ret;
 
 	msb = (event->data.control.value >> 7) & 0x7f;
 	lsb = event->data.control.value & 0x7f;
@@ -939,28 +956,25 @@ static int ctrl14_ev_to_ump_midi2(const struct snd_seq_event *event,
 		cc->cc_bank_lsb = lsb;
 		return 0; // skip
 	case UMP_CC_RPN_MSB:
-		cc->cc_rpn_msb = msb;
-		fallthrough;
 	case UMP_CC_RPN_LSB:
-		cc->rpn_set = 1;
+		ret = fill_rpn(cc, data, channel, true);
+		cc->cc_rpn_msb = msb;
 		cc->cc_rpn_lsb = lsb;
-		return 0; // skip
+		cc->rpn_set = 1;
+		return ret;
 	case UMP_CC_NRPN_MSB:
-		cc->cc_nrpn_msb = msb;
-		fallthrough;
 	case UMP_CC_NRPN_LSB:
+		ret = fill_rpn(cc, data, channel, true);
+		cc->cc_nrpn_msb = msb;
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_lsb = lsb;
-		return 0; // skip
+		return ret;
 	case UMP_CC_DATA:
-		cc->cc_data_msb = msb;
-		fallthrough;
 	case UMP_CC_DATA_LSB:
+		cc->cc_data_msb_set = cc->cc_data_lsb_set = 1;
+		cc->cc_data_msb = msb;
 		cc->cc_data_lsb = lsb;
-		if (!(cc->rpn_set || cc->nrpn_set))
-			return 0; // skip
-		fill_rpn(cc, data, channel);
-		return 1;
+		return fill_rpn(cc, data, channel, false);
 	}
 
 	data->cc.status = UMP_MSG_STATUS_CC;
-- 
2.43.0


