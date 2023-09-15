Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E787A1708
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjIOHMr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjIOHMp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 03:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 972231BC5
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694761901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APHr7dSzwK5FTJvctTPY4ky9uCY4MRx06g7O1O86zP0=;
        b=VjqrKeK1A9QTnIeuihuO5vHyRcvV7Q+MUTzXa2el+2uNzbbmZLl4/bxF91HX8MCyAt/+mL
        GwPuVkrzgITuTE+o4t8WfKXFC+lo2LDM9Wh4OWw7FgF9yIHJf7qnJs80h5dSR5XTexShiD
        YP8/+NF533wh0BCvRoRl+Zl+8lL/9qQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-7IU71-eoPRqnKFzwyzzZrQ-1; Fri, 15 Sep 2023 03:11:40 -0400
X-MC-Unique: 7IU71-eoPRqnKFzwyzzZrQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-57abf1ee779so552326eaf.2
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 00:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761900; x=1695366700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APHr7dSzwK5FTJvctTPY4ky9uCY4MRx06g7O1O86zP0=;
        b=KiCN4KKmKDVnXUuxfuL/TlYuKqnBDH77FtUgxx7t6nJiIvqBO0foGF7i8TpP+mvRfH
         yvcY9/josUzjf8+G5UtVMqEWwJTg/jY+WhQBZxjoQ8mRTwOT8ZGRB0o8V8ep53xPst/E
         7OIOa1pNT98mEeAhYGzZebGeTqZuiq/wRhGpWbj06qHNnQfuSSqN3YDpcedvHvO/fYDx
         G4JWdTV7c53IUuhQ0kPVmzw/NKAwkvrBnQrwFUHTfl0nalLpT2yQXf5J4R80CKDylxc8
         4OllB42akYHFVxrbMIz848xhRWnmSNZxa+7QdtbKrI4cb5l2apIAXe1Mn6fJe7w+2c8I
         OKag==
X-Gm-Message-State: AOJu0YyhTRNC4NtEplA0w8e2aVidRo7Qhy67t8xTdkQlLs9slbSqeyfu
        NFQ1cyODR7oKEFt/jKJ32K/rKiM2zs3a51976A18KdFkDADuSuS0b4hgwFBaXX1qL9Z+dZV07tO
        cKzA5of74Mu0xdXUC
X-Received: by 2002:a05:6870:4612:b0:1d5:1a99:538f with SMTP id z18-20020a056870461200b001d51a99538fmr897688oao.15.1694761899405;
        Fri, 15 Sep 2023 00:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFrB9lY2yXM24KcdsjQMUoOBiTDc784MzEkkFsobwp+XSj6iwKteM3KHz/31uvrAHcexGY0w==
X-Received: by 2002:a05:6870:4612:b0:1d5:1a99:538f with SMTP id z18-20020a056870461200b001d51a99538fmr897678oao.15.1694761899161;
        Fri, 15 Sep 2023 00:11:39 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id dd14-20020a056871c80e00b001d0d4c3f758sm1623507oac.9.2023.09.15.00.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:11:38 -0700 (PDT)
Date:   Fri, 15 Sep 2023 04:11:33 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Tyler Stachecki <stachecki.tyler@gmail.com>
Cc:     kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
        dgilbert@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, bp@alien8.de,
        Tyler Stachecki <tstachecki@bloomberg.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: Account for fpstate->user_xfeatures changes
Message-ID: <ZQQDpRTQ6HHr8vLp@redhat.com>
References: <20230914010003.358162-1-tstachecki@bloomberg.net>
 <ZQKzKkDEsY1n9dB1@redhat.com>
 <ZQLOVjLtFnGESG0S@luigi.stachecki.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQLOVjLtFnGESG0S@luigi.stachecki.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 14, 2023 at 05:11:50AM -0400, Tyler Stachecki wrote:
> On Thu, Sep 14, 2023 at 04:15:54AM -0300, Leonardo Bras wrote:
> > So, IIUC, the xfeatures from the source guest will be different than the 
> > xfeatures of the target (destination) guest. Is that correct?
> 
> Correct.
>  
> > It does not seem right to me. I mean, from the guest viewpoint, some 
> > features will simply vanish during execution, and this could lead to major 
> > issues in the guest.
> 
> My assumption is that the guest CPU model should confine access to registers
> that make sense for that (guest) CPU.
> 
> e.g., take a host CPU capable of AVX-512 running a guest CPU model that only
> has AVX-256. If the guest suddenly loses the top 256 bits of %zmm*, it should
> not really be perceivable as %ymm architecturally remains unchanged.
> 
> Though maybe I'm being too rash here? Is there a case where this assumption
> breaks down?

There is no guarantee that it would be ok to simple remove a feature from 
the guest. Maybe it's fine for 99% of the cases for given feature, but it 
could always go wrong.

> 
> > The idea here is that if the target (destination) host can't provide those 
> > features for the guest, then migration should fail.
> > 
> > I mean, qemu should fail the migration, and that's correct behavior.
> > Is it what is happening?
> 
> Unfortunately, no, it is not... and that is biggest concern right now.
> 
> I do see some discussion between Peter and you on this topic and see that
> there was an RFC to implement such behavior stemming from it, here:
> https://lore.kernel.org/qemu-devel/20220607230645.53950-1-peterx@redhat.com/
> 
> ... though I do not believe that work ever landed in the tree. Looking at
> qemu's master branch now, the error from kvm_arch_put_registers is just
> discarded in do_kvm_cpu_synchronize_post_init...

This is wrong, then. QEMU should abort the migration in this case, so the 
VM is not lost.

Of course, with this issue fixed, there is another issue to deal with:
- VMs running on hosts with older kernel get stuck in hosts without the 
fixes.

Thanks,
Leo

> 
> ```
> static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
> {
>     kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE);
>     cpu->vcpu_dirty = false;
> }
> ```
> 
> Best,
> Tyler
> 

