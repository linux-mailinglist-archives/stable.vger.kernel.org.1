Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD30701DD9
	for <lists+stable@lfdr.de>; Sun, 14 May 2023 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjENO1K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 10:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjENO1J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 10:27:09 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8201FCA
        for <stable@vger.kernel.org>; Sun, 14 May 2023 07:27:06 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba6f8e0b39cso4091923276.0
        for <stable@vger.kernel.org>; Sun, 14 May 2023 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684074425; x=1686666425;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tgxR2bDWw43l9TyRbM99R3zx5LyjvCXMRfv36ocEFs=;
        b=lftfEOJpQ6DGE6H1M76WNUlB/b2/pyIK56vQ49CqOue6wo1Vzi7z8WkJ3GKBl3Fc/p
         /kXRi6HI8A50htdiaYmW/8m8rTaS+/IgXIMIDOwVn1F2rxdGqXk5dfbrIsvwwj1CuN4w
         VyQbpS/NMNUAHH5yuD+yr/WUbqhmskdnDwN6I4kWWff+ong58tnciMWMH34WVOlrrtuW
         E9unp3GH27UJsHDY6J31KcIwUfNPbOwJwNjR0/RiUmbkuzeCC1eFX5rQp/QYAt8UOj2c
         Iu+i0JMbq9ZzeW4yZ3tTykWCjzUix/ZYmhmiKvWqwVXywKCX3ZuJMR+52Vr3BbUAA6YB
         4tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684074425; x=1686666425;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tgxR2bDWw43l9TyRbM99R3zx5LyjvCXMRfv36ocEFs=;
        b=Bwn6u7rjMMBLqzgh8Is6JguGf9B+sUUNHshUIPN9F/UzIbvKB3Efbga2DwrhMtT8Vv
         PuPuOBjdAN+ZOKPb6neV2qnKS6WptlSZ0+uy2wX9u+QKtBuFIZsBkaYYi/1cRrlgUG8e
         gTCDoYZ+Ihz97qY21iF+Re+LyQfKggsCWuZGcO92W10ZBCGWT3D4kfFSk3h+/j9kyi5l
         EdLbCwGugIr0I0wlKGXDOCmL98FAJm/okLsTESK5ZJUDJowBfjn2wTo3tjdWqOwq192B
         IefiV/6GEkWfJnWT0p9U15Lbx7wEznEHcT+Z0JaQH2tw85pUZRti2fsnm8dS7laHzlwx
         UsaA==
X-Gm-Message-State: AC+VfDwcYfhcl2BKiqt87HvsLoUmGEsW3tEDAWEvUE3WqTnWqHJ3xfgk
        urqZR0tFzldLUt5rR2AlVAngFBTkkQy6eMCX+w==
X-Google-Smtp-Source: ACHHUZ43zipyBom1mSCpP3CQSQA/bLsSdesxLShfecOvpIF4Id8ZasBBm4ghUzkstt4Rumu6IHtz+ltAegjKjbrPUc0=
X-Received: by 2002:a25:ce01:0:b0:b3c:b0ea:378d with SMTP id
 x1-20020a25ce01000000b00b3cb0ea378dmr27812751ybe.59.1684074425381; Sun, 14
 May 2023 07:27:05 -0700 (PDT)
MIME-Version: 1.0
Sender: karenleo21888@gmail.com
Received: by 2002:a05:7108:9e0e:b0:2d0:4682:770a with HTTP; Sun, 14 May 2023
 07:27:05 -0700 (PDT)
From:   Rose Darren <rosedarren82@gmail.com>
Date:   Sun, 14 May 2023 14:27:05 +0000
X-Google-Sender-Auth: 8u6BgVmPQ9oU0KhfzrSEjXE_1tI
Message-ID: <CAFj8f_CBD8dG-3xbZ3cb3AWaLDvSsPibM25sK5ROjnJdpuQhVw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greeting to you
Did you get my message last night so we can discuss more?
