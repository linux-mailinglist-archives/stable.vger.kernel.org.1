Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3983672328D
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 23:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFEVzJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFEVzI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 17:55:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D4BEA
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 14:55:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso54731435e9.0
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686002105; x=1688594105;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ffxWIJ1vQjdzgF8ZhvxY7w7o4d/u7JT0wqsfFPFoqSU=;
        b=yOgSrx+e1E7Cx1ssiOptBYlZEj7BUsnqdcXEA3GZddHedPfidrXSrb9dJmIhrY7RWM
         IP+zDbTr5tCKqWvxX9nbyI42U64Z7aq2YanRPyzMQMpzFkCGqO6DzOzUf+aa3hcKABrh
         IWXjkNA6HJBGYAFcWipgLoI3Q+IRHrDOUIPy10P+ShOZOYXXQOYbvPysCBclUc32BsrL
         ipTk7uQcH3ArqO+JKYjAjvbe0/jMudTgpPxY6wSVQExQhd4xHheDqs3c+HUSa8UEWfi/
         QJY2g9QfQfpLSsrXyeUFhksaguIPcvRIuz2gLwj24A1CaOXNFxYLr+d5laqdOtecYKrs
         6RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686002105; x=1688594105;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffxWIJ1vQjdzgF8ZhvxY7w7o4d/u7JT0wqsfFPFoqSU=;
        b=TXkNyTSKzkISc6vEvvBMyoJTVKIboaKvfYSA/eC8qNR9uF4Gni7qAa/QbKrDXIeYaK
         wbWxj63iTmKzx3T1Fyj2tLteCqqm1An4zfvzUPQAQheqILJmWL7Om23wwIvKtpxILbjI
         kWV6n8EleOk+1m++5Ku1xKHAs2X93lHsatA0JzawBSngKdh65oPFzrGSA5KhqX5JW4Xe
         n4jMb4A/vTAGlNDIvMBjU9wzgLc7K0oUYFpID3XCcVoc2nuzKP+YmAm8OxgXybOIN98p
         6XIuk40G1PZ+hhpWgdCHWbJnszKQjmMSGPLkQZmPB6kmn57kAATkCXyW3o3sT9m+/J+y
         lb2g==
X-Gm-Message-State: AC+VfDxjg8e4hBKSsj1b48d/UaRyZ6VT2Q8LifnIuSHIrpt3jBaSF29T
        FBccWGDOzsASuI1evE1/smuj0Aq/q/t+KB1M5oczlCLRtL4auUzw5oNk8aTe
X-Google-Smtp-Source: ACHHUZ44Xs7CYSJCZF0zI3/cJpfIitIknpjYoaPparUJirxNlWYAfygZU4Pw+tSOynzzCyl3SqvVMHay3FpZuiGGxGc=
X-Received: by 2002:adf:f98c:0:b0:307:8879:6cc1 with SMTP id
 f12-20020adff98c000000b0030788796cc1mr154676wrr.71.1686002105391; Mon, 05 Jun
 2023 14:55:05 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Kochera <kochera@google.com>
Date:   Mon, 5 Jun 2023 15:54:54 -0600
Message-ID: <CAN1hJ_P+FG3ac4iV8AocZfffGC_dMUSZfpXKH4zPO1LS8+8RCQ@mail.gmail.com>
Subject: Backport fix for CVE-2023-2124
To:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello, the following patch cherry-picked cleanly during my testing.

Subject of Patch: xfs: verify buffer contents when we skip log replay
Commit Hash: 22ed903eee23a5b174e240f1cdfa9acf393a5210
Reason why it should be applied: This fixes CVE-2023-2124.
Kernel Versions to be applied to: 6.1, 5.15, 5.10

Thank You,
Michael Kochera
