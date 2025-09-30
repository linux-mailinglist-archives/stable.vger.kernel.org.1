Return-Path: <stable+bounces-182290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B75BAD6F8
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB03B324D31
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3A1F1302;
	Tue, 30 Sep 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pSuDIHuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C933064AA;
	Tue, 30 Sep 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244464; cv=none; b=s2TTqW3zs2UYfu/GY9vWCPuaE98z7AxVCoFQ7+OQMweZsKbxoA62KpVbOtPJZ8Pc2AYqrj8y03vWIwd2cyust/vxYGXR7S8uRxYirkQUg28soHACKv61aCY4uBkpn5ZmttVheGmPHZQ40e8Vcgb/IemfDMIFOXx5iMQ2kwuQbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244464; c=relaxed/simple;
	bh=djRVKbkp99ORuo2oazP3QHd+N8zQ/3bDQHJcvHXJ0lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ+V2r+4cIYJcC8Im5+vkg6JmWImu6VROz6F6uE8HvC9/6561UcPqYZIduJxoXXGZYWBnNdk1XPpj0T8pZbWMqyFZE54MhlZD6o0GMftgT3hSV+nwBvgBYNPUKYVYXufoU0RqlPNN8mI2hShMetSgL2STM4FZXkp5EcZWnK5Zyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSuDIHuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFE9C4CEF0;
	Tue, 30 Sep 2025 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244464;
	bh=djRVKbkp99ORuo2oazP3QHd+N8zQ/3bDQHJcvHXJ0lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSuDIHuRmsjZSVcIl21Ybt1ZIX/RHIMJmEY8BkFLxeLif1G/vlel1ssZJqWaDQ2Ih
	 2Wu8tEW+XG2oQO8PCD/UlhJxT1BBqluaX/DxRPVIuUkvyFLmtExrwwVvg7ERLcfuW2
	 zdHeCHjOKWohrupqjWrnvq25cICDDw0Rj7NNtPyc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 015/143] ALSA: usb-audio: Convert comma to semicolon
Date: Tue, 30 Sep 2025 16:45:39 +0200
Message-ID: <20250930143831.853311188@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 9ca30a1b007d5fefb5752428f852a2d8d7219c1c ]

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Fixes: 79d561c4ec04 ("ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://patch.msgid.link/20250612060228.1518028-1-nichen@iscas.ac.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 28842e49700d8..8cb98b5d31124 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -762,9 +762,9 @@ static int snd_dualsense_jack_create(struct usb_mixer_interface *mixer,
 
 	mei->ih.event = snd_dualsense_ih_event;
 	mei->ih.match = snd_dualsense_ih_match;
-	mei->ih.connect = snd_dualsense_ih_connect,
-	mei->ih.disconnect = snd_dualsense_ih_disconnect,
-	mei->ih.start = snd_dualsense_ih_start,
+	mei->ih.connect = snd_dualsense_ih_connect;
+	mei->ih.disconnect = snd_dualsense_ih_disconnect;
+	mei->ih.start = snd_dualsense_ih_start;
 	mei->ih.name = name;
 	mei->ih.id_table = mei->id_table;
 
-- 
2.51.0




