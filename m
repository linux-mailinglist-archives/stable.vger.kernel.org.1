Return-Path: <stable+bounces-65416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B39480E5
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E241F232BD
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDED165F09;
	Mon,  5 Aug 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF5cl8VF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEEA16D9A4;
	Mon,  5 Aug 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880615; cv=none; b=kDHtbJxGGG5LovzVSJXOi/omzsAh9pWeYDqVChArgOqgoe0vdPNKJ2GNW+msIcv7znBdGIzuL9I7YZ8nQaxwu/Sq2v5zz/2P0z94ObULb2SIVBnQ0IDu0fYgAIfqB81WcqTmSqXj9/zuYSF9BFp8vebCP4kE6rFubfwPGgBKAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880615; c=relaxed/simple;
	bh=vJF7D1iUV0VYUegsMQkLBmm10/owjT3+4xHH5xVaR/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts4/InGzjzRqcgLPXeoB/2uS9tBRGtyNCgZZY9kMnek40TO3Z2V6tkijSPS2IQAfhKSAhoQi50KoR1x6PAGuoKi8hNYnbn/NilKdDU5cGlQr8Uw1aF8+y8LhTNKyxfLWM7rrsbJxekdap4U54B9dYYYjqMAfrbXOMThlWGeMgMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF5cl8VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E1AC32782;
	Mon,  5 Aug 2024 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880615;
	bh=vJF7D1iUV0VYUegsMQkLBmm10/owjT3+4xHH5xVaR/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SF5cl8VFzP4zZdgWQK+NfHCYOAHz7pc8RvHCjIBhUTXC5/3Zlt4VSYJ9aHsbXxjp2
	 ewOO/uJuJm74iMzOdSq5LyI0QTW7ezApzCCNzqTFINFMCQSz/CQvWR6ySi/6GtIdbO
	 zNJHJFB/c6v/PYLGVEk2FZHEKAhL3NzqOR/8Q/9vdEzsGQF6vGFyu68Rg7ViWgOqr+
	 GSJPySEen4G9aaWM6wJBPe9JQM4Rai6BR2IBEUgDZCxuy9X+mxNx2XpnZR/BfbIwuR
	 msmWZQXLSyrTdTPo3G/vKnVG54WG9S9eRWJO82TfBTutDigvJOPbDIO3Pv0kq/3cCK
	 UaKZCCNRtWA1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 11/16] ALSA: ump: Explicitly reset RPN with Null RPN
Date: Mon,  5 Aug 2024 13:55:43 -0400
Message-ID: <20240805175618.3249561-11-sashal@kernel.org>
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


