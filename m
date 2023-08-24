Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59621787028
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjHXNWU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbjHXNWA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 09:22:00 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8B19AA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 06:21:57 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77a62a84855so214187339f.1
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692883316; x=1693488116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBq+bzB7lscqikmSJhAFXBiktCV1gBbXEMWl3afWAOE=;
        b=o5dnZDcGUXqzt+x38Q9THJr6mkJ/ZPbZp2c1dSzm1oq2f84mhbL4T/QUsk6TOkXEwB
         rn4IK71ZT0VgTpC45tbN0UtU//K1rSY4cx6VE0cqNwYCerZcprGlwLyUPlhefayczlH7
         QFwQmc6flCefuHkV3qDJaImAtKhBileWEkADw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883316; x=1693488116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBq+bzB7lscqikmSJhAFXBiktCV1gBbXEMWl3afWAOE=;
        b=HCXnDIoMWofhNCu2/JXi1Rf5IfMPfwPAnQrbz7Qg7tjJgls5iUlz+7pyubKP3sl7E1
         w0vu2EKY79sSprJ2+XNUUbQR3ouRU1ofPv3OM+OoY1c8moADD3RORctA/hWkfJKWMoem
         gf9zO37o3veFM8eExBE1CooQrGNjcEjyt8i9s2qEMYNO3LEHG0QuHBlrK5Vu8DK9hmtA
         1SsboBsJJ2xx2Pl3efAox/YzFBxwA72s+TZwFKvl3y3gRlr/xrjWbHcqYdxkG9EoLPlY
         bnkhkBGdfVX2byIapwQAry4wgKByKhZ8m9CoQxHibz4IDF0pRbZsnicyIIL+3nSGZ9CS
         JWJQ==
X-Gm-Message-State: AOJu0YxExPECErjCvKQMHkf/iLujaQSA9DBLu/y8VhYFV21lX3BsqzLa
        xzWGFwTgq+n+MKU3+nwhKZqTFQ==
X-Google-Smtp-Source: AGHT+IFjWHnHBpCiFQH1AzAPX4bose/q+fwlgVd4v2eWmDLjFu9ry/Xs4MGnldrAr5VfE4TnbHY8pw==
X-Received: by 2002:a5e:990c:0:b0:786:cd9c:cfa2 with SMTP id t12-20020a5e990c000000b00786cd9ccfa2mr6035587ioj.0.1692883316587;
        Thu, 24 Aug 2023 06:21:56 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id b20-20020a02c994000000b0042b08954dc3sm4371841jap.33.2023.08.24.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:21:56 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:21:55 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <20230824132155.GB3810470@google.com>
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttspct76.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Thomas,

On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >> > If  do_update_jiffies_64() cannot be used in NMI context,
> >>
> >> Can you not make the jiffies update conditional on whether it is
> >> called within NMI context?
> 
> Which solves what? If KGDB has a breakpoint in the jiffies lock held
> region then you still dead lock.

Yes, we had already discussed this that jiffies update is not possible from
here. There are too many threads since different patch revisions were being
reviewed in different threads.

> >> I dislike that..
> > Is this acceptable?
> >
> > void rcu_cpu_stall_reset(void)
> > {
> >         unsigned long delta;
> >
> >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> >
> >         WRITE_ONCE(rcu_state.jiffies_stall,
> >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > }
> >
> > This can update jiffies_stall without updating jiffies (but has the
> > same effect).
> 
> Now you traded the potential dead lock on jiffies lock for a potential
> live lock vs. tk_core.seq. Not really an improvement, right?
> 
> The only way you can do the above is something like the incomplete and
> uncompiled below. NMI safe and therefore livelock proof time interfaces
> exist for a reason.

Yes, I had already mentioned exactly this issue here of not using an NMI-safe
interface:
https://lore.kernel.org/all/CAEXW_YT+uw5JodtrqjY0B2xx0J8ukF=FAB9-p5rxgWobSU2P2A@mail.gmail.com/
I like your suggestion of using last_jiffies_update though (which as you
mentioned needs to be explored more).

There are too many threads which makes the discussion hard to follow. Huacai,
it would be great if we can keep the discussions in the same thread (Say for
example by passing options like --in-reply-to to "git send-email" command).

thanks,

 - Joel


> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
>   */
>  static ktime_t last_jiffies_update;
>  
> +unsigned long tick_estimate_stale_jiffies(void)
> +{
> +	ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> +
> +	return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> +}
> +
>  /*
>   * Must be called with interrupts disabled !
>   */
> 
> 
