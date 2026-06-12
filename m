Return-Path: <stable+bounces-262950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qm/kGQU3LGpJNwQAu9opvQ
	(envelope-from <stable+bounces-262950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 18:42:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0867B068
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 18:42:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VRAxGSfu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262950-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262950-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 363F630453AD
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE835DA4C;
	Fri, 12 Jun 2026 16:41:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90C382F10
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 16:41:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282474; cv=none; b=Oo/67QCYov79pPc74sSjEsZidWuRAe0adbUgI2NDfmjoADR7Glpgx/9g3laKFyvnta5vcuQ2pwLMqa1YXa7IL3Z8RALltU2Jj972UvczlmqJj5oUGkRhIO/ZPhAxb7Cq3CtuNqiK0idm/r6SFRte9/SQiRvTsor4gRXM2x5Vdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282474; c=relaxed/simple;
	bh=1VuwjjnibSEynGJZTNdWptD7eGQ15aIWeYvxHAlFM28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L2ARpDnx2L3RBTzt7KVG3ol+dkAa0EiDESoVPm1o9KSge1zcio/Iz/YHTkzKveJC9lJiuAyN63I3IcuWEfGlRmQKmc4lZz9P6ctE3EDhoAPHTB84Ez2yoVRHWxe0GoJJA7te2YyP8d/QH8IUlbnuETRiqp49zWe+1cMxTwgFTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRAxGSfu; arc=none smtp.client-ip=209.85.208.177
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39661f81eacso12106641fa.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781282471; x=1781887271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TftuUnxE9Lrtjc/EIh1Zv1ggKOyOeIDF4rAIqHU2nvc=;
        b=VRAxGSfuFyE4HUE3PjB2mHPs4uQ2+afSylyv8sFBKs17Zt1hVcVeQNm0DxEnMRHo3p
         wInp+TzhU0Y7FA7dwyEG53PyOYa+buDWjs3XsT1/pgdy84PC/AR3BCmz5mEGK3abCO8X
         o+PxILmSit7cFjsqDOrzvyLDT+wV265wHCwl936PV4w1GthmHDO5smo8q5jf1WGT/qx9
         4mVbPDu4IWRxkzvwNpjC9M6oH509QQCdRMB6c3S+mZsglCiJIOgbE65D8K0pBUC5xCYg
         wJOlXJ766HRytD2zeOs+QL1bnBhbB/MoCsPgu/RfduMDQq86wLwWpYOVRl7OnQmWpqu/
         dtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781282471; x=1781887271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TftuUnxE9Lrtjc/EIh1Zv1ggKOyOeIDF4rAIqHU2nvc=;
        b=OTGNaRETAPKeZd/GqY/JtzuJMfmnCYWTPL7TKmkZEJE4o4C8FdxMC2o1I3YT3BDV3b
         Qxtih2+AbRcXE8zYSDcQFo2ZkPXsTQGK143yUStlrjI3Y1OFzeIU1a5BVrfxPiI6BaD/
         NZ840AGVKbu8V2GgSQm/P0JjEHn2UtNFrXwZ8uwYkb/rE2z6ro50gL5IgDt4Y4YaeY07
         3zPfnzNeG7LLGRAVrzE5zmr1elNaGeOIzyG7p28hUwJFSPlQGVadXJRFk2jJ5819bRy2
         UXkcEi+q+vsZYd/y+UX7L4U/cjjpk7iV9EigEIEDb0lW9BSEUN1uTsUshIKPBuT2yeYt
         +fsg==
X-Forwarded-Encrypted: i=1; AFNElJ8uMfdFAKfgbVQlEi1JBTS+YcskMEp4WmRa+yCq1YqItNma+ovCynXfBAwW/qHk9se0m0xXlbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEV6vbhnG+yfWyChxnjC5g9wm5ugJwJ9rS3wYPrrOfmtfgfRfQ
	mm86S4wgo2yYti8nXyCHLTmuolGwoQAxx9MCM2tXJ5SgnQWudJhQfRk5
X-Gm-Gg: Acq92OHHprOB2cuy3ul8O/9ZZjXs0S87tJeNn5vKEuAi+mNXDbPcvdRRY95+aJ9znvj
	NIjIUHfKwQejL2bpNyt24ZZ1bdPziHdAr/auIA+o3cGW5GbWAxEgGumiUsF8ECUfuI/KW15NQC+
	2nIXBDXJsi9gTlf5E1uJydk8gNVrtbtI9xEDsnhrxKrFJDSoTH2WFyVPVBG8JI7c8sM1pmo/oIg
	hJda13ryq/D9/6b2nzGIe9no9tq3KulFySifaNByAgqcRbajnXxH+zgSiFSKE4/XbfCwSDFrBZc
	HceXIdBJ6VbDt5i7Ke6wlWsE1et0pE1Bm9lSJ2S6DhvBlfsZCOjtgLoIAgOkIFZNGw+PtBRnfpf
	Q/sDAWQdg/4kJelyv3UzOM5PCQnmjJHDTMOoKOZQNAvwfl2P8urS4MBzWNs7NAB0Kt4h887zTyH
	5C6mYR4ejwL+Zdm8auBdfHvdjzzju2MNJKlfYYSX9A2ovKsEzllxvXg15BNpuHKg2fmsm5h3I=
X-Received: by 2002:a05:651c:1473:b0:38e:8357:c5ae with SMTP id 38308e7fff4ca-3992bdb782fmr8104031fa.9.1781282466664;
        Fri, 12 Jun 2026 09:41:06 -0700 (PDT)
Received: from maverickamd.dyn.int.numascale.com (fwa5e61-57.bb.online.no. [88.94.97.57])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-39929f18210sm7484111fa.22.2026.06.12.09.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:41:05 -0700 (PDT)
From: Steffen Persvold <spersvold@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Steffen Persvold <spersvold@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode
Date: Fri, 12 Jun 2026 18:40:41 +0200
Message-Id: <20260612164041.3652599-1-spersvold@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[spersvold@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262950-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:deller@gmx.de,m:simona@ffwll.ch,m:linux-fbdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:spersvold@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spersvold@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDD0867B068

The 1920x1080@60 modedb entry has one too many initializers before
its sync field: a stray "0" occupies the sync slot, which shifts the
remaining values by one field. The entry therefore decodes as
sync = 0, vmode = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT (0x3,
i.e. FB_VMODE_INTERLACED | FB_VMODE_DOUBLE), and flag =
FB_VMODE_NONINTERLACED, instead of the intended sync = positive H/V,
vmode = non-interlaced.

fb_find_mode() then returns a 1920x1080 mode flagged as interlaced +
doublescan with active-low syncs. Drivers that honour var->vmode and
var->sync when programming display timing enable doublescan and the
wrong sync polarity, corrupting the output.

Drop the stray initializer so sync and vmode hold their intended
values (positive H/V sync, non-interlaced), matching the adjacent
1920x1200 entry.

Fixes: c8902258b2b8 ("fbdev: modedb: Add 1920x1080 at 60 Hz video mode")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Persvold <spersvold@gmail.com>
---
 drivers/video/fbdev/core/modedb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 7196b055..333b3d9a 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -258,7 +258,7 @@ static const struct fb_videomode modedb[] = {
 		FB_VMODE_DOUBLE },
 
 	/* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
-	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5, 0,
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 		FB_VMODE_NONINTERLACED },
 
-- 
2.40.1


