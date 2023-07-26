Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B11E762C31
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjGZG7c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 02:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjGZG6p (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 02:58:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645FE212D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 23:58:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-cfd4ea89978so6766797276.2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690354714; x=1690959514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGpiz7DrXLbyEGUvGioYWcGeQmimAIgmZsGGAj7dQSA=;
        b=BxiKqs/pqt6QiKGcBJym/yI7MCTB+wzrTqupcJVHkAKKVrNP1QPiJxdgCy5AnFETpl
         UjHBCcI75/rHS2KWZc2Mq+fRtBTH7s3LC5WHMiUz/ITS6hVjx05FDi1flv+55Y6/XAx1
         xPNekYkaEzpcvzsnxQefLeTU4SWlO4KlTto7rkkAY4ejMtBDAtuyhklKxLgwpUoPzcqq
         zvF2AAlcVXCE2kfmM3slQUAsJp+Jf5SYT0UkR9rZAnmGFksh8vr6gYqr/VIVtmu6RND6
         Y7F5U2kKUxNvGhoC2UBfe5E95wZ5jgFFJ8JS5V6O3hOP/+CY3KYRN/AAk1r1JXEPeLRu
         cVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354714; x=1690959514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGpiz7DrXLbyEGUvGioYWcGeQmimAIgmZsGGAj7dQSA=;
        b=SK+WpYxSX+ve1BNh6AdgHH40CDn05ThcgaAV/LYT5C7PXRixq93f4ydghoW5M7J1pH
         OqgM/fcVPm6Klt337Fy9nhAatHTUhWACElqv841tKyxWirua/YK1IUSE2VadYBeMPU1N
         u93ka6Hk1weCWj3rIhx1B0rxx4dMA7/eu6cOMyO4itFKGCoVZPzLh2l6lzVu5QzzSAE/
         51aXE8aJobzVWVfhsxgFtDrJYip7rJ8dm3wulxBPfk+v6z04ZBdr82zUVKfGmoBH0Grb
         OtEPd9ZkHCofHwpaRqgL076/hRhg/v58LlxQSDTibiU0wYT1zaBaczalP8zoQq9Q4FvI
         zDsw==
X-Gm-Message-State: ABy/qLZShI9CwUqLxRZoxCpUaunZ51q/IFZGjMltZF7ZjW4dJwXMqElW
        vrvXwIBCAqB2JZZhaCNaimt+/gVuiChZaE/56BXkR1mLXLE=
X-Google-Smtp-Source: APBJJlH1XvSK4kRmUDac0G9s/aYZNcSLdDaq1q6j4S0RsRc15RcquAFBeTSwYhMZVFnT0OafFTjSn2TPcR1jvNYL0n4=
X-Received: by 2002:a25:7405:0:b0:d05:f405:c4c6 with SMTP id
 p5-20020a257405000000b00d05f405c4c6mr976135ybc.57.1690354714492; Tue, 25 Jul
 2023 23:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230725104514.821564989@linuxfoundation.org>
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
From:   Fenil Jain <fkjainco@gmail.com>
Date:   Wed, 26 Jul 2023 12:28:23 +0530
Message-ID: <CAHokDB=LeBLh4=1sVMRcDHbtZ1HHk5hNkgA6gS6cOhQkOnxpdA@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
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

Hey Greg,

Ran tests and boot tested on my system, no regressions found

Tested-by: Fenil Jain <fkjainco@gmail.com>
