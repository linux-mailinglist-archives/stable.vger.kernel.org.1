Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD67AF1C8
	for <lists+stable@lfdr.de>; Tue, 26 Sep 2023 19:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjIZRcD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 26 Sep 2023 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjIZRcC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 26 Sep 2023 13:32:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866CC10A
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 10:31:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d866d13c637so10657472276.3
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695749513; x=1696354313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkOwjfTSaHY+m/Zl9b5fE1gcn9HuUtefVhZTX1+CRKM=;
        b=SmGBrNauuLEYP0AaOKRObj3Gcuwo3oeyPPyVYuvynGxEsRrIgk03qWG5oRBWYalrsS
         yBYVOrE+SR09JPwHikw4R/tPPh65SXs2qQd8+85sJMsMJMJucIU8dV9KnM40/i4aDB7q
         4W+REDDFRLUsfOG4spcKjMvqfNaEEqd7Y6e5kYT7bi0f84Mexg+aHQraehsN6kT0SqiB
         +UpW1wL6QuKaOURdeZPc7ZxEiHw1eCVmQO0Qj4nSsmLSuiu6l7MGWh4z4qZSQnUnzfTX
         CR/UUH4hyYEIUG+m2PI6hST8d3TWnD/Nr0WEcbmz2OJLFhAzaC8Jn+h4TyOebijBEJ2i
         4l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695749513; x=1696354313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkOwjfTSaHY+m/Zl9b5fE1gcn9HuUtefVhZTX1+CRKM=;
        b=pMsrWtIy5MQiSytXGGcnMQPHuubS9UH3LhCSTq2AXb86wcS/Re8YWdwuJltQ5DoC2D
         gAAFXkkS6EBz2gWxb8AMubzALxkq38R809AcouVOypCqzLlLtJXRUf6MBdklYFR8SLVK
         Rr6GHBjUzBfOT18JqNE+Wu2CET6Hi5iYv6OvtdQdqQRCxF2hY7AhpS0q/plfn+5u60uE
         EOg49WFiYS1fPoxOZ1o7OoNDKMhZBir9HGCJquuTMG/OPONlcbhILuzTAwa1aiRZXt8o
         T9F3vETDLeiVpMgDn9xjNPe9SyNNK4TdXEZyA2iRV41960sMBFvcRLOW2sZqv87o7Fiu
         gVrA==
X-Gm-Message-State: AOJu0YyhZhG1br1op/Q3e2JnYB2tO+6v3xSS5qpK0ZVszrkQDVjOKZJv
        01wbCEMN3HtcosQzvyK7jDO/l6DAhWE=
X-Google-Smtp-Source: AGHT+IExq3tjwerjS6HeYq1RGLysSQci3pAH4clVrhj0LxExcmC9lW1kAbBZp0UEI75+zMH0OFY5ZyUXqVo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ec0c:0:b0:d7e:b82a:ef68 with SMTP id
 j12-20020a25ec0c000000b00d7eb82aef68mr112052ybh.3.1695749513702; Tue, 26 Sep
 2023 10:31:53 -0700 (PDT)
Date:   Tue, 26 Sep 2023 10:31:51 -0700
In-Reply-To: <ZRMHY83W/VPjYyhy@google.com>
Mime-Version: 1.0
References: <20230914010003.358162-1-tstachecki@bloomberg.net>
 <ZQKzKkDEsY1n9dB1@redhat.com> <ZQLOVjLtFnGESG0S@luigi.stachecki.net>
 <93592292-ab7e-71ac-dd72-74cc76e97c74@oracle.com> <ZQOsQjsa4bEfB28H@luigi.stachecki.net>
 <ZQQKoIEgFki0KzxB@redhat.com> <ZQRNmsWcOM1xbNsZ@luigi.stachecki.net>
 <ZRH7F3SlHZEBf1I2@google.com> <ZRJJtWC4ch0RhY/Y@luigi.stachecki.net> <ZRMHY83W/VPjYyhy@google.com>
Message-ID: <ZRMVh0CMmfMo3kmc@google.com>
Subject: Re: [PATCH] x86/kvm: Account for fpstate->user_xfeatures changes
From:   Sean Christopherson <seanjc@google.com>
To:     Tyler Stachecki <stachecki.tyler@gmail.com>
Cc:     Leonardo Bras <leobras@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org,
        pbonzini@redhat.com, dgilbert@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de,
        Tyler Stachecki <tstachecki@bloomberg.net>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 26, 2023, Sean Christopherson wrote:
> Masking fpstate->user_xfeatures is buggy for another reason: it's destructive if
> userspace calls KVM_SET_CPUID multiple times.  No real world userspace actually
> calls KVM_SET_CPUID to "expand" features, but it's technically possible and KVM
> is supposed to allow it.

This particular bit is wrong, KVM overwrites user_xfeatures, it doesn't AND it.
I misremembered the code.
