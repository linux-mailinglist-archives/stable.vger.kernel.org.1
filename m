Return-Path: <stable+bounces-202048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A25ECC2AAA
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F6930BD9E9
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B643596F0;
	Tue, 16 Dec 2025 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9N3ESx7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A03596E8
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886651; cv=none; b=k1BAE5RsbUeVUCHNOPHRFjZmkBcDIfdfzPXBd6Jp7TecL9TsmlEOhfwlPCYIBIyNhtouG6p6DOQShYh6NCqGyOxYUld2+wYZ+qP7sr5/ZyUBwZfmerSNqpQnZ2RVRuf6NWiJjIW3WdKbF7qqf2YRIcc0AwCQCEfbhzuGAGHvD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886651; c=relaxed/simple;
	bh=/CAKgWZNxhWiYLVdZDx/O9FyNgfsqIMRk+LMNRB8UVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFlIB3blV5sJ/3ZVnV2ZWIWkLIk+VnObq+DDjBhsE7YfCpRiwNSqMgGHZayaEFMA7CqDoo23cE/S0ltreVkXwzgoKaL6B1SPMW7DyBTu1YgvyjEDOIhFX3+I2nf4fToNgiGtmU34oyU7yr80yHN7S7sbGYJmfkhl+JkKljOquXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9N3ESx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1ECC4CEF1;
	Tue, 16 Dec 2025 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765886651;
	bh=/CAKgWZNxhWiYLVdZDx/O9FyNgfsqIMRk+LMNRB8UVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9N3ESx78PrxG8pNHF+NCX3NJciOUUPISCIZ9683ijDD+NVr0F75alTq4rY1ZgUOu
	 l+Zq9IWX4efPZkuWHq5ouJ5Fl/toQSpG7pxplMtPvdg+AANvPWaaGSSvfwNxpCispC
	 cqsqC6Dt1Egzwe33f5KvHGFjBCytHhsI24RgNBckp+ru/h6bm1Jn0M0BLzxaBTFsNa
	 muNbULUcx7VaJwxDe0ax255M0xTIGnzE4IesmIFPPw41YIQ8GN91kSnmh8tpEmDFoz
	 tIhHXhxrmMVPAfIEcVTWfvDXN1eHKwpDPIBtCpmnbWCK0M3Ipm5o57UQ1x0Z/GC97x
	 Mfl/9fGz154tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: wavefront: Clear substream pointers on close
Date: Tue, 16 Dec 2025 07:03:55 -0500
Message-ID: <20251216120355.2790532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025121601-unpopular-opulently-2ac5@gregkh>
References: <2025121601-unpopular-opulently-2ac5@gregkh>
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
index 72e775ac7ad7f..a53c1d599f13f 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -294,6 +294,7 @@ static int snd_wavefront_midi_input_close(struct snd_rawmidi_substream *substrea
 	        return -EIO;
 
 	spin_lock_irqsave (&midi->open, flags);
+	midi->substream_input[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_INPUT;
 	spin_unlock_irqrestore (&midi->open, flags);
 
@@ -318,6 +319,7 @@ static int snd_wavefront_midi_output_close(struct snd_rawmidi_substream *substre
 	        return -EIO;
 
 	spin_lock_irqsave (&midi->open, flags);
+	midi->substream_output[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_OUTPUT;
 	spin_unlock_irqrestore (&midi->open, flags);
 	return 0;
-- 
2.51.0


