Return-Path: <stable+bounces-71489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529109645AF
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AA41F26975
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED8196DA4;
	Thu, 29 Aug 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCgN30MP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C718E021;
	Thu, 29 Aug 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936612; cv=none; b=gfnHOB0PS1GgLOTwrVz40RpSTGlCPmBIVQSjwLuk/Q3YhGQkcU9sHqFnVjrWoIKQpDM7FtLTL98jGdwhGQMk9DH70UlAY8I8958xuzI4KwEhL+j7Vc4Hi1/4KMKsmq96/K3qaiC/q6NqNutQ+7zMwflrZmR37zTkr4fEZwKSn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936612; c=relaxed/simple;
	bh=pT/Nr2LEpLWEte2xGTNcDDsEdzK4AB7B8Xq0L5zdctk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3PkLax+lPW69+/gE9Bsg1E85DxBZwxzIj/d1yjoHyvqpShVWq51b0I5bwAGjW39c/mnSsqMTsAbJ2aFBE8s0WYC0VHStRf198l2l1J3XCIgwtN6dDrlCkzr+a8aAtSe2JBQevhYrf7ekcQjnfwvYJp1a+t+tUJl25ETSgbFoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCgN30MP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so6982041fa.0;
        Thu, 29 Aug 2024 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724936608; x=1725541408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rUD53qfpmrM6jiWmiR8uEuUiqnr6GPXvbq7APdhH4Zo=;
        b=nCgN30MPZbuVKOpSc52RgT49ltTGQAYvfbqo+Nh1X9NxfNMvTNh2Ax6hKwI0qyD5k9
         7cPhDyQ8LLBfAvw4LYwGOi/0cn++now5vNFhKAVHntYsqPHAUusMCTjEvSy4T2aAcE2W
         Q6Cjdi81k9OHsKg4kaU/ZCIjocPYIHNQD21h05WQx5fM8pWkvxXa2Px7mfj6bezkOJBd
         mkD1lZfdjiFZHNjiTDXhqnRQ+heVRq7tN+XSZj3+c+d3ApT+B8ZHo4FgqA7cOeN7vXHD
         GsXlWDky5tHnCrkHv7h9u8Xr1GZRFDTJqhUqZkOEReLOZecLcGChmQg/U8STqhhYxgHe
         JRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724936608; x=1725541408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUD53qfpmrM6jiWmiR8uEuUiqnr6GPXvbq7APdhH4Zo=;
        b=pgKzjwVzNm3Wpv/bajLJU9Sup33ruVpTYgz3pqAK52fwjriNfFm0c6XBorDKKfEVCV
         1lXl/MQafI08Zd8Yu7U29ImmjTXO2ongOA/PZmWD2GHAGJlbc6UKtnwkJlt7bTWMdyQY
         C9yktV6scp2wbQyIlsw6saLbip+fchD214SyuY7qto4pIJYzvp2cToQhwW8JYsjP1k7q
         qGoJE2CRq+KU/XcCCF6/rCoa6WpSzKQtvSdHbTgJEF3sL8dNafWsYdv7S/QwvN11ZS1f
         X9WmiKI/7mfCBVoPyDuZjJhEe7/RWKKFyplmoq+yHSrqwC1ETezFbLEnjHmOqoHUjc5r
         aqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMTWdbI9oHhX84Af+JtQciD4kMiGo/fejOWNSE1bqnnA4M6eO/sa97WKv/yqfQeVGekDSGyYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRPaDiQTWL3PPgr8cszj7j/OQZ+rhrt6/ps01CGdlnDCfLTX+
	/+vxcG6R79cRdpUnrleiHXF/XvV9HWAZL3gxnt0JFsnUc+8G7Jeg
X-Google-Smtp-Source: AGHT+IHTrWI8GzNChrPOKcPGGXKN4I/vIEZWHXVZhlHcNNi0n37jmLDKAP3pA8vYcCemGLLsHb9qIw==
X-Received: by 2002:a2e:bc1f:0:b0:2f2:b2f7:c8a3 with SMTP id 38308e7fff4ca-2f610527cc9mr21512971fa.44.1724936607169;
        Thu, 29 Aug 2024 06:03:27 -0700 (PDT)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615171e3dsm1717611fa.86.2024.08.29.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:03:26 -0700 (PDT)
From: Markuss Broks <markuss.broks@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org,
	markuss.broks@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)
Date: Thu, 29 Aug 2024 16:03:05 +0300
Message-ID: <20240829130313.338508-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSI Bravo 17 (D7VEK), like other laptops from the family,
has broken ACPI tables and needs a quirk for internal mic
to work.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0523c16305db..843abc378b28 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -353,6 +353,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7VF"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 17 D7VEK"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.46.0


