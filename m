Return-Path: <stable+bounces-89436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3709B814A
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F5B1F251A2
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF111BD515;
	Thu, 31 Oct 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhAc81mS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AD13A868;
	Thu, 31 Oct 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395974; cv=none; b=k5j5dd2uqCEdKfROs0InwapU/nGgIku5C7TB7SPYA1D+otbOt8YN/Qax1RmmY+tGRciUHoe8NdN2+Q4yGF//Jb4umUn+pJ+Oev/I9o2UVKYzNUCh4K7DbJmx72XXds1k/ugbhN9J+Ny3Zwp0qENcl4bYojAeCZHkFS5GWX8veAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395974; c=relaxed/simple;
	bh=H9egTS5cdj/DUjMPa+j66rAN6GRfWc94gbp10M6jLQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oKKkFqp8eNceuPL+XgbT7ECy4Wqz/PY36+rTebGpRSgTW0434v5+bOzM4SIYAbZBVm1mD5nHC343WRmvu1sYx4+w4FPfjl+wDVLBaov7dGglsPpfIDdZJfUhlJ/z2MZiIZtx2FSS4r7aj+ZjGSiGCF/NdmIU7sBIeYpYsZOdyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhAc81mS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e4908837so153796e87.0;
        Thu, 31 Oct 2024 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730395971; x=1731000771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ec1T8+HLYk9K7CxsA+5ASIChYKFZRfEvP+3PIbV3bb4=;
        b=bhAc81mSWbahJ2Fe1rSGk77ZJLUlinEQv6V1YdEpiO3IAl0EysYsOZzh6jhv8edH3q
         JXj8X0HXRl7Cl2TruOqOK6T/aDoQUVmnlAR/avWGjxNDpAwkNcP0xvQ2LiWhu7YjZNrL
         jFNM7Lq9zGuHyJZFH/oUfpJ+ehiKdHN1WO8oJAzPFPtnFLebuVy//JtrVhQE4jTHeQwE
         XgdCO6s8b/JXvhUS2EAIKyaGDFVP4Pc4fSQNzmpJhQvwX8nQUY6gohZ40iPX304ZK+zA
         3TRDPnpLALGBntJ71L1v4CMqEYu6GIGYxdfilfAPS007WzGyVJUZrFeHU1nAMCdwyW6w
         U+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395971; x=1731000771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ec1T8+HLYk9K7CxsA+5ASIChYKFZRfEvP+3PIbV3bb4=;
        b=uPmlzDtQNLD/a/SXUyaYI08Ycrmc8VUz91TGPexpK1xg3LX2c3hxa0YSVoo0pZYpny
         CPyIE4mUTAaeo5t3V/uWPNuGHO0ecCWN8w058ybXbIErZkFltDlsyeOvy1UpB8QjB5y+
         0TSj0UHhZH6G15/qCWDbF/eizQOskIHyhDMOqYQNhQydoH3JPOJD3hXcbMjgJuOXdYa5
         Zm35e/ItvWZRtYobbVVZnpQGcEvV1ngjAogSL98ubuHCMN8IajoGNHm3Ra1qlyaAqNFD
         Wvp611EorjdUGwn/HU5R2Qm/dhrGlEzEABpIwjvMGTnzH3I+S6NGJggUJY4sdtjtqsag
         NaOA==
X-Forwarded-Encrypted: i=1; AJvYcCVNrUUEGwXWU4ZqQQ4eb9s4H23HJVMJdXTbGVHc8ISTvXUrqPnmkgwK59SLTdxQqrtL0mgcO5rt@vger.kernel.org, AJvYcCVjVKExrZZM/ToWvS9rAKL+MpxBT3qTnWTsGeGppZTDJYRa/C7HxJCDXAncjC71iYUfq/uQ0hZKVTDJHv8=@vger.kernel.org, AJvYcCXTP9DXT7ohv3mUzRg23w/2dQbo39dSK7kztX3DyIiwKAsjxDBgjJavLjfPWXLeiiTtX6q5QsAI@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqGLywOhpXZUZB5pI1OixpJ/ghQnVBLTYL4JRb8I6H4ds1JXH
	PoWoYrkjcELqW5scuTUN0iw5H2Qzejrlu2jQuH31uA+yTpr6nBQO
X-Google-Smtp-Source: AGHT+IF9lglkRiHtRRzWMjSjVY++Iu1RU3J1+yC8cX5VnV4C3sHOq7z3/ygm8UQCXCCr2P8HGEYbtg==
X-Received: by 2002:a05:6512:138a:b0:53b:2121:e5f6 with SMTP id 2adb3069b0e04-53b34a31d9amr2969146e87.8.1730395970699;
        Thu, 31 Oct 2024 10:32:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-121-216.nat.spd-mgts.ru. [109.252.121.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc95998sm273378e87.24.2024.10.31.10.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:32:50 -0700 (PDT)
From: George Rurikov <grurikov@gmail.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: George Rurikov <grurikov@gmail.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nithin Nayak Sujir <nsujir@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] net: ethernet: broadcom: Fix uninitialized lockal variable
Date: Thu, 31 Oct 2024 20:32:32 +0300
Message-Id: <20241031173232.1776-1-grurikov@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I can't find any reason why it won't happen.
In SERDES_TG3_SGMII_MODE, when current_link_up == true and
current_duplex == DUPLEX_FULL, program execution will be transferred
using the goto fiber_setup_done, where the uninitialized remote_adv
variable is passed as the second parameter to the
tg3_setup_flow_control function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 85730a631f0c ("tg3: Add SGMII phy support for 5719/5718 serdes")
Cc: stable@vger.kernel.org
Signed-off-by: George Rurikov <grurikov@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..b1c60851c841 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -5802,7 +5802,8 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 	u32 current_speed = SPEED_UNKNOWN;
 	u8 current_duplex = DUPLEX_UNKNOWN;
 	bool current_link_up = false;
-	u32 local_adv, remote_adv, sgsr;
+	u32 local_adv, sgsr;
+	u32 remote_adv = 0;
 
 	if ((tg3_asic_rev(tp) == ASIC_REV_5719 ||
 	     tg3_asic_rev(tp) == ASIC_REV_5720) &&
-- 
2.34.1


