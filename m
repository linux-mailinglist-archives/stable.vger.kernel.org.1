Return-Path: <stable+bounces-201341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 794CFCC23DC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 711253076A06
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343CD341ACA;
	Tue, 16 Dec 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQH5PPHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92DE313E13
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884321; cv=none; b=uQHihsd+1vQuOiZgUHYfvWKnmrOyO2DMpreHi08GVliKxSC5kMNTIcPP5RE+8jXgDzOJ6FqaYZJH//UaeHO0WF6AdKAYgqNN3Z/1tBaVYgx8Q1CbWnzWAT7k98MGWoBKZu8TfZNopO4BoXO3eYR3yHa6NPVPN76pfs49rrflw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884321; c=relaxed/simple;
	bh=JPA9sA5kgBIUXKSJuAAePoAuAop39jxBU7kj8g3y1Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5VPQqIvwlqAuGgTfhr/8qw+TmeM7DniRt6Nn9yDDje9ABrWku250n1HQOO7G1kNOXi8isKjpd28AxLHIU9P+FRtVRAoAn/fvrqzdKWOHOk2un7CMB2/YSw+KDpfpL9GIyj2CgmJrewN9Iq9+TlPFO4a7wqP+IOq23/0EFhtRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQH5PPHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74838C4CEF1;
	Tue, 16 Dec 2025 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765884320;
	bh=JPA9sA5kgBIUXKSJuAAePoAuAop39jxBU7kj8g3y1Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQH5PPHWbMWrJA78PK/qdGzVAorpPHvN1g/pMxZRqpGR7lMbcGWxz5Hl17oA7Vpx7
	 cqaj2wjBi5wsAf2YezeTmUYGFGmhIvSn7mMIPhN4doUmDJlTQOqQ5qbOCtSy+lpHSt
	 hFTgY5NxO5t5wy92d8+8T95fOMJukSpx4TCrSXdAqCOOLEDbjukPZB1CvzWAmi/Fis
	 xag57qK5sXqIiK/anj+hIHn5FBpsXPDgLiQpDZ0Ok4JqzqlB/8eVn/WLvfRdxFmbSo
	 Flc88AWZWWCAHjmYR1OnQZVX2ja5Z2zJj+8tzuMwvEeAeXMkN3Oy7x9EcWuAo0b8gz
	 2NNhVjnYhHSBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ALSA: wavefront: Clear substream pointers on close
Date: Tue, 16 Dec 2025 06:24:47 -0500
Message-ID: <20251216112447.2760018-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216112447.2760018-1-sashal@kernel.org>
References: <2025121600-mammal-natural-0654@gregkh>
 <20251216112447.2760018-1-sashal@kernel.org>
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
index 2dde66573618d..820a5a55d2523 100644
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


