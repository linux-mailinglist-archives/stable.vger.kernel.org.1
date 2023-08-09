Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586E977658D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjHIQvI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjHIQu5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 12:50:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BEB35BF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 09:50:20 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a734b8a27fso4159383b6e.1
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691599811; x=1692204611;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=He4IvUcYyIKK2RGPWRy7aXvjheVu5viAkGNtt/+Ke8E=;
        b=xBTpEF3zpYUq+bjikeX7zSzA/ywa4MrIaUSU74cTEQVvb2kfDdc2Ur+agpsIOxiWnj
         vchYSEhe6u1Fuz6izzgZMbW99gKgXEwyq5FyeO81G5FstwNSDtsIlRr0cW8u53yTCYwj
         gDDBlqWllJddw+qUmhbo06Ia6R3LJDrTZ2hJiWt7recqMyTPuyrgxExNLV4ZosVQS0M+
         wLTdbz7Qt3XFpRXR2d+vg/tuU6O6K7koKTaManMKKYaQS0uSfohiaHAhrzG95P+n3bQv
         9hBg5FJCA6VmKfBIRWtr8p1CEDhtmlGIbquKvfs1gGzha1NJ2oRv0fU4CxrHFE1r0nal
         VzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599811; x=1692204611;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=He4IvUcYyIKK2RGPWRy7aXvjheVu5viAkGNtt/+Ke8E=;
        b=TNCF8rCPRwZabMnoZLwt5r8l5AJ/lx7EN+izh8CxJiJ+Z58+vJIfCe0TfNkCA7mgpZ
         bvUWcPYajtzn8KjbzzPCJa+gbM1My7CS7REUC8Tl1A6OIrXdTsvAL1W6qBw8BYPIejEf
         /OGfOoQnHgjsADen9DTtoWUen8QZSS1/cmdnhdxNEdsVjgWfRbvxQqVMPwsFgoN2CgsO
         q/sCTRTvzsxsYPw7tfNm+rwYJSH/md+rjxpY0J5bnvOjWgHyMSv+uBWE/ez6ecIIEpqW
         zC51RTznnHmm8eRTGuaHphWIzvxZUxerZp5v5kuBZCAhNO031pWVDoyHA2KCsfrBZC3Y
         Wsyg==
X-Gm-Message-State: AOJu0YwKsXJASITbcYgHnv5mJVWNhs2EvCI4nfxrAsisiUiCUW00I5rk
        36trKS63fsQxl2qiP7T9rgtszSIRYHJcvSn2CdHoKg==
X-Google-Smtp-Source: AGHT+IH3CHHnMNfpdOqa4g0/dtp+71gOteaQ08Cs0j+UAFIHskfWfZjHpskTSdvYCFsDCMkWf9ptsh2Hp7Wba1RmRpg=
X-Received: by 2002:a05:6808:3a97:b0:3a7:7bea:d3cc with SMTP id
 fb23-20020a0568083a9700b003a77bead3ccmr3417956oib.0.1691599811381; Wed, 09
 Aug 2023 09:50:11 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Aug 2023 09:50:00 -0700
Message-ID: <CAKwvOdmOVnhKws_6DdakK9SDxiCCCR1d6VJwvz94Ng_y3V8QCg@mail.gmail.com>
Subject: get_maintainer, b4, and CC: stable
To:     Joe Perches <joe@perches.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Kernel.org Tools" <tools@linux.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Joe,
A recent mistake I made when using b4 was that I added a fixes tag,
but forgot to Cc: stable in the commit message.

Speaking with Konstantine, it seems that b4 may just be importing the
recommendations from get_maintainer.pl.

I suspect that either b4 or get_maintainer could see the Fixes tag and
then suggest to Cc stable for me.

Should get_maintainer.pl make such recommendations?
-- 
Thanks,
~Nick Desaulniers
