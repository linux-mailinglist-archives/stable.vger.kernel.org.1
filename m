Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE578D187
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 03:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbjH3BFI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 21:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbjH3BFG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 21:05:06 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302CECF3
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 18:04:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79277cfc73bso184513739f.1
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 18:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693357485; x=1693962285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suY/CmSomjB8J4jX+yIP8mDM9LC2Ww7xj6ma0dhVjb4=;
        b=R8jqpHwx0PKTwD+TZiqTgoM+mVEvzDSgQFJ19xmdNbXqgsFaLlUnpnfQ7//x+RQXaB
         CZ2So7pSjbu2PlGqaRkegNguP7UCW3Ssu7jAl+3FpLTq4gstQfyNsqpHymd9C7ob65ef
         mRkdDqxIVw44s5PqMsL76T+UlQ35iWhfcF0IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693357485; x=1693962285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suY/CmSomjB8J4jX+yIP8mDM9LC2Ww7xj6ma0dhVjb4=;
        b=U+MPDxz+eZZCmicMrPZaRCAp/PZt7iZchD98h1A2xB4PIOOt4z0KFeuuDjW4KWlWIA
         vMlxE0xaVCjHCs05h2dfH6OgqOI8eXtHv14H6t7JTYkspbplQ5a8WX5Fbgrct111XB8t
         5LC9S8u3ctyDN2t9D4r9P3G7A0JFF2MiuX1V4LK7T18vtpE1h23ny1DLz5M0Tv9prxUv
         ildDziW8F0TmMu2X0nKNBRwUKqt9FxcD1oFhvUXfyK+PwxNIrq0lERiTKTqN73qSi6R1
         9iUXGyHizxaYyIykeek/fUTYLXORYj1VnMcDExFW+ICUapsNQSyj0cA5tE1L7SFNlfbd
         H7xQ==
X-Gm-Message-State: AOJu0YzM52FuyM2N0HT3FEWz0XXqOueteMuDhRgJYqUq/EP/+W4RezW2
        AsrFCdENR7v8WwlKGT/fQdFKZtjiWbTt5EiS3fw=
X-Google-Smtp-Source: AGHT+IECJsS18QECLLOZkmJFqx1c1+vSNRvmV5BUx60dgeATp6olnHx4jzT1XR8OvpyVBFzC5vRL/g==
X-Received: by 2002:a6b:d902:0:b0:790:fab3:2052 with SMTP id r2-20020a6bd902000000b00790fab32052mr975418ioc.5.1693357485541;
        Tue, 29 Aug 2023 18:04:45 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id fn6-20020a056638640600b0042b52dc77e3sm3453217jab.158.2023.08.29.18.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 18:04:44 -0700 (PDT)
Date:   Wed, 30 Aug 2023 01:04:44 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
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
Message-ID: <20230830010444.GA33437@google.com>
References: <20230825232807.GA97898@google.com>
 <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
 <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com>
 <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop>
 <20230828133348.GA1553000@google.com>
 <142b4bff-6a2e-4ea0-928c-3cfe9befa403@paulmck-laptop>
 <CAAhV-H4MrUm2xZdZyAALV-r+aKMRQ50v6me6hybpR1pRijirqw@mail.gmail.com>
 <CAEXW_YT-z6s+4MnxTnwFk2-mPba65dbnZogdPDSr14LmOW-h-g@mail.gmail.com>
 <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 28, 2023 at 11:12:49PM +0800, Huacai Chen wrote:
> Maybe putting
> nr_fqs_jiffies_stall before jiffies_force_qs is better, because I
> think putting an 'int' between two 'long' is wasting space. :)

Though it is a decent suggestion, moving it before jiffies_force_qs does not
make the structure smaller. Trying to outsmart the compiler seems not a good
idea when it is not really packing the structure.

Besides, I am not too worried about 4-byte holes considering the structure is
full of them and that ofl_lock is ____cacheline_internodealigned_in_smp which
adds a giant 55 byte hole to the structure. That should keep you at night if
you are worried about 4 byte holes.

And the total size of the structure on a 64-bit build is 3776 bytes so 4
bytes is about 1/10th of a percent. Puny.

So I'd rather leave nr_fqs_jiffies_stall where it is especially considering
it is more readable where it is. :-)

thanks,

 - Joel


> 
> Huacai
> 
> >
> > Thanks.
