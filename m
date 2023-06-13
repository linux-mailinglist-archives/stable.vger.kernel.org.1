Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEDD72D9D4
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbjFMGYN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbjFMGYG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 02:24:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99ED1713
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 23:24:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bce24604eeaso1372413276.0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686637442; x=1689229442;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SksGVuYCcpsJS5jmOyFVtMmk7sbrZYWWYhHorGtkCYg=;
        b=Cvn1KURuUQhom3FaKEax20iu/wRaoEiE+9IlyMWWIGvmYOydnM3Fbia3p3JYFkG+RA
         79Kx39PwldBaXf9s3FZJRMs3Dxdn+VqpVnfMUNBTddetvkg5SuEx+Ourqz6HdUFX76WX
         kqB4YCKy1WOxSMSQ/HghElbCNBtlZAXc+2YXlpmAFddwrIO865Zjv5CnjDZUbKqA0Np7
         uHVlrgjkSHMvsRKpgnXbRDRReCBmcYlgGVHF/KII5tQzwunuWWx0krZ2Z/Hmt7TQfRdg
         TgKKvc0ShTp2X83gkNhOLw5dm5ro1bozBtFfo7BHd8oUDDdPH+BQZOYe7aw3PBB1A2dk
         83Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686637442; x=1689229442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SksGVuYCcpsJS5jmOyFVtMmk7sbrZYWWYhHorGtkCYg=;
        b=OVlONsAquiPU2AORodFFrVVVtpd48NxEQtrPl9co/cB0/POUBKDYPRmDOBN+DlscTf
         44Kvwt3NXtAhroJ/w7JoMkLN9Aea/WGQQOVaMLaBA63d2XseWOPNSI6OsuPnoZnMJN5M
         DbSqoo1Ec5YopNzYhNfP8JaG+fccW5s0j96xXiWJkD5Grhf2dztavXEKtlBBArd8Y65t
         gmIyGEKcuu5Wme+n82GJcssBpDD3OeOfNe9Jxk4WQQ2545QEyKtMR+dJV190sRVzx6qv
         2Rg01v1ANOqt1ZPeTdC6ScR1PqM+PRKqQPOnel9hLCkkIEp5aWO6xe9EVYETHYXduexd
         LS0w==
X-Gm-Message-State: AC+VfDyY/ofufQ0jMEr6nPM1tDaqRTjXLW0jLhk7z+Ifnsky7b/IxkZD
        JSrg4BFI/E+vNha/h8209zDHiIA7PKVUdcxA5g==
X-Google-Smtp-Source: ACHHUZ7MsfCSnI9ZnIsllvUmu8OVRtd5lAnbhP5r+QUWm1RA9r7epvJv2CV2dCkQTlRGDW/LSP6fFyjXpFb9Xgka4g==
X-Received: from yixuanjiang.ntc.corp.google.com ([2401:fa00:fc:202:8f9c:a67:3aa8:51ac])
 (user=yixuanjiang job=sendgmr) by 2002:a25:ad1d:0:b0:bd1:ae45:5447 with SMTP
 id y29-20020a25ad1d000000b00bd1ae455447mr208027ybi.0.1686637442066; Mon, 12
 Jun 2023 23:24:02 -0700 (PDT)
Date:   Tue, 13 Jun 2023 14:23:50 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230613062350.271107-1-yixuanjiang@google.com>
Subject: [PATCH] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
From:   yixuanjiang <yixuanjiang@google.com>
To:     vkoul@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        yixuanjiang <yixuanjiang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Modify the error handling flow by release lock.
The require pcm_mutex will keep holding if open fail.

Fixes: aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
Signed-off-by: yixuanjiang <yixuanjiang@google.com>
Cc: stable@vger.kernel.org # v5.15+
---
 sound/soc/soc-compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 256e45001f85..b6727b91dd85 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -166,6 +166,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	snd_soc_dai_compr_shutdown(cpu_dai, cstream, 1);
 out:
 	dpcm_path_put(&list);
+	mutex_unlock(&fe->card->pcm_mutex);
 be_err:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 	mutex_unlock(&fe->card->mutex);
-- 
2.41.0.162.gfafddb0af9-goog

