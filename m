Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF63D7DE3D6
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjKAPIy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjKAPIx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 11:08:53 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4554FFD
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 08:08:47 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49d0ae5eb7bso2807372e0c.0
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698851326; x=1699456126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=corqp7CfGvUyEgrD9bIV6OXcI9ow1EsKtITC795TmMQ=;
        b=ITbO5wnM5jCLAL13+0dMybayI4hKNf4MZTGhkIMGN1kCltZOP46+fiitHtRr9Adf7H
         aK/11F/fFY+cvC5RS8QMKKUO6M2ujeLSxAZpCMxP7/xwU9Wkzlg+OwRI4czv9WGAo2vY
         HW72xWzqX2h8ROfRMQzROtSOJ0bZkjvVOpXbaBEXUNhC2st+JKYQEiER6L1cUjNlLtkn
         D3zBJQm8gO/K2GqRzL1kSSgaDLP6048XRgwKeOlCRPE2BPSp9HhOneAYo6Aj74z7oFEa
         RIyzFp8yAgCG/RW3c/fOznENzHD1eel3yeXDurJQoPT3UmyffkdtWUL76dEUp9pjsIy2
         XTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851326; x=1699456126;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=corqp7CfGvUyEgrD9bIV6OXcI9ow1EsKtITC795TmMQ=;
        b=CcqxYJFryjSNiKvIRygDTVO7CA3XMT1sShWfC9MTWbnOiTRcynHr6TylfKKszDd9aW
         SgteQNB1gYLhQoePT/bMz6nFVU7KOu4KOqPdI0FkBUhRrJ/ncvNNGoshr5tTBmwM0lF5
         V90iIK/zHyKyysTeSpZHny7AfMunfIbpprDiKsDEoM6qbi+qx4uQ9rH8oIYwKL65RZa/
         uNlPRDnNgw7welGe7fKofi4wkatPkcO2s9/So7mPFnezPyLwO3WnP1zsZtnA+X5lmJUH
         xNCdBMbJ7CP0b7qKqZ9CLNpnI/uEtC4OBJSeZuMhqHNXHZZ6ydTYHhCZSayN6URxmkA+
         u0nw==
X-Gm-Message-State: AOJu0YwV/dg9Fir9Sc7QvLV35PrhfiNzC4Xq85xHxc9KReHoVK9hPwpb
        XdoaCU9C+x57susbwTnP8FkIWGe/DZ37MD7VVn/RnVlkFPeVjrVEJ6Sr2A==
X-Google-Smtp-Source: AGHT+IFRP3J26J6f2G9GoOmlvDxQMUn3GJVpErAduzprqFDcGBF9BHEKiQQgZG1z2mpFGEDO+jReHPh6OMo3irT4O+Y=
X-Received: by 2002:a1f:a047:0:b0:490:e790:a15b with SMTP id
 j68-20020a1fa047000000b00490e790a15bmr14482637vke.10.1698851325888; Wed, 01
 Nov 2023 08:08:45 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Nov 2023 20:38:34 +0530
Message-ID: <CA+G9fYt-XxvA+Fg5+htpqy8ySAtY-q+dGD_FOvmzGJOPbAySHA@mail.gmail.com>
Subject: stable-rc: 5.4 - all builds failed - ld.lld: error: undefined symbol: kallsyms_on_each_symbol
To:     linux-stable <stable@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

I see the following build warning / errors everywhere on stable-rc 5.4 branch.

ld.lld: error: undefined symbol: kallsyms_on_each_symbol
>>> referenced by trace_kprobe.c
>>>               trace/trace_kprobe.o:(create_local_trace_kprobe) in archive kernel/built-in.a
>>> referenced by trace_kprobe.c
>>>               trace/trace_kprobe.o:(__trace_kprobe_create) in archive kernel/built-in.a
make[1]: *** [Makefile:1227: vmlinux] Error 1

Links,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXALLRIZaXJVcqhff4ZmGTeZoQ/

- Naresh
