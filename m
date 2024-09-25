Return-Path: <stable+bounces-77435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B66985D34
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A08F1F25B7C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402C81DC06B;
	Wed, 25 Sep 2024 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kby/lNZF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30B1DC074;
	Wed, 25 Sep 2024 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265767; cv=none; b=InNtjsSW6MuO22TQcXdzEpCxI5wMIMbiQbRrCCqmvEsU7If7jfKLxIRaQ+tldk/cNxA8XAsN4VmbRySjILdoz+2YQaQefOkCZAdGB3RJnaeQ0trG010489rXReXbmMAyfMCdAGaK92UjVDrdCDzkDsMY7rtbRzEhHC8mZuwOq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265767; c=relaxed/simple;
	bh=7hvrXMe7WuLPXYPFt7npfA5tdlIn08uNZaYmyprZjW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3zSKa+Z9UUv39oYG8RFIjYBDOS7ySdhGO9PhasfOJQaDsczeJz6gdiYEMInT+XVkqBYMDvgWYdj0ub5bvocswARTsrTwRayw93K/Dlg/w2HpEL9zMMMBGvvb9iPXDh6xQ5PofkxiodDxvEDknUiTEvXkOC1dKty0ePsFxkVm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kby/lNZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCCDC4CEC3;
	Wed, 25 Sep 2024 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265766;
	bh=7hvrXMe7WuLPXYPFt7npfA5tdlIn08uNZaYmyprZjW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kby/lNZFEkwaeiz93y8wlvm+NW/OFXtB6clAx7mrMzOmCM7P1SopWfv10VSL2r+5H
	 dnhk6BJ4YCu+iUDhXvj2uV8fS0k5mZiNNiaydun9f6idmLYpD3Tdv/hEcjD+k3Gxp5
	 ey1+xQXdpqBGLgrnewI+CGjpOXi7xWsG4rJOcOPfYzDyngEJrK2q5WmKiJu9IrNDbj
	 OB280vyYsxW8n15bY9m2o6CkDdG2pnmxevdq29MwRKDy91iKOPjPph12xM2dZV2IV3
	 khaN3G+FnoFUtwMVRbGN8yqsVO0SPxiukXI43QImITo5YifJ214vMpQYHpluebFb21
	 j4kO5nWIuMQzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 090/197] ALSA: hdsp: Break infinite MIDI input flush loop
Date: Wed, 25 Sep 2024 07:51:49 -0400
Message-ID: <20240925115823.1303019-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c01f3815453e2d5f699ccd8c8c1f93a5b8669e59 ]

The current MIDI input flush on HDSP and HDSPM drivers relies on the
hardware reporting the right value.  If the hardware doesn't give the
proper value but returns -1, it may be stuck at an infinite loop.

Add a counter and break if the loop is unexpectedly too long.

Link: https://patch.msgid.link/20240808091513.31380-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/rme9652/hdsp.c  | 6 ++++--
 sound/pci/rme9652/hdspm.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index e7d1b43471a29..713ca262a0e97 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1298,8 +1298,10 @@ static int snd_hdsp_midi_output_possible (struct hdsp *hdsp, int id)
 
 static void snd_hdsp_flush_midi_input (struct hdsp *hdsp, int id)
 {
-	while (snd_hdsp_midi_input_available (hdsp, id))
-		snd_hdsp_midi_read_byte (hdsp, id);
+	int count = 256;
+
+	while (snd_hdsp_midi_input_available(hdsp, id) && --count)
+		snd_hdsp_midi_read_byte(hdsp, id);
 }
 
 static int snd_hdsp_midi_output_write (struct hdsp_midi *hmidi)
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 267c7848974ae..74215f57f4fc9 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1838,8 +1838,10 @@ static inline int snd_hdspm_midi_output_possible (struct hdspm *hdspm, int id)
 
 static void snd_hdspm_flush_midi_input(struct hdspm *hdspm, int id)
 {
-	while (snd_hdspm_midi_input_available (hdspm, id))
-		snd_hdspm_midi_read_byte (hdspm, id);
+	int count = 256;
+
+	while (snd_hdspm_midi_input_available(hdspm, id) && --count)
+		snd_hdspm_midi_read_byte(hdspm, id);
 }
 
 static int snd_hdspm_midi_output_write (struct hdspm_midi *hmidi)
-- 
2.43.0


