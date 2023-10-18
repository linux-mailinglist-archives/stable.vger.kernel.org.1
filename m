Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D037CEC77
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 02:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjJSAAS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 20:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJSAAR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 20:00:17 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B1115
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 17:00:15 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3515deaa7c1so30430505ab.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697673615; x=1698278415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1HJODpBcMbzB2tUXUZxawzk68qAf00Djnx9IKBN0d8=;
        b=X2gC2r7UGG5y4Sc+EB+khOWcAme3Evcmh7hybtMMjds4baAKWqOTuGYOxkwMyo6YuV
         X1+FoNnzIuP7LbNcRsdDKJUMUpYuznFYROGwsXaLO6nkLpKU8KXJxa1A4kbrOtTwvv7o
         HK+weMKR4tTmMG+x90lG9C0nbAhxYSYvmhVys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697673615; x=1698278415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1HJODpBcMbzB2tUXUZxawzk68qAf00Djnx9IKBN0d8=;
        b=djZTXfuDiFYqs7tx+Swpd+ULOfxwj987tzINJOMJ9zSJJ0XsD5TP4VucHlscWllrNv
         bhd6OKSy8DKnGxuRNym6wRRM3oew+53PBDwpljrgQNl9ckkgq3edoBUyqN7NCgT28pHa
         TyphZ/S0YWuVCoAnPuDJ1Bn6dGZMP92xjzari5mK8gr9qEz8FKMZ6P6Pes/XqQ0Fbbn4
         rB95U8a/edbu036tf+NYtXxgNHyjmq3fYtkN/ZGHNkpsHAn6Noa1wNEH0W5DH5pXxHVH
         4GySW5Ejr/dGZAc0Jjrf6JC/kMAT7/avNYy8fjM5NgXmOCdly5slC0Y6Le/h8ajDbUKm
         AnYQ==
X-Gm-Message-State: AOJu0Yz8xrbJRncZDP0UsjuOiK0JFy/wPTlAqA9FLwNECu7Am0Z/nvQv
        NDo+Qd61HYgFSnG+iHg+Vkl5dW8VBNQOGYOjG+c=
X-Google-Smtp-Source: AGHT+IGb7/9XyHJU8tJSJRr+AOTGRuQiAjyMLpKpxv6aUrSVC/zA8mgpnLR6nLEsyXT+SILta4xVUA==
X-Received: by 2002:a05:6e02:2146:b0:351:e6e:7723 with SMTP id d6-20020a056e02214600b003510e6e7723mr1072598ilv.25.1697673614869;
        Wed, 18 Oct 2023 17:00:14 -0700 (PDT)
Received: from markhas1.lan (71-218-45-6.hlrn.qwest.net. [71.218.45.6])
        by smtp.gmail.com with ESMTPSA id z15-20020a92da0f000000b003512c3e8809sm1425870ilm.71.2023.10.18.17.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:00:08 -0700 (PDT)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Mark Hasemeyer <markhas@chromium.org>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brady Norander <bradynorander@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v1] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
Date:   Wed, 18 Oct 2023 17:59:31 -0600
Message-ID: <20231018235944.1860717-1-markhas@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Some Jasperlake Chromebooks overwrite the system vendor DMI value to the
name of the OEM that manufactured the device. This breaks Chromebook
quirk detection as it expects the system vendor to be "Google".

Add another quirk detection entry that looks for "Google" in the BIOS
version.

Cc: stable@vger.kernel.org
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 sound/hda/intel-dsp-config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 24a948baf1bc..756fa0aa69bb 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -336,6 +336,12 @@ static const struct config_entry config_table[] = {
 					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
 				}
 			},
+			{
+				.ident = "Google firmware",
+				.matches = {
+					DMI_MATCH(DMI_BIOS_VERSION, "Google"),
+				}
+			},
 			{}
 		}
 	},
-- 
2.42.0.655.g421f12c284-goog

