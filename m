Return-Path: <stable+bounces-40307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2B18AB295
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB98D1F249F2
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7246130A56;
	Fri, 19 Apr 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GADsMMA5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E312F386
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542178; cv=none; b=ifHGTqBD99yxFJxckATVb1WxqMpoyPM3RHfycxITQmgADT4caENpUJtw00kF3yV5Ac9Zc0YGiq0FOL0UX4K8fWCtBvaAIsflmVCEm/vs4YDS+wFwiSNmCwZRcW0psd5/yRRRkdsj9dBafjHqofZ6MG9Hew5CZUyPTph1RNFZ+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542178; c=relaxed/simple;
	bh=nRWmsz+ol86iEda/sLaGstghkFR8dtrs3F6/QzYbTWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hk1qtFjbeAwDiKUls468y7JwepaCF+Xz/Wwf/tnLdAdeRePNz46eeUO6tMWnFXeu+5ImYVrXZ9pv1Q2aoKFaw+i8CLplbPxzgMYYCl/8Z+zhSNp4nJfM2ZNTuzQeKNXiY+81+E7wzNBRpOCsNR94JirC0UYzF+LF8BbUtPlTBOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=GADsMMA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C5BC072AA;
	Fri, 19 Apr 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GADsMMA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713542176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IugwrqbwFRM5bjQBieEeKRil9KI+xMtghTX72F0ck44=;
	b=GADsMMA5aBjtlXUiXpxhS+/52XTdMNnK+ZvOo/eYwDzGhjKTBDoFY7tpnf5BGn9B0Yy7d6
	H0W7ifZ9v5s9xU3dbJ5NZ3PzPebLZ+3FzwNkNZ08lfNpKy3NOMKOzvTDo0AUyl1woWx+Ya
	qS5fSPGc4p/DgK/HiprMvtpV12xYMqo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21f102d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 15:56:15 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: stable@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH stable 6.8.y] Revert "vmgenid: emit uevent when VMGENID updates"
Date: Fri, 19 Apr 2024 17:55:49 +0200
Message-ID: <20240419155556.467970-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3aadf100f93d80815685493d60cd8cab206403df upstream.

This reverts commit ad6bcdad2b6724e113f191a12f859a9e8456b26d. I had
nak'd it, and Greg said on the thread that it links that he wasn't going
to take it either, especially since it's not his code or his tree, but
then, seemingly accidentally, it got pushed up some months later, in
what looks like a mistake, with no further discussion in the linked
thread. So revert it, since it's clearly not intended.

Fixes: ad6bcdad2b67 ("vmgenid: emit uevent when VMGENID updates")
Cc: stable@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20230531095119.11202-2-bchalios@amazon.es
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/virt/vmgenid.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b67a28da4702..a1c467a0e9f7 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -68,7 +68,6 @@ static int vmgenid_add(struct acpi_device *device)
 static void vmgenid_notify(struct acpi_device *device, u32 event)
 {
 	struct vmgenid_state *state = acpi_driver_data(device);
-	char *envp[] = { "NEW_VMGENID=1", NULL };
 	u8 old_id[VMGENID_SIZE];
 
 	memcpy(old_id, state->this_id, sizeof(old_id));
@@ -76,7 +75,6 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
 	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
 		return;
 	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
-	kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
 }
 
 static const struct acpi_device_id vmgenid_ids[] = {
-- 
2.44.0


