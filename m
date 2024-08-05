Return-Path: <stable+bounces-65431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89194810E
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9DF1C20C10
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9AA177991;
	Mon,  5 Aug 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRVLiLlu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F4176FDB;
	Mon,  5 Aug 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880690; cv=none; b=rcaOdVJEstB786PwNoId9WNB4SEU5eVH7UsoF8O1wccW5JL+ZKD/3hfvvIF6uAw1R+smbpgEc58OYYszOF3PvTuh5ViDzFzh5FMtlO5rytksnBWeXBNXbJcAYADRtvSLqU8u7UlnB5xOWL+zlPc/IvcFY69sgcPq2yC3u+CPmSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880690; c=relaxed/simple;
	bh=vJF7D1iUV0VYUegsMQkLBmm10/owjT3+4xHH5xVaR/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzNuMfouRABaVnu8Q3t9UOKPQisuRZWWx/8FG4WZcz70DsAQi8O+hLKlaHZqUu1D5zE+ya1vLuUdg4VCOSn65qZh76MaEO8lvJaV4sX/bLXVVqFqa9Z1hYVFOiNR+NKGwzJz7Be1bR6e2UawrS9acpGvfsRbxE+ZTXvgoVBq01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRVLiLlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BB7C4AF0B;
	Mon,  5 Aug 2024 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880690;
	bh=vJF7D1iUV0VYUegsMQkLBmm10/owjT3+4xHH5xVaR/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRVLiLlulv7eH2dr+6EBfmi0LnFXRkUxg74z5Es0ZMPwR8AHIVZJ8P3PhOKM6FFDo
	 R1SS2xO8W7pNOzi0P24wzI8j54s2ETxP2Y2+t3PGzlkIFt7DcX8KZhgfjBAQ6duV1k
	 8sOHgCPtOh3ptx6zN27kCbUDoNOpA0ITQtwdwpAPQSm7IyOcufSLR998Hlu2UxRtOT
	 7FQSHR77E/fd5NNrheeXD4jt+vDGMWIuvDKnI9Hk1NbLFBuGZAol4aa31LsA29o9nN
	 aUNO5IPqSChgrCua5M9MtSfAjBPuJRfXbLHNWLgJf0HVHzCob/ieOtNcwSBXECyOGr
	 YYPCBOUcl09NA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/15] ALSA: ump: Explicitly reset RPN with Null RPN
Date: Mon,  5 Aug 2024 13:57:07 -0400
Message-ID: <20240805175736.3252615-10-sashal@kernel.org>
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

[ Upstream commit 50a6dd19dca9446475f023eaa652016bfe5b1cbe ]

RPN with 127:127 is treated as a Null RPN, just to reset the
parameters, and it's not translated to MIDI2.  Although the current
code can work as is in most cases, better to implement the RPN reset
explicitly for Null message.

Link: https://patch.msgid.link/20240731130528.12600-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/ump_convert.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/core/ump_convert.c b/sound/core/ump_convert.c
index 5d1b85e7ac165..0fe13d0316568 100644
--- a/sound/core/ump_convert.c
+++ b/sound/core/ump_convert.c
@@ -287,6 +287,15 @@ static int cvt_legacy_system_to_ump(struct ump_cvt_to_ump *cvt,
 	return 4;
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
 static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
 		    union snd_ump_midi2_msg *midi2,
 		    bool flush)
@@ -312,11 +321,7 @@ static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
 	midi2->rpn.data = upscale_14_to_32bit((cc->cc_data_msb << 7) |
 					      cc->cc_data_lsb);
 
-	cc->rpn_set = 0;
-	cc->nrpn_set = 0;
-	cc->cc_rpn_msb = cc->cc_rpn_lsb = 0;
-	cc->cc_data_msb = cc->cc_data_lsb = 0;
-	cc->cc_data_msb_set = cc->cc_data_lsb_set = 0;
+	reset_rpn(cc);
 	return 1;
 }
 
@@ -374,11 +379,15 @@ static int cvt_legacy_cmd_to_ump(struct ump_cvt_to_ump *cvt,
 			ret = fill_rpn(cc, midi2, true);
 			cc->rpn_set = 1;
 			cc->cc_rpn_msb = buf[2];
+			if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
+				reset_rpn(cc);
 			return ret;
 		case UMP_CC_RPN_LSB:
 			ret = fill_rpn(cc, midi2, true);
 			cc->rpn_set = 1;
 			cc->cc_rpn_lsb = buf[2];
+			if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
+				reset_rpn(cc);
 			return ret;
 		case UMP_CC_NRPN_MSB:
 			ret = fill_rpn(cc, midi2, true);
-- 
2.43.0


