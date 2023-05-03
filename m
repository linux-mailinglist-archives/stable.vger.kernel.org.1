Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B446F5751
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjECLnj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 3 May 2023 07:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECLni (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 3 May 2023 07:43:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C01F4C2E
        for <stable@vger.kernel.org>; Wed,  3 May 2023 04:43:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24ded4b33d7so2783341a91.3
        for <stable@vger.kernel.org>; Wed, 03 May 2023 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683114217; x=1685706217;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HNHYwnLEvnLgSMzznBh/gGVID9t8HFwI7dBcOQwExQ=;
        b=sDSScT6xoOiuGFA1vKQAJNZ3Vg5KXR4VmZXAPlNeCFnve1cfQez2Sy/EBDANaR2nb/
         q5kkrN2FYKhqcF7c9Ap9uUk26iNXcyklXHrhAtDl9FyUFYN9Ovqrzf53NjCIC7326Zpo
         2spsVnm7bDZG3ZIYEduH+hfA+Qfr7xduo9kv5mUVt6AdiFPKwlhFQyswX0uAYU7h2cms
         naW+wknvqoQpXcpfMqIaOgNGZesX0KtMHXepnR9nJDsIwatIrURpXIagr1hlNy+U/Ifz
         33sh5dFYiLVEjuwXwsLjQha2ZjHfncIa9jmmeSx4VsTot872nONAA4+2sAEvKbcHt3u4
         EUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683114217; x=1685706217;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HNHYwnLEvnLgSMzznBh/gGVID9t8HFwI7dBcOQwExQ=;
        b=ihh5z7UZEZVM3tONBCLjmFVQj4SGDCTJqVNHI0N2lMabGpg+7xLPerMxPAJT0gpmqF
         1dZfUW+yI47m2ZWqobyGMhT8QImcqJeC6UtLjHEkSLBx6DkDdNYK4pNj82WDbT3Q25aV
         3QoHWD1eefzHYifYWN9MmkhxxWCFhczEcOQl3xWSgseFBLNCjShdFUA4DOMhMlEpMlcH
         FvN+YK8Axj5lBfUS/CMs0jNLP2juMIGCExFYkjCAus/c1dXsoe53av3LzAhyUowMLYvk
         qZqlMDGrQR6hNHsbvAC+rOZpxO1elydjOKxijxSGRLgM17WBPljV/kU+geE44zjuQb32
         9M1A==
X-Gm-Message-State: AC+VfDzjyH+iZAYpkhv1/ciFovzeBAJyfhM9WzGQsyS8x6ZXQCA2a8Eo
        ZNXtOmF6yoU6cAuzzIiz6RWcEXzzd3xDrA4XHtE=
X-Google-Smtp-Source: ACHHUZ6T3IZJp121LnEP07Qf2P+XrR6iLfCGsiKAZq+dwNe7xAjkEa/5s/ka2qETEIL0wguEjr4sGCkclv+rWig4AVA=
X-Received: by 2002:a17:90a:4b05:b0:249:7224:41cb with SMTP id
 g5-20020a17090a4b0500b00249722441cbmr21065272pjh.31.1683114216706; Wed, 03
 May 2023 04:43:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:3802:b0:5cf:e14b:9e46 with HTTP; Wed, 3 May 2023
 04:43:36 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <www.nadieng.com@gmail.com>
Date:   Wed, 3 May 2023 12:43:36 +0100
Message-ID: <CAOWrxt_2Lv06xdi0FhPuaT77ZjNCXif8dz7Sf08v0uCJocT=nQ@mail.gmail.com>
Subject: Partnership
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greeting. please i want to know if you're ready for business investment
project in
your country because i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email below.

Thanks and awaiting for your quick response,

Amos!
