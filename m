Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB45794580
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 23:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjIFV5K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 17:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbjIFV5K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 17:57:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BB199B
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 14:57:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so3387625e9.0
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694037424; x=1694642224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQLq2pOUNT714HXackjeww9uvWCkF88NuQCu3+7xKCQ=;
        b=GuQP64QRb+sI8tXg9q/ruUAx6HoluLlbJDQt40fhPNNfgPPB5V1Dg29FH+/TekEjWw
         rKn/OhYTOB7Mm+0ewxyzFqrIHAgUJ39/dwdCKXubBAHRUSSN9J7pA4CjjbXDjmDBzrrC
         rvjKuA5+0OTckFyChXOREt9rXAnJY/RBVSuHE/BgHP/8j/z+Eg2xpJbL+h+DVq3LuzIG
         WKs3Djeu8sQIhSmumUnvNrNZwi2Ex9eXPZ3sR6J2lw2eXM+7ID7Au0SUPVqQ406uAbsr
         I4z1/Gj64NLXhqlwmNmIxbsccAAmT6dmNrT3vCI1pZoyCzuZVwBdKgYJK98nmZphqD/8
         wMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694037424; x=1694642224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQLq2pOUNT714HXackjeww9uvWCkF88NuQCu3+7xKCQ=;
        b=GG85r1OXlCtcwQgajBItUmrIFlUnmYQUx7OF3nREKfMNAXFsvVdR9Vy+H3N78xv6vw
         MoPKWkQFM0+GSv398fKAuELzWiHgiKWY61fHVKo9stMwiC94KB9HgAri/qnRaHxLN0m2
         Iia2dsP11CeQonJEn4yyzL3rd3PtL3N3akVeqGu6kHj0/BDZkHA+EA35iaNjIXCq2uT+
         yRm+XR0Zaxe5XrXyu5j8itjg4fQgPH9plcV0uqknz/TIbc4LXjEZBT9jpMlZM2daV8c0
         ONbrdPeSJZ0/J0BYOy7s2CAQ6+NWEbx+xVsbmXKRd7xZDOD18p03K7K9+hko0HLezoeR
         cKIw==
X-Gm-Message-State: AOJu0YzYUUk0IvXmVaAYxiqQSZy2exLiJGiHwGCXcTBb1L1Ua05HUMGS
        q8lrg9k0qqk+wd9xEP/qvqQ=
X-Google-Smtp-Source: AGHT+IFsxLd/5T5VRRMI4U1YSw7ofZpM7Kg00yG+wHO8MNBR4nCIH6HCaD+wKmF3kVqxojuggMtUVw==
X-Received: by 2002:a5d:644c:0:b0:31a:ea86:cbb8 with SMTP id d12-20020a5d644c000000b0031aea86cbb8mr3325612wrw.2.1694037424425;
        Wed, 06 Sep 2023 14:57:04 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id h17-20020adff191000000b003180fdf5589sm21528145wro.6.2023.09.06.14.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:57:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 6 Sep 2023 23:57:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     x86@kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        stable@vger.kernel.org, Yu Zhang <yu.zhang@ionos.com>,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv4] x86/sgx: Avoid softlockup from sgx_vepc_release
Message-ID: <ZPj1rWuZdSyL5X1M@gmail.com>
References: <20230906131712.143629-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906131712.143629-1-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


* Jack Wang <jinpu.wang@ionos.com> wrote:

> We hit softlocup with following call trace:
> 
> ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> xa_erase+0x21/0xb0
> ? sgx_free_epc_page+0x20/0x50
> sgx_vepc_release+0x75/0x220
> __fput+0x89/0x250
> task_work_run+0x59/0x90
> do_exit+0x337/0x9a0
> 
> Similar like commit 8795359e35bc ("x86/sgx: Silence softlockup detection
> when releasing large enclaves"). The test system has 64GB of enclave memory,
> and all assigned to a single VM. Release vepc take longer time and triggers
> the softlockup warning.
> 
> Add cond_resched() to give other tasks a chance to run and placate
> the softlockup detector.

I've rewritten the changelog: it's not just a change to 'placate' the 
softlockup detector, the SGX code was causing *real*, very long 
non-preemptible delays in the kernel. That's a real kernel bug, not some 
softlockup whingle that needs to be silenced ...

So what this patch does is to break up those delays & latencies, and that 
softlockup doesn't warn anymore is a side effect fix.

I've changed the description accordingly, and applied it to tip:x86/urgent.

Thanks,

	Ingo
