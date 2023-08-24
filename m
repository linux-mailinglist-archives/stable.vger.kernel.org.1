Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD17870D2
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjHXNrf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 09:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbjHXNrK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 09:47:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2E10EF
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 06:47:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fc448ee4fso62490837b3.2
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692884821; x=1693489621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAgKqHj78kAKZRTyvqkKPKjjidwxbpWPTAGlGXZyYJo=;
        b=Qbs/mT7HhALHGb6bFGF4GZLNNHn3/oHFfz2XEEm7l4F7jhYKMsEAh8M1bURHvIL91o
         ccKVZBwnpgh3IWsQDgPTTsDjKNXCUkzKwJ10nK1JyI75Qm4QLT6aRFcW4LUU48UZNRC0
         RkAEzrhsDi7TdrBr/3Da5WA/zWCrybTGlmsutd5mAXsQVt5kZ1GZ7CrqDhQX0aOrBNZ9
         yeDHRrR4AWikvau9MytM23mQov5Rx63ffg9pbZYf4p26wmJNhrXRgwk+bWcrBDDg6HRm
         /zueRGvI6dhCg9J/ESU45hB3s3GtMiX1sQwjPj7IcBt6nOoNBNpflUl31lXqei5Fqyrw
         TZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692884821; x=1693489621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAgKqHj78kAKZRTyvqkKPKjjidwxbpWPTAGlGXZyYJo=;
        b=l9ts4R+CsCdk/zuAy21qD5vEAZSFwSDvb2+dFnc/cHJwu4b0tGnARzfyWoyKeI3TR2
         89hQ9NkuQmuTgEFIGezMhwu0Yy+l+57vN0/FlrYUHlgmoL96AY5NeNIlVamMptZpF5Ut
         8cqNXp5bnjq7vRvBTVlHZ09oO6rFGRHaihhdilgII1bH3w8/BDID2lyZPSGZuaRrYe7i
         HemKWHlwmfX7maYDylSS7DkZD6iVsqCRBUkkAgHqjI0YQK5xQY7wBoKz0/qzWZQd1PC5
         UPmq7BZrizjGFw1R+jpNI5IwyjySJ/VeKO82o1GDPd8HS6vE6Iw51VfpZYNyDASZfEhh
         AUoQ==
X-Gm-Message-State: AOJu0YxsO33r+o+QDr7MIc5MmNDCGoPLd0quy1AmHrChMMGInJTJxHAA
        XMbyt098LZixQEUfjZM6oaOwaunnWCw=
X-Google-Smtp-Source: AGHT+IGXdgg/ssklqYDk55RDWOjzVrp8+5srv3ZUQaokNQMyQlOg8jyuIRb8maXjf+ssY1vir68KGA2SVCw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af27:0:b0:586:a8ab:f8fe with SMTP id
 n39-20020a81af27000000b00586a8abf8femr244105ywh.10.1692884821216; Thu, 24 Aug
 2023 06:47:01 -0700 (PDT)
Date:   Thu, 24 Aug 2023 06:46:59 -0700
In-Reply-To: <2023082423-ninetieth-hamlet-54dc@gregkh>
Mime-Version: 1.0
References: <20230824010104.2714198-1-seanjc@google.com> <2023082423-ninetieth-hamlet-54dc@gregkh>
Message-ID: <ZOdfU1zQ4UCQNVpz@google.com>
Subject: Re: [PATCH 6.1] KVM: x86/mmu: Fix an sign-extension bug with mmu_seq
 that hangs vCPUs
From:   Sean Christopherson <seanjc@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 24, 2023, Greg Kroah-Hartman wrote:
> On Wed, Aug 23, 2023 at 06:01:04PM -0700, Sean Christopherson wrote:
> > Note, upstream commit ba6e3fe25543 ("KVM: x86/mmu: Grab mmu_invalidate_seq
> > in kvm_faultin_pfn()") unknowingly fixed the bug in v6.3 when refactoring
> > how KVM tracks the sequence counter snapshot.
> > 
> > Reported-by: Brian Rak <brak@vultr.com>
> > Reported-by: Amaan Cheval <amaan.cheval@gmail.com>
> > Reported-by: Eric Wheeler <kvm@lists.ewheeler.net>
> > Closes: https://lore.kernel.org/all/f023d927-52aa-7e08-2ee5-59a2fbc65953@gameservers.com
> > Fixes: a955cad84cda ("KVM: x86/mmu: Retry page fault if root is invalidated by memslot update")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> What is the git commit id of this change in Linus's tree?

There is none.  Commit ba6e3fe25543 (landed in v6.3) unknowingly fixed the bug as
part of a completely unrelated refactoring.
