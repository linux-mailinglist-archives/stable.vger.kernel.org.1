Return-Path: <stable+bounces-78484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE7298BCE4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34271F269E4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177E1C244E;
	Tue,  1 Oct 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeGHW+Hm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76D19D88D;
	Tue,  1 Oct 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787366; cv=none; b=CEHayT6D1F4r44glRjXk6DuapJWGTNiM0Qe4mfB0JdvBuM8YQfO6lzDsHT9nU+eOtC0OnT93UNCXHJ8+PeMZKwaptYS03sreFLra82EWdx0xT3HBfY6UfxNhzBOpdnrosUSY8oqrMjR1SFB14jjiGhanKlYY3ByC3Pp64Qzg5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787366; c=relaxed/simple;
	bh=QKV8uQ24B+DSNSoyHfXeI1ggCtgQ4K483qVs8Styg3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cx2AydM6vUgEVsPpeqdv2TGVjVuip6Mf76sq0i/tTcad9SWgvYP7Tgo4xx8EMUbHdOo0vfRQnBvKKe9ypbZnYnx2ZuTMt9zsy0g5H1QqFpcSikaMS8bFTGFMjLxhn3N/rb3aaLM/kJcrUGeyMriLBsxtgSjV8iVkEaVhpWSuW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeGHW+Hm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a910860e4dcso38301866b.3;
        Tue, 01 Oct 2024 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727787363; x=1728392163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NWMxqKDPeYJDQVWtESWvFyp01m0NgonNYr4KtFRKj0=;
        b=TeGHW+Hmd/ZDWKHtrd4tfXPSEnp0FROhMCDzNEwX+ljes2RzOFv0hHoZ7LpXDrWlch
         sJM9q5dbhtPL2zwgPye3Q/mBqPcn3WNaNYFcxXnHlD2KgELIBkCroJvcjUMtq2AmMGNJ
         kPTwwq3UFURd0ATb6KORRLFUA20CB3XHAzyXc8/BSVxkbyVJfArPcBfiQZGHfYlfNvEL
         d0cYN6Q+rpT0iFQqZJQDQxYEjoKQ45cu0zSg4jJgpdlggeG53MhvBghhKJKioDtVbqZI
         cOo8lAtKUXGjzRkOHfPL0Uiyapct55lekK3dlJEo3YqUKYWZ0xubyhwZajh3neo8E62q
         idZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727787363; x=1728392163;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NWMxqKDPeYJDQVWtESWvFyp01m0NgonNYr4KtFRKj0=;
        b=bAlBmvZsIVJp9tHMY1kHDyR5vTQ6v9izew2EDj54VN2lqFilrHPZRwe1FgNHftcNCV
         8rCeBstGCtDprPb6Iqe/W6XZ+ZgcnJ/rTaOjANdwwylk2nerI3w+d3bCUkRv+js0Gddu
         x4wZtw4vSBFNAECw1TRYEnAPNMfsmpgHNHw6bshFw58gCv1h2HhS0bMRwHrJdkqLSOsL
         g1JNBg7Z+iwKOzQ0ABlNMnY+KEra0cxtcugNSVuBZEfIDJWy6YfwJbWcEKEP/yLRw97L
         ZMTlt+91WDvSa6bLl1Af8GedyyiIE/al34Yc+pvdwoQRowsAGRzvyII3H23Hevsh+JtS
         vbag==
X-Forwarded-Encrypted: i=1; AJvYcCX3kUjl0ZyqbIKmKPXVgLBGG6hac11bpbBDbdJatpAW7+N08tTSHptXR1EtzUj8RpaFqU0ZMrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6odFu9eoOnu8zjIqJinGhSUPH2lZScVTVLvVHLb6VfANZtQS
	i/bb8o+/gVUFPb4p5ZG0YUWaIN7LVDxPIsvDDn9hRKdsRdr9nxZK
X-Google-Smtp-Source: AGHT+IF5YiVWOkLm/d3WmhetyzIhQsQzcx2uEFF1iH6yUeSJVBU049p9LsfEUPGVFhw9qTLc0IBTmA==
X-Received: by 2002:a17:907:7ea4:b0:a8d:11c2:2b4 with SMTP id a640c23a62f3a-a93c4aab885mr1804109866b.56.1727787362913;
        Tue, 01 Oct 2024 05:56:02 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299ac60sm711302466b.221.2024.10.01.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:56:02 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 14:55:52 +0200
Subject: [PATCH] spmi: pmic-arb: fix return path in
 for_each_available_child_of_node()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-spmi-pmic-arb-scoped-v1-1-5872bab34ed6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFfx+2YC/x2MQQqAIBAAvxJ7bkFDCPtKdDBdaw+puBBB+Pekw
 xzmMPOCUGUSWIYXKt0snFMXPQ7gT5cOQg7dYVKT0UpplHIxdjy6uqP4XCigM7tVerYUKEJPS6X
 Iz79dt9Y+9sRsp2YAAAA=
To: Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727787361; l=1597;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=QKV8uQ24B+DSNSoyHfXeI1ggCtgQ4K483qVs8Styg3s=;
 b=jvKhV/dAwoPDZnRHSdZckaDS3H9e3Twe9YTWOaCHTWpZI/5hwKgApU2qckN88lFnKUg/B3IPW
 EVZ63ZhqOHIAMLC53a5WAz6rIcTRju3RWfnulr+sWdDMNskT1wTtC5n
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This loop requires explicit calls to of_node_put() upon early exits
(break, goto, return) to decrement the child refcounter and avoid memory
leaks if the child is not required out of the loop.

A more robust solution is using the scoped variant of the macro, which
automatically calls of_node_put() when the child goes out of scope.

Cc: stable@vger.kernel.org
Fixes: 979987371739 ("spmi: pmic-arb: Add multi bus support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/spmi/spmi-pmic-arb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 9ba9495fcc4b..ea843159b745 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1763,14 +1763,13 @@ static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct device_node *child;
 	int ret;
 
 	/* legacy mode doesn't provide child node for the bus */
 	if (of_device_is_compatible(node, "qcom,spmi-pmic-arb"))
 		return spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
 
-	for_each_available_child_of_node(node, child) {
+	for_each_available_child_of_node_scoped(node, child) {
 		if (of_node_name_eq(child, "spmi")) {
 			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
 			if (ret)

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241001-spmi-pmic-arb-scoped-a4b90179edef

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


