Return-Path: <stable+bounces-201175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250ECC2080
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3175830215EB
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B79314B88;
	Tue, 16 Dec 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvsWeMlH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8979314D10
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882448; cv=none; b=HZZbMn9sIR5HocsxKcHj1Uyd7yDujPwMuAxuwI0xwxiJ2wt8ZMdre1JZzJsD1sHobSvyknAy/zvoUsdT7b+p1QGvvuYa2XLG6mMxMtShpgCkA1BNleu4JjhS3x9KIzuveT23ZnjqNjN7blF/31Ho5zHbyiy+cGVibj36KL1C9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882448; c=relaxed/simple;
	bh=gTfPeRLRRJt6Pdd+OExfd4+i+wcd3jmAVJ/Obkj06kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWbNoj5QG4hkwdVuWsDO5gSbBiD2od6QYr9iAnXJU9sdq6HajWkLg7+/kMWB5yAOB+z3Lqhv3enwVW9JgBKuQ1BmkrrjKjuyXn+UV0/BMB5+YzwQ80jNU6oH9SAQmp+jkoLEAY9Jht97NShnBH1Nja+XYXeNPuSpLW/zNXjHGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvsWeMlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC58C4CEF5;
	Tue, 16 Dec 2025 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765882448;
	bh=gTfPeRLRRJt6Pdd+OExfd4+i+wcd3jmAVJ/Obkj06kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvsWeMlH2munQWaTTsXz0o8UKV3QUY1zx20dBwIHN5tbg5fwahHpoA8FZO9t1wnQ4
	 yKWwiE6Ksucq3FSxQVFkGdqzTYCuhxENh3hoWafL4Q5lUrYVGV6xo6us3jHhma+BFT
	 Uj0q5zBR7XJdO8VF34UCSbNCo94Od2cdqILNP2qqyQcJzIN3eGD5f9KlCz48cIgJWl
	 ENhyn6+zAEBl6Tw3n1ZbMdqZ97x2K4HyHRi1K+93ShIcwui+19NTH5GJgt+MDU5lAB
	 hs3afRk96MzGdml4McZsKwcDpqVDXQFZiBVSROthxjb3ylIYEIZ86eppPtwRzWEMKl
	 2xLRhQdMWMP5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] ALSA: wavefront: Clear substream pointers on close
Date: Tue, 16 Dec 2025 05:53:45 -0500
Message-ID: <20251216105345.2748607-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216105345.2748607-1-sashal@kernel.org>
References: <2025121659-feline-king-9be3@gregkh>
 <20251216105345.2748607-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/wavefront/wavefront_midi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index 1250ecba659a0..69d87c4cafaed 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -278,6 +278,7 @@ static int snd_wavefront_midi_input_close(struct snd_rawmidi_substream *substrea
 	        return -EIO;
 
 	guard(spinlock_irqsave)(&midi->open);
+	midi->substream_input[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_INPUT;
 
 	return 0;
@@ -300,6 +301,7 @@ static int snd_wavefront_midi_output_close(struct snd_rawmidi_substream *substre
 	        return -EIO;
 
 	guard(spinlock_irqsave)(&midi->open);
+	midi->substream_output[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_OUTPUT;
 	return 0;
 }
-- 
2.51.0


