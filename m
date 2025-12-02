Return-Path: <stable+bounces-198069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C4C9B1B2
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906643A6930
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F230DEA9;
	Tue,  2 Dec 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="ReQU0OZn"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2D2FD668;
	Tue,  2 Dec 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670850; cv=none; b=cGvPARw5VAhCnQSukRuGU01PBmLZxY0UHOMNDUvlIMc2KN4hDHndu8JRGWVmMCymAqkNqK1H0sItqDjHMrxnlyWnOJhpyKIMbMu/NuBIqrYxunBFzNpYve+QUu1NUJD8XH2U08UUG458CVBx4vMjqDjtEJQkldZuZQ3QYzmIjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670850; c=relaxed/simple;
	bh=O/d8LEK/6mYHrWgdx+ak33ZSAKUqvCm+UfoTfuuJ24Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIYRvSHOrEjd7ohITkxb17BC00L4wUuZ/9EOcS3gWiwKnI1rNLN3vp5QtZTxxJUYaqal2qs9Vi1M/itjJnlFbObLhozAr0ExQ2vww9P/DFycZdEwR7au6cIHfJYXzdeYtkbr85HMP95Cvzc7UjSuuwoWl3eI5CJIcbrQfgWDvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=ReQU0OZn; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1764670418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iUgPLt+OaJEiArNIXwB0JfdX1Xr5sKO1obIwFQbbWyI=;
	b=ReQU0OZnmrNxM0WsrqGgJMK5LIUiydM4lOAdBTVppqYHKJgDa/Ev003Yf0yiCave7Kk5PO
	lVKzz1Lj+v1ywHKEGe6ppFHRh3OopJCgRBK2mAD9H+8WFYcOa7Qfsr7W8pfduXo//1oG/Q
	10c7xostm+g7rY+9bml47itcz01qtaY=
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
Subject: [PATCH] ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()
Date: Tue,  2 Dec 2025 13:13:36 +0300
Message-ID: <20251202101338.11437-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_get_first_physical_node() function can return NULL, in which
case the get_device() function also returns NULL, but this value is
then dereferenced without checking,so add a check to prevent a crash.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index c0f2a3ff77a1..21e00055c0c4 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1901,6 +1901,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 	cs35l41->dacpi = adev;
 	physdev = get_device(acpi_get_first_physical_node(adev));
+	if (!physdev)
+		return -ENODEV;
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
-- 
2.43.0


