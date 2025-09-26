Return-Path: <stable+bounces-181764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF0BBA364A
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF6E7AD306
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 10:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79C2F39B1;
	Fri, 26 Sep 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXoy3eNw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31652374C4
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883795; cv=none; b=gEuy2ZqFQfq22zPF1KE6gIlz40k4tfKHpdec56EKKgePKw7uDPKsD5876DjSxzK5s3qJQUhbIXmeOK1Y+gme67QRy0f+Z42jpUztZoNpVNkePnmbja3k14Itl/TPhSpwRku9y6kAEzlNpPy4B8r2UqQ/jIZCwXg+9IBojpJ5c9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883795; c=relaxed/simple;
	bh=B9mVRBnVQVHHuU5i/JXW6OOSeasGzXnGqCJ1qEWL8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5u8Zs16Hy2R5WWAgBQpC9xrAkGYjsFGrTYZH/wXlm/IzFub1kbb/iQ7bO99m05lClqdFn6iY2JVOQyUZMDiTe8TQno3DSqMZHIqranMQtjZ/vt87alf2LGXWrXAie0/53KG3XqfyyE2ORR3+I/atjE/c2ITywPwGvWVrWI5ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXoy3eNw; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so645221a12.1
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758883793; x=1759488593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xiu+FDDItLuHlZJZJZE6peZ9lOx4+vSWvOYzm5iBrqg=;
        b=CXoy3eNwY+m3xFQSVtbTdxWZYOdx5u1RH7BUUhuOdBX7GbcHZ6y+mjh+fGQ7uWATBg
         9002ifGyX8EZ865mMqlQznbP3uWURG5c6eWESPy5sAl9UtWKq/68QoXXMNevss3liiu4
         qw/4Gw0Ts+Xm5vyd5h4dPKInaXssTxT2YW9hzKPl6XFRTqi4mSfWSje2M2j0/bbjWLu6
         hRrFCQUYs2BqI7UcP4AaUZ0cbkuOScxRFcMBxK3dve7m86Y17ArZ9t+YWmIs+PMEJeMJ
         fjCidtHtZrzOw9MtF3HhPR+zR/Ph2woI/qviVWhrcc4Ihv9MDHtJLvmUYKUpd0VTE9Db
         a3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758883793; x=1759488593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xiu+FDDItLuHlZJZJZE6peZ9lOx4+vSWvOYzm5iBrqg=;
        b=SeIGfDyDf89B5areYqg2QArAjgMM9+vNUBIwBPsWuvj0joBpf2V0NaE80oFoHrzvgi
         6I2OIAeasV/R1nXy5Qe5C49Kq8GYT3NFGU7mxBl0DHVp/MnULu4hXqHe6ZZwok4wGgHF
         AHMzciTRZCeUtOvx+oUu84gX//pIvQV1ISmZAjhPjsXv/lWEKAZ4B1yOX06RHUu+T8l3
         49rLnt0GvEtjkdtUTZ12jDdRHhnvg+K3ChNjEOojq+e/hMcMsGhInSEcPm/gJ4REdXWd
         bHMwcnGG4h1/iG6j0zyjFg6Q2oiqTMzr53j1QcThRkDfHxZo0lp+n3C7MnN6tZAdt1HE
         D2AA==
X-Forwarded-Encrypted: i=1; AJvYcCVNKw28GF75Jxqp5Wyl1lWcCogFNf0fIM5i2U3Z7kh1fOQovDFTOiX4Dl0ARDUUzK87ddUJESQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5WRo4oqtZzj+GV7AaVdOiglAei4qUufaxaaxnbK9nDWMIRL3
	udaJLuJSJtrOC7zMmvIU6qMvqlLNXmX2wbQIiosTor/bO8GFcbBijpM/
X-Gm-Gg: ASbGncsxfo76B3povWCrB5rxgLEOYV1E9mXOUFrh0y+dFHh/3i8VWWriRuAGa2R4g3l
	nnbb0G1rJb1Vto6c73kHycnGTFUgQUTzpvzQ2wBHQ/xckHhd2cR9NXJq0MrG+O0+ubZ78kC4SCB
	2EO8gNrDPf+kCGlwet72tMGD77YDEEUqGqJOnICFDxSsgx58sJIo79h/rvkPK7BX/rnIoEEHUK7
	3pvEQg/aYg9aNOlARQCjQkx5QesrIiXWRyKAslNN25n0oT/2GPVJMNyAsPSISJ6v7H+/w8pAoCJ
	YadHdbMBfb0wLLswiWiYcMlr6Fh0qOJRMJabNKlGtHzyhUDJ6RqRw4OutNCEPnXiGJXDpnAmj9g
	KiZ/5V+kti352AUCHEA==
X-Google-Smtp-Source: AGHT+IFiRN97whwAzqHmwPtTB+CzzgbkrvOHlXC8SosAv1OI3C0LaGR5vlCT4kKYthKy68V84nyixQ==
X-Received: by 2002:a17:903:1a2d:b0:25a:24f2:af00 with SMTP id d9443c01a7336-27ed4a06c8fmr74076905ad.12.1758883793458;
        Fri, 26 Sep 2025 03:49:53 -0700 (PDT)
Received: from lgs.. ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d6523sm50595195ad.11.2025.09.26.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:49:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: hd64572: validate RX length before skb allocation and copy
Date: Fri, 26 Sep 2025 18:49:41 +0800
Message-ID: <20250926104941.1990062-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver trusts the RX descriptor length and uses it directly for
dev_alloc_skb(), memcpy_fromio(), and skb_put() without any bounds
checking. If the descriptor gets corrupted or otherwise contains an
invalid value, this can lead to an excessive allocation or reading
past the per-buffer limit programmed by the driver.

Validate 'len' read from the descriptor and drop the frame if it is
zero or greater than HDLC_MAX_MRU. The driver programs BFLL to
HDLC_MAX_MRU for RX buffers, so this is the correct upper bound.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wan/hd64572.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wan/hd64572.c b/drivers/net/wan/hd64572.c
index 534369ffe5de..6327204e3c02 100644
--- a/drivers/net/wan/hd64572.c
+++ b/drivers/net/wan/hd64572.c
@@ -199,6 +199,12 @@ static inline void sca_rx(card_t *card, port_t *port, pkt_desc __iomem *desc,
 	u32 buff;
 
 	len = readw(&desc->len);
+
+	if (unlikely(!len || len > HDLC_MAX_MRU)) {
+		dev->stats.rx_length_errors++;
+		return;
+	}
+
 	skb = dev_alloc_skb(len);
 	if (!skb) {
 		dev->stats.rx_dropped++;
-- 
2.43.0


