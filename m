Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D987992D1
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 01:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjIHX0U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 19:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjIHX0T (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 19:26:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C1E45
        for <stable@vger.kernel.org>; Fri,  8 Sep 2023 16:26:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26ef24b8e5aso1999513a91.0
        for <stable@vger.kernel.org>; Fri, 08 Sep 2023 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694215574; x=1694820374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gGBpClnFGmaeheUaj1QZkIDF39Q032+bIV5KSNa+MvM=;
        b=rcBsdKGsSK0QL/eakh+du4YQfAeR8ULhy7xRrRzFbm/aDX4DEUzLKQa4dy8mIdAo7H
         oWeJZ845ZRLr60gXc/Y6rFEdwU+jg9ILJP+FKFGU9PhWZLnBGeuo/xypOz7R4ub7msmF
         YBxMJUf4M3J+akxmpkkFBezvJB6sp65V35f1JsFqAxR2SWYULdIPKm3HUj1lTOx9klvj
         LsygbOgKTkJYelZM2RP4PNOWpE34RBTttH/I53bfxlaqnvs0agKW1JKxojRbP0KYxbWu
         k5rVE5liDYk3TxRJvDGmVF13I4K9B1mQingDgH277NAskCRyVGKy2d4BZVfL+xnCyZZM
         YvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694215574; x=1694820374;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGBpClnFGmaeheUaj1QZkIDF39Q032+bIV5KSNa+MvM=;
        b=M1otmQrW03YQtByLhgc9tPoQlAZ023Gr4W+1TuboVmaKIYrje3fKiuJdfZFAke+YHK
         NvBWblN4kRmIRKdSbcpH0ynbr61o1LP3cyFjl2qlLcjKiyo0h0+E0S8c5OtOpifzABRf
         /gobxqhmKPc/PVqSFgBwy6e2IYemrNcX2qg3UIo5QyQWAtBARFkSfZw6GNKXroVq1eDW
         DAY2ojPUi2XmJH4Y1ldQGjgxf6fJvyac1ZidmWsfv3isEEPix1eRQEmAoiKc1SZV8fUg
         ZpzCwNO82sjliWaSgK3+ryuk8VaIE8HDI9usseFe4nGPiB4zDDRMu+2SDdHkGSHGwg2+
         8bZg==
X-Gm-Message-State: AOJu0Yy5WIgBWIl3BXxOf3gOlUegn+jZsF+7sqL1OJgDYe02/3tsAqNe
        rltaWTn+ibSnyxEMeEkG/CACDfVAEDgNjkOMHlP2S9ZpArY=
X-Google-Smtp-Source: AGHT+IF5PT5NWdjk1N6eka3FeSEOYnfHP4VrdUoFvXG/bU97UA607JicI/b/ql2XCx9PnCcRPGkJJ8xajR2UWUWRKEE=
X-Received: by 2002:a17:90b:24b:b0:268:ac3:b1f6 with SMTP id
 fz11-20020a17090b024b00b002680ac3b1f6mr3777407pjb.24.1694215573604; Fri, 08
 Sep 2023 16:26:13 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Sep 2023 18:26:02 -0500
Message-ID: <CAHCN7xLNoqy7NYenfZm_2vLZ94bbmU95jeFvr2FAugTtPn_naA@mail.gmail.com>
Subject: of: property: fw_devlink: Add a devlink for panel followers
To:     stable <stable@vger.kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Stable Group,

Please apply commit fbf0ea2da3c7("of: property: fw_devlink: Add a
devlink for panel followers") to the 6.1.y stable branch. This fixes
an issue where a display panel is deferred indefinitely on an
AM3517-EVM.

Thank you,

Fixes: eaf9b5612a47 ("driver core: fw_devlink: Don't purge child
fwnode's consumer links")
Signed-off-by:  Adam Ford <aford173@gmail.com>
