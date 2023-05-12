Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30CA700D96
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjELREW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 13:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbjELREV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 13:04:21 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D34EB
        for <stable@vger.kernel.org>; Fri, 12 May 2023 10:04:20 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3318961b385so99504495ab.1
        for <stable@vger.kernel.org>; Fri, 12 May 2023 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683911060; x=1686503060;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tgxR2bDWw43l9TyRbM99R3zx5LyjvCXMRfv36ocEFs=;
        b=DCixNs2oK3jtJDZ3TI5vsC3wOXzZ8XnZaQlq1k3ZA4nUBxZYsPEjt99+2wT3v7Mosr
         lP8wyGwo9CfuA4ZB2VVZP96t1fXETFMLYLSNiOwd5ZQ01BWMf1APTxMc07x9Dhp/QvAk
         vH3htSa6ixHp0v5jJ07vmCzCagOnmVRsnW4xWAiSzINaz4LDQF8/GPxYl2fO2TbA/nDX
         vox+kRF9Ci6m+VVCW+zKWfjAnjylepDmHblFi+66QAB0xnDiEYORpsrsNRrVYmL9My/x
         BRfiDQOljvSMjTaymPKddRw0gGCFVOxXAtBIT2oXuvnPtN35BnQLReraHHveo7xm7jwF
         TJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911060; x=1686503060;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tgxR2bDWw43l9TyRbM99R3zx5LyjvCXMRfv36ocEFs=;
        b=WzFbnGvNerqqx/KcYw2P+hzZPcaXBYYel0ZsmwWZmvw9GHxeYPfejoWu0QYko4bvXA
         jhxzzdL7vwfeI/rX/5/rSqODZsOu5e1JnS+/3RDW4v4JJbiXLY0BvRGN1j9Bhb/Z+2+u
         QbgNEt7XEwGmi7IrURjob7K7nWg9uwKOH1wGGNLIli1xqpwl+XTWorPRbdhGt+DC4h2b
         9wWYGS7e18geqNkEk905ApijjqRYJ8HzAYJPhVG1tZqg3bArIaDx+DD/jgU1SQaP6xdt
         mixn0gpi3P7VPhe8VEfFLs16Q8P5rKXQWnmdtziN1okxg7w7y7kAeRkDY9sbEPAl5BiE
         xqTw==
X-Gm-Message-State: AC+VfDwyMcuxDquRfDCNGX132F5IOF6FEdocFELLytgp63nayEKMqgcI
        MXhpfCeZ73R9NmNKTOE0/QpzWo+eDe1fFz6uZRw=
X-Google-Smtp-Source: ACHHUZ4mVdhWv2vF7uyBMHOC73SyAa2CS6pDpoPoqP1DQiKsaBx8PKLzl/Fr/lzgFcIbhcqYy1ENn8Dm/CNnnuYsLFY=
X-Received: by 2002:a92:d5c7:0:b0:335:2dc6:da4c with SMTP id
 d7-20020a92d5c7000000b003352dc6da4cmr13612242ilq.6.1683911060356; Fri, 12 May
 2023 10:04:20 -0700 (PDT)
MIME-Version: 1.0
Sender: johnwhite998765@gmail.com
Received: by 2002:a92:dc92:0:b0:331:3d5b:363a with HTTP; Fri, 12 May 2023
 10:04:20 -0700 (PDT)
From:   Rose Darren <rosedarren82@gmail.com>
Date:   Fri, 12 May 2023 17:04:20 +0000
X-Google-Sender-Auth: tgfFNbqeL16yXc-WG904V8Ed4sE
Message-ID: <CAC=a3tiThTPJ-jMtuaAKeFpvpnRL5RHis+srmAJnP7bNQ2A-ig@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
