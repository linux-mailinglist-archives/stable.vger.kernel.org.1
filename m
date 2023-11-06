Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49C7E31C5
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 01:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjKGAAd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 19:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjKGAAb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 19:00:31 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA3711A
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 16:00:29 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so4804459a12.0
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315228; x=1699920028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21e/wYlKKqV9mT9+9Mlh/xElPGx/iUs7TKMPyQ0Zc0U=;
        b=CXKuwOrE3FKtyojjQkC0IpD7P5JIySPfizZZdQZqAs/8TrvCEmXuwFV1NxwBX3gqNJ
         TXYxud4F4U3XzFJkkoUFgb75bd5Ufjo8h3xe7/NifwOo3DQ/hCkAbUq4kk54Ku+qE1ev
         ZW59c2VFTH5yTZhzpOd3XNHbmdu/B5lakEgIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315228; x=1699920028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21e/wYlKKqV9mT9+9Mlh/xElPGx/iUs7TKMPyQ0Zc0U=;
        b=baiWREBXdPH4uljZ1mrGpPwPRoI9qatDU6ansPQb4IG6N/Le7pv53PCwJ4aSn8MO6B
         2lab6YrLjFhGyrLU23qL3LZWwirl5fCAK3mFsbl3/GOa/fIjCJkMFSQRsVBZ3ptUAfWB
         cj5EfoepGKeb6mlL0bjgFnsxwhV5uNPy22CkLXpxqm3l+EZ+cDwCYlIVs+xTMy91FqMB
         +LZoixqCiLcdlnunwHBqGKFmIXj23YUSgDVIih+wF1IXujIH06/HrDtiRGYKhaEWw8n1
         IcPJLWItVBwPEDOrmr230uBOX7FQcN1A+AOfVzQPvaxn1VnVVpurtwlBNZhAaxlKogSy
         nEOQ==
X-Gm-Message-State: AOJu0YxjVMEms/yALSGIPMxz7c1fCf9r5IRO0W8XOe69Jl0UoPRz6pY7
        qK8Zpda5E78ia2qFZnzAIvIypw==
X-Google-Smtp-Source: AGHT+IGamsXcnSCA+MbJdg+vx6O6uxyacsDYNxLNHmivj5ndEOFKNmAzOAGJeTNVBtUZoJF3xVuSQg==
X-Received: by 2002:a17:90a:8988:b0:27d:8a04:f964 with SMTP id v8-20020a17090a898800b0027d8a04f964mr1202135pjn.24.1699315228619;
        Mon, 06 Nov 2023 16:00:28 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id fw11-20020a17090b128b00b00268b439a0cbsm5852866pjb.23.2023.11.06.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:00:28 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v5 0/4] Add a few panels and use correct modes
Date:   Mon,  6 Nov 2023 15:51:31 -0800
Message-ID: <20231107000023.2928195-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This series contains 3 patches:
1. Add a few new generic edp panels.
2. Support a new quirk to override the mode read from edid
3. Only add hard-coded mode if both edid and hard-coded modes presents.

v1: https://patchwork.kernel.org/project/dri-devel/cover/20231101212604.1636517-1-hsinyi@chromium.org/
v2: https://patchwork.kernel.org/project/dri-devel/cover/20231102221309.1971910-1-hsinyi@chromium.org/
v3: https://patchwork.kernel.org/project/dri-devel/cover/20231106202718.2770821-1-hsinyi@chromium.org/
v4: https://patchwork.kernel.org/project/dri-devel/cover/20231106210337.2900034-1-hsinyi@chromium.org/

Hsin-Yi Wang (4):
  drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02, B116XAK01 name and
    timing
  drm/panel-edp: drm/panel-edp: Add several generic edp panels
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/panel-edp: Avoid adding multiple preferred modes

 drivers/gpu/drm/panel/panel-edp.c | 134 +++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 12 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

