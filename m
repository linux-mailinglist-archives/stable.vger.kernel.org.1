Return-Path: <stable+bounces-65430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630BF94810C
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EB71F23B97
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947B15FA78;
	Mon,  5 Aug 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3gLyP4D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A3176AA2;
	Mon,  5 Aug 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880687; cv=none; b=rBVBKKCkfdsBP8vFGezqpgXG2NJn+I1BS9N81U1lPusSqWtI3OcCKZ2jE5DbIhPc/oalTG7ElYKJTsVdmgEefWauDL3gwJFPh1mz1ZF7rD9JpGfFg64Yyqar3z8wnBU2o77cztKQ6nM2SIGOKhrUeFOJdY/ZaV5G4PYlb/kya0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880687; c=relaxed/simple;
	bh=pF7B1EJOvfIsXUHadIn5iapfDm/Q6ZxnUOD1S8JlJrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyYT/Si8C1uCXkE6j6CgrdOQIMqCHWAPL1xRCoXUct/+SnsFswlwI7dZVk95Y3Hgqs51GX8+lGSzoHr0n+XWYdmiQLp9CFRWLIGmbc2NSq9jQCO9zT68DoMVNuBUEWRo71MbBNiEl9Fi1HFufZYJ/m1E6yOKNFNRRoqKygTHWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3gLyP4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA3DC32782;
	Mon,  5 Aug 2024 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880687;
	bh=pF7B1EJOvfIsXUHadIn5iapfDm/Q6ZxnUOD1S8JlJrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3gLyP4D5F4d69KSxdclP9VcmPLFBrvBGi6C4aLuLMRQkH9VP77T1WvZda0EzEBDv
	 nITevKTGTxwawZ/SPO8lodNF5jg7fj9gbZ6q5g74MWlijhk7GOcSV6LCAofglMj++r
	 d9BjjTV/qIt4PnKkUHjg8PtvYiWyukBs9lk79mFISNgEbA0BjW1SLKr38DkIUshHpw
	 2KmPtqbxP0ISBUGY0Zkx+zMX00tQfrMBiEOpqk1g4fsQmNvcbum3A8q4UbtS3ape3c
	 XL5qsF40UGKrSSHZdQmyK/sOo7RpqlvQ/hZ7yoc1q3m20wm2SYQVJWAUiS/4vTfRrA
	 wW+VvMiTLC3FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/15] ALSA: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
Date: Mon,  5 Aug 2024 13:57:06 -0400
Message-ID: <20240805175736.3252615-9-sashal@kernel.org>
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

[ Upstream commit e6ce8a28c768dbbad3f818db286cd0f4c7a921a8 ]

The UMP 1.1 spec says that an RPN/NRPN should be sent when one of the
following occurs:
* a CC 38 is received
* a subsequent CC 6 is received
* a CC 98, 99, 100, and 101 is received, indicating the last RPN/NRPN
  message has ended and a new one has started

That said, we should send a partial data even if it's not fully
filled.  Let's change the UMP conversion helper code to follow that
rule.

Link: https://patch.msgid.link/20240731130528.12600-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/ump_convert.h |  1 +
 sound/core/ump_convert.c    | 49 ++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/sound/ump_convert.h b/include/sound/ump_convert.h
index 28c364c63245d..d099ae27f8491 100644
--- a/include/sound/ump_convert.h
+++ b/include/sound/ump_convert.h
@@ -13,6 +13,7 @@ struct ump_cvt_to_ump_bank {
 	unsigned char cc_nrpn_msb, cc_nrpn_lsb;
 	unsigned char cc_data_msb, cc_data_lsb;
 	unsigned char cc_bank_msb, cc_bank_lsb;
+	bool cc_data_msb_set, cc_data_lsb_set;
 };
 
 /* context for converting from MIDI1 byte stream to UMP packet */
diff --git a/sound/core/ump_convert.c b/sound/core/ump_convert.c
index f67c44c83fde4..5d1b85e7ac165 100644
--- a/sound/core/ump_convert.c
+++ b/sound/core/ump_convert.c
@@ -287,25 +287,37 @@ static int cvt_legacy_system_to_ump(struct ump_cvt_to_ump *cvt,
 	return 4;
 }
 
-static void fill_rpn(struct ump_cvt_to_ump_bank *cc,
-		     union snd_ump_midi2_msg *midi2)
+static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
+		    union snd_ump_midi2_msg *midi2,
+		    bool flush)
 {
+	if (!(cc->cc_data_lsb_set || cc->cc_data_msb_set))
+		return 0; // skip
+	/* when not flushing, wait for complete data set */
+	if (!flush && (!cc->cc_data_lsb_set || !cc->cc_data_msb_set))
+		return 0; // skip
+
 	if (cc->rpn_set) {
 		midi2->rpn.status = UMP_MSG_STATUS_RPN;
 		midi2->rpn.bank = cc->cc_rpn_msb;
 		midi2->rpn.index = cc->cc_rpn_lsb;
-		cc->rpn_set = 0;
-		cc->cc_rpn_msb = cc->cc_rpn_lsb = 0;
-	} else {
+	} else if (cc->nrpn_set) {
 		midi2->rpn.status = UMP_MSG_STATUS_NRPN;
 		midi2->rpn.bank = cc->cc_nrpn_msb;
 		midi2->rpn.index = cc->cc_nrpn_lsb;
-		cc->nrpn_set = 0;
-		cc->cc_nrpn_msb = cc->cc_nrpn_lsb = 0;
+	} else {
+		return 0; // skip
 	}
+
 	midi2->rpn.data = upscale_14_to_32bit((cc->cc_data_msb << 7) |
 					      cc->cc_data_lsb);
+
+	cc->rpn_set = 0;
+	cc->nrpn_set = 0;
+	cc->cc_rpn_msb = cc->cc_rpn_lsb = 0;
 	cc->cc_data_msb = cc->cc_data_lsb = 0;
+	cc->cc_data_msb_set = cc->cc_data_lsb_set = 0;
+	return 1;
 }
 
 /* convert to a MIDI 1.0 Channel Voice message */
@@ -318,6 +330,7 @@ static int cvt_legacy_cmd_to_ump(struct ump_cvt_to_ump *cvt,
 	struct ump_cvt_to_ump_bank *cc;
 	union snd_ump_midi2_msg *midi2 = (union snd_ump_midi2_msg *)data;
 	unsigned char status, channel;
+	int ret;
 
 	BUILD_BUG_ON(sizeof(union snd_ump_midi1_msg) != 4);
 	BUILD_BUG_ON(sizeof(union snd_ump_midi2_msg) != 8);
@@ -358,24 +371,29 @@ static int cvt_legacy_cmd_to_ump(struct ump_cvt_to_ump *cvt,
 	case UMP_MSG_STATUS_CC:
 		switch (buf[1]) {
 		case UMP_CC_RPN_MSB:
+			ret = fill_rpn(cc, midi2, true);
 			cc->rpn_set = 1;
 			cc->cc_rpn_msb = buf[2];
-			return 0; // skip
+			return ret;
 		case UMP_CC_RPN_LSB:
+			ret = fill_rpn(cc, midi2, true);
 			cc->rpn_set = 1;
 			cc->cc_rpn_lsb = buf[2];
-			return 0; // skip
+			return ret;
 		case UMP_CC_NRPN_MSB:
+			ret = fill_rpn(cc, midi2, true);
 			cc->nrpn_set = 1;
 			cc->cc_nrpn_msb = buf[2];
-			return 0; // skip
+			return ret;
 		case UMP_CC_NRPN_LSB:
+			ret = fill_rpn(cc, midi2, true);
 			cc->nrpn_set = 1;
 			cc->cc_nrpn_lsb = buf[2];
-			return 0; // skip
+			return ret;
 		case UMP_CC_DATA:
+			cc->cc_data_msb_set = 1;
 			cc->cc_data_msb = buf[2];
-			return 0; // skip
+			return fill_rpn(cc, midi2, false);
 		case UMP_CC_BANK_SELECT:
 			cc->bank_set = 1;
 			cc->cc_bank_msb = buf[2];
@@ -385,12 +403,9 @@ static int cvt_legacy_cmd_to_ump(struct ump_cvt_to_ump *cvt,
 			cc->cc_bank_lsb = buf[2];
 			return 0; // skip
 		case UMP_CC_DATA_LSB:
+			cc->cc_data_lsb_set = 1;
 			cc->cc_data_lsb = buf[2];
-			if (cc->rpn_set || cc->nrpn_set)
-				fill_rpn(cc, midi2);
-			else
-				return 0; // skip
-			break;
+			return fill_rpn(cc, midi2, false);
 		default:
 			midi2->cc.index = buf[1];
 			midi2->cc.data = upscale_7_to_32bit(buf[2]);
-- 
2.43.0


