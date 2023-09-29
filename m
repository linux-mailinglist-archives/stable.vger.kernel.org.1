Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0567B2979
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 02:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjI2AYY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 20:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjI2AYX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 20:24:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E54F3
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 17:24:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a2318df875so13371607b3.2
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 17:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695947060; x=1696551860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VK3yYTqUyZzwJjWPYCCiURL3L8OGDHEDjPYeZ/hC2E0=;
        b=mmMNIUSIK9ogmfEqekMJsGEmHumJpq1reG39BeRVF5vPjn0eTx3ucj/LfHsP1mU5DT
         UFQ2XFiH37eJhfzvQnOSrhMBy7DapVdFU2P+MdNnEFZj/+SVeLT3nzA6YksxOFvBSdgX
         5o7oEXIKdyCyIxjgPn4zleFl+j61MuSlTUQvxidpnpgxKxqHgVxHbf0B+Iz5xsPx71F2
         4LWB7urMmXiO2Ke1n4vPBfzy7rmxMSSEonfuX7XY4E4y1C9aKg7PyuBeoPyuPilnY3SR
         xCMZEv9au89TxAWrGYUIvNnTXmlcsqE5XCFHpa0wOvPYNgH14C3hsXd8UGynKT+vHHCk
         uUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947060; x=1696551860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK3yYTqUyZzwJjWPYCCiURL3L8OGDHEDjPYeZ/hC2E0=;
        b=dzIr5hsYcMKGK1V8Uyx59+dpcJJJwBeA6je39dF+aGifSjSkXGKI0ZnZpBmzRgHMIH
         w6ujtybgDbcX/igOikQU7+gvPineKBcSFEfmrZGgs2mYgniRjjRnZZv06FLYokAXk2sH
         7wRqaHWZWIsVbjPXajFiON3j6G6g/pQVAe0rzRfJiFFseAViWQblre81JKKh8EhMXnUE
         jh/erfF3FReyn7EUQ02tkffEbYaomiBS2H9S+f+wq/GeftC6bSM4WtHvoTfp7UbthbOt
         aDgkH32gNf0QNn5CMAxTOlz/moedAmAwPyEauOPBQm5UkiACHAe+mk2R7vB6DFtpGxoJ
         00VQ==
X-Gm-Message-State: AOJu0YyO6AZDyQANXo4/IA4Vuu8hkY3PZpFXofGf0n+GfL+gyllk/7AY
        ey6jzZNpf58P1r3dlxDUMxtpqrCD3zc=
X-Google-Smtp-Source: AGHT+IEOayytUoGF6yiau9EKJIk7fPZSTKse/XCvu4K9plygAETxpWB9IOofC6SPGiHL7SAKxLP/YXrGXcc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:aa48:0:b0:59b:f493:813c with SMTP id
 z8-20020a81aa48000000b0059bf493813cmr44356ywk.9.1695947060234; Thu, 28 Sep
 2023 17:24:20 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:24:18 -0700
In-Reply-To: <20230928173354.217464-2-mlevitsk@redhat.com>
Mime-Version: 1.0
References: <20230928173354.217464-1-mlevitsk@redhat.com> <20230928173354.217464-2-mlevitsk@redhat.com>
Message-ID: <ZRYZMr4fuaywW7fP@google.com>
Subject: Re: [PATCH v2 1/4] x86: KVM: SVM: always update the x2avic msr interception
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, iommu@lists.linux.dev,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
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

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> The following problem exists since x2avic was enabled in the KVM:
> 
> svm_set_x2apic_msr_interception is called to enable the interception of

Nit, svm_set_x2apic_msr_interception().

Definitely not worth another version though.

> the x2apic msrs.
> 
> In particular it is called at the moment the guest resets its apic.
> 
> Assuming that the guest's apic was in x2apic mode, the reset will bring
> it back to the xapic mode.
> 
> The svm_set_x2apic_msr_interception however has an erroneous check for
> '!apic_x2apic_mode()' which prevents it from doing anything in this case.
> 
> As a result of this, all x2apic msrs are left unintercepted, and that
> exposes the bare metal x2apic (if enabled) to the guest.
> Oops.
> 
> Remove the erroneous '!apic_x2apic_mode()' check to fix that.
> 
> This fixes CVE-2023-5090
> 
> Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
