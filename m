Return-Path: <stable+bounces-201181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA53CC20D5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C2A304FE91
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4BD338F26;
	Tue, 16 Dec 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B05NzsBL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA03322B6B
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882791; cv=none; b=NltC9ZsQJQKtejYVrmTEn3VsDO5GDLHNb1VAWR+L4+BAaSpRpHtqz9uzCKUGMCgmYQOX/s/tOoFUbnOsu7ieiReYZy4XR7RWt07PV66z9Ek34AuNgSMpisBQ9czX8SopMCy4Xj8lNiGBJzs6dCi6XzVsO0bsYypqilCU4mPQMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882791; c=relaxed/simple;
	bh=4JaI6KhjGxLeVD6p4P8otb8uRYmW4K/R4wAMrOVwGAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlIsO6nbxqF1Bq0LLTAKf9C975Qt+I0PheCdjZwxJXOej1kUyUrHsdby23HcRCLx6n5iPK+Zn/7w3YPyAjPloXT7XGec2FX4eMKXd7x5g8v+N/IZ45nZkm+fE77yaqLATtgOnzs0WpYCybQeV5OxYsxij15pMcsp36R3fZRZCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B05NzsBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF999C4CEF5;
	Tue, 16 Dec 2025 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765882791;
	bh=4JaI6KhjGxLeVD6p4P8otb8uRYmW4K/R4wAMrOVwGAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B05NzsBLsRAiy5nz0yLPGDmXxRHGszo28loeHwbgjtI3KeO/tQKfpAf5YeXyXU0kc
	 yjvy+d/6RT/zYTTXhUwKGlKZwyYIDn/tkuOvoBT+RIRfpn8FXy4qQoUtgcBMg7QYMz
	 Edw1Ts0tvagTSO60ZQAcUNsRyMUphXflJ6K3R6QeqQfgMcDMPp9TBcJaaOAs7cEMEy
	 bBPmjYFZi0QEOw2CsNy6TVAvfln2LGrqlTyycUFho91JtzT8cbHOR6nACTJ4Rz1M02
	 Dv/br6q3j4BvRopM5WhUdW39js/aY2Hz0nHUZ51V5CdCFAbfz7T7qUnGGxGtPqFe3K
	 toM3RZBXwiGgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: wavefront: Clear substream pointers on close
Date: Tue, 16 Dec 2025 05:59:26 -0500
Message-ID: <20251216105926.2751412-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216105926.2751412-1-sashal@kernel.org>
References: <2025121659-cornflake-fragrance-62b4@gregkh>
 <20251216105926.2751412-1-sashal@kernel.org>
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
index caa3b82f73f58..b9593b4813965 100644
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


