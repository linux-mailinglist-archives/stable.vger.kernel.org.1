Return-Path: <stable+bounces-121532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E809A57841
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 05:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520393B446F
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 04:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461DD15B102;
	Sat,  8 Mar 2025 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c043zgwn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13072CAB;
	Sat,  8 Mar 2025 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741407247; cv=none; b=dz4aQjkU6QWn17MPbvA5cteo5b0cPmhbOdi9ceQFgPlQQx9wrHK7bXOvcehW4cf9qJpq5EulAqOP6/fYVP5SViIYJ2Ng/PceWo8IFdDrAaZumBTfl/D3m+G+VcO0/bwsobDmuqGSMA1iYjQv2WbYPtabzc1N+qKP52ZIU/7e+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741407247; c=relaxed/simple;
	bh=DqtFNKP9MUEj9WZLATG65iYc6B7K9fovf6GYZcFZh+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HD0KV6ssG4Z1b8+pM9eDCwwUnkFEcoRgAW7RamKB7CWYeMSvtFMyxewKdhbMDZ03LxR0Ug19r7TPMXs/v4lJP/xLqu2kMNEsmaQ+k0FpohK8/R1dyQ1PHBUwxuvnEbu3CbrhRuD37OFSzJEx41L8PEatZTBRWbwm78kk7Yr+w7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c043zgwn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso4494098a91.0;
        Fri, 07 Mar 2025 20:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741407245; x=1742012045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3INYmLaQOuwy6XzMyvhLucYfMGdX+9XqD8iYHVj5pcI=;
        b=c043zgwneWaHO9lsobbOLjQ/XhiM/M7uynA3uhVrGOEcM1007LiTMcW40lNox/py7O
         Tx/UxcN3++4rSLzbpQwv0P4aR/UoEFViFgdERzKG8xhqBXUsc7IwiCS/zjwz5KOA6C6G
         RRem4vX9X8DtT8wWDdD0bdl+i/MlSYcFVPnoPTfdFuLk+UiWqqWyywixRWjZ2qc5zbMu
         Zysx7Brax0qWGAlKKaH3DoHPnxTaOLuZC0NiqXSJHiZxAODf+v7+aAy4R8sG52AsUeB9
         MRwFCrFuMKqhog1dP105NmOhhWSE49h6Ygan7DAFZSHss6E6P/l+JVxkelIUV8SLyoPG
         UeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741407245; x=1742012045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3INYmLaQOuwy6XzMyvhLucYfMGdX+9XqD8iYHVj5pcI=;
        b=XDAI8C/6y2ks7aAJWhnNtGngWwrV/dUZndS3UkgUODieOZyX3VkW8/koeF2DNdt1L8
         HMdYT68CQH9dciMKrcPdQahDZRQ9VXex0FDbfkQrDqcT01V00wBJLEspSFCW1JI077U9
         bpAleu2AJU4vpKwnQAELiEV6pXzItra9ZCBURIgpz4xs04ewj6KLHsS1ZvTASvkT6iqH
         8KK0O26ym+Tl4HWpzxQBmGgS0fa21A0zoggxeKtCl6q3zwZ835g2UpzqR94lyPhFvYTK
         Oij4vXoTTFl7h67xDMsW3RdWk4egIpnUYXp0JZGJGJzOlvh3Rl9Uqr7Dxxxj+XgZmaYe
         jFSw==
X-Forwarded-Encrypted: i=1; AJvYcCXu3mbQoG729ygpGlsPbbxqK4VqAtES9Q5LcMvilKGbwlCI5K666R/08FmbnTOig2x0WxGslV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdSrdbnK87bijxKBRtkFXRBWgSWUZ599sJP4m+GBCpxGjTLqM
	B6NmJnxMK3dSXzRfOcI0RmT0ijltQS6BOaYwpZlhcTMFDeZoauEVwN48gKp/
X-Gm-Gg: ASbGnctrQoweqgfnnnmXhFXX0y0XGRnGD+r+SMapYxX2P6jymfYNFhnhHxlsLe5MKdw
	03OHh7WESv5Ai7MC5a0TpXZN45ilij6COhwoV4NJfPAzfow88e0gtCIXE2P9u4fJx+kNy932RVe
	whdMMOB2lRHyRnmjWCU1Up786SfBpIThyJ190UpjoYXhfdnYSM0MTbNNKZ3ohLIJtEnQY94X/sd
	37AQIrvV9dWUf6z3Le05k5My8Ep59Ot/ElNxn50uZy1n4YOe9mvu8ghLg13EbRAqWZH2im2ieTF
	Y1yt/nTu0LV3wih93xavldxxQn8HpmgvgVj56wM8hcTOHynBzZKFkKXPvfSaWvInFw7TWDoe0S3
	EHIkhT0hEeoTIn3rGdRjp
X-Google-Smtp-Source: AGHT+IFJfVkQfXrwaaOZOFpjOdt127kisOCsit/c9oQIMt1ghlNUdekIEzZ3n9aysSiPZnKUkNPj6g==
X-Received: by 2002:a17:90a:d404:b0:2fa:562c:c1cf with SMTP id 98e67ed59e1d1-2ffbc1474a2mr3236143a91.1.1741407244789;
        Fri, 07 Mar 2025 20:14:04 -0800 (PST)
Received: from localhost.localdomain (host251.190-30-223.telecom.net.ar. [190.30.223.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e7fb5sm4354916a91.37.2025.03.07.20.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 20:14:04 -0800 (PST)
From: Thomas Mizrahi <thomasmizra@gmail.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	mario.limonciello@amd.com,
	Thomas Mizrahi <thomasmizra@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Support mic on another Lenovo ThinkPad E16 Gen 2 model
Date: Sat,  8 Mar 2025 01:06:28 -0300
Message-ID: <20250308041303.198765-1-thomasmizra@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal microphone on the Lenovo ThinkPad E16 model requires a
quirk entry to work properly. This was fixed in a previous patch (linked
below), but depending on the specific variant of the model, the product
name may be "21M5" or "21M6".

The following patch fixed this issue for the 21M5 variant:
  https://lore.kernel.org/all/20240725065442.9293-1-tiwai@suse.de/

This patch adds support for the microphone on the 21M6 variant.

Link: https://github.com/ramaureirac/thinkpad-e14-linux/issues/31
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Mizrahi <thomasmizra@gmail.com>
---
I recently acquired a ThinkPad E16 Gen 2 AMD and could not get the internal
microphone working. After some research, I discovered this issue. Since my
machine is a 21M6 variant, the required quirk was not applied by the
existing patch. After applying this patch and testing on my machine, the
microphone was immediately recognized and worked without further issues.

 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b16587d8f97a..a7637056972a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21M5"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M6"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.48.1


