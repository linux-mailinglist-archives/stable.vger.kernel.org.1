Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1C7A35F6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjIQOtW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjIQOsw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 10:48:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DE130
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 07:48:47 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7927f24140eso136372239f.2
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694962126; x=1695566926; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=awnkUkY0pjshz4dWqPqfop50BjiJy8UMeWOwqjpOzwI=;
        b=U8jo8c9tT3x05EmWMPN3cAsS42m8RIonW+KSKmcw2WEIF5YN4TrLDdtOzolPaLpqwA
         Rp/xIYQRk445KEf4jqD428ff++vsTJeFHbBlgdVyH2tg7flYz3cIIdEVoCrS94m35gjM
         MspzabnPq7m1qipJvnui7T8bbMUhD782RiyHJfLrMvv7wVw1O0ZebLME8czZZDAh4pAT
         wzsDeovQz/7gpV20l/RXYx5ZyQkrN09RL+GsI9D8EtEXp8tGkVlYHttzhR4nUbILPLCq
         BAL5kuvqzNX9bi39mlURrysWe39MXdhA8/KCYeaBO3tLiE3LVMsUx7QuZYGJSnRmbIUQ
         i4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694962126; x=1695566926;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awnkUkY0pjshz4dWqPqfop50BjiJy8UMeWOwqjpOzwI=;
        b=Ec684aAVgfNqQh1FlpN0Z1qzinp9CxAzdJwjHw2jkEVDu2E+QekzCEGRgGM6jvbmyH
         Bx8dfU/+E1B11uPI1XhNQgNGJPrXyWHbIwpeEuZjYcCQQrfYBKgplzN0IkPzVbd/lFtn
         /Yp0TtcEt0u5KijIxG5GzSWWrKy3f8Cj+/SG27Jm6hxfAQoDPHxxoDanp/WrzENT92DT
         nf+T5rOHpzOSNO+rkq4a1tl+2PethmKTc6Mi4M+U2gg2FPDAg7jRQwE7figZSiqY9P7s
         O/nLdOryCV47aakkkXGmKnDo6DtDFrj4Hp+kC4V8qdavJpqJ+y0BvygslhPVzVZdsGku
         q3jA==
X-Gm-Message-State: AOJu0YzXke7tAgcBdzp3/UacaNQIX2om3Nw+L3KNrKdX5pGmZFEMYo01
        C4ZmLYgBTfpOAKSjLUHsZtaOGERzmSs=
X-Google-Smtp-Source: AGHT+IGV1sl3dxB8a/Puf4pk3ikhmkL9s5RDUmBwt+kLBD1CD2ltm+ZCqVpd8m+NYeVaio4a5+eW0A==
X-Received: by 2002:a6b:ce0f:0:b0:786:fff8:13c2 with SMTP id p15-20020a6bce0f000000b00786fff813c2mr7423267iob.11.1694962126225;
        Sun, 17 Sep 2023 07:48:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h15-20020a056602130f00b007911db1e6f4sm2374311iov.44.2023.09.17.07.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 07:48:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1ac26257-5434-0ef2-d9e5-66398c684ac4@roeck-us.net>
Date:   Sun, 17 Sep 2023 07:48:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     stable <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: perf build failure in v6.1.53-221-g5e5c3289d389
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

make tools/perf fails with

gcc: fatal error: no input files

Bisect points to 'perf build: Update build rule for generated files'
which adds

+
+# pmu-events.c file is generated in the OUTPUT directory so it needs a
+# separate rule to depend on it properly
+$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
+       $(call rule_mkdir)
+       $(call if_changed_dep,cc_o_c)

but there is no PMU_EVENTS_C in v6.1.y.

Guenter
