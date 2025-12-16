Return-Path: <stable+bounces-202246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D09CCC319A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B99305D019
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D5359711;
	Tue, 16 Dec 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/251G/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF43451BD
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887283; cv=none; b=eZriNoakJ1jRPP90towdb6CzvsL6WdaikCj5hlEFH1whkAN620ivz964YoTpmxnr/ZUlbs4qmZfgRSyaZe4vL9gKfXyp1kVhgZ8x5rN2sTrh4HJhdw38jkA9ryLlWe0G/t1wz+U0GQnzHHRaxRwzb3mQaQxoe0UWfIKl59AoHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887283; c=relaxed/simple;
	bh=1HJbxnJYVzbX/uSMq3SUh8c0Pd9K4aOK664xTC8JKLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag4TNkkIjuZ4PIMvjpcHREP/fLSspb59LAseVle0dZ4R+eZsoInJGhlbwyEf3OlKjAwONuFYlXzvrXW7PgZfJ2RQnytOjkd6d4O/CyjTbjhEsw/EsWSF71uMgJJvomrKZE2ix+D8ZM5JPYsLgwzi1IXT+AH/RYYE7EFF7R4sX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/251G/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88554C4CEF1;
	Tue, 16 Dec 2025 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765887282;
	bh=1HJbxnJYVzbX/uSMq3SUh8c0Pd9K4aOK664xTC8JKLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/251G/jCfGBK62/C5bYCen2ktaXRfTqS+ne9b8dA+DSLE5sPxtDLoSKsd2LT25n5
	 ZAe3JjPX2dRuM1vXqGGKsolZiXgBTPwifLOzE0JbRAJMwNjBYljiXbd3MTvfbHmW0V
	 ggi9HN6bm/qGPdTvoFui61VfYTy43pLXjjb/DpYCHKQVWcQjthti2iwwOplpiNN1MK
	 /TYcVpVkImR7ty0aYxmGivcXAzFAUnCryMz7Y9uE09sLzDx9KgsfkotZ9CvqenCraM
	 s6CxikR5wnAaoiTChTSwqA+YWjl8p70s3QW+QtbFNE0vf1DKLfK5zp5nS+oItvH242
	 Z3y9KCrpPG/Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: wavefront: Clear substream pointers on close
Date: Tue, 16 Dec 2025 07:14:27 -0500
Message-ID: <20251216121427.2792618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025121601-suffrage-senate-99ab@gregkh>
References: <2025121601-suffrage-senate-99ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit e11c5c13ce0ab2325d38fe63500be1dd88b81e38 ]

Clear substream pointers in close functions to avoid leaving dangling
pointers, helping to improve code safety and
prevents potential issues.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB7881DF762CAB45EE42F6D812AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ No guard() in older trees ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/wavefront/wavefront_midi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index a337a86f7a65f..049ff37382e7e 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -291,6 +291,7 @@ static int snd_wavefront_midi_input_close(struct snd_rawmidi_substream *substrea
 	        return -EIO;
 
 	spin_lock_irqsave (&midi->open, flags);
+	midi->substream_input[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_INPUT;
 	spin_unlock_irqrestore (&midi->open, flags);
 
@@ -314,6 +315,7 @@ static int snd_wavefront_midi_output_close(struct snd_rawmidi_substream *substre
 	        return -EIO;
 
 	spin_lock_irqsave (&midi->open, flags);
+	midi->substream_output[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_OUTPUT;
 	spin_unlock_irqrestore (&midi->open, flags);
 	return 0;
-- 
2.51.0


