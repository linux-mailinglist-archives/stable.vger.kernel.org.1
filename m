Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9D6FBC48
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 03:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjEIBF2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 21:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjEIBFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 21:05:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005A37D90
        for <stable@vger.kernel.org>; Mon,  8 May 2023 18:05:13 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3357ea1681fso238865ab.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683594313; x=1686186313;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vmb3cPyiLYG8YQHUK6hZUsMelHos7ttgVB6kPr2RVzU=;
        b=UCIPqzROAwkB54/KPjquketH31DrIYB+KfEjFoz0l5DmTXlL9ZFayZOb7I9R2SOGCT
         xF1ptmNOzuKTZXdJbDetMfLHPASlh3K/+4ZzId3Hf6glBmwj5o7WO2v/yz17eiiB0ZBj
         XwMf0VyFvuDfLJ8MYTwNG6lcQKq2DScpjZ0m/ARWvU74PWwjn1RGAIRnnEA0XIX98Sw/
         ASnEGcemZFE527873mzmP78wmkqeJhdciAhuRccrRa+VrWy8N7F0vHCItBYPGkOhcDVM
         +OWzPWBOeMhAqQlqGTcqSpA++IyuTmLbXt9BA7RBfam42v92PAFlsM9A9q5wnDwde4ak
         Sq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683594313; x=1686186313;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmb3cPyiLYG8YQHUK6hZUsMelHos7ttgVB6kPr2RVzU=;
        b=GSHxBFv/kJ0Ln9hgOpTF4TTAa22w1d7blPvxAa0GfTxQJWSf/CiZYICdmb8rUpEiGI
         Vned1CNil2Kuz/BK7qhhrKC5vyAkeQF8d5DUhAg9yhqayVxfGwhGJfahTn27fb7Hf/Wn
         FENbK9Con0UyWql0qGVfoO7PPjbHOUAxp6hXsz0m1zVEA8UZRCVX2Bv1kgdIOYkbkEMx
         pe7/uJKdbwEQCcEnIoN0yXsKqg1+NhoHiBaEgcJX7+49IoYtJWFLm3fgOEn+/8NMQxED
         9BB2pkinlgkTIIT+Iz7WpnJfxsxcOTp3XwLJyTa6IkHubqv0dfyDKEbviAcYOO2ZWSJK
         uOSQ==
X-Gm-Message-State: AC+VfDyRZB48az+nw7kNvf5wRXOHKdE1cncP8JDZ2LByaEfSgKfT+lm9
        /ZCuG1keduztfilGrZtgjYSsxzxEKZuCu5tZlcKD6Wo+PEw=
X-Google-Smtp-Source: ACHHUZ4THdyotsqwBMwe8QTUAuOanxhpFHZn8syU2yHj0eS3QoZNrs8CLbhwR0HDb1iXK0lIKNFXxwlVCoMnG9ZOk9k=
X-Received: by 2002:a05:6e02:178f:b0:325:f635:26c5 with SMTP id
 y15-20020a056e02178f00b00325f63526c5mr6389522ilu.3.1683594313054; Mon, 08 May
 2023 18:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230409164229.29777-1-ping.cheng@wacom.com>
In-Reply-To: <20230409164229.29777-1-ping.cheng@wacom.com>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Mon, 8 May 2023 18:05:02 -0700
Message-ID: <CAF8JNhJudYKrzBuyaT5aYy+fzeaxtB6HALRrbHwYzjcwz+=S0g@mail.gmail.com>
Subject: [PATCH] HID: wacom: Set a default resolution for older tablets
To:     "stable # v4 . 10" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Stable maintainers,

This patch, ID 08a46b4190d3, fixes an issue for a few older devices.
It can be backported as is to all the current Long Term Supported
kernels.

Thank you,
Ping
