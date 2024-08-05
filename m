Return-Path: <stable+bounces-65428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497E948107
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474A32890D0
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21D717623A;
	Mon,  5 Aug 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShQ6RVJ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C3176242;
	Mon,  5 Aug 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880682; cv=none; b=WW8FU0EKGdpRI2Q2EGIFpN9AAlHMkFaf9LlWmGa40uirxjoL2ljVIf4RzAfZoyyJZBq/eWSTqwGm/fQYF/btnG+inaHn7zfXacVdG9EYXbk5ZJtKosYdQ0mbrzlLoH7NcKUBpCctguBjogXZblsKgePEpxqxzvM3OUNHDLvWW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880682; c=relaxed/simple;
	bh=c6Ownx+iWsQEvgWsGYT+lbPsC5vHcmYz5Ph9J0a+bQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIubnUqSzBVAUw8/tXJPqRBWOheWrP4QExDUH8WgLhd/5NwvQqsblG/kPEFcO1GFC5v9AsMlRtdtvyfxkrNjBNPbASromno9/mFbj7CaVBBksNFAR0IFtR8KJYyApf18Q6ApsG++VddrvB7BLxqt+iRcRA+XyEh3zc4u3ETiqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShQ6RVJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178B4C32782;
	Mon,  5 Aug 2024 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880682;
	bh=c6Ownx+iWsQEvgWsGYT+lbPsC5vHcmYz5Ph9J0a+bQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShQ6RVJ/778zO8w36knidMYVa1dBBiL1AIMRYe4KtEMhpJL6g+mCC7+gn8ylnn1Mt
	 w+uG17VvQ7GgGhZKufq/vi6gH7I8K2W+z4WN+3mkS78vCnsopW+AH9keiJwV7d/yC2
	 on/KggrhwmSYBFfqf+uI7sjQFN9B9yqwp+lm0Vn5jp5GxAoW2JhzVQ0nU2CHUbM4X2
	 K173Yu1A9y+Febp8o4icy+07Sxs1KoIE0IGlzodgqzV/I2xuH2bE6AT92q4QPEFMZQ
	 S5+04HjqfjKpvUPrmsUn88PPFJAayB5gXfqHWlVdvkbAp2/jJ+1etHPg/FF1lgxi3O
	 bldVI5lnF1nsw==
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
Subject: [PATCH AUTOSEL 6.6 07/15] ALSA: hda/conexant: Mute speakers at suspend / shutdown
Date: Mon,  5 Aug 2024 13:57:04 -0400
Message-ID: <20240805175736.3252615-7-sashal@kernel.org>
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


