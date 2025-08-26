Return-Path: <stable+bounces-176168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367EB36BE4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F201C41D12
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B5322128B;
	Tue, 26 Aug 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K49WWWLS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED322370D;
	Tue, 26 Aug 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218958; cv=none; b=TbGEVff1X/gA0dU+fLCB55Xy0tCcD7Qio7YGXSeUD3DfgqBbeYDYc32cnc+vr7wIjj/u380sAZBead3piQkvcBvgBkmLU2yDdN2iWdvFXVQuY/AKVoGoTGLXCW1UBD7KdNFBGG0dHsv1RJeEoSYci1tE6Tm/1ZWBjt00t6LeN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218958; c=relaxed/simple;
	bh=7+oIhm1ozrT1/86FnJXB1Y2qINFE98AdMWFHACcL4EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5BMgihFAMSSpmZkLxU2vwO2KF6Gf4TkzWK2cLXkE1ieKj75yT8ehpeHtmgaiWeVakqN3TmtdKgKqfofbIf3OfO1xRwxVCJGJRGXLU1KfPSuTypZF1NX4vwYzqG6tnzg0iglcsJHI4Acgkz/IK49UbhlhaqDOkHGiUKb02ZbwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K49WWWLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57685C4CEF1;
	Tue, 26 Aug 2025 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218956;
	bh=7+oIhm1ozrT1/86FnJXB1Y2qINFE98AdMWFHACcL4EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K49WWWLS4sr/K0VGjyCaoYKQqKXanH9V3oqPilO3/EnsJpu6obZNC4WgQRdwYjc3w
	 h6P8Tx4mCaMcjYSTUirR/Gg75Yx1rrOHGr+l7qVMeqtAJbUWXwp+ekz/mEP6Eh6yWN
	 B5KL+4ryyN76vf62KEldUfOLa5eq7euVLQU+bZlQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 199/403] ALSA: intel8x0: Fix incorrect codec index usage in mixer for ICH4
Date: Tue, 26 Aug 2025 13:08:45 +0200
Message-ID: <20250826110912.362120722@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 87aafc8580acf87fcaf1a7e30ed858d8c8d37d81 ]

code mistakenly used a hardcoded index (codec[1]) instead of
iterating, over the codec array using the loop variable i.
Use codec[i] instead of codec[1] to match the loop iteration.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Link: https://patch.msgid.link/20250621185233.4081094-1-alok.a.tiwari@oracle.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/intel8x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 5150e8d38975..87a23a4660e8 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2285,7 +2285,7 @@ static int snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 			tmp |= chip->ac97_sdin[0] << ICH_DI1L_SHIFT;
 			for (i = 1; i < 4; i++) {
 				if (pcm->r[0].codec[i]) {
-					tmp |= chip->ac97_sdin[pcm->r[0].codec[1]->num] << ICH_DI2L_SHIFT;
+					tmp |= chip->ac97_sdin[pcm->r[0].codec[i]->num] << ICH_DI2L_SHIFT;
 					break;
 				}
 			}
-- 
2.39.5




