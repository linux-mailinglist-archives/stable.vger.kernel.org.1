Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C1875DD3D
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGVPfb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 22 Jul 2023 11:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGVPfa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 22 Jul 2023 11:35:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D72E60
        for <stable@vger.kernel.org>; Sat, 22 Jul 2023 08:35:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8c81e36c0so17862075ad.0
        for <stable@vger.kernel.org>; Sat, 22 Jul 2023 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690040125; x=1690644925;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=em7jBiZPm3GAT4I2G7ExzbgtIjtZJ5kckW42+zL7afI=;
        b=nitm0bsVwDQO0c+0yUxlswgPQncC8uNepdh2qXrBbLmCW0/tFx70KFfTTBUBCoDaYw
         D7R1IQRGy4SzM56T4lzPj+po5tc5IgPz8tAVCeybbrmVQTnkTOfc4eU6iK2ng1Q9RoF6
         uVZAjfKRZFT00PVAWgu6ld9v7lAjXnBWLst8ZVkI+7gfgGLBikNZ2Zhy8mVGf+R8s/I5
         JslxgGY0NzRrZrgnrCAmbGSRzQUH/CUgmKIktphovVV1gmFqqYzOjJ4kjscW9tLkj9qv
         d3T34wLB+s1koGmJb7BGmkc+9EChsYhTgBLp/O1pUzCXkSltI3gJKCSX1Rbrut6dljgi
         4eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690040125; x=1690644925;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=em7jBiZPm3GAT4I2G7ExzbgtIjtZJ5kckW42+zL7afI=;
        b=Lp1Ma9WEQBbnTqaVQX9iNKj1ZuRJfx7kkZUs8ovpl2GAnXEZdgy5DTDrtqbTh7oV0z
         TvlRYZpMF5yJMogLjrZFdA7WWTD7q2FLFPtvztao5yM7NSB+Hp3r6UUHtlDaaaseMbpV
         qfQB5KJBNnoX1GEp5/RGIUeMGLXwjWhN4PUVdI9E/XblOZTy4sTgiJ4m4mZPpFppTVZY
         9wbd/8ho303OdgmjTRs8OGeXaKLanEBXtQF6eJF9ZYsVzvt8UQFjP7NdR1NQf1cg3cOy
         z9H0NBf/4wOD+WTvAV94g3/nrxdEW2EXNBO492N6H+7kqfzOTLckxuRTTrJiLUv4xZ7F
         ZnUQ==
X-Gm-Message-State: ABy/qLYi+JtC8oFtfw26TMO638EF2h2B/NBNWlpOAlBiBhC2GzB2a8uP
        uJsAT+LIge9N3kc0eNYAAINXNwVoFiU=
X-Google-Smtp-Source: APBJJlElHE3veUwgbzutvQN90tZBFa665DMS8e5aBvsOPbkMZOT0Y9ksX2Ry9hu+bg7D1c/cNIbQdA==
X-Received: by 2002:a17:902:e995:b0:1b8:a328:c1e6 with SMTP id f21-20020a170902e99500b001b8a328c1e6mr4728333plb.63.1690040125508;
        Sat, 22 Jul 2023 08:35:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902a61300b001b830d8bc40sm5568504plq.74.2023.07.22.08.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 08:35:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b54030b3-9cb2-5c31-cc3f-45a4ac8f41f9@roeck-us.net>
Date:   Sat, 22 Jul 2023 08:35:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     stable <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Build error in v5.4.y-queue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Seen in arm:allmodconfig and arm64:allmodconfig builds with v5.4.249-278-g78f9a3d1c959.

sound/soc/mediatek/mt8173/mt8173-afe-pcm.c: In function 'mt8173_afe_pcm_dev_probe':
sound/soc/mediatek/mt8173/mt8173-afe-pcm.c:1159:17: error: label 'err_cleanup_components' used but not defined

Guenter
