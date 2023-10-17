Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDE67CBA25
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 07:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJQFcq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 01:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQFcq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 01:32:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E0A2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 22:32:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-406609df1a6so50992325e9.3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 22:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697520763; x=1698125563; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptqK46Sao6TMrWb+csBUSCN7pOvytfhJ0CcS/J1cAwo=;
        b=J2CgkMk1n9xl5oHggAOMmRdYAbg7t3rLPkjZSVwYZ1MAnomkRSCt/uMSUEd/bCpvwl
         VuP9XfIJuxkLm6PoNvCNLcg+3qsWJWOYdMFoZb+osg/436aW0BB24Ll1d+KazXQhnv0U
         MgOY0+gHOpPMXA022tR2f+BitTyq57knh1M8Jsyxpmbdj4HLDurA3s6KzKKZFEaf2gyz
         9aSiKfUkkEbU/vcluXE0OmHRvY/ofIe6eF3FuMrhcxaCKYTQ2Udn5Ly0CGkyxTCX7BQm
         MLq9bnmIiKeUTJ2IUjBAiXiqBVgUNRprhd9rzReJE4GKBdXyq8uqoLmkMzY54Tzq7tP3
         PYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697520763; x=1698125563;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptqK46Sao6TMrWb+csBUSCN7pOvytfhJ0CcS/J1cAwo=;
        b=benDXD8JQfndprFet4D6tRHCXtMlrKoVLbHPJmZySIeVdl3XZ/E9TZk7QzT/eNOgjJ
         WwA7oAUTeVy+UJOljWDjFS6iBUQXwe6Xehs2D8ilA/3z2zfNC3ABZfXCfIhRh0QHAfz3
         N7M87K9hPj/vQzQvEnuK5WxjoLbUNAhaMaRyS2bVVmcTN+oABqTVllpl13Xzr+HgZh1Y
         RdLYmTJjbgOZokgccqh1gI/r0IJi0pYBD//B701OiC1xhYIgtHflQKCG9s3ygfYwQd9q
         qH7r2pDqeMH3ihhN/b+I/JW6siwcZTfYKQY2DRj5lEplhQoUKbpiuO4wXNuEUf5IHjLM
         307w==
X-Gm-Message-State: AOJu0YxomKOCfbdr+xpxDiIRFXx6kGpWpB1Ny+XSnz5DtoWanPv8grPN
        NhPC7sTUlp1ZsfLibjYZ/wyNsDGbCfxtXkOpz6Y=
X-Google-Smtp-Source: AGHT+IEwz7wPaH2ZRk4m8CukpXVpfqa8TM2hu91sQYqGJoaQ97IcbvOHsyW2KWR0TYnBgbBBkc6QijuBE9VKVMZ+cJM=
X-Received: by 2002:a5d:564c:0:b0:323:1887:dd6d with SMTP id
 j12-20020a5d564c000000b003231887dd6dmr1159069wrw.3.1697520762789; Mon, 16 Oct
 2023 22:32:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:414f:0:b0:32d:9e69:e7b9 with HTTP; Mon, 16 Oct 2023
 22:32:42 -0700 (PDT)
Reply-To: Naomi_noguchi100@hotmail.com
From:   Naomi Noguchi <marcusslayer45@gmail.com>
Date:   Mon, 16 Oct 2023 22:32:42 -0700
Message-ID: <CAP9Jr=fPSEftbsXBKNAKCX+az1-1Xcv048WNYi1UVqN_hFfraQ@mail.gmail.com>
Subject: PROFITABLES ANGEBOT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:334 listed in]
        [list.dnswl.org]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [marcusslayer45[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [marcusslayer45[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [naomi_noguchi100[at]hotmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

 Hallo,

Ich habe eine sehr reale und lukrative Gelegenheit f=C3=BCr Sie, antworten
Sie f=C3=BCr weitere Details.

Beste gr=C3=BC=C3=9Fe,
Naomi Noguchi
