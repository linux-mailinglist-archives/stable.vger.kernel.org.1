Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410C678B023
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjH1M2L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 08:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjH1M1x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 08:27:53 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06560CA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 05:27:51 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44d48168e2cso985772137.2
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693225670; x=1693830470;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mD8rjBVWRUnVFIrMO4cA1ZPhi9N2+KrE61nTEBLn+r8=;
        b=w2wX8EBOtv0qHfJ40DEvdYIUkVY21B1Li/gT5HMgGkzlmFM75fFKNc3D6dVlQ7YQv2
         b/ZNO4vnByOP/dUANkhAq+6bRSPeVB/bw5kbGpEOq4x/eu/DLbBVwFpIFNKqbRNQiLsj
         TxrxcHFIvd6bp0TkUSeVXXvZ/PO296+4OgMQqPnUYGvnTbG82lXs/qdTPLXgQ+V76fj+
         J7pvLOKe3GgKu+mB/iowEbK2UwyxT5qZkChG4+MAZHMA39GzTYxrSIbGrkscdXFNntac
         hkQO6hnYR2s9VWJ9nJMouraPmYAhyK7GYNH5ZtuIWf/6BRD1cYITQXg0RwcLzu3OzL7X
         cOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225670; x=1693830470;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mD8rjBVWRUnVFIrMO4cA1ZPhi9N2+KrE61nTEBLn+r8=;
        b=HtCll8xu9XvR+aT+ai9rZ9YQY4npSY0Xs+S4/J4L6De5Iu3wLWF+7aGrBKHZW/Eubq
         DB+tcAQQWlwlkBfMlATnP/0I9/34Gn6bkrlJbFrJnIkXI6UgaUTgbUq50Vxayf9YFjHR
         WkYNpzyvxZkNw0KhXEBVsxV3edJFRkweV1ONEHWA0mGM2BBIjCdcePTsup1MFpJfIPL4
         vre6osTUMMk/gkQ9ry9hhLFeA/gX3AoFlPjAOKC5T4zPt6F2X5IhZ2xOfgpuuDpaUeFw
         2dWh7nHREjzds5DhajKxiLGtJL74yHlgEM5QasPMXYovBPR1pbCDpkuZBZONtfBwhHHG
         3tvQ==
X-Gm-Message-State: AOJu0YylX/3LtoiCZhhtMW2rXqpfLWyEIqa78EZx0C/qKTUQcleN+vnO
        PkwwLJYQxsuSPxQmbQCcME+b9SeGyKt1WFIB79TfYw==
X-Google-Smtp-Source: AGHT+IF0RiZ0dNfm1hl6bCcyi1b7qOZTEPlRkMEvYAZgrIt+/7pxC7vY4qFsDn3YySHb9VtQ1bv6mghrSZupPrXVSTg=
X-Received: by 2002:a05:6102:3bc4:b0:44d:4aa1:9d3e with SMTP id
 a4-20020a0561023bc400b0044d4aa19d3emr19174288vsv.0.1693225670012; Mon, 28 Aug
 2023 05:27:50 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 28 Aug 2023 17:57:38 +0530
Message-ID: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
Subject: clang: net: qed_main.c:1227:3: error: 'snprintf' will always be
 truncated; specified size is 16, but format string expands to at least 18 [-Werror,-Wfortify-source]
To:     clang-built-linux <llvm@lists.linux.dev>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[My two cents]

stable-rc linux-6.1.y and linux-6.4.y x86 clang-nightly builds fail with
following warnings / errors.

Build errors:
--------------
drivers/net/ethernet/qlogic/qed/qed_main.c:1227:3: error: 'snprintf'
will always be truncated; specified size is 16, but format string
expands to at least 18 [-Werror,-Wfortify-source]
 1227 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
      |                 ^
1 error generated.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
