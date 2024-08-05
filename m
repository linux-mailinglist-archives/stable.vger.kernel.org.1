Return-Path: <stable+bounces-65412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E349480DA
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 19:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290B1B23185
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7639116BE11;
	Mon,  5 Aug 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5xsrZLw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41116B75B;
	Mon,  5 Aug 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880605; cv=none; b=TEL+jK7tzuKkRHiNtfBpmOIDthcuXbLJPdtDuy1TtLIn8VwdPUC8wJfDN5AjOaiLwKrBduSQKlDWUDA1UJtFxjs03lcu2tLI6thZrLz5A2LrB/PW0Zo/6Cv3rcl0+9G99cEl/f6l6EzGz5cZzO3sjI30O2JMDFYoyxuZAalbIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880605; c=relaxed/simple;
	bh=Q1RCKHSdifpnj4Bqi4RUYY5LoE8tNU04hLeNQkuo3zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBK2MehOnTJzaDvAePj6i6NsQsBA6DyAEoHn8oqvh7Lao+BndOOehdn3jOo3pUkqOxMqB7JVouvZ5ulVwR/IHmOXCMQfmmvhn4XnWAqDnSN1BPCBmRlbwoubZCqsCRkkPjphui4jC+DDqD4X6+AuKhJ2WUNQF7U8SV2Lzcw0bOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5xsrZLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF000C4AF0E;
	Mon,  5 Aug 2024 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880604;
	bh=Q1RCKHSdifpnj4Bqi4RUYY5LoE8tNU04hLeNQkuo3zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5xsrZLwV7pxFLSAu5AP25nQieKGT8eIky/rai4AbmKa/vfUvkYuQDL6XXJLMaM6w
	 +zDTi7yYrsLPf0ipsEagWKWAyQ5sH4urCmEoiY1isYm3Hmq+SPXZmgIvBFHP26Fzhs
	 IQKH6tzvTjF67KEgbDfyvUUMV9SmdRV/OPyd3Rb0pzBmHSOTihOLlRx0P17hYTzH+t
	 J/vuFagBZZ5qfdgWk2G/isAKoSuO2XkxrSjFUE3DS9+JO0KnXQ3dFdncmxnJTyqSQO
	 UTODnwGm7nVs8eCvYaYTTrSS2AHK6osddlX9DydW5BDYMaem2kpI/WKDWH7MLKaZCA
	 z9InJGEVp7KAQ==
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
Subject: [PATCH AUTOSEL 6.10 07/16] ALSA: hda/conexant: Mute speakers at suspend / shutdown
Date: Mon,  5 Aug 2024 13:55:39 -0400
Message-ID: <20240805175618.3249561-7-sashal@kernel.org>
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
index 17389a3801bd1..ae12b47332201 100644
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


