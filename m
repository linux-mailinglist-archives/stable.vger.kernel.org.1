Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E02E704F9E
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjEPNne (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjEPNnd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 09:43:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E7C5264
        for <stable@vger.kernel.org>; Tue, 16 May 2023 06:43:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac81d2bfbcso151744501fa.3
        for <stable@vger.kernel.org>; Tue, 16 May 2023 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684244610; x=1686836610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVx1X/gwP3O7S/acEluGud38z490UszSjPAa5tTq1SA=;
        b=TtsZfDOxTuNsE27DN6kpPXzY1SDVnobgvWGQgiDLhx9C/6aI1MZgZxmY5vWgti3XOV
         /LY/XOkF/3vy3ozKfdNK8WCAAXPB9tw0vC/4/A2nra6okzurMEXKkYgSjFOG8ZqwCrdJ
         l+0bxY4F8j2vS/oA9GHy2okxy+kdzqBh/aSYKzVu8yIBqLlU5/z+5a/0VyILOsFC7zNs
         EifElpevwqWGZatqvSGRLrxUprEOMxU/sESV3wT5CeJfM4JG93vBlS2EJTNye+is8t51
         ae/I+XO5mj6K7Rr3Se/Xl3/6rwP1wlXLUjVXtVT/nejvPiBqlYiUan7GzjisoUblt6Qi
         af9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244610; x=1686836610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVx1X/gwP3O7S/acEluGud38z490UszSjPAa5tTq1SA=;
        b=BwcEFbdI9VEqi3ZH6STfPB4WE9hvhRfrCnZ5tgTDnHp2w4mIguvlJIUTWnRoy6kQ9x
         4QIb+fV3z0OVn226JB6FeJ+fFs+GKEICZGabstuvWN756ZOu0T10LcD5dkBCBJ5pgudl
         /jXwK+0PLh1DzGdoPHtAVcM6AFBCN73YT0bqN5o7KIcNa5ct+HOMHQE4v6fmXbCDdSHh
         t5MQ/JATkgRD9427jeW/+9TH5KM0VQ2kXUFKSXcOcpPx2V1eYEiufmP3U8X/GvnjLkw1
         WlvfwuoZnj2f8mzWqqfgQ8CAkmGqkuLr5fdWmMgNNyYcXPGZ/hbUhD3M01bFsUNuU9z1
         0JQg==
X-Gm-Message-State: AC+VfDzheb8sKNKBW3/YJvb9CLX9PK+o5h53EANSVzfZ0ya0Zpm2AWWC
        Llr8ZdX8dn/yTjmXbxrH1x809JbFiDplHBym4FRohw==
X-Google-Smtp-Source: ACHHUZ4J6X6FsP+hxQfYBZ+Llw27Sb70tt4L2tuHrTFJmYGd89/NDsRYu9W8c9zg5O13WhWJRa3ZEQ==
X-Received: by 2002:a19:f709:0:b0:4ea:fa78:3662 with SMTP id z9-20020a19f709000000b004eafa783662mr8360810lfe.39.1684244610402;
        Tue, 16 May 2023 06:43:30 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id l26-20020ac24a9a000000b004f13b59307asm2962558lfp.232.2023.05.16.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:43:30 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 2/6] can: kvaser_pciefd: Clear listen-only bit if not explicitly requested
Date:   Tue, 16 May 2023 15:43:14 +0200
Message-Id: <20230516134318.104279-3-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516134318.104279-1-extja@kvaser.com>
References: <20230516134318.104279-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The listen-only bit was never cleared, causing the controller to
always use listen-only mode, if previously set.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 867b421b9506..cdc894d12885 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -554,6 +554,8 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
 
 	if (can->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		mode |= KVASER_PCIEFD_KCAN_MODE_LOM;
+	else
+		mode &= ~KVASER_PCIEFD_KCAN_MODE_LOM;
 
 	mode |= KVASER_PCIEFD_KCAN_MODE_EEN;
 	mode |= KVASER_PCIEFD_KCAN_MODE_EPEN;
-- 
2.40.0

