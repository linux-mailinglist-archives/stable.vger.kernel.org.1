Return-Path: <stable+bounces-183506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA751BC0803
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 09:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D563BD433
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 07:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63032550BA;
	Tue,  7 Oct 2025 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="X1M2fSo6"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEDD25486D;
	Tue,  7 Oct 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759822728; cv=none; b=dwD0/EOO3yR/x3l01kXtd6ApRcV4etSQJI6gAysb7i+u8oUs+hxVHBC5MZKEoMsD/IIXzdBe2ZMVwApQjKHGNAmymTpz977FAYk4n8G6B4fR6QDmLfYIhNuij/AiomyahrtwTNornnPGOBUP7QOxrFj2cLzD7Rb55Mhfl5YM7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759822728; c=relaxed/simple;
	bh=izKDjWaxuTD0X9xPadokk2qGqpRQ5SI3QiNeU6LMxIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arB9iCGC9nNa4kGVkKkQBIsX1ceUCrx74YYr+gN61vyYhN6Tv00JAK9BBBp+elFU2nn0aPUQ3p713CHdQ4VqEEQsjrVV9+aveey5LBEqYZH6BjYGYpNcMRwg2hmedQy787BNvjJViZI2ZsGBUGZQar7qH4TAqHev7LrkTdpqZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=X1M2fSo6; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1759822712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mQtBl8NZIHe7kauTG50kRQk+84xEw1u9+LoZLcV7hns=;
	b=X1M2fSo6NrITkvAQIeaEd9bSf/+rsy1a15nD/flLJ4tbA5GmjOKhPHPvfZNGQHeeneTQyK
	KGzDXe/KcFWY+Tvd0iVMthv7pLCDR/wa5DZHMG29qUMoFtb5NLtcGSCLHkBzi48enGCxyt
	ZZ1gMyzyN9OtAWBtlakNgcpWecyYAnQ=
To: David Rhodes <david.rhodes@cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_get_acpi_mute_state()
Date: Tue,  7 Oct 2025 10:38:31 +0300
Message-ID: <20251007073832.3662-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return value of a function acpi_evaluate_dsm() is dereferenced  without
checking for NULL, but it is usually checked for this function.

acpi_evaluate_dsm() may return NULL, when acpi_evaluate_object() returns
acpi_status other than ACPI_SUCCESS, so add a check to prevent the crach.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 37f2cdc8ce82..890ddb8cc66c 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1426,6 +1426,8 @@ static int cs35l41_get_acpi_mute_state(struct cs35l41_hda *cs35l41, acpi_handle
 
 	if (cs35l41_dsm_supported(handle, CS35L41_DSM_GET_MUTE)) {
 		ret = acpi_evaluate_dsm(handle, &guid, 0, CS35L41_DSM_GET_MUTE, NULL);
+		if (!ret)
+			return -EINVAL;
 		mute = *ret->buffer.pointer;
 		dev_dbg(cs35l41->dev, "CS35L41_DSM_GET_MUTE: %d\n", mute);
 	}
-- 
2.43.0


