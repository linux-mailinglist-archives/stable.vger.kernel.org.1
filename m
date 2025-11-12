Return-Path: <stable+bounces-194633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5BC53E93
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 19:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8237A4E9F3E
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2634B414;
	Wed, 12 Nov 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar64TOml"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80A34B42C
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971556; cv=none; b=HXnk0iGS5ZxKIGkftUVtxMMtDINzDE+sCXWE7jZYDoJsxFZ0Q0xwwZLq7/VKcXzF6IT2tGdRNloMNncDXWZ6j+42PkpC2SC5T5dGbQ0CNb9x4qqynoCkQzSke1v2Qi8YL5Y6HNNidaZx6srJvYTKXHacWazQcqJzuJV0NMj5+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971556; c=relaxed/simple;
	bh=JSk2wiQKBahdJ8dYGksFv11VvJ1NPd2DXSatLhgaWEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJop/8Hpm/vm8E6d7ibiI2ROddp0N+NoQkCKkA0wQ8LPebS/vNZODe8lZL3SN2JaPy6iZoblLNw5DOMotQEOijhemOl+HjRhUYNc+b7Hg1jkoNXvSFqZSJpOdeNMha3bjiRX1E+rJwIK/qsn5pxTOi52C02oC/DbO1w5CYcrrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar64TOml; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-782e93932ffso1058146b3a.3
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762971554; x=1763576354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajL3qyJYFc6tD7lnGfH4M98Ye8+T06Aj5rRcRA12Okk=;
        b=Ar64TOmlxe3N161cZTBVfb/dIqX1VLovG5y6PwyGIPc2VMxhhcM+Gj7EAubKCkIpGN
         Fktk6wYT9DWPnzsYTrOoDCDAXoOgle6N583gZmaELsF/ifk8dI2YrwoccXb5f2yOmmIa
         Jz6QYNA8wx+hEvHER/Yey2e7TbLKBsAHuRr2G2o7jCzYSCjuQ7b/jq8owxs2nfEMuy9U
         IeX2v0wQrbU7gcBdDUMF9IzRitozq1Fy2Quu34FNEarVMSFyTuMRYA2RcLApmey0jDmP
         +OEQ8d2FwLumogpVUO/8IBqS6kLyNrE1eudUPMrSrTLPUP2nNLjN/v1gShWSp7zztx7j
         jMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971554; x=1763576354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajL3qyJYFc6tD7lnGfH4M98Ye8+T06Aj5rRcRA12Okk=;
        b=jYnl2s1grLFJGkLawhqc09Bb0S/yX+9BMfSWUUOzHyYRrLd+revIlTLjLiByzWrr9f
         uUajFplg6bxpCSqkqJ+DvKkeKBd5kwjAEBqZF1lvvrWLTIYwG1ull4XTVfiIuUuFE/U5
         vs+Ish9N6Bo9CHCF2OV4CmiwhHc4K4fQqx77HZyBxATTWjPH+IIAuJLBZJTz+bRWK4cG
         HVJ0Ia5qKDxuJKf1xvNfS1sw6A9buNzFnul9XlWzC6ANGRl7prx8zkCppDnUBCzMlx9Q
         Jqh8uHS6LXTVh7qpPlRouytyXalvdGf96ZvbnIrLreSleQTHLW3KaTtG5cP89aFhrR6g
         iw+g==
X-Forwarded-Encrypted: i=1; AJvYcCWnOD/gRQxaLWPSnNAs1q9DuxB9/Eu7XDwkREIBEcrRmhe9chEiFISJ4dNhDc6FmqRCBQcjsPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnmrc6lB+6qeeWYgTDNIRtI2dt0qFCR4pzfb4PDgPqWVtAcOU
	rzlkGhyXw4Fl5OoRV3OzFVEnd6fdSsT9ygPpdJt7Ni/uJEXzTIbcK6cYuBAyucs2ul0=
X-Gm-Gg: ASbGncvaRi4YuliJbqqcYdVQx+GROzHxzkkZJG/zv10vMWiwZt0POVrDZTz1klgnoor
	yKtucovIjVc+UN36N5+KVMrXaG3JIzN4qYHu62HxwulM2JLVbxaAEJVNtQnBoU2XbCKdfTpnooI
	misH8GRrOG5Q6EiQpJ0h3Ds9G0Qqk1BcRQdXd9isaM1SIq6VIWUqvBd1m7NDdh76ipzmLuYKqPw
	tZygyGU/IbmMRrDqQMY8mxwhHUnNsRl4AfgtgMETq0lLPV6Z16IDPMx3EFXDu4pcakZAlkUd7YV
	N2RJ8KwIn/4+3u/eNe5f7FxP+jSZWtUoy+YMI4HuxAA1zjXM0rDgZ7nrX73uZOdJLUyGtYIIYRs
	q4mEolUDOx3bnHzH7v4Fwtp8UdE62Y1okQWFXuShE1Od0smNmIgZwXer6Eij376uFFQO76zNUYS
	nRSK8Ihb5KTEps1wMw
X-Google-Smtp-Source: AGHT+IHlsgCrOCxbH1xUwfriUBHh5Wzt3eZZ8m1hSbR+IpGy4PwSajaGLSMmb7HAExzbcjFaVH+8vA==
X-Received: by 2002:a17:903:28c:b0:27e:f018:d2fb with SMTP id d9443c01a7336-2984ed2b896mr48147475ad.6.1762971554462;
        Wed, 12 Nov 2025 10:19:14 -0800 (PST)
Received: from gmail.com ([157.50.185.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9f8f1sm37051095ad.54.2025.11.12.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:19:13 -0800 (PST)
From: hariconscious@gmail.com
To: cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	sakari.ailus@linux.intel.com,
	khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH v2] ASoC: Intel: avs: Fix potential buffer overflow by snprintf()
Date: Wed, 12 Nov 2025 23:48:51 +0530
Message-ID: <20251112181851.13450-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

snprintf() returns the would-be-filled size when the string overflows
the given buffer size, hence using this value may result in a buffer
overflow (although it's unrealistic).

This patch replaces it with a safer version, scnprintf() for papering
over such a potential issue.
Link: https://github.com/KSPP/linux/issues/105
'Fixes: 5a565ba23abe ("ASoC: Intel: avs: Probing and firmware tracing
over debugfs")'

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
Thank you for the feedback and the suggestions.
Corrected the indentation & commit message.
V1:
https://lore.kernel.org/all/20251112120235.54328-2-hariconscious@gmail.com/
 sound/soc/intel/avs/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
index 3534de46f9e4..cdb82392b9ee 100644
--- a/sound/soc/intel/avs/debugfs.c
+++ b/sound/soc/intel/avs/debugfs.c
@@ -119,9 +119,9 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
 	}
 
 	for (i = 0; i < num_desc; i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len,
-			       "Id: %#010x  Purpose: %d  Node id: %#x\n",
-			       desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
+		ret = scnprintf(buf + len, PAGE_SIZE - len,
+					"Id: %#010x  Purpose: %d  Node id: %#x\n",
+					desc[i].id.value, desc[i].purpose, desc[i].node_id.val);
 		if (ret < 0)
 			goto free_desc;
 		len += ret;

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0


