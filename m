Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEA7EFB07
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 22:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjKQVvF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 16:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQVvE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 16:51:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5876D68
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 13:51:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-282fcf7eef9so1940709a91.1
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 13:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700257861; x=1700862661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swBF5B7pk8gsTpy7ro1S9ZK9Y1Lu98QqRS2h9Xja/h8=;
        b=BdoDuYNG2zI7vgZYVPsMyZWujBszO5p77FRxM7C/L7E0cSQCiIE2Tt5ojQ91tdmE6o
         hZOqvUk5NtRs9CeoeZkAdUMmpvi6DHPNzLV5qHNsFyaY2X01KGK3E1alUSYtgYpfrL2f
         ljMK4/1hfeR65ep8uJV0UswfGN2f1xwr4fapI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257861; x=1700862661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swBF5B7pk8gsTpy7ro1S9ZK9Y1Lu98QqRS2h9Xja/h8=;
        b=QmXv5ssM1Y/9lquJs37Qpkbq91iQZwZasOv035myIFxNNOCsWpV6MLGZylDEjtjvgT
         z9rVZ0uEkG3Q4PWkJsGTdQ7XUabZREapdKXLMbGAMyV3ByqUNIjMhdF3VJa8ht+O/HT8
         H9pfjv86FKV+KNCvkgGDS751zM8t0nvCN0jvJ0GL1rWYCf9oJJdy6C5Fk9MihOltgyRL
         0l84N/HVgKe31MkgMvRkL6/3Cji5v7qYfG89oX25pqIj58HTLiExk9Z2lsih8fPein5T
         gSnpSez0JJD24LIhdtxmrWMWKJubeb3vx93NEf7riHcwWb44i2l2ChujZtPq36iTuJX2
         ssjg==
X-Gm-Message-State: AOJu0YxYs3vCBdRKL6WkcEfMZu+fqtABpGU2tF2zTQx1k6VKCDADQ6Fa
        g9zWTRaaoo/x1Jq6kD8zOrh1LQ==
X-Google-Smtp-Source: AGHT+IEUspXo2pTbNwW9zexsuhcFiZyZsalHf5KstkhLjR3XfhaoQzHpDx11A94uCRV3b5EuHixtow==
X-Received: by 2002:a17:90b:384b:b0:280:8544:42fb with SMTP id nl11-20020a17090b384b00b00280854442fbmr842143pjb.17.1700257861154;
        Fri, 17 Nov 2023 13:51:01 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:7ed:b095:f0ba:5801])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090aca0700b00256b67208b1sm3639587pjt.56.2023.11.17.13.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:51:00 -0800 (PST)
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
Subject: [PATCH v7 0/3] Use correct mode for edp panel
Date:   Fri, 17 Nov 2023 13:46:31 -0800
Message-ID: <20231117215056.1883314-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This series contains 2 part to handle mode selection for edp panel:
1. (patch 1, 2) Add a quirk to override the edid mode for generic edp.
2. (patch 3) If a panel contains hardcoded mode, skip edid mode.

Previous versions:
v1: https://patchwork.kernel.org/project/dri-devel/cover/20231101212604.1636517-1-hsinyi@chromium.org/
v2: https://patchwork.kernel.org/project/dri-devel/cover/20231102221309.1971910-1-hsinyi@chromium.org/
v3: https://patchwork.kernel.org/project/dri-devel/cover/20231106202718.2770821-1-hsinyi@chromium.org/
v4: https://patchwork.kernel.org/project/dri-devel/cover/20231106210337.2900034-1-hsinyi@chromium.org/
v5: https://patchwork.kernel.org/project/dri-devel/cover/20231107000023.2928195-1-hsinyi@chromium.org/
v6: https://lore.kernel.org/lkml/20231107204611.3082200-2-hsinyi@chromium.org/

Hsin-Yi Wang (3):
  drm/panel-edp: Add override_edid_mode quirk for generic edp
  drm/panel-edp: Add auo_b116xa3_mode
  drm/panel-edp: Avoid adding multiple preferred modes

 drivers/gpu/drm/panel/panel-edp.c | 79 ++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 11 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

