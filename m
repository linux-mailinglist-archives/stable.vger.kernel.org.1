Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4370D7CA
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjEWIoa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjEWIo3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 04:44:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED0495
        for <stable@vger.kernel.org>; Tue, 23 May 2023 01:44:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso4406931b3a.3
        for <stable@vger.kernel.org>; Tue, 23 May 2023 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684831468; x=1687423468;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhCcbiMDeimZgRsX8GeS67PO3y/8MJ5nVThqdM2u2S8=;
        b=DGh+AhDfddJwMzdQ6E+ULNCkhqQ2leu5jV8bDOA2Cznq6grLKTprOZ2JxfNVxfjFTg
         cVck7rkcJbKitAbNLT0yW8wsni8CaNPEyYFF/gg9GeACCyfgjWmLo6P+qfpQpVJ7g8Nt
         x/msfh2T8EWLQazYeMJpjb0lDSH2leM+FY0PpdSUrH3sa4evJyfMG38q81QNukR+ajdj
         Gzy4LJnTX1plfb19Xg28j4LnFMa08rSyDkSEycfyWfrqKtDGkWeIZuBmLBMyK4ZORZUw
         3TUvvk2xpX5KvpdTs10xDE/WXH9mYBN/8o7b8cvJnVXdHj34MclwGQ453pCVBUbmN/ls
         uU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684831468; x=1687423468;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhCcbiMDeimZgRsX8GeS67PO3y/8MJ5nVThqdM2u2S8=;
        b=VQHkCDP7CYes1FDiMvOBYCSeI8pFyZ1FlMn7kAlbFhME88BEITKRgLKq/BBPNn0mtd
         l6oAg8l0qToiiqvaQ4UMGdfq3JsZRpfsGw3JhHSjZolE6MT/D1h8iZSYK42iTyJlOGvt
         i4UDHyaFqQ2MVEKqJ1REerPQpIfars1R4CBoy4vDR0uyF00IvYe53M4tvNklNPXxSqaF
         u+TU/KPpG6PT4rZKj5CZ+4uQpqMi0K9QAy81WX+4D//wOlgm6WR1Tli+X984/sHjG8Ui
         Q+/v0O34Sz6QX1O68h+mKVUztZht57vybHchvWAQnTHiFVPnjRJjcxsjG9J3BBQ5jBta
         uriQ==
X-Gm-Message-State: AC+VfDyb8J/RQDzKPb1cW5AwZz+CVQ/gX9sCOVs2IfGA0z7e2rbIbNwY
        0MvZM49ApvewRvclujbljS7eYF3TXvbXnwCD3Mg=
X-Google-Smtp-Source: ACHHUZ7gLB6+d7837h71EntHEuhOx+Pv5JeXvxR9mjLMx5J8G5r62C2BXnPN9ppzRFR9O3cbTEFnJTFeP+00T8Omob4=
X-Received: by 2002:a05:6a21:1088:b0:103:ef39:a829 with SMTP id
 nl8-20020a056a21108800b00103ef39a829mr10673399pzb.26.1684831468156; Tue, 23
 May 2023 01:44:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:540a:b0:bd:4eb4:f73 with HTTP; Tue, 23 May 2023
 01:44:27 -0700 (PDT)
Reply-To: samuelkelliner@gmail.com
From:   Sam <saljeeranmofagovkw@gmail.com>
Date:   Tue, 23 May 2023 09:44:27 +0100
Message-ID: <CA+LF_-nTZPFwhntfpV2gKKG5q2tVV_JOV2DXEshsck7UpaHgNg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello, I am aware that the Internet has become very unsafe, but
considering the situation I have no option than to seek for foreign
partnership through this medium.I will not disclose my Identity until
I am fully convinced you are the right person for this business deal.
I have access to very vital information that can be used to move a
huge amount of money to a secured account outside United Kingdom. Full
details/modalities will be disclosed on your expression of Interest to
partner with me. I am open for negotiation importantly the funds to be
transferred have nothing to do with drugs, terrorism or Money
laundering.

Regards,
