Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB27816E5
	for <lists+stable@lfdr.de>; Sat, 19 Aug 2023 04:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbjHSC6c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 22:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244486AbjHSC6J (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 22:58:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD926AB
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 19:58:08 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6bca38a6618so1218666a34.3
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 19:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692413888; x=1693018688;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5hnMYcegSO+Wb8MEJ8jI39+ge2I2mb8uvKaJMmgr+Jk=;
        b=jMdvYeU8A/h2660yyK8X/bLz/04TUpUNHSTtkre0bzEgJWWcsDw28woHtPnz4/pntv
         VX7nHswwhkry+1v2rq9J4B0Tjgmrrn5gKjUmGDLf6KI/yJ9aLAxCKiFz5X173KGwRLR6
         zheIC2asP2WT2hYSsE552NGgVtYRiDFGMWLn9Yy1hlhNgDIzeLdeszQZdP3K3mJUKE8S
         5Do2xva9Q7v2h+vbdbbk8TxtlcTWIsUR69nYyDHbR7EUvSsSChzGB54BRHIxjoGOowCW
         nNDX2F9+6ifilf4K/jqXVOEQGlZNwbMRANBoGKb73yHlAOS1ayIhZghqZLtbrNBFlwSq
         eZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692413888; x=1693018688;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hnMYcegSO+Wb8MEJ8jI39+ge2I2mb8uvKaJMmgr+Jk=;
        b=Pi9EU+cZtWZKL7Fp8fSvmnGjtA4Ben13MZLicfreY3hDfeAx5yKLr5RFXnk7T3Yzqi
         tIFOTV90XQh0zAYuNqwqu20KVFGK0OSeQcAve89fsLWmzhIVHpyy6Zbc9Ku0Eua6RsPu
         kfcsYG0fbi9RhocIRoUcvyvjIClVWErYiyllY2LnSKLcmKcIWTGaGzoSDlIOIcMHLrNK
         n87MA+etooaFUj+REoUkC/LvUCK5+sSGAVrZKSFjxcWuhZYYRzqU0Y2o0nRfk2U931bN
         V+5gPNhkJBhpUImIPmUv+925ZZyQbwjRXd2I+yWxFJrB3pIApr681wiVjVvGC4hbAv96
         ZWHQ==
X-Gm-Message-State: AOJu0YyqJ+qV4mcL7zZt8WlDHjU5436/lGqQ4EyVJmvFs8R/cBXv/9Ii
        V9y8wcEo7SjHFW8MaJ7avbKgYXRtNVmMJhcEaa8=
X-Google-Smtp-Source: AGHT+IGPESkUrTThlif73Wjit+8hRe8fBW2kBzLjIZjwDO91Wv9MZR2BYVSDYLrmyVfK6uP5vLx0nVqT8DADw+vMsys=
X-Received: by 2002:a05:6870:818c:b0:1b0:57f8:dabf with SMTP id
 k12-20020a056870818c00b001b057f8dabfmr1349699oae.33.1692413887657; Fri, 18
 Aug 2023 19:58:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:c09:b0:139:6efb:3518 with HTTP; Fri, 18 Aug 2023
 19:58:07 -0700 (PDT)
Reply-To: mohammedabuhamman066@gmail.com
From:   Barrister Mohammed Abu Hamman <mohammedabuhamman44@gmail.com>
Date:   Fri, 18 Aug 2023 21:58:07 -0500
Message-ID: <CADx3RwBZoknsJn_DcbWKOioz2yY-tMDne5-VRUDNOMtNEnBkww@mail.gmail.com>
Subject: ATTENTION PLEASE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        SUBJ_ATTENTION,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:342 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mohammedabuhamman44[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mohammedabuhamman066[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mohammedabuhamman44[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 SUBJ_ATTENTION ATTENTION in Subject
        *  2.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Good day.
I emailed you a week ago, but I=E2=80=99m not sure if you received it. Plea=
se
confirm if you receive it or not so I can be sure Thank you.
Yours Sincerely,
Mr.Mohammed
