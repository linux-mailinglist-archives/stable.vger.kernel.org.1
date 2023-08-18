Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83047802F8
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356837AbjHRBR3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356869AbjHRBRO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 21:17:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA13AAE
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 18:17:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdb3ecd20dso685385ad.0
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 18:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692321428; x=1692926228;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rOWh71R2unsmK0j18LXUVFqJ8OAoWTJeI+ndUPvXeI=;
        b=ZTS6fgNIGlcr8R7FOud+NC/deBiPoZ1OfG4zLqCQA3jEFU5bqr9ZrccyJKZN8251G2
         mt3YVWglWPQ+PoGr+V9Elwd/iHFVWotmUBWoTTpLDpJqWZcmmjsWQqZtKr2Tx5Ng6QBJ
         JaU5O57Z8hEGukbgSoUY65rqJQ7DbbWvfoGulguQvKJ6WUhy6U8IZq06DWEe8VJh1q/r
         rhKBUDuK0aYsXiJfwntmcIL/2oqtBP2ImRlYKpOUaxefGMUGNz+qLr/GfWlPreURsZDM
         j57QwEpbiHjQSYXwWTNG2LHD6+xyyK7M+OEMFKi0sZ89MJrV3ulYd8coCowlm4HmZKrP
         dSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692321428; x=1692926228;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rOWh71R2unsmK0j18LXUVFqJ8OAoWTJeI+ndUPvXeI=;
        b=SCy/6XcjdhptHpKL9Wqe1iujJ3stN0MUwa3gW/OpztDoVXAmqhm/zdj/+dgR1/9CbR
         9s2fxYK43k8/B9Kcp+zRHuNEaGjwOTMb8g3wGNHVgYXLbjg3msHS5MlNKtWR7rX5rnY0
         9472mV4+VwlWfFBxUr/GHauMByJLGE8tRuViE6FlvMh549mSN0KxmHCtZXqSWCOcAv9b
         hZkl8hNtaS5/kKJhyZsAfXaTrANq+7YBFI+sT8pA+KW1WZAhjFHFca4tZsN/dTKgobqz
         9aDMGi4v+uVlA93IYb5jE7EA6mp9O3gNx4TXNJtFk84nW4JkY7lm3x5jQOAMj5iVCu5j
         +HkQ==
X-Gm-Message-State: AOJu0Ywhf3i+gAVb0j6KALY2w0CJJm/J1/4CPBCGe7xStlVuK1JE/6Ux
        o9MbMpowE0I3bSfp/NSsCTER7g==
X-Google-Smtp-Source: AGHT+IEPvuAZTF/J4BLjkzC2XooD6Ry1mwWHeucKb32CCzjPzbPPVJ6IH03SeRCWu7Un32tb1Uy72w==
X-Received: by 2002:a17:902:e54b:b0:1bf:349f:b85c with SMTP id n11-20020a170902e54b00b001bf349fb85cmr970086plf.1.1692321428716;
        Thu, 17 Aug 2023 18:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001b890009634sm391358pla.139.2023.08.17.18.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 18:17:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        kernel-team@meta.com, ebiggers@kernel.org,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     stable@vger.kernel.org
In-Reply-To: <20230817141615.15387-1-sweettea-kernel@dorminy.me>
References: <20230817141615.15387-1-sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v5] blk-crypto: dynamically allocate fallback profile
Message-Id: <169232142755.701491.1403250038127170415.b4-ty@kernel.dk>
Date:   Thu, 17 Aug 2023 19:17:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On Thu, 17 Aug 2023 10:15:56 -0400, Sweet Tea Dorminy wrote:
> blk_crypto_profile_init() calls lockdep_register_key(), which warns and
> does not register if the provided memory is a static object.
> blk-crypto-fallback currently has a static blk_crypto_profile and calls
> blk_crypto_profile_init() thereupon, resulting in the warning and
> failure to register.
> 
> Fortunately it is simple enough to use a dynamically allocated profile
> and make lockdep function correctly.
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: dynamically allocate fallback profile
      commit: cc7de17e2fe6b778a836032e7e5f9991dec40a25

Best regards,
-- 
Jens Axboe



