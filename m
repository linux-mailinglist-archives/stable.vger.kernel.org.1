Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7377CC4D9
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjJQNhr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQNhq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 09:37:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B6EF5
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 06:37:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso18342275e9.0
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=basnieuwenhuizen.nl; s=google; t=1697549861; x=1698154661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVXCnESVi6yIaR3wvDcjKCyG9I43Pvn876LU89XVxLg=;
        b=evpHvZPObnW1u4/aTw9WIgD9UHt6OeflDRW9dVv5mCFPWKiDcr4mcdogMAHj5zOIl0
         vC7XLRSv0rNWjj3OfaGAkYwaZk9fNVqEdvMwyoCTrG84wcPUyG3tzDZL6VbOQzEvIQaD
         yAPXA8hJfyaxnbQoxhsOxl8yeg6YSwouD7ZC1cQSHfIvL19obUp1EijjkdFvdxed5q/s
         5G/5Fo1dXz2iKOS3IrX0Kx+WxrysiEWlTziZglz0qglqdIICGu/S/EuMk8joslrOu/a0
         Yleet8yjHuO5hi6Om3FdfylCdvrnXS4PuNr8xJnnTkMubYfxM4dQT0ymazv7MNpLJF9V
         Q8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697549861; x=1698154661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVXCnESVi6yIaR3wvDcjKCyG9I43Pvn876LU89XVxLg=;
        b=vJ72GNJ4jTZm1FkCsIjJQIAZweAlnPsaZDJMEcNT/2lrHpMKLlukt6WE7kQIP6uEBE
         7/kyJGF60076bFLK3Rfez8bk/BWkCsszHdRHbEj3lWbXaE8APz0IhtWXzySS4xVxOdtU
         2u5xUPx733vDgxGEdE7hqe+906sr5UI8WPhIdB35TmM0lyRlM+Tg5am51puwMyarTY7A
         eLM83rLfdtize0BSh/Ix34ix4gzCa5CT9GhOqg6XbsBj1RjuQF+B4AauS6RSGdv4lX0p
         b78JzGGYbVK6lk3awpwyvcdJCNrwDnuZy7tyihbuVK5WU6S+qTjVlwOH6+nOxFEdoiwW
         xOcA==
X-Gm-Message-State: AOJu0Yz6qdV04g+cjGrwQonB+axlMcpjNvhWkZhMmVUBsFill26mY1wS
        HSOlaP99+KE+7cNduCuWKxGWpJH+IxOf3uF8qwFTiw==
X-Google-Smtp-Source: AGHT+IHcjT1dZVRZSu2K2TqudkByolOv00BOnN5Ag0A+jznulTc9jBEQvXUYysWJ8ew6PYBDAAKhjg==
X-Received: by 2002:a05:600c:4f88:b0:405:3cc1:e115 with SMTP id n8-20020a05600c4f8800b004053cc1e115mr1651102wmq.3.1697549860669;
        Tue, 17 Oct 2023 06:37:40 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77e:6d00::d7])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c4f0400b00405959469afsm1988584wmq.3.2023.10.17.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:37:39 -0700 (PDT)
From:   Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To:     amd-gfx@lists.fredesktop.org
Cc:     Rex.Zhu@amd.com, alexander.deucher@amd.com,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        stable@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Handle non-terminated overdrive commands.
Date:   Tue, 17 Oct 2023 15:37:38 +0200
Message-ID: <20231017133738.1122018-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The incoming strings might not be terminated by a newline
or a 0.

(found while testing a program that just wrote the string
 itself, causing a crash)

Cc: stable@vger.kernel.org
Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs")
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index da0da03569e8..f9c9eba1a815 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	if (count > 127)
+	if (count > 127 || count == 0)
 		return -EINVAL;
 
 	if (*buf == 's')
@@ -780,7 +780,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	else
 		return -EINVAL;
 
-	memcpy(buf_cpy, buf, count+1);
+	memcpy(buf_cpy, buf, count);
+	buf_cpy[count] = 0;
 
 	tmp_str = buf_cpy;
 
@@ -797,6 +798,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			return -EINVAL;
 		parameter_size++;
 
+		if (!tmp_str)
+			break;
+
 		while (isspace(*tmp_str))
 			tmp_str++;
 	}
-- 
2.42.0

