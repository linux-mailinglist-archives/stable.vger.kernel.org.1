Return-Path: <stable+bounces-65440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE894812C
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC961F22866
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93217B4F3;
	Mon,  5 Aug 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxxMv5df"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A417B504;
	Mon,  5 Aug 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880731; cv=none; b=VD9dU56HMg1hiuo6DDJwuiIGJQgDbWsJSoBIcz9aJmm+0vidf0cMlTFLmApHRYRsU1ZnsLmKhS3+sZ6MqPne2ilzoF92hUqafxBYQSbHLz0MBQZXyJsHCRj4fTWOc5W5AoGDpN3UO/lXDNxTISUNxXO0hRIIX8huJ/gEHJzVjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880731; c=relaxed/simple;
	bh=c6Ownx+iWsQEvgWsGYT+lbPsC5vHcmYz5Ph9J0a+bQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIJ+A28qos6YKGPFwaL0ssSTx+i6GO5GPhVuL+zEoc0oHRap9+3zrgSYFU7+Du6wLFSgQZAGsHd0oIqCChuXMg6KpJGCAh86xnU+ERAaGJBvmVCkFBFc9bJ9YPEWwiSO0CTV0SyiaafsOHH1YLeO+pdxaY88Z6SeJ2Ms9G1XlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxxMv5df; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F0BC32782;
	Mon,  5 Aug 2024 17:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880730;
	bh=c6Ownx+iWsQEvgWsGYT+lbPsC5vHcmYz5Ph9J0a+bQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxxMv5dfVyOvrz1S0q8z43VN3e1gpxALKL8g8CaSHqkp0aPYBEDUjH5D7r/A20a5f
	 Swpjb9zHyAAnZcCuQXAZis1L3S1++hP1fDA/OwKr76qHZNI2B7KT+j5j2n30ib89fo
	 V8YR59ADthoa2InE1SiFh9wG0DxgObMbz5KGY3hgntc7zA1zDsa5a6QdoOfNGy9BTB
	 0apeUKXx571sYSdxTURNuVbMWllGNk9vAXbNks0bbP9xw1WnST+KdNpInqBUJ7Jo85
	 Y3lCkG43l6oEASMia5y8UZB807TmFm8pqitfEHrsUNH/qToDjse/Wn1/jBUoZ9nm37
	 HlcEwJhFIkWTg==
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
Subject: [PATCH AUTOSEL 6.1 4/5] ALSA: hda/conexant: Mute speakers at suspend / shutdown
Date: Mon,  5 Aug 2024 13:58:27 -0400
Message-ID: <20240805175835.3255397-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175835.3255397-1-sashal@kernel.org>
References: <20240805175835.3255397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.103
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
index e8209178d87bb..083d640fe348c 100644
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


