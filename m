Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E773D7CC56F
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjJQOBx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344013AbjJQOBl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 10:01:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43279F5
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 07:01:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c519eab81fso4147291fa.1
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=basnieuwenhuizen.nl; s=google; t=1697551297; x=1698156097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVXCnESVi6yIaR3wvDcjKCyG9I43Pvn876LU89XVxLg=;
        b=JHovkiFu7oe+gvYIujKtRSfbX7/l8mxG5RetzzE+oOiLbtkLoGvN/d/FQNk0N2An+e
         ds5N0tRMokLMzDMSb6ZfIv3k/g80JrCbnGT/i+7GpYySSfqgMlALOqD9Pi1mL7f+E0H5
         IvZ0sPS/kmWzsV8OnKdXUT7tyhuzQt6K6NTMi55U23qiRzAHq+9oHYziN4zjB4sQW9XW
         0BuX9Feph+mCLu7lU6dqT11CFFi8cJT/Tt1XXl3qBUicLkMn+jwSMIXw6EKFrCNbK3pj
         aZCloQi/sarJ6LMYZQ4Ggb37egfPW81J7zkPJ3wkPOdSyqBqs/Jf+b4FHcCNEt8sPD94
         u2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551297; x=1698156097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVXCnESVi6yIaR3wvDcjKCyG9I43Pvn876LU89XVxLg=;
        b=PlWKAwHUNkcw+rxh+ssbeVkyoU/xZeCZKQDHgCocOYcTvxuJ/gkGAdSnDwhWRfI5UA
         lku5CVrOYyNEtlx8mAcK4ZKhcfTlJkv4dG7nRL1SohylqNkJryNbiWTWo28LMwhCLIbu
         7QFqlkRjcaXfhkLSHKhGVZ0Hh47+RLkU52hDPzE3y78bLHdgHClj+irR7XNDRHlnkbfW
         4shWceV/HbCnjurjgLsi/hM4T7AMsh0HudBzV7Y+IsZMrD+h5mZFx2eP/q8tAcSIJtoS
         pLIA3qfob3ap3P2b/fPYpYfKugBsV0iQHEaJBFi4PewdFt2rUTtm266FhQNs/ZwTiRoq
         PUrg==
X-Gm-Message-State: AOJu0YxgbtKkmBSj781rPYEZurk/RNDBuy5hyPxrbZ7/hfbOpvBs0LMl
        5Vs1A6/JB0APPFnS0ZeqvWGQzOWKLg91f0/PxeRm4A==
X-Google-Smtp-Source: AGHT+IGkVQJBaWNhpc7ZcKAQMuw69SsFCvPvZTczEMnaEXVneH2xmq+U1MjubhquR2tP9arZH04psQ==
X-Received: by 2002:a2e:b5ad:0:b0:2c5:36e:31bf with SMTP id f13-20020a2eb5ad000000b002c5036e31bfmr1404911ljn.5.1697551296497;
        Tue, 17 Oct 2023 07:01:36 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77e:6d00::d7])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c024100b003fee8793911sm1949566wmj.44.2023.10.17.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:01:35 -0700 (PDT)
From:   Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To:     amd-gfx@lists.freedesktop.org
Cc:     Rex.Zhu@amd.com, alexander.deucher@amd.com,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        stable@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Handle non-terminated overdrive commands.
Date:   Tue, 17 Oct 2023 16:01:35 +0200
Message-ID: <20231017140135.1122153-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

