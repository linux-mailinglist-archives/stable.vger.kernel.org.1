Return-Path: <stable+bounces-71096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2196119D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6571F24122
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372719F485;
	Tue, 27 Aug 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZVszVw77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBF1BFE07;
	Tue, 27 Aug 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772086; cv=none; b=iBHO33pLR6eWPvh34ygGabmr9z+cwclobh+TujESzQc0fqkMjdwmjSTMfeZjP2ZreKRKqaGYsjpgqEd+TbaBoslumUxviidakgKBZ+z4cXMbbM8k6mp4kqmyyi1oWr7NCcdEUYvTmqs4LPoEyM6q3CXgGAidyEyPZmJVlu326DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772086; c=relaxed/simple;
	bh=+YpTYjUBhJpvovuEs68UTDl76N8qxHe8s6LklTjcmDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2Cet3Z2z7VNopMNjYDG27Y8l3ZsJClvxuc99hZtePiz8DYltz9lBzPHkWz6hu9JFOohXSwaX4ichedqioO2hqSf62LdGkpnCujgvhG6fbbmWG9fk80LVaj4x11wJFcT6WicdDjHqSCAy00WeDMqVxKTtdjpGxG5Qo6NEGX14tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZVszVw77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB830C4FE09;
	Tue, 27 Aug 2024 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772086;
	bh=+YpTYjUBhJpvovuEs68UTDl76N8qxHe8s6LklTjcmDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVszVw77QVL2LAYbuF9quKTG8o/BRPLx1OZITMOYPBBVCU3Ee49W5U87l4tq8y/GT
	 SI1EAVzrBpkbuogGUCPqCyh/xmQAzyda+YDQQsN3gb7yYFFF/X/M5g8lZzpQY+huRF
	 rJC1fGtXqzc+a3e2VOKN2X01qG1HxixfgpgFGRbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Parsa Poorshikhian <parsa.poorsh@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 110/321] ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7
Date: Tue, 27 Aug 2024 16:36:58 +0200
Message-ID: <20240827143842.432905414@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parsa Poorshikhian <parsa.poorsh@gmail.com>

[ Upstream commit ef9718b3d54e822de294351251f3a574f8a082ce ]

Fix noise from speakers connected to AUX port when no sound is playing.
The problem occurs because the `alc_shutup_pins` function includes
a 0x10ec0257 vendor ID, which causes noise on Lenovo IdeaPad 3 15IAU7 with
Realtek ALC257 codec when no sound is playing.
Removing this vendor ID from the function fixes the bug.

Fixes: 70794b9563fe ("ALSA: hda/realtek: Add more codec ID to no shutup pins list")
Signed-off-by: Parsa Poorshikhian <parsa.poorsh@gmail.com>
Link: https://patch.msgid.link/20240810150939.330693-1-parsa.poorsh@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 93d65a1acc475..b942ed868070d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -583,7 +583,6 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
-	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
 	case 0x10ec0285:
-- 
2.43.0




