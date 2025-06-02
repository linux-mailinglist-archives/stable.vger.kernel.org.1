Return-Path: <stable+bounces-149123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B7EACB0BC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84E4481614
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CF822F751;
	Mon,  2 Jun 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+AgP4f3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FB22F745;
	Mon,  2 Jun 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872966; cv=none; b=AUY6rl0bYS9LNnaYMlWj85wxOal+bhNtJuG7NWl2j5+uo5kto2tqwr6o5QBwYWlJiYAtmY8QJN7pgsLd+Ox0p+ntVfNhhYnwxEIWxaFiYOiqGY+5BdxRIN1xNT+rzU7oX/WGra2Xsw4TdGhCtV5uChqtjiKkckPGFeR1AsLA2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872966; c=relaxed/simple;
	bh=5xqeFVI/RNrEPpFtmANsNx1j+EJUxGoDstMksMOoCN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djsBGoz9OWZjNEHhF3eBjS8p8DkSRdP5l4BaXIpHfzYakoc0y+yHkfXVObIi+CkVjIP37ogiidfm+gzOXjWO9TqQFrzaePQf058/DOOrsqcWuDkzHkDfW69FuoTeLh2x5zRu+zh4sQEabkS7t/pCqTEQluYFV4pfvfWsTu0bKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+AgP4f3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D2EC4CEEE;
	Mon,  2 Jun 2025 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872966;
	bh=5xqeFVI/RNrEPpFtmANsNx1j+EJUxGoDstMksMOoCN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+AgP4f3SdgGBML/PuWDqlOiLP+nGAGAotlh9PmkRu91BPAEHet1GRknb20nCpaBl
	 aKU30sTmQYaO72AtZ6SSc2a6hPSqHdorjNNq1DYp0aMiI7UQ65SQuLJs/+AahpeeHS
	 dOIWIkvPZbZNB8Jg2ofv9kSY/tL6dSJC8JF9FPlg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 52/55] ALSA: hda/realtek - restore auto-mute mode for Dell Chrome platform
Date: Mon,  2 Jun 2025 15:48:09 +0200
Message-ID: <20250602134240.328814749@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
References: <20250602134238.271281478@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 5ad8a4ddc45048bc2fe23b75357b6bf185db004f ]

This board need to shutdown Class-D amp to avoid EMI issue.
Restore the Auto-Mute mode item will off pin control when Auto-mute mode was enable.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Links: https://lore.kernel.org/ee8bbe5236464c369719d96269ba8ef8@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 13ffc9a6555f6..dce5680912006 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6813,7 +6813,10 @@ static void alc256_fixup_chromebook(struct hda_codec *codec,
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		spec->gen.suppress_auto_mute = 1;
+		if (codec->core.subsystem_id == 0x10280d76)
+			spec->gen.suppress_auto_mute = 0;
+		else
+			spec->gen.suppress_auto_mute = 1;
 		spec->gen.suppress_auto_mic = 1;
 		spec->en_3kpull_low = false;
 		break;
-- 
2.39.5




