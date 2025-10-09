Return-Path: <stable+bounces-183682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81EBC895D
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 12:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39DF1889087
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9A2DCF7C;
	Thu,  9 Oct 2025 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="gYVeLXP7"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB8313E41A;
	Thu,  9 Oct 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007064; cv=none; b=ZGvPCifcWkYjqtw70dpG/kBm7t3gl2AQHtxJ/Kh32KLJmJ78Q15pQWv2psvPlPNMPofjCiqSM3H3BVEvifC/fMIJWVwV0p7oDAl6BU/VqUf/pcOn3loeASnd10ylSo3RYNl0+pDwXggwxl+FZfeJxUQrcsEFSkB64mniTTqW4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007064; c=relaxed/simple;
	bh=dES5xU44DVZYAsDNXMMecotfKT0H5p3bn+Jl+pDUyZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXgPoJPLMCvjM+tygfy7PP22VBNDwx+wSDjMSY2rHad046TDWqgM8LRA8KNHg5aeBHfOsRLv2slLJypc+A2b19YWpGx1+sXd6YTuc07J5r376S5THcXoMIx+f1Fs9ln744lkJNlJCgoEkMxexNxniiNhfIoT8jpO7Tt51UO7hPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=gYVeLXP7; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1760007050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vsiZ5gBlQopTSGe0JyyYKO7fN0J0UxYzPlRuHKTUIfs=;
	b=gYVeLXP7MhHyuFhiol5SOAGMkE8kuMSQIR/1n2agnPeCPMbU3TXcNHP6crx3iYP++QlxIL
	bucnV9YV72jArNUKA4W0Npfs6D2xwuD8XJN/hPlvX3HwQCQ9zsPZS6zgB+u4UO8ffXGVhr
	kJo2+appnpfoVBhBDjAm5e7Sh68QZd8=
To: David Rhodes <david.rhodes@cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda: Fix missing pointer check in hda_component_manager_init function
Date: Thu,  9 Oct 2025 13:50:47 +0300
Message-ID: <20251009105050.20806-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __component_match_add function may assign the 'matchptr' pointer
the value ERR_PTR(-ENOMEM), which will subsequently be dereferenced.

The call stack leading to the error looks like this:

hda_component_manager_init
|-> component_match_add
    |-> component_match_add_release
        |-> __component_match_add ( ... ,**matchptr, ... )
            |-> *matchptr = ERR_PTR(-ENOMEM);       // assign
|-> component_master_add_with_match( ...  match)
    |-> component_match_realloc(match, match->num); // dereference

Add IS_ERR() check to prevent the crash.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ae7abe36e352 ("ALSA: hda/realtek: Add CS35L41 support for Thinkpad laptops")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
V1 -> V2:
Changed tag Fixes
Add print to log an error it as Stefan Binding <sbinding@opensource.cirrus.com> suggested

 sound/hda/codecs/side-codecs/hda_component.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/hda_component.c b/sound/hda/codecs/side-codecs/hda_component.c
index bcf47a301697..603a9b8ca481 100644
--- a/sound/hda/codecs/side-codecs/hda_component.c
+++ b/sound/hda/codecs/side-codecs/hda_component.c
@@ -174,6 +174,10 @@ int hda_component_manager_init(struct hda_codec *cdc,
 		sm->match_str = match_str;
 		sm->index = i;
 		component_match_add(dev, &match, hda_comp_match_dev_name, sm);
+		if (IS_ERR(match)) {
+			codec_err(cdc, "Fail to add component %ld\n", PTR_ERR(match));
+			return PTR_ERR(match);
+		}
 	}
 
 	ret = component_master_add_with_match(dev, ops, match);
-- 
2.43.0


