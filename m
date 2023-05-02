Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6F6F4087
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 11:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjEBJ5x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBJ5x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 05:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F3CE75
        for <stable@vger.kernel.org>; Tue,  2 May 2023 02:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E38DF62289
        for <stable@vger.kernel.org>; Tue,  2 May 2023 09:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53668C4339B
        for <stable@vger.kernel.org>; Tue,  2 May 2023 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683021471;
        bh=dNXpVSFxLo0kOwHD5ahHuxyK3xj+TAJZVxS8uAILxwc=;
        h=From:Date:Subject:To:From;
        b=OksHxGrRyfZecF6jHxOGFJ8c1ged+4hcy7jxaa/AIfzWw3DXh4jfTQMfEyhJ1m0SS
         HLV6Rkbp1ebAbovxTwfkmLoaTAv+cxAimG2hS5WdDT2JOauL43jssAG+3n4rXLJWvP
         K2Dlqa113W//23/rXdFs98ck76aWuzFBTzUUhNF1I8UqI10f5z0GvMoyUWAxG+Jrsn
         hA+RUzuD2K3rOQVt+VnrnbO3Q5EZTdJ+sSiKyQn9XAqmtjuAhbVOCzO6w59G5+/5TT
         KLmw4KU6+8MF/eploabdaGROpHObZiaCiYCbp0RXUgmmEl4fqayfyGtkBXIaUB3eA4
         EvAP1JN4xpmLg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so4645631e87.3
        for <stable@vger.kernel.org>; Tue, 02 May 2023 02:57:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDz12tVkEd7EygPrBU2Z2U9z0+inVM3nvOEIjle7Spwuoyb5uvdD
        8u6qNbRBTKP/1goUSz8vzKua1SMFLtkLja1Yb9E=
X-Google-Smtp-Source: ACHHUZ50e58uhl4adw4J0Fym003fC8EzVeSJ6Ci/hOGNje7sGtT2yRnEbwpND+m4zwqwhCtNZzpOg0zVW9qytW4zVZI=
X-Received: by 2002:a19:5502:0:b0:4f0:20bd:2126 with SMTP id
 n2-20020a195502000000b004f020bd2126mr2815610lfe.54.1683021469354; Tue, 02 May
 2023 02:57:49 -0700 (PDT)
MIME-Version: 1.0
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 May 2023 11:57:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHCN0CuB86RpE_y=2KOo=KR80KjBzEMTPkmxxn8=D4uaA@mail.gmail.com>
Message-ID: <CAMj1kXHCN0CuB86RpE_y=2KOo=KR80KjBzEMTPkmxxn8=D4uaA@mail.gmail.com>
Subject: stable backports for arm64 shadow call stack pointer hardening patches
To:     "# 3.4.x" <stable@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please backport the following changes to stable kernels v5.10 and newer:

2198d07c509f1db4 arm64: Always load shadow stack pointer directly from
the task struct
59b37fe52f499557 arm64: Stash shadow stack pointer in the task struct
on interrupt

Thanks,
Ard.
