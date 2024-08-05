Return-Path: <stable+bounces-65444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF600948137
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05F71C209DC
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05B17C21B;
	Mon,  5 Aug 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRnGLco1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0A17C20F;
	Mon,  5 Aug 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880749; cv=none; b=Nho+hDW6WTT6/pvDVH9uJ7oMrBrRDRK5phEnTQio77ya8nRbGNtPmN4ivkasM40Vy6QQrgcmdHQEv3UXgngyM3Ur6lX+/0O6pnoeTiAXvyH+YFV5NiYG7L7M1XFr67QVzz4OO+iJC8tOvWQl+WCKPgulSvRDl3SX5zl9g57k/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880749; c=relaxed/simple;
	bh=BUVZ1NN0CCALHkn6LY/cO0vPYB7ZsppqOSb9m0pUjzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2zjYlhh3BEk/R0GNievNnx2UQxr+DMWFdoB5zffUUwttaoOy8lDpAGEaW5db0gpnNxJgVlVAFbrCHG0cdCcHgvhIWo6t9UnSna+nKDJiY9m0JlVePmNiMcSu3KFNsZAs1XKbuEve6Jeu5fx1lb47d3kvApx2vsvHWUBM2zlBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRnGLco1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9B7C32782;
	Mon,  5 Aug 2024 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880749;
	bh=BUVZ1NN0CCALHkn6LY/cO0vPYB7ZsppqOSb9m0pUjzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRnGLco1jqPRgbCriAkOIinogB8RFg/P+Y4/uRpOEeh4VijPFGSsWykN4FOLzzsA1
	 73koXwNjNHKfy8/P/8EzFXc8XfybCfiCusZEiXaBm9FSGVQ5gkrYt+G+BwhzjeYMUi
	 c3yEKu/xWQbe6NlIiItradWjfT6FCxSXzGZkHptT5udJ10p50yO+j/tiMlFmrV2g/6
	 FaluSblA+6P9Rv1HgfAOlVj9RIqFDgp+NjQSyedQWqe+n3+6D0mQzpC35dMbnI/p1u
	 fdmJ6nQY57PRRbPXN9XJcUn1MNxl93e7EEn6RBtAQtC3cF2+wpCTsdYkjZVZqctSEI
	 3St3JWib7hjnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	bo.liu@senarytech.com,
	songxiebing@kylinos.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/4] ALSA: hda/conexant: Mute speakers at suspend / shutdown
Date: Mon,  5 Aug 2024 13:58:51 -0400
Message-ID: <20240805175857.3256338-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175857.3256338-1-sashal@kernel.org>
References: <20240805175857.3256338-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 4f61c8fe35202702426cfc0003e15116a01ba885 ]

Use the new helper to mute speakers at suspend / shutdown for avoiding
click noises.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1228269
Link: https://patch.msgid.link/20240726142625.2460-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 876380ad2ed13..cae8de6481222 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -212,6 +212,8 @@ static void cx_auto_shutdown(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
 
+	snd_hda_gen_shutup_speakers(codec);
+
 	/* Turn the problematic codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
-- 
2.43.0


