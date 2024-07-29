Return-Path: <stable+bounces-62564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310493F732
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A377B222B2
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EFA14EC55;
	Mon, 29 Jul 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cq8TufW6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC6148FE0
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261736; cv=none; b=sE17qAi/oIn9sDoRHcReYms3j4obsJiNq/ypOVcgdqAMTkjDQ6dYed0rD6anVLFVdGJm4diOk+qSeAHLku0VvvHZpBO6QyCUko0hKxDUkSHOiOUjwcvUWUhV8Z14e01v0eR7ChtO7wH55XfqbcV/zVMOy9jp2l3y4WMsrC8pgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261736; c=relaxed/simple;
	bh=55XENsnNCk84FLNa+lraTuZ6bEgW732leOZMMeH2J88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7OMiFUhCLyLihgCMwfT2GQAQoas0W5whSWQxm1E2clHPDbcCdX/LyWNRzx5KPDfmNsLI7cZ7whpQ8SeAB56CUJPBAW8hGE073pMfxbJiVxbR9y8cOled2PgTZYoT012mepQf+K23MBHK1Dc2SIkaNzOAXId5SosiVEHiIJ4N8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cq8TufW6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-369f68f63b1so1315640f8f.2
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722261733; x=1722866533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BmtHBomoMa6GjrD4GHzO5YGBhc3NcYaKKlfZd4lImTc=;
        b=Cq8TufW6HY6VjApUxJAiacfY6MGeHxS8O2nQSBlHxtSKCH54cfqxs9eSBmVhma5alY
         SBGQ1YBcsXZpDz4+nNmw2GqjxJa3SNZgtHJrJm70HSVw/HEiqbUOMX/OSRnhDhsOPogx
         DckvY8jSafUnmxCMLY1xAa1KuBMp//ndZgti5XJUuKqidDl4Jq1UXb0wuVKhYqWW5sC1
         /z/ufP8D9e5Y4Uq3d9toMLffcAHMAIZTxvFfBPPRrHiyrVURt4/jzjU3QGtDQeexVsrT
         gz/FopY20ksusRG+XzHdIJJ9syfTYQ5vh3jYb1aBkgOrlyxvsMAuHX5/0jm3PmKnzqg+
         7GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261733; x=1722866533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmtHBomoMa6GjrD4GHzO5YGBhc3NcYaKKlfZd4lImTc=;
        b=e5WxXUPeRCpiuIFzJV8XQPhASuRR48IELCdC/14CTwPDgj4xGLiZWVnAIrUfbLfrAv
         0gOSJoCI6CIJ6Z6YW8leZp5Eb3trDLL4OYrRf8qtB3wNXCNG03WHbenQVQlmxYOnfGJb
         HY5aOzimA2zQ2dKNw74QIhAJFBj3iJlVgIeBIV4l2z1HV+k1HpjJePPw4JbnabHBuluw
         4h43xn9a906I453wWqfZDQ0Yt4eVqdr711BovHzWJbdM4vRVW7srOACjjiSU2T0JlEJu
         Uyy+5dQ4YUpXGfkjd0LQ2LetmIS7tGuPiM9U2cT6dR8tLyMycleGMNZR1PkJLU9oYfy7
         r//A==
X-Forwarded-Encrypted: i=1; AJvYcCWw6SmhjMYkNNFnlRecNfUxB1qCE7qsQp5XZmGE43xSBLE8j0Mrjl1ovXcjcl6x2k5j0SbsEDE3IGj5hu4pSYMkJiYcngzT
X-Gm-Message-State: AOJu0Yy1uv1AcFbvd+QrYagE0d6rRuQZgHhx+tAf0rNwSPQdmCRkotRy
	kJJmC+dxlU9RPjru4uXL4nFOhJXKUzwUJTckQT6Hemk9VFugYZ4I+qXDEN0aWdU=
X-Google-Smtp-Source: AGHT+IGV0v4M42FoTYGpDxA/2lFq7kTxKgkZ753sgQBpfRFo1ZH43NSLN1QY9dJKGrzBR6PmH5CHCw==
X-Received: by 2002:adf:fa0f:0:b0:368:3717:10c7 with SMTP id ffacd0b85a97d-36b5cee324fmr4444568f8f.4.1722261721007;
        Mon, 29 Jul 2024 07:02:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b368709fdsm12283163f8f.116.2024.07.29.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:02:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Shreyas NC <shreyas.nc@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] soundwire: stream: fix programming slave ports for non-continous port maps
Date: Mon, 29 Jul 2024 16:01:57 +0200
Message-ID: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bitmasks in 'struct sdw_slave_prop' - 'source_ports' and
'sink_ports' - define which ports to program in
sdw_program_slave_port_params().  The masks are used to get the
appropriate data port properties ('struct sdw_get_slave_dpn_prop') from
an array.

Bitmasks can be non-continuous or can start from index different than 0,
thus when looking for matching port property for given port, we must
iterate over mask bits, not from 0 up to number of ports.

This fixes allocation and programming slave ports, when a source or sink
masks start from further index.

Fixes: f8101c74aa54 ("soundwire: Add Master and Slave port programming")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 7aa4900dcf31..f275143d7b18 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 					    unsigned int port_num)
 {
 	struct sdw_dpn_prop *dpn_prop;
-	u8 num_ports;
+	unsigned long mask;
 	int i;
 
 	if (direction == SDW_DATA_DIR_TX) {
-		num_ports = hweight32(slave->prop.source_ports);
+		mask = slave->prop.source_ports;
 		dpn_prop = slave->prop.src_dpn_prop;
 	} else {
-		num_ports = hweight32(slave->prop.sink_ports);
+		mask = slave->prop.sink_ports;
 		dpn_prop = slave->prop.sink_dpn_prop;
 	}
 
-	for (i = 0; i < num_ports; i++) {
+	for_each_set_bit(i, &mask, 32) {
 		if (dpn_prop[i].num == port_num)
 			return &dpn_prop[i];
 	}
-- 
2.43.0


