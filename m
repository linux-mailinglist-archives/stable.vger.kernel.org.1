Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC33273074F
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjFNSYJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFNSYI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 14:24:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F4DF
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 11:24:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so967a12.1
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686767045; x=1689359045;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0XMSBiDo8EnwlS/NxAuHXvKqJ7PWX8RjNfkfEfB1GdY=;
        b=zSAU5lzePns89P3SFuo1OM+oKQae+GVi7WShgrffrr4QwuWw3wtuxluTYjVRhCvMqS
         mPK/5yvUzJdmaX+Jh9Edli4Zfg9vJ79RWqjxZjRclscN1Jt9RB8/CeHUAYstl2+8xogj
         pB3MQTzDMfog9gnFuqZL+RUHsM2njYC4twBWa+j1xRKy40Um6xdWBrg17NxHeeYUs7op
         ksAVGb3zpxbYOOVZG32rAJSi1dc3jMcEQ0UxH4Am2Y66+NBtMovAC4BW8LZAPei5eluD
         Ff8wAmQ8K1rymK1AI0/+49wKnpR3+lHgxejVictfJUc/XYn2iaa3muQP//5B7nyP7feT
         jvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686767045; x=1689359045;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XMSBiDo8EnwlS/NxAuHXvKqJ7PWX8RjNfkfEfB1GdY=;
        b=RdL4/jozXJHXdu8pOPHy/cYRed56Y8jgA8EfL0b264/yk2jUNDwZBlTVfuPKsQDqA9
         EZoX8NEnXb3BKFULc9aqQvknAJe0cXT+hFN9xFyTK8EwOdFNW7aZ7g+xy4Ip4i7aZj1Z
         m3eS8LB5Tr7zHuLp55LAhbo2AfWXW6pUWRv8XxHFSQo7n52cIb5jyWBxFBLXBKh04oZi
         uFs3e5Y4nwZt5BwQYcjVSVHOhdJHAy/4ldMNDvYqvlnhGX+aw3WdnTeNOWUVTMizfqLf
         FixbdffI72xX3OTXmCoAJ2BejZapUrNqEypj8Xa8MxQ14GzuQqos2rU3uf1zQqIXG4JH
         UhVA==
X-Gm-Message-State: AC+VfDxXgd5qDm1BzC4JQ7zwvGEFOSlsZWY6PezY4of2UpTK8yOuZRQd
        96MjmM7LNkaHYpt0PZCvwdYxamVGoA7OKRcsn4RSPiTkORhUkqy+szqA
X-Google-Smtp-Source: ACHHUZ4FUPbfTsBArfrhGvB4xXY/W/lejL+aLFB3U1S+AVe+dvd/NAucJjEQf4WFTSz3BKgCgoYIR7gwXou+08id5y4=
X-Received: by 2002:a50:a6d3:0:b0:51a:1ffd:10e with SMTP id
 f19-20020a50a6d3000000b0051a1ffd010emr1064edc.3.1686767045189; Wed, 14 Jun
 2023 11:24:05 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Kolchmeyer <rkolchmeyer@google.com>
Date:   Wed, 14 Jun 2023 11:23:52 -0700
Message-ID: <CAJc0_fwx6MQa+Uozk+PJB0qb3JP5=9_WcCjOb8qa34u=DVbDmQ@mail.gmail.com>
Subject: BPF regression in 5.10.168 and 5.15.93 impacting Cilium
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, Greg KH <gregkh@linuxfoundation.org>,
        kafai@fb.com, ast@kernel.org, sashal@kernel.org,
        paul@isovalent.com, Meena Shanmugam <meenashanmugam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi all,

I believe 5.10.168 and 5.15.93 introduced a regression that impacts
the Cilium project. Some information on the nature of the regression
is available at https://github.com/cilium/cilium/issues/25500. The
primary symptom seems to be the error `BPF program is too large.`

My colleague has found that reverting the following two commits:

8de8c4a "bpf: Support <8-byte scalar spill and refill"
9ff2beb "bpf: Fix incorrect state pruning for <8B spill/fill"

resolves the regression.

If we revert these in the stable tree, there may be a few changes that
depend on those that also need to be reverted, but I'm not sure yet.

Would it make sense to revert these changes (and any dependent ones)
in the 5.10 and 5.15 trees? If anyone has other ideas, I can help test
possible solutions.

Thanks,
-Robert
