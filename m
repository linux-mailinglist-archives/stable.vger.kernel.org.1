Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28CE7D9695
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJ0L20 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 07:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0L2Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 07:28:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C73C129
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 04:28:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7789aed0e46so146836785a.0
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698406101; x=1699010901; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79aTCIrVJtcoBzwLf20/gJuTJbHzBwLsnf14+zcK3wI=;
        b=C4b4ed+EGP9C9xcof/uvOuZ+O3Y+c9SwoK6T8jilsL+F4Ne9TdGECiSWXJ/i3xG2m8
         J1vVc8KeWsLRisePskrL6/pTqVHKtPAvMnD9b9deOyd8aCraZ7n82SwbmnKzSD1kgsGJ
         e+t0WW08VgKDszPxiwc7nY16ubH7XnaS2NEXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698406101; x=1699010901;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79aTCIrVJtcoBzwLf20/gJuTJbHzBwLsnf14+zcK3wI=;
        b=P0OiXuPY4wOfpKGyJpbm/gcS2LD8yM6/+Oj/ziGkmH6BIknVX8SIlZF0ZKqFz3Pg0M
         6nOU53UXSHCsWoLcIOSgDil1AJb3ruVMMz7VYUG1SwG++d7YKEj4AwWFZBEToHUuj7Cw
         R8VCvbw2jBF8qFxhe/iY+35kS8ZIwKw9t8s/xAtgGk8KTpvJZosN0TlF2kOjrXzyAnV2
         AyWHpmBJgpnd/d3BE70GggQq3XlPGS4CFO9CTid5EreCvOX0POLJ3wvX/tzGoY++pRY6
         RiA3aZizwmuydgMdhVkVCUMUstzsbcPwQ1yexcQtr4B1bJ4E/VI7otsi+53YjhMhmD9m
         pUPA==
X-Gm-Message-State: AOJu0YwDv280wO5QZzw5fbexcj+043hEEhkxptPU67kY/XAe4xBjFfSy
        RxA1ujYwV0+vVKHFgjdcj57asIq34qTC4ZHM0doCEw==
X-Google-Smtp-Source: AGHT+IEmv6H40NZs1aVjFDRquDxZP2HXDhl/PlbMGXt/MC9BV/jT5ljNQAAO8Z96v7EKG9tziH0rHw==
X-Received: by 2002:a05:620a:3189:b0:76d:a110:856d with SMTP id bi9-20020a05620a318900b0076da110856dmr2437763qkb.0.1698406101594;
        Fri, 27 Oct 2023 04:28:21 -0700 (PDT)
Received: from denia.c.googlers.com (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id x19-20020ae9e913000000b007770d47c621sm450516qkf.66.2023.10.27.04.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:28:21 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 27 Oct 2023 11:28:20 +0000
Subject: [PATCH v2] usb: dwc3: set the dma max_seg_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org>
X-B4-Tracking: v=1; b=H4sIANOeO2UC/12NQQ6CMBBFr0JmbQ1tEYIr72FYtKXQSaA1U0EN4
 e6OLF2+l5/3N8ie0Ge4FhuQXzFjigzqVIALJo5eYM8MqlRalqoW/ctpMRjXVIOz2ioDPLUme2H
 JRBd4HJdpYvkgP+D7aN875oD5mehzXK3yZ/+qqxRS1JXmdtPIS9veXKA04zKfE43Q7fv+BaQiU
 NGwAAAA
To:     Zubin Mithra <zsm@chromium.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Allow devices to have dma operations beyond 4K, and avoid warnings such
as:

DMA-API: dwc3 a600000.usb: mapping sg segment longer than device claims to support [len=86016] [max=65536]

Cc: stable@vger.kernel.org
Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Reported-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Found while running 
yavta -f YUYV -s 1280x720 -c  /dev/video0

with:

CONFIG_DMA_API_DEBUG=y
---
Changes in v2:
- Add stable tag
- Link to v1: https://lore.kernel.org/r/20231026-dwc3-v1-1-643c74771599@chromium.org
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 343d2570189f..65f73dd8ef47 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1918,6 +1918,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err_exit_debugfs:

---
base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
change-id: 20231026-dwc3-fac74fcb3b2a

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

