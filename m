Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0676F7932C7
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 02:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbjIFABq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 20:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbjIFABp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 20:01:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A501AB
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 17:01:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e8207103so33361527b3.2
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693958501; x=1694563301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGU0Ldc06VPvpAP7m0sVwOLJkd4koSpzj+Ua2QIatXY=;
        b=0e8GNSCt+QzjxjaNSRYvTMKflo6TIP4hHH41c09+DfpJb8AdfEuu6bgXVB5a3soNAU
         QCU3J3o88zJoQB0kgg/GQI152V8e4WCdX31IgCZ+jCXDSpkcu9w72LSvAEhmoULZVK9Y
         St4JwIlY5N8Z6UaGVohdYdWp4LMjB4ReGHNLjAi3pypRfDD3H3RRDJt71l3xFQglamLa
         bOpvz/NHumebz6ucIvgl4zsoYbr+KbEgTxSfKA1aXgTZcGrb7LA9N6xcNpR7e8I6dLDX
         LQPJRoM5u4wvnjCNhd9gdj4VFAhX+f2IOQwYPXf42bCai4TCyxuKVz1WvNJA92ua14/X
         xFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693958501; x=1694563301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGU0Ldc06VPvpAP7m0sVwOLJkd4koSpzj+Ua2QIatXY=;
        b=UhA0fWsERLYQErlJy7aV2XGIK1aX/hgoNNPRR740TWXN5dDwvQCJ7KcUSk3meuHIgY
         L6faU1fzANaL/Bu1fZzjZEGxApssBynWyh5XKWuyXgj05mmuzVP5mNyysxcjl+0mhpEp
         8oItncqUTsjeJiQmVlVv6pYPas2OWoTYNAEr6+pVZ+QT00B/YcpreOZEWjTGmFUMPzzO
         2hGeJYlyiTFvBxA/RaRYBQp8jGDeYfj9i4ITXwBILUQ+ypZeh709WjapjxyAdsrYUAvh
         NSdv6l99m8Oumw7g9VlKGjmvCbxzMWfQfkCT9vxPNfF3SGL6lbeoKxnNFG6wFvG/F/jI
         p0/g==
X-Gm-Message-State: AOJu0YxdEOxvv93L2393wphv0ZAL5Sk8ZxVp4+JMR0o7ET9yX7nSH7dE
        KjMDeW3cdiOyWr2sYLu/Ct6A7I0Q6/k=
X-Google-Smtp-Source: AGHT+IHUC5/1q0YTww8LSntOwfWI8TlOXS94/btDD6oA2HWc9MrndIr3CmTZDzqtk8bL10J8OvfW1mho/5E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b70a:0:b0:583:a3c1:6b5a with SMTP id
 v10-20020a81b70a000000b00583a3c16b5amr346458ywh.4.1693958501557; Tue, 05 Sep
 2023 17:01:41 -0700 (PDT)
Date:   Tue, 5 Sep 2023 17:01:39 -0700
In-Reply-To: <8c1fdd1cb24d042d02c4f2660c0690604448a2f4.1693593288.git.luizcap@amazon.com>
Mime-Version: 1.0
References: <cover.1693593288.git.luizcap@amazon.com> <8c1fdd1cb24d042d02c4f2660c0690604448a2f4.1693593288.git.luizcap@amazon.com>
Message-ID: <ZPfBY5rnDwEIDR90@google.com>
Subject: Re: [PATH 6.1.y 1/2] KVM: x86/mmu: Use kstrtobool() instead of strtobool()
From:   Sean Christopherson <seanjc@google.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        lcapitulino@gmail.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 01, 2023, Luiz Capitulino wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Commit 11b36fe7d4500c8ef73677c087f302fd713101c2 upstream.
> 
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Link: https://lore.kernel.org/r/670882aa04dbdd171b46d3b20ffab87158454616.1673689135.git.christophe.jaillet@wanadoo.fr
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
