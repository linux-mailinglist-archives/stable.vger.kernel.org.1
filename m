Return-Path: <stable+bounces-74060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036F971F80
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F442839BC
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268A13B58B;
	Mon,  9 Sep 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5XfhB23"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BE1758F
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900473; cv=none; b=PbF3oXQJBl7HOc7SJxe869+G8F35ZvnpmpGSrJ0rpOkh0O07GwPk3SeXVu8L59b+Df3ETsve1nJV5U7+Preew/yUCOqhCzlqVj7900Tm4bGlnXHmG0EINaNueagS30NOXwnr/aDypM5XrBvkZ/IgXftEsXLlbu6zvjtoYXw4KJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900473; c=relaxed/simple;
	bh=gvrrOqdVgjpm5u/np2uh2v/a16iqFEZtpyJE9eQIzfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4PXfo2/JcZM0Nf02TiJF4xegN08eosfH/st56ptwoupzldZ0RgPEbb15kXXBTdpQgauFoJPvinPC5JFZUjATq0gIPbuGpjxxVh4Tqfd+7uktdCq+eCKgJUVt1r0FIExAf3y4cQJcmcPSvOlydMbddy+bEpWtprtRsOAwo0niLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A5XfhB23; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbadbefe1so930395e9.0
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725900470; x=1726505270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9K+ClSg80/aj3+WNRq1JEXBhsSt9yh+XEQ9PiBAm4KU=;
        b=A5XfhB23WV28hfbGGAYdknK5K6owq01QyrQ13onTLyoXBxoFJrhH7YR13yDuse1Mwi
         6DmxioQ1lzCJMj548Cqh4gTpHI1xX0vYGkadrEhhtxBWczxv/aHQWjgYPrpTWDgsvYxa
         KtTf4CvZBAZ0hjw3Dtwy+JpMcusPI+svEUO3Xik1jvWv0o3CSPcvT02jzGC4EFZhTqnF
         IuxGUKpdvfX43OSIN6TyEtJq9QYlD0AWSyEBoS0w3mZc84HRsZt8zZcFlrN36er7Nyw/
         Q6jpA1lzzVwNJBw2AEwcpSU2adaPFwiLriTxvBkw7Tbw7WXZzdDGxbaw1ZKne/SC8fNo
         QH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900470; x=1726505270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K+ClSg80/aj3+WNRq1JEXBhsSt9yh+XEQ9PiBAm4KU=;
        b=ch/sfTcBnKVTVH5ZfsejGYphZ7oLsQbA6uc+RBDYZlLIoF1M3wBWT01uzevd4wPg9T
         PBgo0YUA/HiOJUYXlfDVhgija0JUKeuZzYVPL+6odzPKK7UYX84zkfai9AxkcmnfbYg2
         ezSMtgrb8TvGoTTt2eJOJujMgABqxaZ/U9SmQ728fH8nHY5dbbEQlaeJAJKXaHUpJ6Wh
         AXUya87lMap6u8toEdfhQuh3k25sOYtTLxE6cPFhH6Iw2U0olpe9Hd6th9h7Y5765Fku
         ZH1VqtKlXAnT4FpUC5s7bISoz3n/hbVl5EZbpBVwxZNxTAbT8UL2ToxAbCeskSpBhDE7
         iQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXduBgYYD/5P8ylhE2PtrbF/xKwZ5CwLMBU7JASyuMaz9LrDnN9M3NAdoeIRaJEkh70W24CsAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbG3pRYXI3XF8qnxrWt2d4o9fQgZbkoPw02Fj6dCWVMMVehDpG
	bPRz8PfP41TOm2q/v+fhcr19eUaTBBFtaaj7o4Xkf736uIQMOfUcruJoK5TY4Uk=
X-Google-Smtp-Source: AGHT+IHPy2hYIJH4VPnE2BBNfbfOtDSs5NB3RmCrLWeX29JP0Q3CX1Vj8YTy0TBPiP+DHMOrbTjUcQ==
X-Received: by 2002:a05:600c:510a:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-42caeee0847mr25402795e9.7.1725900469366;
        Mon, 09 Sep 2024 09:47:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675c1dsm6470822f8f.58.2024.09.09.09.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:47:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"
Date: Mon,  9 Sep 2024 18:47:46 +0200
Message-ID: <20240909164746.136629-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
breaks codecs using non-continuous masks in source and sink ports.  The
commit missed the point that port numbers are not used as indices for
iterating over prop.sink_ports or prop.source_ports.

Soundwire core and existing codecs expect that the array passed as
prop.sink_ports and prop.source_ports is continuous.  The port mask still
might be non-continuous, but that's unrelated.

Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Resending with Ack/Rb tags and missing Cc-stable.
---
 drivers/soundwire/stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index f275143d7b18..7aa4900dcf31 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 					    unsigned int port_num)
 {
 	struct sdw_dpn_prop *dpn_prop;
-	unsigned long mask;
+	u8 num_ports;
 	int i;
 
 	if (direction == SDW_DATA_DIR_TX) {
-		mask = slave->prop.source_ports;
+		num_ports = hweight32(slave->prop.source_ports);
 		dpn_prop = slave->prop.src_dpn_prop;
 	} else {
-		mask = slave->prop.sink_ports;
+		num_ports = hweight32(slave->prop.sink_ports);
 		dpn_prop = slave->prop.sink_dpn_prop;
 	}
 
-	for_each_set_bit(i, &mask, 32) {
+	for (i = 0; i < num_ports; i++) {
 		if (dpn_prop[i].num == port_num)
 			return &dpn_prop[i];
 	}
-- 
2.43.0


