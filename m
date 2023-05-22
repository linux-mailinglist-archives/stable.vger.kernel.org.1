Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0370B56F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 08:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjEVGxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 02:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVGw3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 02:52:29 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43641213F
        for <stable@vger.kernel.org>; Sun, 21 May 2023 23:50:08 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba878d5e75fso7776488276.3
        for <stable@vger.kernel.org>; Sun, 21 May 2023 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738164; x=1687330164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srw7ucIfC/5OeRnIMtL1cXf2KeT7TF+ezb33HBVqndE=;
        b=jfHJgAclYOCpZnVYwHQClOGj72/gRBDmhMr7hJi487dtvkRI8Q5DsevbASg3dJ5tYQ
         Avz9oKiKLw0jTdXnZhNRkWHSKF5G+Vu4NpY+EyJ2RWDgDmY4uST4TjFRWAEXPJOsrdgc
         b1RQGWF29DJmF+bgXTPhxv0z0qnC9aWQlw//sJEtHmraU1729Lyy8lh5lRU4SRcHw+/l
         B32rpDHxMlkjyddRFlZqAM+YzvXJRXnsM0FnBQOzE+PM+cHgyncUpLtMtT9cK/FaSIiN
         zk32BlWiwsg+JRT/jHCaa0uSd1oyKvFJWUl35J7PcuFCcWe3Sd+Ot+MaAbuK8dCA1o2B
         4+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738164; x=1687330164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srw7ucIfC/5OeRnIMtL1cXf2KeT7TF+ezb33HBVqndE=;
        b=XUKvUoD8VzP0FGnf1FnbLCqM6X0EY4Xm2DDeIxMIZ/1V9p+L60h0aCP3vHfiD2DDw3
         gRvEW+R9HJGFGc54M8q++l5NiL34KAct4piN1Sc6KgBQ6i80peoGMgnUWMExXvQ210tn
         ZhcyCnZSNmu8+qGRgJqxGi1b6P3ha1E6TJ+o8SXsIMyeRwWcjgASpp70bKEtaqo/21aC
         TSMz6diqV5FlySxRJgEx2ZCJqpdxheqKPnzszYKL8/lSS1YySjEBl05YtHTy5wtF+SU7
         AaHuQgmv4+ock0amTeKvoqbW34ADzcu/1l95vDKvitpeo34UmkAdEL4UEOKVfmUTCDJs
         +2Hw==
X-Gm-Message-State: AC+VfDxAtxd8XYfCLKMaURjJW2tjRzW3wNm4A/RvCIe0WdHkzDaYPLZE
        NQ9DGLMUBNZDGZ8Pbf+oYR73SXzY8OcJARwhC5vviA==
X-Google-Smtp-Source: ACHHUZ6Q7RsqWGPIcQ3JBMdEBS4SK/jmI1H8DA8MXUBTMYlg5VmyjMYTXyn1bYRjIyiEOi9iT3uzP2Zpp6oYMCrnodE=
X-Received: by 2002:a81:88c6:0:b0:564:bc99:cde8 with SMTP id
 y189-20020a8188c6000000b00564bc99cde8mr9098144ywf.6.1684738163951; Sun, 21
 May 2023 23:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230518210246.2401737-1-linus.walleij@linaro.org>
In-Reply-To: <20230518210246.2401737-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 08:49:12 +0200
Message-ID: <CACRpkdbTgL33+KjoNx4hOsGEmqXM3Rw2HucC38stiBik=5f3eg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mmci: Add busydetect timeout
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
        phone-devel@vger.kernel.org, Stefan Hansson <newbyte@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 18, 2023 at 11:02=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> ChangeLog v2->v3:
> - Took out the most urgent fix from the pile of changes
>   and send separately, without the rest of the refactorings
>   that were used for debugging the issue. After this the
>   Skomer and Codina with problematic eMMC boots fine.

Scratch this, while this gets the phones to boot it does not make
the eMMC partitions mountable. When I try to balance the
scheduled timeout with cancelling of the delayed work things
screw up as well, so I need to progress with the "big" patch
series, some of the other issues is coming into play as
well as it seems..

Yours,
Linus Walleij
