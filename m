Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440287E4A02
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 21:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjKGUqW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 15:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjKGUqV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 15:46:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B3D10CC
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 12:46:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c115026985so6242876b3a.1
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699389979; x=1699994779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfxpAYOWmleR8K355O3R14aCnteWRdFE5O9l2OhvQSo=;
        b=Ijk4D8eubXCqvIJ7oCth+BKcSlqrIyOBDb+81HvzbcDSwPmwEO20vW9pLMBF3dXe3l
         ukJFoqQBVhMj31s164Qj/8vpF/sQ+O25/AgTb29uf0m9NzZMuAB6FbK92Ir1AiEbuRbo
         bhUWSbALuI05aLJejgTBnyRCFq2XlJ0UoFh5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389979; x=1699994779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfxpAYOWmleR8K355O3R14aCnteWRdFE5O9l2OhvQSo=;
        b=F68qTNDohhoGbLLJTGDF49YD0/yjhRT6W16VZOycxT3HhjxYuyUj8ZpocP9egwPkh1
         2ePmhNOE7T3F2xog5FMdJ6MX5wM0xZDapec4KJ0IbxI/WPPmQ8cOy1WQPk+jWqAj30sM
         QZjtPB4BdIFmrMra79vg/SbVbowRz3xwY/HEBU//DIU7JxYQZ9q8U3mR4cauzQA8r80s
         DouQx7p1ClpfTOTOzPRR38Ge9k9XjWCBW+ghNY3+7xcgQTCsZc+t+zJPqx0zbg+zT6Cn
         YF+Uxj8nG1gIfkGC3k2wWUNuD8FVUJCyCWObcM227O5+TSGkNsTh4ZBYAlPAESOEkiNx
         hLFg==
X-Gm-Message-State: AOJu0YydDUkomsYxlMTY1Dyix8RjeCrgbTQbZN8GEny8T+m+u5Q8gz9g
        sIlimg4iGT/J5KNFMbvor5p8jQ==
X-Google-Smtp-Source: AGHT+IGsveKs3LwTQ3bVZb/XOA2HeSV60NxgDj9v7CvUPzNo+vvUKGEt1p5IB2LltiYD/vVyUmpTdQ==
X-Received: by 2002:a05:6a00:234f:b0:68a:5cf8:dac5 with SMTP id j15-20020a056a00234f00b0068a5cf8dac5mr129018pfj.22.1699389978852;
        Tue, 07 Nov 2023 12:46:18 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:586c:80a1:e007:beb9])
        by smtp.gmail.com with ESMTPSA id e7-20020a630f07000000b005ab46970aaasm1750211pgl.17.2023.11.07.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:46:18 -0800 (PST)
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
Subject: [PATCH v6 1/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing
Date:   Tue,  7 Nov 2023 12:41:51 -0800
Message-ID: <20231107204611.3082200-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107204611.3082200-1-hsinyi@chromium.org>
References: <20231107204611.3082200-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
auo_b116xak01: T3=200, T12=500, T7_max = 50 according to decoding edid
and datasheet.

Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
Cc: stable@vger.kernel.org
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v5->v6: split to 2 patches.
---
 drivers/gpu/drm/panel/panel-edp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9dce4c702414..2fba7c1f49ce 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -973,6 +973,8 @@ static const struct panel_desc auo_b116xak01 = {
 	},
 	.delay = {
 		.hpd_absent = 200,
+		.unprepare = 500,
+		.enable = 50,
 	},
 };
 
@@ -1870,7 +1872,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.42.0.869.gea05f2083d-goog

