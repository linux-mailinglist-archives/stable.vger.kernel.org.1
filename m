Return-Path: <stable+bounces-222880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBUCLLDhpmkPYQAAu9opvQ
	(envelope-from <stable+bounces-222880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:27:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF61F02E6
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D28B8303353A
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD733FE06;
	Tue,  3 Mar 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcsUIroh"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC133F5AA
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544121; cv=none; b=VvISSO3tWlcQ6myjU4pcX7qxqU99ir3vdl7OR0+2Kszs7GgE6azsemGVm3B/xH4A2y84fedUuQQc2S7Nzll0mvYwxbOOzNoRtgdPMfwjA5tX7EAlTjrBPY3V7B8FCz9Tph+zaImZv1NXJIrZqihotf9uUiTzyGPCc9EuOivbL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544121; c=relaxed/simple;
	bh=8HV852kkCrLJJqm5lXdcFWJSQ384uj2qm9kSfvfSljU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jRlMVQY+5TOmEiSMT6PZmyURk18uv34/Qz2XioimUOV9InNYNZqSIBnCk0ueb+HcGbuCAnTBcj8M/Ubl2YgJGYjbjBD8oaJPpM/LHSkxYFkGeZqd7sQKP9ZlfVeJv99E5cumvBSB4D3PUcGaDQmxZ+IQvuAgcN4fRgVOO1Y+dDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcsUIroh; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ff1703cb9eso1435495137.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772544119; x=1773148919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ox2lIBigJxBhDAzWF1GGFhbADrcYbkRqSJFVIngTPE=;
        b=GcsUIrohR/3NZLYVqhuVgFtYg0YN8rRQb/93+LKyKZrsL9gg1a4czG2D3uarwKo48Z
         8dA8/GaJsaF9NzJnpSQs5XfkMQ1pO4wd1sCETzO1ujl6Kl7lou7rGSIx5vOhVU89Z/2C
         7aqRzr07MjYkPFnKKWQm/5C8XMzf6sAKLAoGf5GBumsUhEk78hgexGXO0qIdq5gVkUyE
         UziyRRikbF3f3T9D989DrbRuHcZ1by8rOZqWnvveOgFJCE2K6QVl3wTksjrfbpFtHOv3
         PPA2F4yroVJ58S8vDndMLxi17TUoKbW6hD5kFs/LskhV+r43GbwKSDY8pjzokwWDygWM
         Es1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544119; x=1773148919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ox2lIBigJxBhDAzWF1GGFhbADrcYbkRqSJFVIngTPE=;
        b=XtmRdvUWl9nccm748z5it2tuEAjO9vt6gIBUxatvhjpqls9HHTwUQ8IU2v700qM9Hq
         /RGF+1ikXTNudgc4JWi5OpRT6eBcaHTO5kIUdTrnjJ7de1xQyqbQcrc6K/ilcd52021x
         jI2JjvzBi0H2M+NYfI3N4We+L/T0OBrBYK3VseN3MpxvUYSxGqMLZs+UAupbfMFt08oZ
         vOh+GT57wsPVgT/9VF2od4m+7c3/FbgnyXTdCSTy6ETM6Vcz83PIfRzfMaWwjmZfHHxV
         fZxPZQp+C5PUxFI9kMVkn8QeLqQgZdKAjMfHsI1VGeAK3QqshrwbDwkguCSk2uFHoLsq
         2U3g==
X-Gm-Message-State: AOJu0YwZwJ7xIbZs2FBtaiTFYIp7/Ze+QlB4gfGmEzm2hQ7OdGLAstr6
	0eBjZOSKnTDhPO97ccmGON33dM/RRot/M+2mM67mg0KszLxz5bL8xgq+GyGK0g==
X-Gm-Gg: ATEYQzzcfB3BzJibXmWgtaJ7g0HcOajOb/beaT3krRwm/qa3hSwHoqVwijVAyw4Zz5r
	gqJS1szlryISd9XEbBuDdIU8znqLEAjZ08I1xXo4h5g4rH7C7Bz6cqWqTrt8PbU8PgQZ+xw1Uso
	4Dg26hNYdwjaO5InDcqnz9njH0Ucl5ULIjT7klCm+G+UvdyeNrAKxkKs5AwHBa6gBXEy6lcTwMd
	f6JYAuE/hArSUsfpBb7UdiFEpaqptWFWI3o5f1jh8r6w34jt4jxiGNp6jj9Uf8ZVmJcsmbabw6M
	eyUDq8uLtQkdoSSHo5MYglS8hnjPCIz8KyiCnEI/vgQ06dssaaAHGqB0JaUsP8qdPf1pLp0ubMT
	UJnM71SnRWs9tVgK6s+ZxN0CPE9/9edAURVrdcF1stPwr+bTNLFj/gL2nPYnmo2yHf4zUAfCZw8
	aZBlk4Bs522NJJMqOB30qbJRM42X3FpnfiGDwkN/FuJp2lOtj6NBDfGmhlcKAUqJrrtAOeTslnu
	pnToR0=
X-Received: by 2002:a05:6102:3ed6:b0:5fd:fa29:ae15 with SMTP id ada2fe7eead31-5ff3233258bmr5395968137.9.1772544118714;
        Tue, 03 Mar 2026 05:21:58 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:1b3:a802:8875:499e:12bf:3287:5753])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea6ea19sm16593553137.12.2026.03.03.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:21:58 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	alexander.stein@ew.tq-group.com,
	linux-sound@vger.kernel.org
Subject: ASoC: fsl_xcvr: provide regmap names
Date: Tue,  3 Mar 2026 10:21:42 -0300
Message-Id: <20260303132143.766078-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BEF61F02E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222880-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,tq-group.com:email]
X-Rspamd-Action: no action

From: Alexander Stein <alexander.stein@ew.tq-group.com>

This driver uses multiple regmaps, which will causes name conflicts
in debugfs like:
  debugfs: '30cc0000.xcvr' already exists in 'regmap'
Fix this by adding a name for the non-core regmap configurations.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://patch.msgid.link/20251216084931.553328-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_xcvr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 06434b2c9a0fb0..a268fb81a2f868 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1323,6 +1323,7 @@ static const struct reg_default fsl_xcvr_phy_reg_defaults[] = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_phy_cfg = {
+	.name = "phy",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1335,6 +1336,7 @@ static const struct regmap_config fsl_xcvr_regmap_phy_cfg = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_pllv0_cfg = {
+	.name = "pllv0",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1345,6 +1347,7 @@ static const struct regmap_config fsl_xcvr_regmap_pllv0_cfg = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_pllv1_cfg = {
+	.name = "pllv1",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
-- 
cgit 1.2.3-korg

