Return-Path: <stable+bounces-201184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 818D9CC217D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B9E3050373
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8F33AD86;
	Tue, 16 Dec 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvydYKku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB77271A6D
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883215; cv=none; b=gcd8/o+xZ3Ixx2fotnO5cM6o6xqkNYkY+NPO5eG+FCdcsoX3+DMPKuNLGGpulARyy5WhxsqrUygJdKS5X3zK+zYyhmTPthDV4citE6DOusTs5L8f28tVErENp5G0ul0VvBUVv/9aFSqxR8IPtbTwu6XNyEq3kEZnzzcbu3OszrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883215; c=relaxed/simple;
	bh=JPA9sA5kgBIUXKSJuAAePoAuAop39jxBU7kj8g3y1Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMswX6jyqVZVB8j3w8UPzH1tAayGtKVGJcOZBvkh53bl1Gj8mZoGsfa7qq1ArRey6hzFKOwwR2SLVxtfTy4XpnwAtzUw+C1c4n0Um9O+hXSem5xRQwA38mWrWxHpeZDhICgoe1Q3qFJbs/BHC0oor7o2wucutdeY/ES5HxU91FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvydYKku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C81C4CEF5;
	Tue, 16 Dec 2025 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765883215;
	bh=JPA9sA5kgBIUXKSJuAAePoAuAop39jxBU7kj8g3y1Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvydYKkuLAf90TcvNGGnIxAP1Y4lDYSVjsc4qwLUe46dZT851MWt/dswZmLiK7Ib6
	 Ff/zQ7GruZXA1DFBfQ1o9p1Y8p7l2KgBmlBKZaOanilCshyBw6oc+l5RvW4wzEbWTr
	 0neLLS0Me2h8iWmeRmNFEtnxFL3T2rjqQ8Z00JamAXnKNUonIX4fesCqA+znxdG3XB
	 wzvXuISvSTm99ZHI9oRuTUGLvqLftUCLZR1+RlgiducIBHj5WTQeAEP713qNTANtaL
	 XLaLVYkC1NU/XNC5YaZ18awiiIsyBPHfbCZdVbRhXktWHQvx7OZ89opwQddSVJoQxO
	 qsBYTSVECryZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ALSA: wavefront: Clear substream pointers on close
Date: Tue, 16 Dec 2025 06:06:30 -0500
Message-ID: <20251216110630.2754006-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216110630.2754006-1-sashal@kernel.org>
References: <2025121600-skincare-suspense-5b69@gregkh>
 <20251216110630.2754006-1-sashal@kernel.org>
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


