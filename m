Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B536F0607
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 14:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbjD0Mn6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbjD0Mn6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 08:43:58 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A260E78
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 05:43:57 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-555d2810415so121649177b3.0
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682599436; x=1685191436;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9OtUw5qfuvq5waaIwQtysg67SaToj9SLYSO+4dneqU=;
        b=nPG1M4cIOcur8RvVDtnxgZLc6UVOJy1Z+uWsisgVLoJNS54vJiAD9OKIhYYCeBMd7Y
         /Xe46Cn+sYY2eISzvZgnxrtxJ3yfHmDjKMTr0ifbSiXVob6/eH9Sk/zQm9ibDciWNcEC
         0rQKXstty+EV6gMBEJtcm5hLyCRdYvVsab6GHF+u96gX5a7UzkxqtiTaYVFoMpJ+/BvZ
         xHiceypBRIKlYFWKaIOe1gZO2UISAaG4VA+9wj5T4l2PElMX/1XCuzA05MXWhuMqdBDd
         qHijnc30SC+xsCalwwMMSnuB973F1A726DeT5TreLeiHR8uKxu2V5+6BWwc00eNoJ8GJ
         z6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682599436; x=1685191436;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9OtUw5qfuvq5waaIwQtysg67SaToj9SLYSO+4dneqU=;
        b=kaIF+2aj6eYEQSjcFibbGTDYohIJ3PS6YGU1BIGxd799h4BCVaD631GCkXKzwDr/IR
         iWCRstnIhah4V5Rkx48WCZ4xRy81kB64VrWVb7rPcW5mhcpD0ETHCGCSgLk0NSMKD0z9
         JIbUNXB5Dq/wV42YakU4z/INieY3zTDp3x0EfDUPkJu/a8d3yV4Kbu77GEGhtXUjyBPQ
         iZJrhXoh1jk5O4rrskXZqVDPiYF9P2UaZDsklIg2qSGUkex5cP5Q+3eMn/c5ex5E/exW
         Zbj65AmoNWwgSbzOUqYWCFbNyTA1W1J544MXK1CrjvOuoqlE78977PegxATg6w6oqWOC
         YWww==
X-Gm-Message-State: AC+VfDxX7qdRKPaPrRyeE5/ds6jqnHypqZisg0hishk/aasJ1gfqEY4o
        uTRLdtslBMViKepYFnsboJPt6NN+hhLTMNOozLk=
X-Google-Smtp-Source: ACHHUZ6VQU+EMDq4Bd1YIuGYnHpmVaia1wG+7JcwihFE+VqbAhVcenpef5zD6UNKzkBHAcU/c7bAVULIEj7v8q8IWsw=
X-Received: by 2002:a0d:f4c3:0:b0:544:ccde:b6b8 with SMTP id
 d186-20020a0df4c3000000b00544ccdeb6b8mr1104666ywf.4.1682599436334; Thu, 27
 Apr 2023 05:43:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5924:b0:348:6f44:5117 with HTTP; Thu, 27 Apr 2023
 05:43:55 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <mosesstephen120@gmail.com>
Date:   Thu, 27 Apr 2023 12:43:55 +0000
Message-ID: <CA+JpxykKPoOvSYGsYxYij7tQMJjLRJhUid2SGJ8UKhrDRr7UUg@mail.gmail.com>
Subject: MORE INFO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello best friend. i kindly wanted to know if you're capable for investment
project in
your country. i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email.

Thanks and awaiting for your quick response,

Wormer,
