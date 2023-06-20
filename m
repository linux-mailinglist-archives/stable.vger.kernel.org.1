Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1025E736B8E
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjFTMGD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjFTMGB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 08:06:01 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E2E1731
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 05:05:54 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-570282233ceso39237347b3.1
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687262754; x=1689854754;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+sO3CnrciXzeRftTKRGz40Iq1CD6A4RCbNTFZ0YuzWc=;
        b=HqS9wbFu4Wo+4maXxJkAatc7mDyrWaHYBJwIP3+jjo+wI/ZW6KTi16CbeaDn1ddScq
         ne0KFVzdkpXK7Q9++47DC7WQnaxlsc+AedNCw2XtrLhXfUIYMCebpNJu+z4uWoRvDazX
         sTfT0X2QDN9MARlqhauxudYPH3sWkh7cah6yp6+x/lsWpu4H2uRS2CYlfZE4+pdICREa
         5R0zKORKUhbyinC6KWtzlT6NRS1HnBIcaV2aNzLqM+RkTw6bRCHKTZ08o5LdgrIVAjeH
         UMg0hPXSc7t1czWIM9dDyCf9VWsV/e353yb0dCmkOHk8Ua3xtp4BaWoqUFIYdAr6DYzt
         56gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687262754; x=1689854754;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sO3CnrciXzeRftTKRGz40Iq1CD6A4RCbNTFZ0YuzWc=;
        b=ZzxAzwpVUsKjmEJD3huk8v2F8NqVBw4Za4FLzgxuhrqIf2JE0dsIKuFLoz59GEoS8L
         wk9iADt3apf/RfHxSIaHWBwUeiDSdRFfbeShsms46by4a1R3iULMk6N3gzcNqG4oOHEh
         0Dm2ipwCNzrquLwo0FOHv17usEIykYx5+i10OssVKxYlsDSTEkfEu7FFUvY8qa6pzCVp
         9NcKDmvbl6YDW7JV/8gaZannYBHrjHK2tqyzsH5DfDuPBWCOBDoHSOEvxFqX764TYw2R
         bswXCucf6+hIcfCAp5G1hkio3DZxoOaRebe7rAV/7B/QWOgjxiIqopPVyeiQVA4JCp2C
         LWdw==
X-Gm-Message-State: AC+VfDxxIqb+Vj3pqdPF2SenqoKzd5E23/YLPtpurYYED0KpwuPAU1k0
        IV5Ac301pwRVZ4UY6Hk5nCt5PxsT0A==
X-Google-Smtp-Source: ACHHUZ6p5P06B/Sn3klGwyNZ7/Iw/V6a1GAp0dCR57IagFiPlxOxkWACjJp7flP0gAE6Vfu5JYqAqw==
X-Received: by 2002:a81:bf53:0:b0:55c:67df:6700 with SMTP id s19-20020a81bf53000000b0055c67df6700mr11667250ywk.19.1687262753910;
        Tue, 20 Jun 2023 05:05:53 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id v128-20020a818586000000b005704a372ce7sm445914ywf.125.2023.06.20.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:05:52 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:3c66:2774:dcfe:891a])
        by serve.minyard.net (Postfix) with ESMTPSA id BA5D11800BA;
        Tue, 20 Jun 2023 12:05:51 +0000 (UTC)
Date:   Tue, 20 Jun 2023 07:05:50 -0500
From:   Corey Minyard <minyard@acm.org>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
Subject: Request for backport 4.19 for the IPMI driver
Message-ID: <ZJGWHhJJeuiP1H18@mail.minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please backport the following changes to the 4.18 stable kernel:

  e1891cffd4c4 "ipmi: Make the smi watcher be disabled immediately when not needed"
  383035211c79 "ipmi: move message error checking to avoid deadlock"

e1891cffd4c4 doesn't apply completely cleanly because of other changes,
but you just need to leave in the free_user_work() function and delete
the other function in the conflict.  I can also supply a patch if
necessary.

Change

  b4a34aa6d "ipmi: Fix how the lower layers are told to watch for messages"

was backported to fullfill a dependency for another backport, but there
was another change:

  e1891cffd4c4 "ipmi: Make the smi watcher be disabled immediately when not needed"

That is needed to avoid calling a lower layer function with
xmit_msgs_lock held.  In addition to that, you will also need:

  383035211c79 "ipmi: move message error checking to avoid deadlock"

to fix a bug in that change.

e1891cffd4c4 came in 5.1 and 383035211c79 came in 5.4 (and I believe was
backported) so everything should be good for 5.4 and later.  b4a34aa6d
was not backported to 4.14, so it is also ok.  So 4.19 is the only
kernel that needs the change.

Thanks to Janne Huttunen for quick work on this.

-corey
