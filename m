Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77A17C9B02
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 21:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJOTcB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOTcA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 15:32:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6F6A9
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 12:31:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso606151266b.1
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697398317; x=1698003117; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ju0LW+OpOIGGF6upIjZUt2TcNB2TFeY0Wvu8WVDWU2k=;
        b=LKxyGwB6/3vovCd2bhdWuU/2xu93TNuSwyruCfFUyu3XEKix8j34FzuYLdh3tPNZBf
         cn6nK+K6BRkKOejSMpFKXAVRV1+GGsEt3jIIOeJLrrUr8PN5RdoA8ECwqHHr959lJIWD
         IFj2BLaH8M6yIlRsf1+8RcmsVsPJer26rBilY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697398317; x=1698003117;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ju0LW+OpOIGGF6upIjZUt2TcNB2TFeY0Wvu8WVDWU2k=;
        b=mqs759akel08nO5WoSIH2d/Yrq+HnMMnjGAs3zyUVH2LJlAu1PjN3llRVcZTqztqif
         xooS0G3TAQUeseDumMzEhvK28PXK+IZZFH280eU61K44HzBOxTRiCQNyjAFLBHfNDABt
         HLn+GTVcl76SxMzlcLNIov1njzV+gMzAJPyPe83vlpqcUYSh2tQfTaIyGTvf/dplQBr3
         7yIrWWJC7wD0/oKLrvE4jOd6/3DBg38isV3ipfR/ER9v8jguudVEVs3BNgNJHt7wLDTc
         g/vpb78OXp2sQXGk2jE3+dsM/afbICftdigkQk9aNS1iQTPkOYtlEyvgPSBGPjrgYVCV
         MF/A==
X-Gm-Message-State: AOJu0YxOLmKDJkmg9ShX0/o4ZymeGSWqRxI3o08FMZBLqzfj7FKba1iS
        xBso3utaFdfdtl/Ve714d95jmGgN6sYChBELS0+k3w==
X-Google-Smtp-Source: AGHT+IFOQlNmPWGQ/iFhEvWZG3iIBpjDQOPtBOHhjHqpitjbgu7CEKwRbflAF19cyiwq+5jVLhDiyw==
X-Received: by 2002:a17:907:9486:b0:9bf:30e8:5bf9 with SMTP id dm6-20020a170907948600b009bf30e85bf9mr3545163ejc.4.1697398317088;
        Sun, 15 Oct 2023 12:31:57 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id hy1-20020a1709068a6100b009ad8acac02asm2717877ejc.172.2023.10.15.12.31.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 12:31:56 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99c1c66876aso603617266b.2
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 12:31:56 -0700 (PDT)
X-Received: by 2002:a17:907:724b:b0:9a1:fcd7:b825 with SMTP id
 ds11-20020a170907724b00b009a1fcd7b825mr32640311ejc.71.1697398316026; Sun, 15
 Oct 2023 12:31:56 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Oct 2023 12:31:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-ivh+tqpw3gPjDe5kPC_CNa0xYr12d20GwtvFF8xcYQ@mail.gmail.com>
Message-ID: <CAHk-=wh-ivh+tqpw3gPjDe5kPC_CNa0xYr12d20GwtvFF8xcYQ@mail.gmail.com>
Subject: Forgotten stable marking
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Bah, I just noticed that the recent revert should have been marked for
stable for 6.5, but I pushed it out and it's too late now.

It may be that you end up auto-flagging reverts the same way you do
for "Fixes:" tags, so maybe it would end up on your radar, but just to
make sure, I thought I'd mention the commit here explicitly:

  fbe1bf1e5ff1 Revert "x86/smp: Put CPUs into INIT on shutdown if possible"

just so that it doesn't get missed.

            Linus
