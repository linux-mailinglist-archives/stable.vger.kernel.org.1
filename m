Return-Path: <stable+bounces-75979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B69766DD
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4091C22E4A
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A02190482;
	Thu, 12 Sep 2024 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFPZnych"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDF15D5D9
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137998; cv=none; b=O5vdISFJCTSCH2ZDSbyDrATGh7qO1cOYe0Kjw7/odTxBvUcEDO8GhIIh1LniFOgOvcJ8VmnLL5NuEGo6c7Q9SwxUpfsEb/rr5khU3vtvTX8KS8jYtt8jo96X81lXRjDk7ejOezDA3x+YZKnT7kWh9UO+bQ+dDm7fNLgjXUZQiKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137998; c=relaxed/simple;
	bh=WO8gkkgWXybRtxCWF5HutQJX9bK21wpal+uxu9KD3YI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g++Sc+K6NBpeVNDV3aNfcd5OhFU9JdYYNZC1vxrPkRV9NB73pgdTHuso3uYp31ltQXWXzYuGKhD4/Ys481KxNGvesNe4LY7V5s6RR4Kd3TzKgNWOse8reB2JGHBxBEL3MZqLa7Qmo6Na/q5wogi4y2qpkCgaxZJjJv66wMNHbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFPZnych; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-374c294d841so657571f8f.1
        for <stable@vger.kernel.org>; Thu, 12 Sep 2024 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726137995; x=1726742795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s4vDbSmUq4BkHSfWXq0yaMWGfTgb44jekAkFpPtGTCU=;
        b=GFPZnychdDLwYUWERm8j/ixvq52nDh5EUH0yeeOOqlPpZBMd7EjGjIz8DsvJ0NnAtS
         utkO2I6Gcj5eOpRDje5MUV/07+F8KtIVfjX/+QihnTpOiiW2STpwwen4/lTlyQqOYKK5
         FGh0RI10I10y7HZDWK5NuA2T+/S9L7V7jLjDtNgs66qj4LydeyT89JI9DkS1H4Bjjvdc
         PDj8GFP1Qgc6xI8lDgdm0kf7hUVfFm9S0p8RO6paERyCw4HgCnGTi/PWXkdLQjNK+P7Q
         waLkQc2WAamAwBA9ULQMFSARq38ET5vs2i8jePtaaB2pt/9dMMBIPqVNlBonW5XwkKb4
         xB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726137995; x=1726742795;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4vDbSmUq4BkHSfWXq0yaMWGfTgb44jekAkFpPtGTCU=;
        b=ZB88X1EK45QSbeOyRWxQJEzxrfTJyIHT+niCIrTRTihjTXry2FoZ6AfRfHp3V6Bpx5
         5p8BMo6aRLkvoYsfFOAZQwfpdELJlDBjnPe2df/pQXllHkD9OvK00BjwxK9v8EfWng3e
         OPk4TYRz7XTu/RPuOGRpTXRJ5ERSHdioJcQg7bWzJP4+QiHEX/CFSLTBOfFV6bkeA9+X
         fuS3mCF08izxXmB3Vvf14Upg4oVuqq22allRX6kOLy+gDErA/JQ+a+gzV7Bm2uMv0kZq
         OTSnn43a8kn6KcJIeys/gM846RPrt3jJ70K8HuDVDvFR2RBaBCrRyOMifeEKsJ8IznGK
         Cddg==
X-Forwarded-Encrypted: i=1; AJvYcCULceUFt0ps5WiIvHfIZ2h5d22RDl1rhnOxpmFFiE9mlPggiumcp/fs1hFG4TdsOZSib35ZQH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQn5Hh8zRhuPqz5tMUAb4t74smdBrLQaevmzRgqij2ASCDY+T
	e9cqZuBd8UJi6LxTLJDIzqxBP/1x45tjP9I9nhqA8uElpZmCJ1vs4YjhdT1F2yGQbN8l1w==
X-Google-Smtp-Source: AGHT+IEbQiXno9L7v1wd6SJNAajDejL+LmtDZTYHoM9M52NO8OCOAW0BceeQ8XEEnkiC75ijxU58K4Vj
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5d:6083:0:b0:374:c563:c2ed with SMTP id
 ffacd0b85a97d-378c2d00110mr2913f8f.5.1726137994973; Thu, 12 Sep 2024 03:46:34
 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:46:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=ardb@kernel.org;
 h=from:subject; bh=eAYbRaFGiFbTpDXwm1BvK/t4IwnqUkhxsfQgcCU+BjI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe3RsfagSfaO89w/suVM5zrI3WF8I+/nu+zEnT8eH2Vbv
 FP+S/WvjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRnCSGPzzyOx+Lpzd8fdB4
 3PbSugv7w/f+KVtXHriJcW6ssRvLcl6G3yybJHiftv198NZy+juDewqi8j4elWq/tCUv8JfttLn 6mA0A
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912104630.1868285-2-ardb+git@google.com>
Subject: [PATCH] i2c/synquacer: Deal with optional PCLK correctly
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-i2c@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	Andi Shyti <andi.shyti@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

ACPI boot does not provide clocks and regulators, but instead, provides
the PCLK rate directly, and enables the clock in firmware. So deal
gracefully with this.

Fixes: 55750148e559 ("i2c: synquacer: Fix an error handling path in synquacer_i2c_probe()")
Cc: <stable@vger.kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
https://lore.kernel.org/all/CAMj1kXFH+zB_YuUS+vaEpguhuVGLYbQw55VNDCxnBfSPe6b-nw@mail.gmail.com/T/#u

 drivers/i2c/busses/i2c-synquacer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index 4eccbcd0fbfc..bbb9062669e4 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -550,12 +550,13 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "socionext,pclk-rate",
 				 &i2c->pclkrate);
 
-	pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(pclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
 				     "failed to get and enable clock\n");
 
-	i2c->pclkrate = clk_get_rate(pclk);
+	if (pclk)
+		i2c->pclkrate = clk_get_rate(pclk);
 
 	if (i2c->pclkrate < SYNQUACER_I2C_MIN_CLK_RATE ||
 	    i2c->pclkrate > SYNQUACER_I2C_MAX_CLK_RATE)
-- 
2.46.0.662.g92d0881bb0-goog


