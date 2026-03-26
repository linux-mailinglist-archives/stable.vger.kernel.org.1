Return-Path: <stable+bounces-230468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FIlLro6xWn/8AQAu9opvQ
	(envelope-from <stable+bounces-230468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:55:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCE3365B6
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50930304501C
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BEF2DF3DA;
	Thu, 26 Mar 2026 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF9DQp9O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9602DB78C
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532889; cv=none; b=PJLUr9128Mm13nMLqk/41d+kZL4YZQyE2QQgwv+3Wy123WaXFD9jdK0+XQH+Urn6Z5gqe+JEOhpG6eVO2DqAzGhHkGVRklmm/LQ34+T+7fz2DQzptz1bv79oqpukh1U3p9VfMn0a8+4XHPN6CK2D37uHHiV9JOLRWuNHkvA4kFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532889; c=relaxed/simple;
	bh=UNszagHGVwJzhH76TN04OiQNNlfu1FHxIjAgRAs2zH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcvWvI5/b6Ruu2A7xLKSYd14yTRpttNv5zvizIEguo/yXnGJ3D86ZrO812zzpQSSCBe6o4k2XyRcl60l24vJ9o8RPrAjuYdIoQ8ABH+/EN5JcJgV8xFYOQzHtiozdwspYu98pKNPEPv4KGvyRCpiM2RMMB9VZMDODlLHkkDxHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF9DQp9O; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so441160a12.3
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774532888; x=1775137688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjw+Wz2BQ09NcUFFpdqkRCn9P+DLrBZP5HIOIlyaTdY=;
        b=gF9DQp9OUQoqQ6LKODjia1aIQnsV3ugQkt9QiiC97reqbwruxbXcY2hJUzozzvs9LB
         g91JqGLviDL6nHvFdfocjJlUFq1T7NVUaBhGNF79rMAKnquVl5k6LP7NZD37YKBnvK4c
         M9hw8bzPCl3gyDga9skNC2l3sNvrFk/SXus+klUC9jlPMrpz49a66BhP/e537p9DGPno
         8rYJVa6ZDNDEwCG+pTXg/5R/rhxLhrgqPJVq0uRyGYANJAEgf1bPIZi0Efyv/4x4nR0R
         3/0LgleYvnIcoVv0073Hi7rjJ68/vRAXJmKRAWZM0SvhQjm/K2y9/pUa1el71yIFZtWn
         HKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774532888; x=1775137688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vjw+Wz2BQ09NcUFFpdqkRCn9P+DLrBZP5HIOIlyaTdY=;
        b=Ip8Ueuh6SApbEv57B4bRPf6K3OJyfTCw2RcTI98uZKiYjAHFqMJC2MV9xGIHsSKaR0
         pBeYhM6ZP/gKR42SyRslfrUzKoYfgorWgrp8bGl4haCGdkMSfUa6vVISGBp9aylHFT0q
         1Im4YmCq+jRd4kH+qSD1dHUszEPc4Mq69/rxGr43hXmDRfjNuXShnKm6il0owTWtvliA
         u85XCvKQXd5EFVzvaVH9+HbJt91Mb+F2dzjX2IqZC4NiVaIsY2OkF25SBfv8Ayq9xm/E
         7inNKkJn97wuvGo4H6KxacdA8mY/sv1LBeTEO2jooNaB48hJEGtKe8x91Yt/CQul1HYg
         Yo+w==
X-Forwarded-Encrypted: i=1; AJvYcCUU2SFyaPz7wvcATKeDCmQ/7VoffWrXtF70hAf19JcbZ3Uq/ORVuP+CCjvqUZ10NqcBxUVdWKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzicQL9OSFLUiBYwRKyIfpLE6EKVy/C/YE3Sp2KRa1KlV7lLc3H
	9wbLaNr4nc/97i/FEB3Mr/7MmECKxgmfTBk3JlvYWfklGDCPm/hZ+eVZ
X-Gm-Gg: ATEYQzzNH3rBJZGf5y3GQaRJsxmtSFmnGjZBLRDeRl5FoA03F/QT4cF9AHTkyo+JOVY
	6sIWGgPFThPs34BA93No6TMnKsTftIKBXlUJ47sA89JbPFp58eXXc8e8hxEBDwaGZR69baXXam+
	tEr7jTQ1fFtTEE0tXoWtYyY17ANl+PqgYMwyNuhKZ/i1nE1UZYINvO+zr/qxzfjMP1U+DibXiiW
	Wg2hKZDHGh/mzNoCy0oL24uKrfOo/g5Dz20vzkXyG7qe29Iln/8n97NSf9l/fPzLmPP1dZ93XB7
	H1VvWtRucUSuem7Tn4OdPsRHorgx5VeDQ/FKaqVzsHl7ZkRdkPJTFvdsn08ZkMAvziHWyt9qLJo
	YOGSUPVjRjCRptJqrgVgMTpEfHvtM77Qosdbbodjc8cUiSDItfnpiIFlHpD0mHbxYJoW94fTgIv
	GDzi4XfLkOYFTXcywPbsc2PZ+70jMnl71aqNSClQnF1gVpJPs=
X-Received: by 2002:a05:6a20:7352:b0:398:abe1:ea8f with SMTP id adf61e73a8af0-39c4ad559eamr8472339637.44.1774532887902;
        Thu, 26 Mar 2026 06:48:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e2:102a:c1a6:90d6:f111:290a:9842])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76739345b2sm1940581a12.17.2026.03.26.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 06:48:07 -0700 (PDT)
From: NonameBlank007 <nonameblank007@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	stable@vger.kernel.org,
	NonameBlank007 <nonameblank007@gmail.com>
Subject: [PATCH 1/1] ALSA: hda/realtek: add quirk for HP Victus 15-fb0xxx
Date: Thu, 26 Mar 2026 19:13:24 +0530
Message-ID: <20260326134409.15230-1-nonameblank007@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230468-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonameblank007@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CBCE3365B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds a mute led quirck for HP Victus 15-fb0xxx (103c:8a3d) model

- As it used 0x8(full bright)/0x7f(little dim) for mute led on and other values as 0ff (0x0, 0x4, ...)

- So, use ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT insted for safer approach

Cc: <stable@vger.kernel.org>
Signed-off-by: NonameBlank007 <nonameblank007@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index ab4b22fcb..7f3e88999 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6954,6 +6954,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a34, "HP Pavilion x360 2-in-1 Laptop 14-ek0xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8a3d, "HP Victus 15-fb0xxx (MB 8A3D)", ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0


