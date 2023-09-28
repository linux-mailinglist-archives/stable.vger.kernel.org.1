Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF957B26BB
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjI1Ult (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 16:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1Uls (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 16:41:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF0F19C
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 13:41:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fa7e33573so381857739f.0
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695933706; x=1696538506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jIWceKcbN6JDqokRfv7C9OS6f1Cw+cC7U+PN8WoJO5c=;
        b=hipZ3NXiBPxaw5zNmWgoL01S518ZEt3t82wpW23zRmjXeHJlWaDdawnX8o/tfyPnbS
         F/JqdRx1NlDBeNcKPy3dreAEkRRIBEi9RtC16EQg30traAVGOiR+1O6O3GVIkVzgq5NI
         +eRy0vX8Gh8soi1TshUUi1WOCn6GTjVq1ixObcgBk392FqfVyKVqdpV5SyvHeoS2LYR0
         tDU5ORbVDHAn+kSEbDQSQrxf+MOSHsuR746Oz0msGhm0zaLVIwr4t8vE43SdZwQj0/9v
         Z3XNbNaOL3dw9Flg7e6b4ETXQeC3AZTHY/qMX8dv6ji0ebD4kRFYXQ6+2BKOOS7cGMFW
         SY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695933706; x=1696538506;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIWceKcbN6JDqokRfv7C9OS6f1Cw+cC7U+PN8WoJO5c=;
        b=Aq9bKbJBCjzL88E7w7pexWalv771xtEvozhdoLWNWvBH4cpbOSNbJsgkKxmTyZigO8
         q4eQa42bVKE1ibh2m0cwPUePmLcukc0faZtxw5BDSUVjM4zMHlCJfeCc6kxIR4PM5Hm/
         h7kkFbf7rBJ6s/7Ze4gKlkoAKQn2QujJbcX/MvITaqYlZ1EP91/j67SJcMuYvx7RTi4o
         f0hRd6Fd3sfRp8pER1VtGuPqlennqa+sZ/C2TIXjaoh/XPOdPIXP2y78Y7opxzMUoGPT
         G0eUjH1FX0+eEWwsV8My+ZrTQ9fP13BcByDcJQKU+r0eHhZkFjJ7LoJdCoZgvhUzLuke
         EmOQ==
X-Gm-Message-State: AOJu0YxTS8GRC9cVGITJyNPGB4+n1law/7hFzt0cNznC6g4cgBKVg5XE
        ZqyqH8yMFsUU2i5W8S3hBZID2eqhnDUGvjiKWzakT4cTr1Y=
X-Google-Smtp-Source: AGHT+IH0fYCwRE+aruMjDfKsDd94bfpdrwhHQK6RT+lMpXj4W+IRrM4KFxaRReAHkHrOXkCYEDcvCoZjpkIJqyVnuBo=
X-Received: by 2002:a5d:9ed9:0:b0:783:550e:33c0 with SMTP id
 a25-20020a5d9ed9000000b00783550e33c0mr2552736ioe.7.1695933706098; Thu, 28 Sep
 2023 13:41:46 -0700 (PDT)
MIME-Version: 1.0
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 28 Sep 2023 13:41:34 -0700
Message-ID: <CAM9d7cggeTaXR5VBD1BoPr9TLPoE7s9YSS2y0w-PGzTMAGsFWA@mail.gmail.com>
Subject: 6.5-stable backport request
To:     stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Akemi Yagi <toracat@elrepo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello,

Please queue up this commit for 6.5-stable:

 * commit: 88cc47e24597971b05b6e94c28a2fc81d2a8d61a
   ("perf build: Define YYNOMEM as YYNOABORT for bison < 3.81")
 * Author: Arnaldo Carvalho de Melo <acme@redhat.com>

The recent change v6.5 series added YYNOMEM changes
in the perf tool and it caused a build failure on machines with
older bison.  The above commit should be applied to fix it.

Thanks,
Namhyung
